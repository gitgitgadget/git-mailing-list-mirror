Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 515811F97E
	for <e@80x24.org>; Sat, 24 Nov 2018 02:55:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729813AbeKXNlx (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Nov 2018 08:41:53 -0500
Received: from smtp.rcn.com ([69.168.97.78]:60774 "EHLO smtp.rcn.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729519AbeKXNlx (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Nov 2018 08:41:53 -0500
X-Greylist: delayed 1202 seconds by postgrey-1.27 at vger.kernel.org; Sat, 24 Nov 2018 08:41:52 EST
X_CMAE_Category: , ,
X-CNFS-Analysis: v=2.2 cv=DNvN2GFb c=1 sm=1 tr=0 a=OXtaa+9CFT7WVSERtyqzJw==:117 a=OXtaa+9CFT7WVSERtyqzJw==:17 a=KGjhK52YXX0A:10 a=IkcTkHD0fZMA:10 a=NTnny0joGdQA:10 a=JHtHm7312UAA:10 a=bmmO2AaSJ7QA:10 a=BTUBnpS-AAAA:8 a=s8iBPitLiQXxVvCGnCoA:9 a=QEXdDO2ut3YA:10 a=pblkFgjdBCuYZ9-HdJ6i:22
X-CM-Score: 0
X-Scanned-by: Cloudmark Authority Engine
X-Authed-Username: ZHNlb21uQHJjbi5jb20=
Authentication-Results: smtp01.rcn.cmh.synacor.com smtp.mail=david@mandelberg.org; spf=softfail; sender-id=softfail
Authentication-Results: smtp01.rcn.cmh.synacor.com header.from=david@mandelberg.org; sender-id=softfail
Authentication-Results: smtp01.rcn.cmh.synacor.com header.DKIM-Signature=@mandelberg.org; dkim=pass
Authentication-Results:  smtp01.rcn.cmh.synacor.com smtp.user=dseomn@rcn.com; auth=pass (LOGIN)
Received: from [209.6.43.168] ([209.6.43.168:32908] helo=uriel.mandelberg.org)
        by smtp.rcn.com (envelope-from <david@mandelberg.org>)
        (ecelerity 3.6.25.56547 r(Core:3.6.25.0)) with ESMTPSA (cipher=DHE-RSA-AES256-GCM-SHA384) 
        id D8/C0-05071-DD8B8FB5; Fri, 23 Nov 2018 21:35:10 -0500
Received: from [192.168.1.152] (DD-WRT [192.168.1.1])
        by uriel.mandelberg.org (Postfix) with ESMTPSA id 3D9BB1C6036
        for <git@vger.kernel.org>; Fri, 23 Nov 2018 21:35:07 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mandelberg.org;
        s=201809; t=1543026907;
        bh=yF0wV6dvAQRFETgEol6i7oLbcf54Q4IfCKfE6QchMLA=;
        h=To:From:Subject:Date:From;
        b=dWY10jgNQ2iZxfAA5lkiGf6sFCky7V+rciAx+lMX7vjgHetyqLE5Xy3peOXK9ogLe
         alBC/TtW/+imPgBw+VB8x3BeFqPgFRy+rxaOijppInB6gY4XHiHiULCWX2ZwHIe/E/
         wpyD4G2N+9jwrJfuV5TXSsjGl8/LWwuVwznPqPPG+Clae+Jy7WOXVDZDIMnXEUfkwh
         d3ofGs1g936ZBpV0uVubnRgo9Nn9oHPVMrL3hW6gg7tcxVOuDUqYb78/MgAfP6dePe
         IM0amBWr1T1ZoMu1w+hy3rWrC7nGpn31NrRkIwMxGVrKIMAYgZc9w2y3ilyveOwgaB
         061B1v3ldGnpg==
To:     git@vger.kernel.org
From:   David Mandelberg <david@mandelberg.org>
Subject: git overwriting local ignored files?
Message-ID: <a852c0e9-f278-8e2a-406c-bb6099b2440c@mandelberg.org>
Date:   Fri, 23 Nov 2018 21:35:05 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

It seems that git is overwriting my local files on merge if they're in 
.gitignore. See command transcript below. I searched `git help config` 
and Google, but I couldn't find any way to prevent it. Am I missing 
something? (The reason I care about ignored files is that I'm using git 
with a working directory of $HOME to manage my dotfiles, and most files 
in my $HOME are not tracked by git but are still important.)

dseomn@solaria:~$ mktemp -d
/tmp/tmp.RHyyMxJ5Zp
dseomn@solaria:~$ cd /tmp/tmp.RHyyMxJ5Zp
dseomn@solaria:/tmp/tmp.RHyyMxJ5Zp$ git init --bare repo.git
Initialized empty Git repository in /tmp/tmp.RHyyMxJ5Zp/repo.git/
dseomn@solaria:/tmp/tmp.RHyyMxJ5Zp$ git clone repo.git foo
Cloning into 'foo'...
warning: You appear to have cloned an empty repository.
done.
dseomn@solaria:/tmp/tmp.RHyyMxJ5Zp$ git clone repo.git bar
Cloning into 'bar'...
warning: You appear to have cloned an empty repository.
done.
dseomn@solaria:/tmp/tmp.RHyyMxJ5Zp$ cd foo
dseomn@solaria:/tmp/tmp.RHyyMxJ5Zp/foo (master)$ echo '*' > .gitignore
dseomn@solaria:/tmp/tmp.RHyyMxJ5Zp/foo (master)$ git add -f .gitignore
dseomn@solaria:/tmp/tmp.RHyyMxJ5Zp/foo (master)$ git commit -m 'gitignore'
[master (root-commit) affd2fb] gitignore
  1 file changed, 1 insertion(+)
  create mode 100644 .gitignore
dseomn@solaria:/tmp/tmp.RHyyMxJ5Zp/foo (master)$ git push
Counting objects: 3, done.
Writing objects: 100% (3/3), 216 bytes | 216.00 KiB/s, done.
Total 3 (delta 0), reused 0 (delta 0)
To /tmp/tmp.RHyyMxJ5Zp/repo.git
  * [new branch]      master -> master
dseomn@solaria:/tmp/tmp.RHyyMxJ5Zp/foo (master)$ cd ../bar
dseomn@solaria:/tmp/tmp.RHyyMxJ5Zp/bar (master)$ git fetch
remote: Counting objects: 3, done.
remote: Total 3 (delta 0), reused 0 (delta 0)
Unpacking objects: 100% (3/3), done.
 From /tmp/tmp.RHyyMxJ5Zp/repo
  * [new branch]      master     -> origin/master
dseomn@solaria:/tmp/tmp.RHyyMxJ5Zp/bar (master)$ git merge @{u}
dseomn@solaria:/tmp/tmp.RHyyMxJ5Zp/bar (master)$ echo hi > quux
dseomn@solaria:/tmp/tmp.RHyyMxJ5Zp/bar (master)$ git add -f quux
dseomn@solaria:/tmp/tmp.RHyyMxJ5Zp/bar (master)$ git commit -m 'quux'
[master aee4b54] quux
  1 file changed, 1 insertion(+)
  create mode 100644 quux
dseomn@solaria:/tmp/tmp.RHyyMxJ5Zp/bar (master)$ git push
Counting objects: 3, done.
Delta compression using up to 4 threads.
Compressing objects: 100% (2/2), done.
Writing objects: 100% (3/3), 273 bytes | 273.00 KiB/s, done.
Total 3 (delta 0), reused 0 (delta 0)
To /tmp/tmp.RHyyMxJ5Zp/repo.git
    affd2fb..aee4b54  master -> master
dseomn@solaria:/tmp/tmp.RHyyMxJ5Zp/bar (master)$ cd ../foo
dseomn@solaria:/tmp/tmp.RHyyMxJ5Zp/foo (master)$ echo bye > quux
dseomn@solaria:/tmp/tmp.RHyyMxJ5Zp/foo (master)$ git fetch
remote: Counting objects: 3, done.
remote: Compressing objects: 100% (2/2), done.
remote: Total 3 (delta 0), reused 0 (delta 0)
Unpacking objects: 100% (3/3), done.
 From /tmp/tmp.RHyyMxJ5Zp/repo
    affd2fb..aee4b54  master     -> origin/master
dseomn@solaria:/tmp/tmp.RHyyMxJ5Zp/foo (master)$ cat quux
bye
dseomn@solaria:/tmp/tmp.RHyyMxJ5Zp/foo (master)$ git merge @{u}
Updating affd2fb..aee4b54
Fast-forward
  quux | 1 +
  1 file changed, 1 insertion(+)
  create mode 100644 quux
dseomn@solaria:/tmp/tmp.RHyyMxJ5Zp/foo (master)$ cat quux
hi

-- 
https://david.mandelberg.org/
