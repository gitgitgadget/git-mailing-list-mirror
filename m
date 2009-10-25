From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: [PATCH 5/7] t5540-http-push: check existence of fetched files
Date: Sun, 25 Oct 2009 17:49:13 +0100
Message-ID: <20091025164913.GA11267@localhost>
References: <20091025232142.6558d9e4.rctay89@gmail.com> <20091025232044.06d7ce5c.rctay89@gmail.com> <20091025231932.be9a6dfa.rctay89@gmail.com> <20091025231809.15b470fa.rctay89@gmail.com> <20091025231651.18c75559.rctay89@gmail.com> <20091025232227.96769e50.rctay89@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 25 17:49:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N26HO-00013i-Pr
	for gcvg-git-2@lo.gmane.org; Sun, 25 Oct 2009 17:49:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753542AbZJYQtH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Oct 2009 12:49:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753166AbZJYQtH
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Oct 2009 12:49:07 -0400
Received: from mail-bw0-f227.google.com ([209.85.218.227]:38949 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752845AbZJYQtF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Oct 2009 12:49:05 -0400
Received: by bwz27 with SMTP id 27so1669909bwz.21
        for <git@vger.kernel.org>; Sun, 25 Oct 2009 09:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:sender:received:date:from:to
         :cc:subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=xxFiIztNWWpM9TIlYPTVNTkPv+jcmsaRik9HImeg/UA=;
        b=xQXEDiAEMsc2ND2+65ls7CkWPjedDHoPXp8Nl1AspjM4iqSqCDRZkx83RNLB3MiU+V
         BsTe806DsfItDb8XQluAO/Hpxf1DrO2/DjOKPRU19G5CycRNZoF1cdDOkoIhHnAT4Zd3
         VHXJOQ2VjuyDrv15322SUP/1QzHYbV/bDyyY4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=sender:date:from:to:cc:bcc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        b=Dk7gsQcp0sy04xwRFpxZdCzV35T4phC8NBhI4YZFXMmOssimrvrsY/Vd1v80l5f71D
         6E3m2g1XmFCurLhNJBCA3oQKYl5xFJ8EDpCg3zgkYJhtgJw6jL1KCCtgHLHJ2o0chPlI
         Ej73YZzqta07YkfjF9eQuM8TupOxoJ2picWR4=
Received: by 10.204.10.6 with SMTP id n6mr13337932bkn.27.1256489349347;
        Sun, 25 Oct 2009 09:49:09 -0700 (PDT)
Received: from darc.lan (p549A3880.dip.t-dialin.net [84.154.56.128])
        by mx.google.com with ESMTPS id 15sm674579bwz.4.2009.10.25.09.49.08
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 25 Oct 2009 09:49:09 -0700 (PDT)
Received: from drizzd by darc.lan with local (Exim 4.69)
	(envelope-from <drizzd@aon.at>)
	id 1N26HJ-0004ua-PH; Sun, 25 Oct 2009 17:49:13 +0100
Content-Disposition: inline
In-Reply-To: <20091025232227.96769e50.rctay89@gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131222>

On Sun, Oct 25, 2009 at 11:22:27PM +0800, Tay Ray Chuan wrote:

>  	# By reset, we force git to retrieve the object
>  	(cd "$ROOT_PATH"/fetch_unpacked &&
>  	 git reset --hard HEAD^ &&
>  	 git remote rm origin &&
>  	 git reflog expire --expire=0 --all &&
>  	 git prune &&
> -	 git push -f -v $HTTPD_URL/test_repo_unpacked.git master)
> +	 test ! -e ".git/objects/$COMMIT_PATH" &&
> +	 git push -f -v $HTTPD_URL/test_repo_unpacked.git master &&
> +	 test -e ".git/objects/$COMMIT_PATH")
>  '

This fails with smart HTTP. First of all, the objects are packed,
so I substituted the above with

 ! git rev-list -1 $HEAD &&
 git push -f -v $HTTPD_GIT_URL/test_repo_unpacked.git master &&
 git rev-list -1 $HEAD > rev-list.out &&
 test -n rev-list.out

That should be an equivalent test, right? But still, why should push
re-fetch the commit we just pruned? Smart HTTP does not do that and
therefore fails the last rev-list test:

 ++ git rev-list -1 9d498b0bbc2a25438e2fbd19081948da86028c23
 fatal: bad object 9d498b0bbc2a25438e2fbd19081948da86028c23

Clemens
