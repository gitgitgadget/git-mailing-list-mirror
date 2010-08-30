From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 12/13] git-remote-testgit: only push for non-local
 repositories
Date: Sun, 29 Aug 2010 20:48:21 -0500
Message-ID: <20100830014821.GF2305@burratino>
References: <1283053540-27042-1-git-send-email-srabbelier@gmail.com>
 <1283053540-27042-13-git-send-email-srabbelier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 30 03:50:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OptVl-0003Cn-1y
	for gcvg-git-2@lo.gmane.org; Mon, 30 Aug 2010 03:50:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754508Ab0H3BuG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Aug 2010 21:50:06 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:54288 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754381Ab0H3BuF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Aug 2010 21:50:05 -0400
Received: by gxk23 with SMTP id 23so1797716gxk.19
        for <git@vger.kernel.org>; Sun, 29 Aug 2010 18:50:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=CnqQGM1pP4b4VAUXSgSkBgWAkBqMF8l9z8fbNNOe4WI=;
        b=C9YV48P4yygnznyln1/kRysIxOvO0uWLNGjzJXg6sbRA1ZaG4w6+0PcIa/8BC5ohGZ
         a1OL/ke/ZrDDeERxhxulO2mCVLys1wrR/Ezp9S2vIFm2WcveDaOXwf0YlriPogfoEqmW
         sMvx7ywQnxSn8s5GVQnt8uZStTSLMM5WzmReU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=DiBscOvx/DHeu/vcu6KLhlxsY15qDkhjwLwLAm/LycoIxAvnd7prDjNi7NPGPb0Rgp
         /jqqzenShdRdJ0s5+6eE7H3DRnFRSPKs0Ljo9FVeQVmn5613jUVPrwhA5dKBp8CmMsfe
         NVJyojSRfXB4yYUQxi84olly7bqMcnGqFjbgQ=
Received: by 10.151.158.10 with SMTP id k10mr4445253ybo.356.1283133004993;
        Sun, 29 Aug 2010 18:50:04 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id q31sm6989825ybk.13.2010.08.29.18.50.03
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 29 Aug 2010 18:50:04 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1283053540-27042-13-git-send-email-srabbelier@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154743>

Sverre Rabbelier wrote:
> Trying to push for local repositories will fail since there is no
> local checkout in .git/info/... to push from.
> 
> This went unnoticed because the transport helper infrastructure did
> not check the return value of the helper.
> ---
> 
>   I guess it also shows how many people look at the verbose output of
>   the helper test suite ;-).
[...]
> +++ b/git-remote-testgit.py
> @@ -160,7 +160,9 @@ def do_export(repo, args):
>  
>      update_local_repo(repo)
>      repo.importer.do_import(repo.gitdir)
> -    repo.non_local.push(repo.gitdir)
> +
> +    if not repo.local:
> +        repo.non_local.push(repo.gitdir)

[warning: I have not read through remote-testgit carefully]

Could you explain further?  I see

 ERROR: could not find repo at .git/info/fast-import/4dc49bf026b65e6a1b28e2457d4d6393af8d382c/.git

but I do not know why there should have been a repo there, or why we would
not want to do the equivalent of

 git push . refs/testgit/origin/refs/heads/master:refs/heads/master
