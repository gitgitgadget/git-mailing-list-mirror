From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] Expand ~ and ~user in core.excludesfile, commit.template
Date: Mon, 16 Nov 2009 15:47:29 -0800 (PST)
Message-ID: <m3k4xqc9qj.fsf@localhost.localdomain>
References: <1258366060-27966-1-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Karl Chen <quarl@quarl.org>
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Tue Nov 17 00:47:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NABIK-00008l-QN
	for gcvg-git-2@lo.gmane.org; Tue, 17 Nov 2009 00:47:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754733AbZKPXr0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Nov 2009 18:47:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754564AbZKPXr0
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Nov 2009 18:47:26 -0500
Received: from mail-fx0-f221.google.com ([209.85.220.221]:36190 "EHLO
	mail-fx0-f221.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754707AbZKPXrZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Nov 2009 18:47:25 -0500
Received: by fxm21 with SMTP id 21so3325520fxm.21
        for <git@vger.kernel.org>; Mon, 16 Nov 2009 15:47:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=S2+oAvKIi8ZE3KO4G9ucfTd2f1pAa54/VQK06RJVHYo=;
        b=oQFY68P8ZhoUpYjPgn8sHAF1hsnGwZFooGOwUpHn+5U7Q09qLbYBungvqnuVasIWrK
         2chbcuXOvH9pinGPHFow5EQElb4dAXT4U3Pza0YVAzMa1CjrdXPXIVj2uSBPUDrSdvZ+
         EpBG5dfbESsozIlqfXWe0smSxk7l5GHizDhbk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=Jat4gy71OQE5rluP68a7tkbYSu2CcQrKGwJwCbiFaPCkYSDGCfcd5KPkmMR43BdLXw
         UJTVKOpxNeneBrLuvrazGvuVYZndgiEL4Jx8jIOcL2mBVz8i9bXSN0/z0z0Rf5B5GQom
         VchKCw9MV3LwxKBuCCgRN3tWvMTKHVAT82kcg=
Received: by 10.204.20.143 with SMTP id f15mr5589108bkb.49.1258415250180;
        Mon, 16 Nov 2009 15:47:30 -0800 (PST)
Received: from localhost.localdomain (abwn221.neoplus.adsl.tpnet.pl [83.8.237.221])
        by mx.google.com with ESMTPS id 16sm176818fxm.8.2009.11.16.15.47.28
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 16 Nov 2009 15:47:29 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id nAGNm7FV009645;
	Tue, 17 Nov 2009 00:48:07 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id nAGNm59F009642;
	Tue, 17 Nov 2009 00:48:05 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <1258366060-27966-1-git-send-email-Matthieu.Moy@imag.fr>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133038>

Matthieu Moy <Matthieu.Moy@imag.fr> writes:

> These config variables are parsed to substitute ~ and ~user with getpw
> entries.
> 
> user_path() refactored into new function expand_user_path(), to allow
> dynamically allocating the return buffer.
> 
> Original patch by Karl Chen, modified by Matthieu Moy.
> 
> Signed-off-by: Karl Chen <quarl@quarl.org>
> Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
> ---

> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index d1e2120..c37b51d 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -380,7 +380,8 @@ Common unit suffixes of 'k', 'm', or 'g' are supported.
>  core.excludesfile::
>  	In addition to '.gitignore' (per-directory) and
>  	'.git/info/exclude', git looks into this file for patterns
> -	of files which are not meant to be tracked.  See
> +	of files which are not meant to be tracked.  "~" and "~user"
> +	are expanded to the user's home directory.  See
>  	linkgit:gitignore[5].
>  
>  core.editor::

It would be nice to have an option to git-config which would do such
expansion, as a separate type similar to --int and --bool, e.g.:

  git config --path section.key

so that not only core.excludesfile could use this new feature, but for
example also core.worktree, commit.template, gitcvs.logfile,
mailmap.file, and perhaps also *.receivepack and *.uploadpack

-- 
Jakub Narebski
Poland
ShadeHawk on #git
