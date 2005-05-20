From: Jeff Garzik <jgarzik@pobox.com>
Subject: checkout-cache -f: a better way?
Date: Fri, 20 May 2005 17:05:06 -0400
Message-ID: <428E5102.60003@pobox.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------030400040304000103080201"
X-From: git-owner@vger.kernel.org Fri May 20 23:06:20 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DZEfT-0006dG-CZ
	for gcvg-git@gmane.org; Fri, 20 May 2005 23:04:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261584AbVETVFX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 May 2005 17:05:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261588AbVETVFW
	(ORCPT <rfc822;git-outgoing>); Fri, 20 May 2005 17:05:22 -0400
Received: from mail.dvmed.net ([216.237.124.58]:44729 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S261584AbVETVFL (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 May 2005 17:05:11 -0400
Received: from cpe-065-184-065-144.nc.res.rr.com ([65.184.65.144] helo=[10.10.10.88])
	by mail.dvmed.net with esmtpsa (Exim 4.51 #1 (Red Hat Linux))
	id 1DZEg8-0000Gw-Qw
	for git@vger.kernel.org; Fri, 20 May 2005 21:05:09 +0000
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050328 Fedora/1.7.6-1.2.5
X-Accept-Language: en-us, en
To: Git Mailing List <git@vger.kernel.org>
X-Spam-Score: 0.0 (/)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This is a multi-part message in MIME format.
--------------030400040304000103080201
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit


Being a weirdo, I don't use cogito for kernel development, just git 
itself.  I store branches in .git/refs/heads/ per the defacto standard, 
and use the attached script to switch the working directory from one 
branch to another.

Problem is, 'git-checkout-cache -q -f -a' really pounds the disk, and 
takes quite a while.

Is there any way to avoid -f, while ensuring that the working directory 
truly represents the new branch?

BitKeeper has a secret checkout arg '-S', which will leave files 
untouched if the mtime/size information is unchanged.

	Jeff




--------------030400040304000103080201
Content-Type: text/plain;
 name="git-switch-tree"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="git-switch-tree"

#!/bin/sh

if [ "x$1" != "x" ]
then
	if [ "$1" == "master" ]
	then
		( cd .git && rm -f HEAD && ln -s refs/heads/master HEAD )
	else
		if [ ! -f .git/refs/heads/$1 ]
		then
			echo Branch $1 not found.
			exit 1
		fi

		( cd .git && rm -f HEAD && ln -s refs/heads/$1 HEAD )
	fi
fi

git-read-tree $(cat .git/HEAD) && \
	git-checkout-cache -q -f -a && \
	git-update-cache --refresh


--------------030400040304000103080201--
