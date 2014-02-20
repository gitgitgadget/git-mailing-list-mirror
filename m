From: Ephrim Khong <dr.khong@gmail.com>
Subject: git log omits deleting merges
Date: Thu, 20 Feb 2014 08:35:33 +0100
Message-ID: <5305B045.2060503@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 20 08:35:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WGOAX-0007LN-7M
	for gcvg-git-2@plane.gmane.org; Thu, 20 Feb 2014 08:35:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751624AbaBTHfh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Feb 2014 02:35:37 -0500
Received: from mail-bk0-f50.google.com ([209.85.214.50]:39893 "EHLO
	mail-bk0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750883AbaBTHfg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Feb 2014 02:35:36 -0500
Received: by mail-bk0-f50.google.com with SMTP id d7so502687bkh.23
        for <git@vger.kernel.org>; Wed, 19 Feb 2014 23:35:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        bh=eNG2S35bJVKsTimWLiLkWCWUddhHVN33MrOFT4v3fcs=;
        b=JtOICntXlCPeVERoZV+D5vDtyVmLa8d1BFsr1ws9YdsFmNbsaE/yJrH2ORS4wsbs9d
         8mnWZgH1ifm9dWUh2F/dRwROtDLgl29T/4bKfVvijWbThrF9T4jLaliuszVnEUlz4vyg
         ubW6p8AcxlGHuKMKHsOfRVgpsgaJEj3jD4kNdASdZoEfNCHTWl2nvm6jfX6h/YoYgKcn
         4wE4fqn0rmGDUw/aDelGKCUqFSGCh5AVGPbF1peVqRp5po2HBbMJ4QaYlLisYhx7074h
         yCkNWUJffqI7sHxw11FlcrGroNOFf8dOsQ5pR8ezJ1F8zqK8Jgiq7eoySlp2uPikHdnT
         IPyg==
X-Received: by 10.204.100.199 with SMTP id z7mr187094bkn.73.1392881735568;
        Wed, 19 Feb 2014 23:35:35 -0800 (PST)
Received: from [192.168.32.40] (merlin.mvtec.com. [62.245.183.130])
        by mx.google.com with ESMTPSA id i8sm2838896bko.10.2014.02.19.23.35.34
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 19 Feb 2014 23:35:34 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.3.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242427>

Hi, git log seems to omit merge commits that delete a file if --follow 
or --diff-filter=D is given. Below is a testcase. I'm not sure if it is 
desired behaviour for --diff-filter=D, but it's probably not correct 
that --follow _removes_ the merge commit from the log output.

Thanks - Eph

--
git init
touch some_file
git add some_file
git commit -m "initial"
git branch other_branch
echo foo > some_file
git commit -a -m "commit in master"
git checkout other_branch
echo bar > some_file
git commit -a -m "commit in other_branch"

git merge master --no-commit
rm some_file
git rm some_file
git commit -m "merge"

echo "log 1 - no output"
# note that --diff-filter=A and M work as expected
# the merge does not show up for --diff-filter=ACDMRTUXB either
git log --pretty=oneline --diff-filter=D -- some_file

echo "log 2 - merge is missing"
git log --pretty=oneline --follow --all -- some_file

echo "log 3 - complete"
git log --pretty=oneline --all -- some_file
--
