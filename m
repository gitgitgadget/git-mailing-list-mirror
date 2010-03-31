From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: git_get_project_config requires only $git_dir, not also $project
Date: Wed, 31 Mar 2010 19:47:31 +0200
Message-ID: <201003311947.33587.jnareb@gmail.com>
References: <4BAE4F07.3040806@gentoo.org> <201003272027.59216.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: Tobias Heinlein <keytoaster@gentoo.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 31 19:47:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nx21C-00037W-RV
	for gcvg-git-2@lo.gmane.org; Wed, 31 Mar 2010 19:47:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757907Ab0CaRru (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Mar 2010 13:47:50 -0400
Received: from mail-bw0-f209.google.com ([209.85.218.209]:62064 "EHLO
	mail-bw0-f209.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757815Ab0CaRrt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Mar 2010 13:47:49 -0400
Received: by bwz1 with SMTP id 1so272351bwz.21
        for <git@vger.kernel.org>; Wed, 31 Mar 2010 10:47:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=gLwStr3SW0H+aPXWXjU2vgz7IE3qmFP4ODzhwZFeQwk=;
        b=EMknDHtiEspkzeINXzChUTQia9f087cBT0pg7pBRtkweIduFLphhiyvypeYsCB3GK4
         +a8LMyyh7hqzCWkZlebv3mFbrAeqNUrOOwZMKWSvkgP5p+M/j1tClEG3k8nkhBxgTEDP
         KPGYCGngCZeCIYXQLzjDKAIY/RQxqULiyX468=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=dHzqVdV/pC1Nsh8bdyBeh3GcE1tyDSsmzc7lm/z6LvlEh45OI/j/rQGOKjp+s4WlnD
         5f8nr80UOP4K0yVAZdnAp7Pz2D4l1jtBNVAhNNTWGtPnrwmiadmIHt3veskRrIv5bizD
         8ekfkD+/QkKEUVytKTa4EUZj60Z+TKH8R59/0=
Received: by 10.204.33.206 with SMTP id i14mr1316445bkd.52.1270057667542;
        Wed, 31 Mar 2010 10:47:47 -0700 (PDT)
Received: from [192.168.1.13] (abuz2.neoplus.adsl.tpnet.pl [83.8.197.2])
        by mx.google.com with ESMTPS id 24sm59410042bkr.0.2010.03.31.10.47.45
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 31 Mar 2010 10:47:46 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <201003272027.59216.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143688>

Ping!  This patch is straight fix for a recently introduced bug
(in a bugfix)... and it removes more than it adds.

On Sat, 27 Mar 2010, Jakub Narebski wrote:
> On Sat, 27 Mar 2010, Tobias Heinlein wrote:
> 
> > I stumbled upon a small bug in gitweb that was introduced by commit
> > 9be3614eff36271d5f1cd460a568a219902cb044.
> > 
> > The projects list page is no longer able to display the projects'
> > descriptions and owners properly when they are set in the git config
> > file, e.g. like this:
> > 
> >   [gitweb]
> >           owner = Tobias Heinlein
> >           description = test
[...]

> Does the following patch fixes this issue?
> 
> -- >8 --
> From: Jakub Narebski <jnareb@gmail.com>
> Date: Sat, 27 Mar 2010 20:26:59 +0100
> Subject: [PATCH] gitweb: git_get_project_config requires only $git_dir, not also $project
> 
> Fix overeager early return in git_get_project_config, introduced in 9be3614
> (gitweb: Fix project-specific feature override behavior, 2010-03-01).  When
> git_get_project_config is called from projects list page via
> git_get_project_owner($path) etc., it is called with $git_dir defined (in
> git_get_project_owner($path) etc.), but $project variable is not defined.
> git_get_project_config doesn't use $project variable anyway.
> 
> Reported-by: Tobias Heinlein <keytoaster@gentoo.org>
> Signed-off-by: Jakub Narebski <jnareb@gmail.com>
> ---
>  gitweb/gitweb.perl |    3 +--
>  1 files changed, 1 insertions(+), 2 deletions(-)
> 
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index a2d2283..c356e95 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -2216,8 +2216,7 @@ sub config_to_multi {
>  sub git_get_project_config {
>  	my ($key, $type) = @_;
>  
> -	# do we have project
> -	return unless (defined $project && defined $git_dir);
> +	return unless defined $git_dir;
>  
>  	# key sanity check
>  	return unless ($key);
> -- 
> 1.7.0.1
> 
> 

-- 
Jakub Narebski
Poland
