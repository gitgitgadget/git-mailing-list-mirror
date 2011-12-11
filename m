From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: best way to fastforward all tracking branches after a fetch
Date: Sun, 11 Dec 2011 07:52:18 +0530
Message-ID: <20111211022218.GA22749@sita-lt.atc.tcs.com>
References: <jbvj5o$skt$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Gelonida N <gelonida@gmail.com>
X-From: git-owner@vger.kernel.org Sun Dec 11 03:23:08 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RZZ4G-0006l3-8v
	for gcvg-git-2@lo.gmane.org; Sun, 11 Dec 2011 03:23:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751315Ab1LKCWe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Dec 2011 21:22:34 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:55528 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750934Ab1LKCWd (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Dec 2011 21:22:33 -0500
Received: by iaeh11 with SMTP id h11so1020191iae.19
        for <git@vger.kernel.org>; Sat, 10 Dec 2011 18:22:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=KSN/UVzkUCTXeDWj03hyhE7OpQVy7KUZAqqxePnL4Qc=;
        b=Z9pRw00XJKronlpgF8ry4xTk2ksxbrOrIfaFa9MPDuAtBtqZ1FB+uhf0Dx1FVjcESe
         1wVnG+qz1FYx+TyxLlUVfeIOjBBPiYsLxP4anRHMaNKLvRrNOKQJHg1e6ZVKhnNXjw3E
         TpYm3SKOO5xLE7OptFoORj6P56Pj5rYzz+Rog=
Received: by 10.50.220.231 with SMTP id pz7mr9348495igc.94.1323570153101;
        Sat, 10 Dec 2011 18:22:33 -0800 (PST)
Received: from sita-lt.atc.tcs.com ([117.195.174.217])
        by mx.google.com with ESMTPS id ew6sm29226386igc.4.2011.12.10.18.22.30
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 10 Dec 2011 18:22:32 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <jbvj5o$skt$1@dough.gmane.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186796>

On Sat, Dec 10, 2011 at 01:26:32PM +0100, Gelonida N wrote:
> Hi,
> 
> What is the best way to fastforward all fastforwardable tracking
> branches after a git fetch?

I dont think there is a single command to do it for *all*
branches, but for any particular branch, this should work:

    git merge --ff-only @{u}

So what you want would boil down to this script (untested):

    #!/bin/bash
    git status --porcelain -uno | grep . && {echo dirty tree, exiting...; exit 1; }

    for b in `git for-each-ref '--format=%(refname:short)' refs/heads`
    do
        git checkout $b
        git merge --ff-only @{u}
    done
