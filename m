From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Cloning into an existing, non-empty directory?
Date: Thu, 21 Apr 2011 17:03:27 -0500
Message-ID: <20110421220327.GA3396@elie>
References: <BANLkTi=VwiqN99AMEJb6jb1uFya2Hipibw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Richard Hartmann <richih.mailinglist@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 22 00:03:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QD1yP-0001wm-Gf
	for gcvg-git-2@lo.gmane.org; Fri, 22 Apr 2011 00:03:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755274Ab1DUWDg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Apr 2011 18:03:36 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:44686 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752428Ab1DUWDf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Apr 2011 18:03:35 -0400
Received: by gyd10 with SMTP id 10so44600gyd.19
        for <git@vger.kernel.org>; Thu, 21 Apr 2011 15:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=wzcyuEHnB0cpL3BiFiqd+FukbxiAWgMdnw2wPEMSTT0=;
        b=v73ICTgMhe5RE3zWTyG3ZbizXai9ZsDjlLXV5m6WLTW6vr2cm72+TjzdSTkmH6QwXD
         NKKi4loaKUOhi8N9By6h2SC+U+qGhAa+ymNkoPfZs/aTxr8vz0R4KtWGaYNFH5YeM3Yq
         3Yy6Kon/8a0Tc+AkODEmUp6FXnXRoULUIXMYc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=hK1LBARr+qNRXnJlG+DGcEi3S/SbJ7TUTAkIV8czAy13K7D4h1/8D/KO5jbgsPIvZN
         xWlgM8hs1Pr8HBM0pupqF+0Yh69TxMCUs7PW9g9O7w0OGJ6M0JnrnHXJS066ifiX+wzj
         mTw3ra+XbQ+nrM/l9ZJNmzr+7gNJhcl3yY8xo=
Received: by 10.236.143.41 with SMTP id k29mr524745yhj.64.1303423414597;
        Thu, 21 Apr 2011 15:03:34 -0700 (PDT)
Received: from elie (adsl-69-209-64-141.dsl.chcgil.ameritech.net [69.209.64.141])
        by mx.google.com with ESMTPS id p51sm1026173yhm.56.2011.04.21.15.03.32
        (version=SSLv3 cipher=OTHER);
        Thu, 21 Apr 2011 15:03:33 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <BANLkTi=VwiqN99AMEJb6jb1uFya2Hipibw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171922>

Hi,

Richard Hartmann wrote:

> The only real
> problem left is that I can't clone initially as $HOME is obviously
> non-empty, resulting in
>
>   git --work-tree=$HOME \
>     --git-dir=$HOME/.config/vcsh/repo.d/mr.git \
>     clone <remote> .config/vcsh/repo.d/mr.git
> fatal: working tree '/home/richih' already exists.
>
> This means I am down to cloning, creating the directories I need,
> moving .git and the actual files around, making git aware that tracked
> files were not deleted, just moved, and then finally being able to use
> my repo.

Have you tried something like the following?

	cd $CROWDED_DIRECTORY
	GIT_DIR=/path/to/git/dir
	GIT_WORK_TREE=$(pwd)
	export GIT_DIR GIT_WORK_TREE

	git init
	git remote add origin <remote>
	git pull

Two more caveats for the road. :)

 - git does not track detailed file permissions or secret/non-secret
   status.  Please be careful about ssh private keys and so on.

 - when updating the worktree, git will unlink existing files before
   replacing them and does not fsync the result.  So one should be
   careful when tracking files that will cause major harm if they go
   missing temporarily (though I can't think of any major examples in
   $HOME offhand).

Happy hacking,
Jonathan
