From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Where should git-prompt.sh be installed?
Date: Thu, 25 Oct 2012 09:12:50 -0700
Message-ID: <20121025161250.GA30334@elie.Belkin>
References: <1337719600-7361-1-git-send-email-felipe.contreras@gmail.com>
 <1337719600-7361-3-git-send-email-felipe.contreras@gmail.com>
 <20121025005106.GA9112@elie.Belkin>
 <20121025151120.GA14740@goldbirke>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Anders Kaseorg <andersk@MIT.EDU>,
	Danny Yates <mail4danny@googlemail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Ted Pavlic <ted@tedpavlic.com>, Dan McGee <dan@archlinux.org>
To: SZEDER =?utf-8?B?R8OhYm9y?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Thu Oct 25 18:13:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TRQ3m-00070H-DX
	for gcvg-git-2@plane.gmane.org; Thu, 25 Oct 2012 18:13:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760003Ab2JYQNJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 25 Oct 2012 12:13:09 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:64475 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759996Ab2JYQNC convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 25 Oct 2012 12:13:02 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr4so2119840pbb.19
        for <git@vger.kernel.org>; Thu, 25 Oct 2012 09:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=H6ArrSbSj1fW5H8LAaMhz7dlYWXkKO+sRgPk/7QUOJ4=;
        b=jrGumkUSZ/UEfBqqBvqU3ziWOggiBKBIpTLq2AfylaNrN1r3BcyQU5/ry/y/JGSBsE
         UM6Si0kzWoWDvmlQGKq5trNnM/SAbtO6VpeBinPFY4yrZqbI2piSqb1TJi5NgWsCw+fe
         PsQIgFQh1JXbD6X7wjXr4eX/NgTBQSthjMm6tnH5l9g0Jt7n9KNzcSQVEHa0JsMbdgoF
         NBQLmxfW0CQkUiXhE5McC/xJdgYPyu9Uo5QIbDUJi49U+gkh4xOTBoOJN8ptbt/VUkdk
         2KgMRWDIDImi30XYKu0CVlCiJe4qNfBlCeXjhfTMzSHQ08s6ngkQQFRCJmqb6qgkdRX2
         QImg==
Received: by 10.68.217.168 with SMTP id oz8mr37185611pbc.90.1351181581601;
        Thu, 25 Oct 2012 09:13:01 -0700 (PDT)
Received: from elie.Belkin (c-67-180-61-129.hsd1.ca.comcast.net. [67.180.61.129])
        by mx.google.com with ESMTPS id op7sm11413524pbc.52.2012.10.25.09.12.59
        (version=SSLv3 cipher=OTHER);
        Thu, 25 Oct 2012 09:13:00 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20121025151120.GA14740@goldbirke>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208406>

SZEDER G=C3=A1bor wrote:
> On Wed, Oct 24, 2012 at 05:51:06PM -0700, Jonathan Nieder wrote:

>> Proposal:
>>
>>   1) /usr/lib/git-core/git-sh-prompt
>>   2) git-sh-prompt(1)
>
> Not sure about the "sh" part.  The prompt function is very
> Bash-specific, it won't work under a plain POSIX shell.

That's an interesting point.  Here's my logic:

The prompt function was originally Bash-specific, but over time
it gained support for Zsh as well.  If we're lucky, some day it
might gain support for mksh.

Meanwhile something simple like "git-prompt" would sound too much
like a normal git command, I fear.

Shell language extensions used:

 * future standard: local variables
 * cosmetic: [[ and (( syntax in place of test and $(
 * cosmetic: for ((n=3D1; n <=3D n_stop; n++)) instead of a more explic=
it
   while loop
 * cosmetic: var+=3Dvalue syntax
 * optimization: <<< syntax to iterate over lines in a variable
   instead of, for example, sed + eval
 * arrays: svn_remote, svn_upstream --- using plain variables would
   require some escaping.

So nothing fundamental, but since this is only useful in shells like
Bash that support command substitution in $PS1, it seems reasonable
to keep using the extensions until someone wants to use it with a
more limited shell.

In other words, the interface is still "this is a scriptlet you might
source in your Bourne-style shell to get a __git_ps1 function to use
in your prompt".  The implementation language just happens not to be
POSIX shell today.

Perhaps it should return early in shells other than bash and zsh to
help people keep their .shrc simple.  What do you think?

> Do other VCSes have similar prompt scripts?  Where do they install
> theirs?

Mercurial has an hg-prompt extension that can be used by running "hg
prompt".
http://mercurial.selenic.com/wiki/PromptExtension

I haven't found one for Subversion.

Bazaar has contrib/bash/bzrbashprompt.sh.  It doesn't get installed.

Thanks,
Jonathan
