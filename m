From: Jon Seymour <jon.seymour@gmail.com>
Subject: Semantics of a workspace checkpoint
Date: Thu, 16 Jun 2005 18:21:28 +1000
Message-ID: <2cfc4032050616012146948b49@mail.gmail.com>
Reply-To: jon@blackcubes.dyndns.org
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Linus Torvalds <torvalds@osdl.org>,
	Junio C Hamano <junkio@cox.net>, Petr Baudis <pasky@ucw.cz>
X-From: git-owner@vger.kernel.org Thu Jun 16 10:16:34 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DipY2-00008d-Sw
	for gcvg-git@gmane.org; Thu, 16 Jun 2005 10:16:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261191AbVFPIVb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 16 Jun 2005 04:21:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261197AbVFPIVb
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Jun 2005 04:21:31 -0400
Received: from rproxy.gmail.com ([64.233.170.207]:24650 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261191AbVFPIV2 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Jun 2005 04:21:28 -0400
Received: by rproxy.gmail.com with SMTP id i8so225995rne
        for <git@vger.kernel.org>; Thu, 16 Jun 2005 01:21:28 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=WFneX0NiPMVtpdJN9UNfmvrY49gz2FxcW4ZRrAU5ANJMkC8SyBxJhP75LCpryzsArRr4fL8/E7P5OgKKoEwdEnWn3Fl0V4FlP54s3ib4grsUSmpM7k4Hz3OG3EnfK7Ux3hw3zMUFvncBZ2lFkgOvCJ6p5jpdcspZ2HmXSDDL8xA=
Received: by 10.38.88.14 with SMTP id l14mr440876rnb;
        Thu, 16 Jun 2005 01:21:28 -0700 (PDT)
Received: by 10.38.104.42 with HTTP; Thu, 16 Jun 2005 01:21:28 -0700 (PDT)
To: Git Mailing List <git@vger.kernel.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

I'd like to propose these as the semantics for the checkpointing of a workspace

On checkpoint, create a file called:

.git/checkpoint/<treeid>

where the contents of the file are:
    exactly identical to the index file immediately prior to the
checkpoint being performed

and the treeid is the tree that results from:

    git-update-cache $(git-diff-files | cut -f2)
    git-write-tree

To restore from the checkpoint, one does:

    /* magic to remove files that are not in the resulting tree */
    git-read-tree -m <treeid>
    git-checkout-cache -u -f -a
    cp .git/checkpoints/<treeid> .git/index

Comments?
-- 
homepage: http://www.zeta.org.au/~jon/
blog: http://orwelliantremors.blogspot.com/
