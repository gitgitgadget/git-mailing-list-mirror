From: Morten Welinder <mwelinder@gmail.com>
Subject: Re: "git-checkout-cache -f -a" failure
Date: Wed, 11 May 2005 14:31:48 -0400
Message-ID: <118833cc050511113122e2d17d@mail.gmail.com>
References: <118833cc05050911255e601fc@mail.gmail.com>
	 <7vr7gewuxt.fsf@assigned-by-dhcp.cox.net>
	 <20050510230357.GF26384@pasky.ji.cz>
	 <7vsm0us5p5.fsf@assigned-by-dhcp.cox.net>
Reply-To: Morten Welinder <mwelinder@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Petr Baudis <pasky@ucw.cz>, git@vger.kernel.org,
	Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Wed May 11 20:25:46 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DVvtD-0007lB-Lk
	for gcvg-git@gmane.org; Wed, 11 May 2005 20:25:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262016AbVEKScG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 May 2005 14:32:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262020AbVEKScF
	(ORCPT <rfc822;git-outgoing>); Wed, 11 May 2005 14:32:05 -0400
Received: from rproxy.gmail.com ([64.233.170.193]:10945 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262016AbVEKSbu convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 May 2005 14:31:50 -0400
Received: by rproxy.gmail.com with SMTP id a41so109118rng
        for <git@vger.kernel.org>; Wed, 11 May 2005 11:31:48 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=HPBaWNti+ZtF/7rCA1cI7yGIbu+5w+99m9bFoU43ScY5IHd9C5uOztFq+lXRQqslx+8y4r9jyclSQGjRbFD7adr7/YNRAakJbXV2REGmFzYkCTxkxJMyVhc2SM9K84uO8vtY/127k4xvA5UVJ+9A2gdSOIM0545F2WWUrpId2e8=
Received: by 10.38.153.45 with SMTP id a45mr373917rne;
        Wed, 11 May 2005 11:31:48 -0700 (PDT)
Received: by 10.38.76.77 with HTTP; Wed, 11 May 2005 11:31:48 -0700 (PDT)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vsm0us5p5.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Here's the symlink version.  Note, that git does not complain but
simply creates (or
overwrites) the wrong file.

Morten


cd /tmp
mkdir xxx
cd xxx
rm -rf .git dir yyy
mkdir dir
touch dir/empty
cg-init </dev/null
cg-tag initial
mkdir yyy
touch yyy/zzz
cg-add yyy/zzz
cg-commit </dev/null
cg-tag dir
rm -rf yyy
rm -f .git/HEAD
cat .git/refs/tags/initial > .git/HEAD
git-read-tree -m HEAD
git-checkout-cache -f -a
ln -s dir yyy
git-update-cache --add -- yyy
cg-commit </dev/null
cg-tag symlink
# Got that?

# yyy is a symlink right now.
git-read-tree `cat .git/refs/tags/dir`
git-checkout-cache -f -a
ls -l dir
total 0
-rw-rw-r--    1 welinder research        0 May 11 14:20 empty
-rw-rw-r--    1 welinder research        0 May 11 14:26 zzz
# dir/zzz should not exist at ths point!
