From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH/RFC] remove #!interpreter line from shell libraries
Date: Mon, 12 Mar 2012 14:17:03 -0500
Message-ID: <20120312191703.GB21817@burratino>
References: <20120308121403.GA16493@burratino>
 <20120309075820.GA15985@ecki>
 <4F5E4618.10102@xiplink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Clemens Buchacher <drizzd@aon.at>, git@vger.kernel.org,
	Jeff King <peff@peff.net>, David Aguilar <davvid@gmail.com>,
	Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To: Marc Branchaud <marcnarc@xiplink.com>
X-From: git-owner@vger.kernel.org Mon Mar 12 20:17:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S7AkD-0003J7-9X
	for gcvg-git-2@plane.gmane.org; Mon, 12 Mar 2012 20:17:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756617Ab2CLTRP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Mar 2012 15:17:15 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:54062 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756598Ab2CLTRO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Mar 2012 15:17:14 -0400
Received: by iagz16 with SMTP id z16so7251422iag.19
        for <git@vger.kernel.org>; Mon, 12 Mar 2012 12:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=Qv+kAcyUhnhPFYhSAwqXfCOJeivY+QqeyauyHz6JDAs=;
        b=poY7x3/2S+Igb7dcnm42DHJnSzl+uM12m7FrsaN0XSiecy2PmANYsQhBSYPc16nH9x
         bG29jGqySVnOUEd8vlhnHxPcKqbnLcXdV8Nh4iyuceXLorQRd+O9pwMm4TaEjRboo4c6
         GLm1DZnLuvhMgcDDy9ofT8m9IAGyeaEhPi6xiyWWRolZBgwvr4JMizXc9as4kdmvOl75
         oPtCGMLoOO7k/EazxOqMRAyp03BZ2a/ymR7uFlhemtenWIw6EgjOyV+6TRjGTSGaUMzb
         TTJhaj/eB7cRlGKcnGj3xH9Ww3SDO6baGtkLIa8aG7ucIX0A4dC3UlXoqEFYuZ8jf5bN
         mAtw==
Received: by 10.50.77.170 with SMTP id t10mr333859igw.35.1331579833703;
        Mon, 12 Mar 2012 12:17:13 -0700 (PDT)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id cw5sm9820367igc.17.2012.03.12.12.17.11
        (version=SSLv3 cipher=OTHER);
        Mon, 12 Mar 2012 12:17:13 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4F5E4618.10102@xiplink.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192927>

Hi,

Marc Branchaud wrote:
> On 12-03-09 02:58 AM, Clemens Buchacher wrote:
>> On Thu, Mar 08, 2012 at 06:14:04AM -0600, Jonathan Nieder wrote:

>>> +++ b/git-mergetool--lib.sh
>>> @@ -1,5 +1,4 @@
>>> -#!/bin/sh
[...]
>> This breaks vim's filetype detection. It can still guess the file type
>> from the .sh extension, but we strip the extension during the build.
>> Although one should typically work with the source files, in the past I
>> did have a look at the installed files on a few occasions.

It seems moot until someone has had time to deal with the --valgrind
fallout Jeff mentioned.  Here are my thoughts anyway.

vim's filetype detection has been broken for me in other ways, too:
when it sees "#!/bin/sh", by default it assumes that this is a script
intended for Solaris's lowest-common-denominator Bourne shell and
decides to annoyingly flag POSIXisms in red.  So I end up needing to
override vim's default heuristics already.

By the way, my mild dislike for the #! line in shell libraries is
actually rooted in functionality, in a way.  Though it would never
happen in git, I have had too many unhappy experiences of shell
libraries with #!/bin/bash at the top that were used in #!/bin/sh
scripts and broke completely.  So that is where the bad association
comes from.

Steering people towards git-sh-setup.sh when they try to edit
git-sh-setup is just a happy side-effect.

[...]
> How about a modeline?  I think the following would work for both emacs and
> vi(m?) (I'm not a vi user, so I might have it wrong):
>
> 	# -*-mode:shell-script-*-   vi: filetype=sh

A modeline becomes a distraction as people work to get the settings
perfect with respect to line length, indentation style, and changes in
supported editors, and to get them applied consistently as new files
are added.

So from a maintainability point of view, it seems wasteful --- better
to ask people to configure their editor to recognize .sh files,
#!/bin/sh, and files starting with "# " or containing "is a shell
library" on the first line once and be done with it.

Of course I can easily be convinced otherwise.

Thanks for some useful observations and for catching the huge holes
in the change description.

Sincerely,
Jonathan
