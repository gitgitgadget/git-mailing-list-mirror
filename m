From: Ephrim Khong <dr.khong@gmail.com>
Subject: [Bug] git gc with alternates tries accessing non-existing directory
Date: Wed, 18 Mar 2015 09:11:48 +0100
Message-ID: <55093344.9030500@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
To: GIT Mailing-list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Mar 18 09:12:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YY954-0007t8-IG
	for gcvg-git-2@plane.gmane.org; Wed, 18 Mar 2015 09:11:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754995AbbCRILy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Mar 2015 04:11:54 -0400
Received: from mail-we0-f180.google.com ([74.125.82.180]:36688 "EHLO
	mail-we0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754887AbbCRILv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Mar 2015 04:11:51 -0400
Received: by wetk59 with SMTP id k59so25758063wet.3
        for <git@vger.kernel.org>; Wed, 18 Mar 2015 01:11:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        bh=T1bsTkAW+kKSNvmvfL8p09iFXQLIpBy5L4YIBvlebcw=;
        b=WtQwM9T1IdCaIf0vz/lwXOKwew8T9Beb4I1zsYDx9xDFfGOMzomIiUSx6g3nv4VSYb
         CEgNuOU7bP6Egx2Rp5cb9IssaGE9Lhnr40SU82WV9lrN1FGLeantJjMzAiqV2kMUPT+w
         510+rxmD6AwLeNdBb9RKeUUgfBsqpL/LRrLNoKuOPP2dmzi1KLhbCptvGxp5tEfWXIyU
         8I7Gd3Z5UhcE7Yz8FkOTBCyVH5ZLQ7JK3ktVUdNHpSPDJ3Cx60guz064TK5k8jqAUCze
         yHigzfB671OQ3P6rl01dl9wXdoxFYlcXQTY+8yyE0hLYOV3GhHjVqvDbp+DzcNz8ROn8
         INPQ==
X-Received: by 10.180.35.72 with SMTP id f8mr4520713wij.31.1426666310255;
        Wed, 18 Mar 2015 01:11:50 -0700 (PDT)
Received: from [10.0.100.231] (merlin.mvtec.com. [62.96.232.130])
        by mx.google.com with ESMTPSA id nd15sm2051327wic.8.2015.03.18.01.11.49
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Mar 2015 01:11:49 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.5.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265692>

I have a non-bare repository /home/a set up with an alternate to the 
bare repository /b. Running  git gc  on /home/a produces below's error

   error: unable to open 
/b/objects/56/b969ffdf64343777a069260f41761dc0551bfa/00: Not a directory

The referenced file

   /b/objects/56/b969ffdf64343777a069260f41761dc0551bfa

exists, but is not a directory.

Thanks,
- Eph

 > git --version
git version 2.3.0

 > cat /home/a/.git/objects/info/alternates
/b/objects

 > cd /home/a && git gc
Counting objects: 4046, done.
Delta compression using up to 32 threads.
Compressing objects: 100% (970/970), done.
Writing objects: 100% (4046/4046), done.
Total 4046 (delta 3074), reused 4046 (delta 3074)
error: unable to open 
/b/objects/56/b969ffdf64343777a069260f41761dc0551bfa/00: Not a directory
fatal: unable to mark recent objects
error: failed to run prune

 > ls -al /b/objects/56
-r--r--r-- ##   199 Mar 11 11:21 0ae39e1f65160f0256aa1411d6c3c6d36cb79a
-r--r--r-- ##  1717 Mar 10 17:15 0c22f578c0f47c54bcd9de899701fceb08607a
-r--r--r-- ##   477 Mar  5 11:34 0dc6b1dac39e4366c739ede698232ce1a02d1a
-r--r--r-- ##    51 Mar  5 09:04 14ee4b890b61b9e8ac07a05b878d44ed2138da
-r--r----- ##   431 Mar  5 15:58 161adcb8a02868940f2fab2e7eb084de9a106a
-r--r--r-- ##   264 Mar 11 14:35 30af07890c31e54bc92da16ee6557d9ffba21a
-r--r----- ##   795 Mar 13 09:35 4ab2cb69f2f2e22215772f2ae604d24863ab9a
-r--r--r-- ##   181 Mar  9 12:38 ad631112e5971e872a88946cbae8176b4563ba
-r--r----- ## 14574 Mar  2 16:25 b969ffdf64343777a069260f41761dc0551bfa
-r--r--r-- ##   821 Mar  6 11:16 c55b01a68613c0ea1946869bb9b72370b8738a
-r--r--r-- ##  8199 Mar  4 12:14 cb732d06ae2adf04150766a70ca079e11801aa
-r--r----- ##   261 Mar 10 09:47 fadac9ce2f87392986438737b329fc6cab18ca
