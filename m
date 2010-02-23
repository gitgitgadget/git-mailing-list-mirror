From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] git checkout -b: unparent the new branch with -o
Date: Tue, 23 Feb 2010 15:26:01 -0800 (PST)
Message-ID: <m3ocjfmt60.fsf@localhost.localdomain>
References: <1266960007-16127-1-git-send-email-erick.mattos@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Erick Mattos <erick.mattos@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 24 00:26:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nk48r-0006Kh-LK
	for gcvg-git-2@lo.gmane.org; Wed, 24 Feb 2010 00:26:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754465Ab0BWX0I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Feb 2010 18:26:08 -0500
Received: from mail-fx0-f219.google.com ([209.85.220.219]:52326 "EHLO
	mail-fx0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754166Ab0BWX0E (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Feb 2010 18:26:04 -0500
Received: by fxm19 with SMTP id 19so4434321fxm.21
        for <git@vger.kernel.org>; Tue, 23 Feb 2010 15:26:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=fWQ8hjknmVP3OZNuEGQHBoQXyjdkx/TOeu10uo4xygQ=;
        b=KRzGS6Mw8aBRGumtww+I0kEuDHBllu0vyxcM/eBxdXPIxmne3/+E0c4ScHovMiv8ee
         DfE+WhSrOPxV/iA2KA7WVRHMx9BS++S2spK1fOzrlfCYoBXfkPTnssAK9iZqzz0IWHvD
         TBC6KoyM7SSWvXXL267b6kCTU4CVOqy4rNanI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=hEfjIAKGv2AoGQwSSbCLGAU67fUGIlBD/2x8XVt7GTtUzrx3gZo7ezHClx+zyjq4Mq
         VUXGbjT9TO5Gtd+39oXwQ6stAFDt803vsMah1VjGYYhyqMVqS/j7FlOk8iOgs2Jtu0fe
         GebbPsRZjdyVKMBFKwe1P0mb9N/odC/Q8wQ2c=
Received: by 10.223.143.21 with SMTP id s21mr14223956fau.51.1266967562632;
        Tue, 23 Feb 2010 15:26:02 -0800 (PST)
Received: from localhost.localdomain (abwi180.neoplus.adsl.tpnet.pl [83.8.232.180])
        by mx.google.com with ESMTPS id z15sm8702241fkz.51.2010.02.23.15.25.59
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 23 Feb 2010 15:26:01 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o1NNPSmU006746;
	Wed, 24 Feb 2010 00:25:38 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id o1NNPCVi006742;
	Wed, 24 Feb 2010 00:25:12 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <1266960007-16127-1-git-send-email-erick.mattos@gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140867>

Erick Mattos <erick.mattos@gmail.com> writes:

> Subject: [PATCH] git checkout -b: unparent the new branch with -o

I would say it is rather: "git checkout -b: allow creating unrelated branch",
or something like that.

By the way, for the solution to be complete it should work not only for 
"git checkout -b" shortcut, but also for "git branch".

>
> Sometimes it is necessary to start up a new development branch of code
> intended to be merged in the near future to existing branches but which
> actually does not relate to them.

I'm not sure if 'unrelated but _intended to merge_' is most common
workflow utilizing unrelated branches... and whether git should
promote such workflow, even if only describing it in the commit
message.

> 
> The new -o/--orphan is intended to solve this situation allowing the
> creation of a new branch unparented to any other.

I think that for example '--root', or '--rootless', or '--unrelated'
would be a better name than '--orphan'.  Besides I don't think that
such rarely used option should squat on rare resource of single-letter
option.

> 
> After the 'checkout -o -b' the new branch is not saved until some files are
> added to the index and committed, exactly as if it was an initial commit.
> A 'git clean -df' would delete everything from the work tree making it
> empty for new files.

Does it mean that the index is empty, but the working area is
unchanged?  It is not clear from the commit message.

> 
> Signed-off-by: Erick Mattos <erick.mattos@gmail.com>
> ---
[...]

> --- a/Documentation/git-checkout.txt
> +++ b/Documentation/git-checkout.txt
> @@ -9,7 +9,7 @@ SYNOPSIS
>  --------
>  [verse]
>  'git checkout' [-q] [-f] [-m] [<branch>]
> -'git checkout' [-q] [-f] [-m] [-b <new_branch>] [<start_point>]
> +'git checkout' [-q] [-f] [-m] [-b <new_branch> [-o]] [<start_point>]

This is not stricly correct, as you can use either '-o' OR '<start_point>',
but not both (but you can use '-o' only together with '-b <new_branch>').



> +-o::
> +--orphan::
> +	When creating a new branch, set it up as unparented thus
> +	unrelated to the previous branch.
> +

Unparented?  Perhaps "set it up so first commit on this branch would
be root (parenless) commit".  Hmmm... it is not easy to describe it
well...

-- 
Jakub Narebski
Poland
ShadeHawk on #git
