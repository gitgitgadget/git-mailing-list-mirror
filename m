From: Anton Akhiar <anton2k@gmail.com>
Subject: Bug report: Add submodule with --branch and --depth (git version
 2.5.0.windows.1)
Date: Wed, 9 Sep 2015 14:45:28 +0700
Message-ID: <55EFE398.60208@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 09 09:45:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZZa4O-0003B9-KQ
	for gcvg-git-2@plane.gmane.org; Wed, 09 Sep 2015 09:45:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752821AbbIIHpV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Sep 2015 03:45:21 -0400
Received: from mail-pa0-f47.google.com ([209.85.220.47]:35515 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751837AbbIIHpT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Sep 2015 03:45:19 -0400
Received: by pacfv12 with SMTP id fv12so2458039pac.2
        for <git@vger.kernel.org>; Wed, 09 Sep 2015 00:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-type:content-transfer-encoding;
        bh=MIgp/hYkDQGYipTIsBmKNV+g0to8atkfozsgOkHVb40=;
        b=BI9G/dGL98L7gjmz52c/Xc/mEnSs66kfhilIC+N24C372xJ74e+Dh/oVFF4qOtA/Gf
         z+gzolVsKGmPWjbfbQ3DNwhNmwrpXNimYRNa5aGVLmjb+jKqaHvcAyxChZoZ3nov17bV
         rpzzteHWXls0zx4uX1i30T8XwZWe/tMF4TCNHu7JM1riGDViA0msCjMZTKpqpUuX/6sB
         BWHM0te/rhhXuh28TgdZ7lVn6pwZc/kH4j68H7lsMYU328FczJDZrrXhEGeYjq0BJB61
         HKzktiNuk5sX8MdGs50itO/czcQTQoHks1zIB9fZ2IlIgI9tjXwPeRyoDdeWdRrjr9+Y
         g2Ag==
X-Received: by 10.69.3.228 with SMTP id bz4mr68531111pbd.79.1441784718880;
        Wed, 09 Sep 2015 00:45:18 -0700 (PDT)
Received: from [172.17.13.27] ([36.85.86.193])
        by smtp.gmail.com with ESMTPSA id vv2sm5956201pab.21.2015.09.09.00.45.17
        for <git@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Sep 2015 00:45:18 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.2.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277533>

Hi,

I am trying to add a submodule with option --branch and --depth 
together, and failed. However, there is no problem if only one of them 
is applied.

So, this worked:
git submodule add --branch develop 
https://anton@bitbucket.org/anton/mysubmodule.git

This is also worked:
git submodule add --depth 1 
https://anton@bitbucket.org/anton/mysubmodule.git

But this won't worked:
git submodule add --branch develop --depth 1 
https://anton@bitbucket.org/anton/mysubmodule.git


Here is how to replicate the problem:

Setup remote repositories, e.g. in bitbucket:
For superproject: https://anton@bitbucket.org/anton/mysuperproject.git
For submodule: https://anton@bitbucket.org/anton/mysubmodule.git

Setup local repository for superproject:
git init mysuperproject
cd mysuperproject
echo "This is the parent project" > README
git add README
git commit -m "add README"
git remote add origin https://anton@bitbucket.org/anton/mysuperproject.git
git push --all -u origin

Setup local repository for submodule with branch "develop":
cd ..
git init mysubmodule
cd mysubmodule
echo "This is the submodule" > README
git add README
git commit -m "add README"
git branch develop master
git remote add origin https://anton@bitbucket.org/anton/mysubmodule.git
git push --all -u origin

Now, go to superproject and add submodule with options --branch and --depth:
cd ../mysuperproject
git submodule add --branch develop --depth 1 
https://anton@bitbucket.org/anton/mysubmodule.git mysubmodule

Output:
Cloning into 'mysubmodule'...
Password for 'https://anton@bitbucket.org':
remote: Counting objects: 3, done.
remote: Total 3 (delta 0), reused 0 (delta 0)
Unpacking objects: 100% (3/3), done.
Checking connectivity... done.
fatal: Cannot update paths and switch to branch 'develop' at the same time.
Did you intend to checkout 'origin/develop' which can not be resolved as 
commit?
Unable to checkout submodule 'mysubmodule'
