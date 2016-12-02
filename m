Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7B6881FC96
	for <e@80x24.org>; Fri,  2 Dec 2016 23:04:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752824AbcLBXEE (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Dec 2016 18:04:04 -0500
Received: from mail-pg0-f50.google.com ([74.125.83.50]:36673 "EHLO
        mail-pg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751164AbcLBXED (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Dec 2016 18:04:03 -0500
Received: by mail-pg0-f50.google.com with SMTP id f188so111772981pgc.3
        for <git@vger.kernel.org>; Fri, 02 Dec 2016 15:04:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mooflu-com.20150623.gappssmtp.com; s=20150623;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding;
        bh=UOwZ0DxufqixVEgcEqCTQm9YPUBs8wMPeMwIHVaK3x0=;
        b=TRbl508r8EB1/8ZAA120kTAQqBMyldqPYEkHJxn9TNNwGme0gWdm+VYKnJ/GLa75g/
         WefGCNOgmyxR6iYnhFuQ6FO1Cu1b//43heTTTMlboG/DCiq6nVnHD/9Skos2KE4CCRGQ
         n3dE2Z8LkrJDRqmP9mxVpmme51r5gXFW3sKl5bKYQyK2EDQorVvbumaNISj4CmCJP+M5
         MXyGyGahBlaQJ9z8JrJ4CA45Q8PmpZzoxQo6xmouvBqwiF6kySqU/AvighpNRemvqxt3
         UjvBVG1FwgjWQMrRr0cMWTUmpAYLK3ocylTObV7ovGFtoBU71oCjXpU611dzmBHxMaLI
         Zmjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding;
        bh=UOwZ0DxufqixVEgcEqCTQm9YPUBs8wMPeMwIHVaK3x0=;
        b=TkXNe4713JVh6tsvlpJZFvm2iDdxiUq3O+9cDWgbxzLQjLF92yhlCywNxTB0Pwd+1m
         OejU86sJbA9b8PWLfe3KXhMxv0cr1uGjTNp8DTjGd+SgMDxQLTqHlGpKdPbJZYJHFTMQ
         PTd+wJzKuqAGpJkMXj1WFxCqJ1mXWHVmxmtGAlnJYJFS8P8+ySHfiHrSmYoV9UyZyJns
         5dqRzznIYQqQXNhpCjkQGOQOFPOiu1L780SbpgupFlynyPzVRYYZ9V+uFc+X/WOiv0DQ
         fe7B9lkMIbdqP4+8/EY4QKWwkY1YmsQTAMdGIuRz4zwiSWjF6XGiHcFP38pCoyvqACdH
         6iPQ==
X-Gm-Message-State: AKaTC0020R6sCEp2LFb9lUtNdh4ZZMROH883M8/Rmv+vtryeyy68hSkpC9G2x3B4k6GFIA==
X-Received: by 10.99.240.83 with SMTP id s19mr82271486pgj.175.1480719842493;
        Fri, 02 Dec 2016 15:04:02 -0800 (PST)
Received: from Franks-Hacky.local (d99-199-86-243.bchsia.telus.net. [99.199.86.243])
        by smtp.googlemail.com with ESMTPSA id j190sm10054727pgd.23.2016.12.02.15.04.01
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 02 Dec 2016 15:04:01 -0800 (PST)
To:     git@vger.kernel.org
From:   Frank Becker <fb@mooflu.com>
Subject: difftool -d not populating left correctly when not in git root
Message-ID: <68f49f5e-4e71-fd52-cd6f-64e92face962@mooflu.com>
Date:   Fri, 2 Dec 2016 15:04:01 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:45.0)
 Gecko/20100101 Thunderbird/45.5.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

looks like this broke between 2.9.2 and 2.9.3

cat ~/.gitconfig
[difftool "diff"]
     cmd = ls -l ${LOCAL}/* ${REMOTE}/*
     #cmd = diff -r ${LOCAL} ${REMOTE} | less

~/stuff/gittest> ls -l *
d1:
total 8
-rw-r--r--  1 frank  staff  16  2 Dec 14:30 test.txt

d2:
total 8
-rw-r--r--  1 frank  staff  18  2 Dec 14:30 anothertest.tst


~/stuff/gittest> git status
On branch master
Changes not staged for commit:
   (use "git add <file>..." to update what will be committed)
   (use "git checkout -- <file>..." to discard changes in working directory)

     modified:   d1/test.txt
     modified:   d2/anothertest.tst


~/stuff/gittest> ~/stuff/git_tmp/bin/git --version
git version 2.11.0

~/stuff/gittest> ~/stuff/git_tmp/bin/git difftool -d -t diff
/var/folders/0j/3pk3pdsx7rzb9_njdpyjwm000000gn/T/git-difftool.0oGRF/left/d1:
total 8
-rw-r--r--  1 frank  staff  6  2 Dec 14:52 test.txt

/var/folders/0j/3pk3pdsx7rzb9_njdpyjwm000000gn/T/git-difftool.0oGRF/left/d2:
total 8
-rw-r--r--  1 frank  staff  7  2 Dec 14:52 anothertest.tst

/var/folders/0j/3pk3pdsx7rzb9_njdpyjwm000000gn/T/git-difftool.0oGRF/right/d1:
total 8
lrwxr-xr-x  1 frank  staff  38  2 Dec 14:52 test.txt -> 
/Users/frank/stuff/gittest/d1/test.txt

/var/folders/0j/3pk3pdsx7rzb9_njdpyjwm000000gn/T/git-difftool.0oGRF/right/d2:
total 8
lrwxr-xr-x  1 frank  staff  45  2 Dec 14:52 anothertest.tst -> 
/Users/frank/stuff/gittest/d2/anothertest.tst


cd d2
~/stuff/gittest/d2> ~/stuff/git_tmp/bin/git difftool -d -t diff
/var/folders/0j/3pk3pdsx7rzb9_njdpyjwm000000gn/T/git-difftool.eRXhB/left/d2:
total 8
-rw-r--r--  1 frank  staff  7  2 Dec 14:52 anothertest.tst

/var/folders/0j/3pk3pdsx7rzb9_njdpyjwm000000gn/T/git-difftool.eRXhB/right/d1:
total 8
lrwxr-xr-x  1 frank  staff  38  2 Dec 14:52 test.txt -> 
/Users/frank/stuff/gittest/d1/test.txt

/var/folders/0j/3pk3pdsx7rzb9_njdpyjwm000000gn/T/git-difftool.eRXhB/right/d2:
total 8
lrwxr-xr-x  1 frank  staff  45  2 Dec 14:52 anothertest.tst -> 
/Users/frank/stuff/gittest/d2/anothertest.tst


Note that left does not contain d1



~/stuff/gittest/d2> ~/stuff/git_tmp/bin/git --version
git version 2.9.2
~/stuff/gittest/d2> ~/stuff/git_tmp/bin/git difftool -d -t diff
/var/folders/0j/3pk3pdsx7rzb9_njdpyjwm000000gn/T/git-difftool.YxtVw/left/d1:
total 8
-rw-r--r--  1 frank  staff  6  2 Dec 15:02 test.txt

/var/folders/0j/3pk3pdsx7rzb9_njdpyjwm000000gn/T/git-difftool.YxtVw/left/d2:
total 8
-rw-r--r--  1 frank  staff  7  2 Dec 15:02 anothertest.tst

/var/folders/0j/3pk3pdsx7rzb9_njdpyjwm000000gn/T/git-difftool.YxtVw/right/d1:
total 8
lrwxr-xr-x  1 frank  staff  38  2 Dec 15:02 test.txt -> 
/Users/frank/stuff/gittest/d1/test.txt

/var/folders/0j/3pk3pdsx7rzb9_njdpyjwm000000gn/T/git-difftool.YxtVw/right/d2:
total 8
lrwxr-xr-x  1 frank  staff  45  2 Dec 15:02 anothertest.tst -> 
/Users/frank/stuff/gittest/d2/anothertest.tst



~/stuff/gittest/d2> ~/stuff/git_tmp/bin/git --version
git version 2.9.3
~/stuff/gittest/d2> ~/stuff/git_tmp/bin/git difftool -d -t diff
/var/folders/0j/3pk3pdsx7rzb9_njdpyjwm000000gn/T/git-difftool.TpJ5u/left/d2:
total 8
-rw-r--r--  1 frank  staff  7  2 Dec 15:01 anothertest.tst

/var/folders/0j/3pk3pdsx7rzb9_njdpyjwm000000gn/T/git-difftool.TpJ5u/right/d1:
total 8
lrwxr-xr-x  1 frank  staff  38  2 Dec 15:01 test.txt -> 
/Users/frank/stuff/gittest/d1/test.txt

/var/folders/0j/3pk3pdsx7rzb9_njdpyjwm000000gn/T/git-difftool.TpJ5u/right/d2:
total 8
lrwxr-xr-x  1 frank  staff  45  2 Dec 15:01 anothertest.tst -> 
/Users/frank/stuff/gittest/d2/anothertest.tst



Cheers,
Frank.




