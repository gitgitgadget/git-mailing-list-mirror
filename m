From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: What's cooking in git.git (Oct 2013, #02; Mon, 14)
Date: Tue, 15 Oct 2013 12:16:56 -0700
Message-ID: <20131015191656.GD9464@google.com>
References: <20131014184524.GW9464@google.com>
 <20131015001231.GA9464@google.com>
 <xmqqiowye66r.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Anders Kaseorg <andersk@MIT.EDU>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 15 21:17:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VWA79-0003x8-UN
	for gcvg-git-2@plane.gmane.org; Tue, 15 Oct 2013 21:17:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759579Ab3JOTRD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Oct 2013 15:17:03 -0400
Received: from mail-pd0-f179.google.com ([209.85.192.179]:48912 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759113Ab3JOTRB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Oct 2013 15:17:01 -0400
Received: by mail-pd0-f179.google.com with SMTP id v10so9254939pde.24
        for <git@vger.kernel.org>; Tue, 15 Oct 2013 12:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=opmxiaQfGT/exSt0CWTQHpTFRK+DjjrIIwwVfkYIo9s=;
        b=hr2LQ99qqZFyqYvyWjdCnKvOwdJAsgaFl7i/lywqqNzuylh6C/bg/W+VM3Xv3EhnWl
         cGto6KLqxJ1MPcA22U6rx4d1BhcRVvlZUSnPF9KLkN7DrTMyoOlJr47TTbNd+LgSQS7M
         4VzH/wSoOFdaT7anAHsGKX6raJYS13aPFFqb4Ud1tofTbOw/x15Ps1HwQg1rQekkjrTt
         n+7ROoj2TEsPj2IedosshMpL+z5M73BwD5Y8aKj0b9qfNWt7pp6pH/HQ6nSz0efO8IjQ
         ff6KSzcyXRbuENkSrnKRK+yYP9NfJAjZcJ8kNmK2peJOicNRi14CcH2HdOdxNmlR3PhM
         wXew==
X-Received: by 10.66.196.168 with SMTP id in8mr44092834pac.18.1381864621213;
        Tue, 15 Oct 2013 12:17:01 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id yo2sm100958630pab.8.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 15 Oct 2013 12:17:00 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <xmqqiowye66r.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236195>

Junio C Hamano wrote:

> I'll try:
>
>  - slurping your integration branches,
>  - teasing the topics apart out of your 'pu',
>  - populating my rerere database to match your confict resolution,
>  - reconstructing the Meta/Reintegrate insn for 'pu', and
>  - rebuilding 'pu' to make sure the end result matches yours
>
> and then push the result out to the usual places

Sounds good.  The teased-apart topics can also be found at

    https://github.com/jrn/git

[...]
>>  This patch preserves the old "just pass it to the shell" behavior
>>  when a single argument is passed to 'git submodule foreach' and
>>  moves to a new "skip the shell and use the arguments passed
>>  unmolested" behavior when more than one argument is passed.
>
> When scripts give 'echo' and '$path' (two args), does this change
> allow the 'echo' command to see the value of $path (coming from
> $sm_path), or just the not-useful-because-not-exported variable name
> '$path'?

The latter.  A quick search (web search + codesearch.debian.net)
reveals that most callers to submodule foreach either pass a script as
a single quoted argument (e.g.,
http://stackoverflow.com/questions/8364738/bash-git-submodule-foreach:

	git submodule foreach '[ "$path" = "Libraries/JSONKit" ] \
	  && branch=experimental \
	  || branch=master; git co $branch'

or http://sources.debian.net/src/jquery/1.7.2+dfsg-3/Makefile?hl=131#L131:

	git submodule foreach "git pull \$(git config remote.origin.url)"

) or pass a one-off command with no arguments intended for the shell
(e.g., http://sources.debian.net/src/libreoffice/1:4.1.1-1/g?hl=352#L352,
http://sources.debian.net/src/swi-prolog/6.4.1-3/scripts/newversion?hl=81#L81):

	git submodule foreach git push "$@"
	git submodule foreach git tag -s -f -F $tmp  $gittag

So I suspect this will fix more scripts than it breaks, though it may
still break some. :/

It might make sense to warn when passed multiple arguments and some
include shell metacharacters, since that's probably rare, too, except
it's punishing people who use multiple arguments as a way to avoid
quoting issues.  Probably there's no replacement for just advertising
the change loudly and seeking out scripts it could break.

Thanks,
Jonathan
