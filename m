Return-Path: <SRS0=LPWw=2P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7677C2D0C8
	for <git@archiver.kernel.org>; Wed, 25 Dec 2019 18:51:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68A7A2067D
	for <git@archiver.kernel.org>; Wed, 25 Dec 2019 18:51:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mKY5TubM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726688AbfLYSuC (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Dec 2019 13:50:02 -0500
Received: from mail-pj1-f45.google.com ([209.85.216.45]:38313 "EHLO
        mail-pj1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726397AbfLYSuC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Dec 2019 13:50:02 -0500
Received: by mail-pj1-f45.google.com with SMTP id l35so2565233pje.3
        for <git@vger.kernel.org>; Wed, 25 Dec 2019 10:50:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:references:in-reply-to:subject:date:message-id:mime-version
         :content-transfer-encoding:thread-index:content-language;
        bh=+XEXjgYQzNlCS/j2C8OG1liUlr2APp9zI8IUsOg2VKQ=;
        b=mKY5TubMTeZ6SSQVFAUV9Bmendadhi+N1BVjdu+LUTub9nOfgle2u9Khpe5+MHwMbH
         gWpXjpPkTqF3KXG1lMp5XWo48l4l9FS7K0tbt82XzFFUVYYynNtfruTFsfbYwm8w4okq
         Gs30csQVXaF9OzPsL4oVrSDhPs9uqilN4N0Tkj2uVkIPkC0K7II5qBFEIYWE3Bal7Uty
         /qhgH3oGqUVslWafu6ZL8S3AY9+VYv8U3L40XrppLxEz4sf9XkVM5ztxCz64wgE2Cy5Y
         O2nsHcRdOMjfGaVSeuzlTU+Khnc96H4kHcrz/6F5+o65/PP0bv8reNuSe3oVHVyiArWb
         vv8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:references:in-reply-to:subject:date
         :message-id:mime-version:content-transfer-encoding:thread-index
         :content-language;
        bh=+XEXjgYQzNlCS/j2C8OG1liUlr2APp9zI8IUsOg2VKQ=;
        b=ao+ArhG0SLyXC52I+98+HdDCr88VYTnGIisEFpOJvFuICJ2XFA39if8AHgf3mMUYtX
         0K+g6hchah85RK9+nlzHGz1l2YPFka69d+4RHtnHSkjvrXNjlte0fNQI4Sr6aLciGMU9
         PjQYLm8GPLc5KL6e7zhqtd8ecXXQNHyKyDH1Y/zM5gUcpCKcwxKGh7CsnOjri8/+ChaB
         Le6gyNJFEQqHhePc85AiDLcSsV/qdnNXcCbWCqFl9+pvrHkv6d7LdU/cAv2g900M5QN2
         +TEf3vRPsCA/TaW+3MJmt/vMEYRyY/58QiwxBZrJAWZRVURreT4N2j9NhRLoijboc+NQ
         tY0g==
X-Gm-Message-State: APjAAAXL9e9v0+PFCWuf7vLfSN+hzU5yMKQemZnSUGrAB1pbKXcie5y1
        XlyPKVRzOU3IAVmuX+6XaiW+07J6
X-Google-Smtp-Source: APXvYqzPYaNYgKPzmKzNUaqaL344c/+MuI1EBav803XMZ379U/WDNyetsYzS9RtSNuT9Kxnrb4HR+Q==
X-Received: by 2002:a17:902:b08d:: with SMTP id p13mr43048044plr.109.1577299801019;
        Wed, 25 Dec 2019 10:50:01 -0800 (PST)
Received: from LJZDELLPC ([184.103.66.8])
        by smtp.gmail.com with ESMTPSA id d129sm10695015pfd.115.2019.12.25.10.49.59
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Dec 2019 10:50:00 -0800 (PST)
From:   <lyle.ziegelmiller@gmail.com>
To:     <git@vger.kernel.org>
References: <004101d58d24$4daab5b0$e9002110$@gmail.com> <91e5f3d8-d2cf-363c-2407-4b4dfb75e5a8@iee.email> <005501d58e14$07504990$15f0dcb0$@gmail.com> <001a01d5a256$5e64d010$1b2e7030$@gmail.com>
In-Reply-To: <001a01d5a256$5e64d010$1b2e7030$@gmail.com>
Subject: FW: unpacking error
Date:   Wed, 25 Dec 2019 11:49:59 -0700
Message-ID: <000d01d5bb54$1c38a920$54a9fb60$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQG1h2GfhZDeVN3ik89S7UEhF7jkegHN4Q6UAW27+sMB8V0p7KfiKirw
Content-Language: en-us
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi

It seems Philip is no longer receiving emails?

Please see below.

Regards

Lyle

-----Original Message-----
From: lyle.ziegelmiller@gmail.com <lyle.ziegelmiller@gmail.com>=20
Sent: Saturday, November 23, 2019 4:33 PM
To: philipoakley@iee.email
Subject: FW: unpacking error

Hi Philip

Any updates on this?

Thanks

Lyle

-----Original Message-----
From: lyle.ziegelmiller@gmail.com <lyle.ziegelmiller@gmail.com>=20
Sent: Monday, October 28, 2019 9:48 PM
To: 'Philip Oakley' <philipoakley@iee.email>; 'git bug report' =
<git@vger.kernel.org>
Subject: RE: unpacking error


From: Philip Oakley <philipoakley@iee.email>
Sent: Monday, October 28, 2019 3:14 AM
To: lyle.ziegelmiller@gmail.com; 'git bug report' <git@vger.kernel.org>
Subject: Re: unpacking error

Hi Philip.

Thanks for writing back. Please see below.

Regards

Lyle=20

On 28/10/2019 00:11, lyle.ziegelmiller@gmail.com wrote:
> Hi
>
> I almost always get this error when pushing from my PC to the bare=20
> repository on my laptop. I'm running Cygwin on Windows 10. I've tried=20
> everything! chmod -R 777, chown -R <my user id>, etc.
>
> A few more details: I have a Git repository on my PC, and from that,=20
> I've cloned a bare repository on my laptop,

[Philip] "How did you clone that bare repository? In particular, how did =
you provide the path to that repo."

I'm recreating the entire process below with a smaller repository on my =
PC (so it won't take hours to clone, etc):

lylez@LJZ-DELLPC /cygdrive/c/Users/lyle/documents/budget
$ git clone --bare . =
//lylez-laptop/Users/Administrator/bare-repositories/budget-bare-reposito=
ry.git
Cloning into bare repository =
'//lylez-laptop/Users/Administrator/bare-repositories/budget-bare-reposit=
ory.git'...
done.

lylez@LJZ-DELLPC /cygdrive/c/Users/lyle/documents/budget
$ echo "line1" > afile.txt

lylez@LJZ-DELLPC /cygdrive/c/Users/lyle/documents/budget
$ git add afile.txt

lylez@LJZ-DELLPC /cygdrive/c/Users/lyle/documents/budget
$ git commit -m 'Added afile.txt'
[master 7fa616b] Added afile.txt
 1 file changed, 1 insertion(+)
 create mode 100644 afile.txt

lylez@LJZ-DELLPC /cygdrive/c/Users/lyle/documents/budget
$ git push
Counting objects: 3, done.
Delta compression using up to 4 threads.
Compressing objects: 100% (2/2), done.
Writing objects: 100% (3/3), 287 bytes | 287.00 KiB/s, done.
Total 3 (delta 1), reused 0 (delta 0)
remote: fatal: not a git repository: '.'
error: remote unpack failed: unpack-objects abnormal exit To =
//lylez-laptop/Users/Administrator/bare-repositories/budget-bare-reposito=
ry.git
 ! [remote rejected] master -> master (unpacker error)
error: failed to push some refs to =
'//lylez-laptop/Users/Administrator/bare-repositories/budget-bare-reposit=
ory.git'

Note: I'm able to access the remote repository using Cygwin Unix =
commands on Windows 10:

lylez@LJZ-DELLPC /cygdrive/c/Users/lyle/documents/budget
$ ls =
//lylez-laptop/Users/Administrator/bare-repositories/budget-bare-reposito=
ry.git
config  description  HEAD  hooks  info  objects  packed-refs  refs

... and I do have write permission:

lylez@LJZ-DELLPC /cygdrive/c/Users/lyle/documents/budget
$ touch =
//lylez-laptop/Users/Administrator/bare-repositories/budget-bare-reposito=
ry.git/anotherFile.txt

lylez@LJZ-DELLPC /cygdrive/c/Users/lyle/documents/budget
$ echo "line2" >> =
//lylez-laptop/Users/Administrator/bare-repositories/budget-bare-reposito=
ry.git/anotherFile.txt

lylez@LJZ-DELLPC /cygdrive/c/Users/lyle/documents/budget
$ git remote -v
origin  =
//lylez-laptop/Users/Administrator/bare-repositories/budget-bare-reposito=
ry.git (fetch) origin  =
//lylez-laptop/Users/Administrator/bare-repositories/budget-bare-reposito=
ry.git (push)

lylez@LJZ-DELLPC /cygdrive/c/Users/lyle/documents/budget
$

So, I can clone the repository, and I can still write to the remote =
directory using the "touch" and "echo" commands. But I can't push to it. =
It seems that "clone" can access (create, actually) the remote =
repository, but "push" cannot access it effectively.

[Philip] "If I understand correctly it must be in a URL format (e.g. =
file://) to ensure that you get distinct repos, rather than two =
interrelated repos (thought the docs discuss the issue as being the =
transport mechanism)."

"file://" is for referring to a local file from within a web browser. =
"//" is how to begin a path of a file on a remote machine in Windows.

After doing all of this, I created another test file on my laptop =
(filename: afile2.txt) in the repository on my laptop made by cloning =
the bare repository that I just created on my laptop, and added the test =
file afile2.txt to the cloned non-bare git repository, and then did a =
"git push" on my laptop (the remote machine) to the bare repository on =
my laptop (the remote machine). Then, back on my PC, I was able to do a =
git pull even though earlier I could not do a git push:


lylez@LJZ-DELLPC /cygdrive/c/Users/lyle/documents/budget
$ git pull
remote: Counting objects: 3, done.
remote: Compressing objects: 100% (2/2), done.
remote: Total 3 (delta 1), reused 0 (delta 0) Unpacking objects: 100% =
(3/3), done.
From =
//lylez-laptop/Users/Administrator/bare-repositories/budget-bare-reposito=
ry
 + e9d5a3c...cd21f1d master     -> origin/master  (forced update)
Merge made by the 'recursive' strategy.
 afile2.txt | 1 +
 1 file changed, 1 insertion(+)
 create mode 100644 afile2.txt

lylez@LJZ-DELLPC /cygdrive/c/Users/lyle/documents/budget
$ ls
afile.txt  afile2.txt  backup  Budget.xlsx  Joanne  Scotland.xlsx

lylez@LJZ-DELLPC /cygdrive/c/Users/lyle/documents/budget


And there it is, the new file (afile2.txt).

So Git is able to utilize the remote bare repository for cloning on the =
remote machine, and on the local machine (my PC) it can pull from the =
remote bare repository, but it can't push to it.

[Philip] "The same issue probably applies to the subsequent clones of =
the bare repo."

[Philip] "Perhaps focus on the error message and decide if "." is the =
correct way of thinking about the path."

"." is the local directory on my PC that was initially cloned. It is =
where the Git repository reside:

lylez@LJZ-DELLPC /cygdrive/c/Users/lyle/documents/budget
$ ls -a
.  ..  .git  afile.txt  afile2.txt  backup  Budget.xlsx  Joanne  =
Scotland.xlsx

lylez@LJZ-DELLPC /cygdrive/c/Users/lyle/documents/budget

>   which I then used to clone a regular repository on my laptop. The=20
> error occurs when I attempt to push changes on my PC into the bare=20
> repository on my laptop.
>
> If I delete the old bare repository on my laptop, I'm able to create a =

> new bare repository on my laptop from my pc, but then as soon as I try =

> to push to it, I get this error again. I've tried disabling the =
anti-virus, etc.
> I've spent hours Googling solutions. Nothing works! Many others have=20
> had this same issue. I never had this type of problem with SVN.
>
> It would be nice if Git would say what's failing when this happens,=20
> and it would be nice to get this bug fixed. It happens with all my git =

> repositories. I don't think it's a network issue or I wouldn't be able =

> to create a new repository on my laptop from my PC, as that would=20
> encounter the same permissions issues.
>
> The two machines are connected with an ethernet cable. I've done=20
> everything I can to make sure all the Windows permissions are set =
correctly, etc.
>
> $ git push
> Counting objects: 3, done.
> Delta compression using up to 4 threads.
> Compressing objects: 100% (3/3), done.
> Writing objects: 100% (3/3), 331 bytes | 331.00 KiB/s, done.
> Total 3 (delta 2), reused 0 (delta 0)

> remote: fatal: not a git repository: '.'
[Philip] "Why is the remote end of the connection reporting the error =
that it is looking at "." (as opposed to a proper path/repo)?"

I'm not sure. I cloned ".". I think that's a legitimate thing to do.

All this stuff has worked for me for years. I'm not sure why it's =
stopped working.

[Philip] "I could easily be wrong - I haven't double checked the man =
pages at all, but thought a comment may help your research."
> error: remote unpack failed: unpack-objects abnormal exit To=20
> //lylez-laptop/Users/Administrator/bare-repositories/Tradelab-bare-rep
> ositor
> y.git/
>   ! [remote rejected] timestamp_testing -> timestamp_testing (unpacker
> error)
> error: failed to push some refs to
> '//lylez-laptop/Users/Administrator/bare-repositories/Tradelab-bare-re
> posito
> ry.git/'
>
>
> $ git --version
> git version 2.17.0
>
> ------------------
> System Information
> ------------------
>        Time of this report: 10/27/2019, 16:53:09
>               Machine name: LJZ-DELLPC
>                 Machine Id: {39BC0826-743F-4ECA-AFBE-66A14FBE533C}
>           Operating System: Windows 10 Pro 64-bit (10.0, Build 17134)
> (17134.rs4_release.180410-1804)
>                   Language: English (Regional Setting: English)
>        System Manufacturer: Dell Inc.
>               System Model: Inspiron 3650
>                       BIOS: BIOS Date: 06/17/16 21:14:07 Ver: 05.0000B =
(type:
> BIOS)
>                  Processor: Intel(R) Core(TM) i5-6400 CPU @ 2.70GHz (4 =

> CPUs), ~2.7GHz
>                     Memory: 8192MB RAM
>        Available OS Memory: 8096MB RAM
>                  Page File: 8076MB used, 7243MB available
>                Windows Dir: C:\WINDOWS
>            DirectX Version: DirectX 12
>        DX Setup Parameters: Not found
>           User DPI Setting: 96 DPI (100 percent)
>         System DPI Setting: 96 DPI (100 percent)
>            DWM DPI Scaling: Disabled
>                   Miracast: Available, with HDCP Microsoft Graphics =
Hybrid:
> Not Supported
>             DxDiag Version: 10.00.17134.0001 64bit Unicode
>
>
> Regards,
>
> Lyle Ziegelmiller
>
>
--
Philip




