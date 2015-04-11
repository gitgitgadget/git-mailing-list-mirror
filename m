From: Elliot Wolk <elliot.wolk@gmail.com>
Subject: rebase --root conflicts with --committer-date-is-author-date
Date: Sat, 11 Apr 2015 14:29:55 -0400
Message-ID: <55296823.4010409@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 11 20:30:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yh0AV-00036d-Cp
	for gcvg-git-2@plane.gmane.org; Sat, 11 Apr 2015 20:30:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754889AbbDKS36 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 Apr 2015 14:29:58 -0400
Received: from mail-qk0-f169.google.com ([209.85.220.169]:33889 "EHLO
	mail-qk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754058AbbDKS36 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Apr 2015 14:29:58 -0400
Received: by qkgx75 with SMTP id x75so90039268qkg.1
        for <git@vger.kernel.org>; Sat, 11 Apr 2015 11:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        bh=2C/pthOXwHkWhc9cYQy36O6v4EZKZLb+BXnTSS0c7KI=;
        b=wCpF4OJc3lI6YFKcoYaPVeQNNagvFGFXOdm8Y34ibRL/GXa6teHRjJhKbV3K9I1PiA
         StRW5cCpGO6zXI9SnqQsgD91Ck5dL/C9ySQUALp9f0rz+Lx2BRU8hKtYD5ZR5iqA0g0w
         PPQ96X5BWA1afKmUE1fAwce+ZZRUyITuMn1H6cLOmd1tNnlQ+7ZygXUqkW8DkNb1wSke
         zkLpwXq/uvw14JmSE0Mj+vGWSltJyzdWmW3+9tc3JNx6J8XpTpsV+IAXFf/YVzCPD+Fe
         JJklci9o4jE37YO3tk3eyC6S2mVegPL94CfjpE5F31p7ZUFjN8ral0fVKCDM+kiZsLHl
         /JKQ==
X-Received: by 10.140.98.3 with SMTP id n3mr8591116qge.62.1428776997280;
        Sat, 11 Apr 2015 11:29:57 -0700 (PDT)
Received: from [192.168.11.50] (pool-74-108-147-174.nycmny.fios.verizon.net. [74.108.147.174])
        by mx.google.com with ESMTPSA id c35sm1897534qkh.37.2015.04.11.11.29.56
        for <git@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 11 Apr 2015 11:29:56 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:34.0) Gecko/20100101 Icedove/34.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267029>

============
version:

git version 2.1.4
Linux wolke-w520 3.19.3-towo.1-siduction-amd64 #1 SMP PREEMPT siduction 
3.19-9 (2015-03-26) x86_64 GNU/Linux
============
summary:

if i do `git rebase --committer-date-is-author-date --root', the 
committer date is set to now, instead of set to the author date.
when rebasing onto the first commit, it works perfectly well.
============
reproduce:

set -x
cd
mkdir test
cd test
git init
echo line >> a; git add a; git commit -m 'jan1' --date '2015-01-01'
echo line >> a; git add a; git commit -m 'jan2' --date '2015-01-02'
echo line >> a; git add a; git commit -m 'jan3' --date '2015-01-03'
git log --format=format:%s-%cD-%aD%n
git rebase --committer-date-is-author-date HEAD^^
git log --format=format:%s-%cD-%aD%n
git rebase --committer-date-is-author-date --root
git log --format=format:%s-%cD-%aD%n
git rebase --committer-date-is-author-date HEAD^^
git log --format=format:%s-%cD-%aD%n
git rebase --committer-date-is-author-date --root
git log --format=format:%s-%cD-%aD%n
============
expected:

jan3-Sat, 03 Jan 2015 13:28:06 -0500-Sat, 3 Jan 2015 13:28:06 -0500
jan2-Sat, 02 Jan 2015 13:28:06 -0500-Fri, 2 Jan 2015 13:28:06 -0500
jan1-Sat, 01 Jan 2015 13:28:06 -0500-Thu, 1 Jan 2015 13:28:06 -0500
============
actual:

jan3-Sat, 11 Apr 2015 14:28:06 -0400-Sat, 3 Jan 2015 13:28:06 -0500
jan2-Sat, 11 Apr 2015 14:28:06 -0400-Fri, 2 Jan 2015 13:28:06 -0500
jan1-Sat, 11 Apr 2015 14:28:06 -0400-Thu, 1 Jan 2015 13:28:06 -0500

{full output: http://pastie.org/10086950}
============
sorry if dupe/wrong-venue/poorly-formatted/incomprehensible. i tried.
