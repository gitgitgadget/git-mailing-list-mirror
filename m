From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Keeping reflogs on branch deletion
Date: Thu, 14 Feb 2008 08:35:08 -0800 (PST)
Message-ID: <m33arvcx8x.fsf@localhost.localdomain>
References: <76718490802131739n22c56cadn39c1871ea1762dc3@mail.gmail.com>
	<ee77f5c20802131745p23aa1db3j47207f1e6538b0e@mail.gmail.com>
	<18355.42595.377377.433309@lisa.zopyra.com>
	<ee77f5c20802131903i45b1629fpcb4a5c6e4f483052@mail.gmail.com>
	<7vr6fgkxt2.fsf@gitster.siamese.dyndns.org>
	<20080214140152.GT27535@lavos.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	David Symonds <dsymonds@gmail.com>,
	Bill Lear <rael@zopyra.com>,
	Jay Soffian <jaysoffian@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: bdowning@lavos.net (Brian Downing)
X-From: git-owner@vger.kernel.org Thu Feb 14 17:35:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JPh3t-000074-MJ
	for gcvg-git-2@gmane.org; Thu, 14 Feb 2008 17:35:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753348AbYBNQfN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Feb 2008 11:35:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753838AbYBNQfN
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Feb 2008 11:35:13 -0500
Received: from ug-out-1314.google.com ([66.249.92.171]:23019 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753016AbYBNQfL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Feb 2008 11:35:11 -0500
Received: by ug-out-1314.google.com with SMTP id z38so1074186ugc.16
        for <git@vger.kernel.org>; Thu, 14 Feb 2008 08:35:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        bh=/FbUrwOOZHMzeDJTASNV6aAUR7juWBSNobBK3Fp4Aj0=;
        b=ryJeZF+A+h9RxZXfgrhunRxP/73EVpZGRXeYHWCmkfOiWCCNW+rLdg/HKhxXqb3C4GokNtCMTyMZJUBI2ycMNJ8Znl5Xwge5bFXZ+xQ7aPX7fyoLyOFS2HQPizmsa9RyFvr37DcyfsZNoTpYX4AullLVSyNYGGpYWED2U79r++o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        b=rLuhoNJ/IGsnkDK3hO0GgRuHSQLyVlCcniuQBe/nXJx0fjQyDnSEiZG/fOCX2GMv6CH6MxFKfwvqIzmJJJuXWRyo2re8hQv/As4B8bsiRziO8e0nrO9K0/kvMF/G8Dgrmpy51fMz5IOLgcjwhOgmM2mFo5yS2Gd0UJi9OSu36bA=
Received: by 10.67.40.15 with SMTP id s15mr106441ugj.46.1203006909607;
        Thu, 14 Feb 2008 08:35:09 -0800 (PST)
Received: from localhost.localdomain ( [83.8.219.2])
        by mx.google.com with ESMTPS id k2sm4480593ugf.12.2008.02.14.08.35.06
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 14 Feb 2008 08:35:08 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m1EGZ0Wi012861;
	Thu, 14 Feb 2008 17:35:01 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m1EGYtsf012858;
	Thu, 14 Feb 2008 17:34:55 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <20080214140152.GT27535@lavos.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73886>

Brian Downing <bdowning@lavos.net> writes:

> When deleting a branch, is there any reason we can't add a deletion
> entry into the reflog and keep the reflog around?  This would seem to be
> a lot safer; I know I've been burned by expecting the reflog safety net
> to be there, and surprised that it's not when I've deleted a branch.

There is techical problem with that, namely possibility of D/F
conflict. When you delete branch 'foo', you can later create branch
'foo/bar'. If reflog for 'foo' was not deleted, you couldn't create
reflog for 'foo/bar' because of directory / file conflict.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
