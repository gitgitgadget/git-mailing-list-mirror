From: "Geoff Russell" <geoffrey.russell@gmail.com>
Subject: Re: exporting the last N days of a repository
Date: Wed, 5 Nov 2008 09:19:33 +1030
Message-ID: <93c3eada0811041449u20e0fc74gf6a1cb420923e484@mail.gmail.com>
References: <93c3eada0810281801l29253e02g95c7a6851c4c4db3@mail.gmail.com>
	 <alpine.DEB.1.00.0810291610340.22125@pacific.mpi-cbg.de.mpi-cbg.de>
	 <93c3eada0811021716y37ba999fkc2085b1060fbea2d@mail.gmail.com>
	 <cc29171c0811030855s2fb0d7a5ncdfdd6acd7c71537@mail.gmail.com>
Reply-To: geoffrey.russell@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 04 23:50:56 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KxUjZ-0002OQ-Dw
	for gcvg-git-2@gmane.org; Tue, 04 Nov 2008 23:50:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754382AbYKDWtf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Nov 2008 17:49:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754445AbYKDWtf
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Nov 2008 17:49:35 -0500
Received: from yw-out-2324.google.com ([74.125.46.30]:25076 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754380AbYKDWte (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Nov 2008 17:49:34 -0500
Received: by yw-out-2324.google.com with SMTP id 9so1300400ywe.1
        for <git@vger.kernel.org>; Tue, 04 Nov 2008 14:49:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:reply-to
         :to:subject:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=rsINFRlxmTRwwIOVAYyLhz/UG8ezN6yboed7kO//r1s=;
        b=Wuq89J05+Oz3aM99ap75d2g0Q/+hOw4KwKRSZz+iXPOs9OxuCOE9ZKxYRBs07p+snW
         bQn5hDyHdy1sVPtIQl+NrNPRr2qth/TPI6o7Qpc15IJrvBdTuKBvZmRIEtlD0Cav1kuZ
         BVEVGU/Z/XX9DQrMeYhLpvRMOHPgVJzVKQ89k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:reply-to:to:subject:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=mslmmklwf89tmsCAS/eDFgyRq3q/sg16leSaa3lhjhdelPkNAMzEkyGoCfe40q1Ao4
         xpweQ8qCwjGfJflwcmP7R2w2Bp89Ol5FMZFPmUJoN7P3/0+ukPyZ8thszekjyk1+Uaki
         81ZhaJGM3bvQqXtB0IFZ41ynX4iF7dDDQF99c=
Received: by 10.150.137.12 with SMTP id k12mr394066ybd.141.1225838973315;
        Tue, 04 Nov 2008 14:49:33 -0800 (PST)
Received: by 10.150.181.6 with HTTP; Tue, 4 Nov 2008 14:49:33 -0800 (PST)
In-Reply-To: <cc29171c0811030855s2fb0d7a5ncdfdd6acd7c71537@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100112>

Apologies to Johannes and Bob who have tried to help
but I'm still having difficulties, here is my current non-working script:

------------------------------------------------------------------
#!/bin/sh
DIR=/tmp/gitdemo
# for testing just arbitrarily
# select the 15th most recent commit as our new origin
NEWORIGIN=$(git rev-list master@{15} | head -1)
echo $NEWORIGIN
# checkout earlist point we are interested in
# we want to drop any history before this point
git checkout $NEWORIGIN
# now make a new directory, initialise with new origin
# and apply all commits after that point
mkdir $DIR && (cd $DIR ; git init) &&  \
    rsync -aHv --exclude=.git ./ $DIR && \
    (cd $DIR ; git add . ; git commit -m "starting point" </dev/null ) && \
    git fast-export $NEWORIGIN..master | (cd $DIR ; git fast-import )

----------------- end of script

The fast-import gives me a message I don't understand and doesn't
do the import.
