From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 2/3] hooks/post-receive-email: force log messages in UTF-8
Date: Sun, 4 Aug 2013 11:14:40 -0700
Message-ID: <20130804181440.GA2894@elie.Belkin>
References: <20130802232118.GB2963@elie.Belkin>
 <20130802232338.GD2963@elie.Belkin>
 <20130804145448.GA15097@dell-note>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>,
	Alexander Gerasiov <gq@debian.org>
To: Alexey Shumkin <alex.crezoff@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 04 20:15:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V62pp-0000Cc-VB
	for gcvg-git-2@plane.gmane.org; Sun, 04 Aug 2013 20:15:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752786Ab3HDSOt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Aug 2013 14:14:49 -0400
Received: from mail-pa0-f45.google.com ([209.85.220.45]:49016 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752483Ab3HDSOt (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Aug 2013 14:14:49 -0400
Received: by mail-pa0-f45.google.com with SMTP id bg4so2463526pad.32
        for <git@vger.kernel.org>; Sun, 04 Aug 2013 11:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=KgDZY9MnTCZ4KpFo2nTEgRTL9aSMXOxpCQLkwuL4gG0=;
        b=LCrfUNKmkiI/qrIkv8d/iKVCs/lV1uKUBt10hXC73LqduQvjSmjEB597SPtXVvLw16
         BcUTw7MnjhCCQzNfsstyaNdE84CN5gpQa09BZtODOYwVz44jsYyNazkAl8a6QCvucYOZ
         onaL5HaL4bZkFOvHeL8xaS7DB3HafNwuDyHGmEe5tHR3ud65fubapIvlsA7JtfQH19re
         gShK9kKhi1MzBQf80FqC/JWNUkG8RV6gupxMdjp5xD5o0s9IEMT5/y3yvZhaH00eJzSo
         Ce3GvAzm/yyR3s89iitNX1YceODrw8S3jc6DxIaw6A22ZmdBtudRRHQ4lT17VYgbuzBp
         1I8w==
X-Received: by 10.68.179.194 with SMTP id di2mr18402218pbc.203.1375640088591;
        Sun, 04 Aug 2013 11:14:48 -0700 (PDT)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPSA id w8sm23244821pab.12.2013.08.04.11.14.46
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 04 Aug 2013 11:14:47 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20130804145448.GA15097@dell-note>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231636>

Alexey Shumkin wrote:
> On Fri, Aug 02, 2013 at 04:23:38PM -0700, Jonathan Nieder wrote:

>>  1. Log messages use the configured log output encoding, which is
>>     meant to be whatever encoding works best with local terminals
>>     (and does not have much to do with what encoding should be used
>>     for email)
>>
>>  2. Filenames are left as is: on Linux, usually UTF-8, and in the Mingw
>>     port (which uses Unicode filesystem APIs), always UTF-8
>
> I cannot say exactly if it makes sense for THIS patch, but I'd like to
> remind about Cygwin port, which definitely does not use UTF-8 encoding
> (in my case it is Windows-1251) for filenames.
>
>> 
>>  3. The "This is an automated email" preface uses a project description
>>     from .git/description, which is typically in UTF-8 to support
>>     gitweb.

Thanks for clarifying.  So in the context you describe, (1) is
configurable, (2) is Windows-1251, (3) is unconfigurably UTF-8, and
there is no way with current git facilities to force the email to use
a single encoding unless (3) happens to contain no special characters.

What is the value of the "[i18n] commitEncoding" setting in your
project?  What encoding do the raw commit messages (shown with
"git log --format=raw") use for their text, and what do they declare
with an in-commit 'encoding' header, if any?

Does everyone on this project use Cygwin?  That should be fine, but
I'd expect there to be problems as soon as someone wants to try the
Mingw port ("Git for Windows").

I wonder if there should be an "[i18n] repositoryPathEncoding"
configuration item to support this kind of repository.  Then git could
be aware of the intended encoding of paths, could recode them for
display to a terminal, and at least on Linux and Mingw could recode
them for use in filenames on disk.  "repositoryPathEncoding = none"
would mean the current behavior of treating paths as raw sequences of
bytes.

What do you think?
Jonathan
