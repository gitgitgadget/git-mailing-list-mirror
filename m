From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Yet another base64 patch
Date: Wed, 13 Apr 2005 21:19:48 -0700
Message-ID: <425DEF64.60108@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Thu Apr 14 06:16:13 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DLvlc-0001MK-Gm
	for gcvg-git@gmane.org; Thu, 14 Apr 2005 06:15:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261428AbVDNETD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Apr 2005 00:19:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261429AbVDNETD
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Apr 2005 00:19:03 -0400
Received: from terminus.zytor.com ([209.128.68.124]:993 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S261428AbVDNES7
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Apr 2005 00:18:59 -0400
Received: from [172.27.0.18] (c-67-169-23-106.hsd1.ca.comcast.net [67.169.23.106])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.1/8.13.1) with ESMTP id j3E4It7i028269
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 13 Apr 2005 21:18:57 -0700
User-Agent: Mozilla Thunderbird 1.0.2-1.3.2 (X11/20050324)
X-Accept-Language: en-us, en
To: git@vger.kernel.org
X-Spam-Status: No, score=-5.9 required=5.0 tests=ALL_TRUSTED,BAYES_00 
	autolearn=ham version=3.0.2
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

I am assuming this will be the last one one way or another...

I decided that filenames/tags beginning with - was a really bad thing,
so I decided that, ugly though it might be, the best was to do a hybrid
between regular base64 (+ /) and filesystem-safe base64 (- _) and use
+ _ as the nonalpha characters needed.  I have updated the base64
patches as well as gitcvt, and also put out a flat version of gitcvt.

gitcvt also now converts the HEAD file over.  This requires pointing it
at the .dircache/.git directory instead of the objects directory inside.
  I have tested it on both the git and the kernel-test repositories.

Checking out the total kernel tree (time checkout-cache -a into an empty 
directory):

	Cache cold	Cache hot
stock	3:46.95		19.95
base64	5:56.20		23.74
flat	2:44.13		15.68

It seems that the flat format, at least on ext3 with dircache, is 
actually a major performance win, and that the second level loses quite 
a bit.

	-hpa

