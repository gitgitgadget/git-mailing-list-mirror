Return-Path: <SRS0=dClv=3H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8846C32771
	for <git@archiver.kernel.org>; Sat, 18 Jan 2020 18:07:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 788FD20748
	for <git@archiver.kernel.org>; Sat, 18 Jan 2020 18:07:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ksRGm8sc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726642AbgARSHg (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 18 Jan 2020 13:07:36 -0500
Received: from mail-pl1-f175.google.com ([209.85.214.175]:43804 "EHLO
        mail-pl1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726490AbgARSHg (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Jan 2020 13:07:36 -0500
Received: by mail-pl1-f175.google.com with SMTP id p27so11266047pli.10
        for <git@vger.kernel.org>; Sat, 18 Jan 2020 10:07:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:references:in-reply-to:subject:date:message-id:mime-version
         :content-transfer-encoding:thread-index:content-language;
        bh=ZXG+2IczsUvvbeRhWajEiAd+i/NJvNqBF+2dqj96zmE=;
        b=ksRGm8scboOSYCagjrkUXD9OsuzQ5vDrNFSng9tHkU3hmM5YBLefJ7OoZfneSOhCs9
         xKlh8uYrk9w4i0PxOjS25bMlf/BgTKdVsc+lxlM/woX5l++kr+hReBYSmzmRkVYcTwLP
         Lq+FHVVROTwzWpBcvV9ccambgID/lvxQwN982PM0fenfHjguisvVPzl8p2K8DkFgjxCb
         5Ws49dHyw47BQo3huxP7pxlVcjr34edsCrEHi9NvDsvGAyT5Pkc92o+kvgekJ8XgG/NE
         HfWxj4EUpvNwQe1mBERht/8lOO+pqb7qDoT6ETMaEy7Wn4dzCJVaNAuXEs8/ocdv5Vay
         bzCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:references:in-reply-to:subject:date
         :message-id:mime-version:content-transfer-encoding:thread-index
         :content-language;
        bh=ZXG+2IczsUvvbeRhWajEiAd+i/NJvNqBF+2dqj96zmE=;
        b=mE5LDARVUwQDMUovQpshz3WcwhsHDfFflQjewCCKwDP1Zrgndm/t6yLqLvuV3KKNFe
         zVpIwEpzIN8CRXmjVn/IDg7ARyZowmu7ixLM5zMeVwZoFKyv6dUXUHe0Eo9j33F7214/
         Mrrb9ZHl7Pd8YA/lyzQ6Nyu/xEPgbVIjLc6Elb+S1E01ksRn6uZfpu90+BXvHpv2h4f1
         gNX1fZkj6/IrPXE6/K2dGsNy5+rB8V41ntsB7kZh/LO+y1Im792/fqJCFoBhz0+cBKQK
         wivtaT5lzjrMLc9ibWZOzAZO8DCvPkzlS7Z6pIX11TktY71JoOs+zZUIP4omFulxg1ja
         p8Sw==
X-Gm-Message-State: APjAAAUV6KXjrW6TWdtesTPBxX4tu0gZRJFyS7CPwHxOUaUCPQhQQOW5
        wVJQspdz9cwu9ztF7rBuxLdsXd/n
X-Google-Smtp-Source: APXvYqzn4Z9/K8RVXubboPsZXhLaHcxF0yA+j5UKVOFm+2NE0TZa1UhQa7UQwdTQNiDdqKgYvVgHEw==
X-Received: by 2002:a17:90a:330f:: with SMTP id m15mr13196722pjb.24.1579370855068;
        Sat, 18 Jan 2020 10:07:35 -0800 (PST)
Received: from LJZDELLPC (75-167-33-30.phnx.qwest.net. [75.167.33.30])
        by smtp.gmail.com with ESMTPSA id z4sm33342428pfn.42.2020.01.18.10.07.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 18 Jan 2020 10:07:34 -0800 (PST)
From:   <lyle.ziegelmiller@gmail.com>
To:     "'Philip Oakley'" <philipoakley@iee.email>, <git@vger.kernel.org>
References: <004101d58d24$4daab5b0$e9002110$@gmail.com> <91e5f3d8-d2cf-363c-2407-4b4dfb75e5a8@iee.email> <005501d58e14$07504990$15f0dcb0$@gmail.com> <001a01d5a256$5e64d010$1b2e7030$@gmail.com> <000d01d5bb54$1c38a920$54a9fb60$@gmail.com> <4C0A4F83-DD45-455F-B086-3416F86C1CCE@iee.email>
In-Reply-To: <4C0A4F83-DD45-455F-B086-3416F86C1CCE@iee.email>
Subject: RE: FW: unpacking error
Date:   Sat, 18 Jan 2020 11:07:32 -0700
Message-ID: <00a501d5ce2a$280ee230$782ca690$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQG1h2GfhZDeVN3ik89S7UEhF7jkegHN4Q6UAW27+sMB8V0p7AHVtRhGAtPtofSn4pBKAA==
Content-Language: en-us
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Philip

Per your request, here's a reminder (albeit a bit late) after January =
4th. Please see below.

Regards

Lyle

From: Philip Oakley <philipoakley@iee.email>=20
Sent: Wednesday, December 25, 2019 1:41 PM
To: lyle.ziegelmiller@gmail.com; git@vger.kernel.org
Subject: Re: FW: unpacking error

Hi,=20
must have missed that one. I'm away for Christmas and New year, so a =
reminder about 4th January may help, or maybe other contributors may =
have ideas.


On 25 December 2019 18:49:59 GMT+00:00, =
mailto:lyle.ziegelmiller@gmail.com wrote:
Hi

It seems Philip is no longer receiving emails?

Please see below.

Regards

Lyle

-----Original Message-----
From: mailto:lyle.ziegelmiller@gmail.com =
<mailto:lyle.ziegelmiller@gmail.com>=20
Sent: Saturday, November 23, 2019 4:33 PM
To: mailto:philipoakley@iee.email
Subject: FW: unpacking error

Hi Philip

Any updates on this?

Thanks

Lyle

-----Original Message-----
From: mailto:lyle.ziegelmiller@gmail.com =
<mailto:lyle.ziegelmiller@gmail.com>=20
Sent: Monday, October 28, 2019 9:48 PM
To: 'Philip Oakley' <mailto:philipoakley@iee.email>; 'git bug report' =
<mailto:git@vger.kernel.org>
Subject: RE: unpacking error


From: Philip Oakley <mailto:philipoakley@iee.email>
Sent: Monday, October 28, 2019 3:14 AM
To: mailto:lyle.ziegelmiller@gmail.com; 'git bug report' =
<mailto:git@vger.kernel.org>
Subject: Re: unpacking error

Hi Philip.

Thanks for writing back. Please see below.

Regards

Lyle=20

On 28/10/2019 00:11, mailto:lyle.ziegelmiller@gmail.com wrote:
 Hi

 I almost always get this error when pushing from my PC to the bare=20
 repository on my laptop. I'm running Cygwin on Windows 10. I've tried=20
 everything! chmod -R 777, chown -R <my user id>, etc.

 A few more details: I have a Git repository on my PC, and from that,=20
 I've cloned a bare repository on my laptop,

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
   which I then used to clone a regular repository on my laptop. The=20
 error occurs when I attempt to push changes on my PC into the bare=20
 repository on my laptop.

 If I delete the old bare repository on my laptop, I'm able to create a=20
 new bare repository on my laptop from my pc, but then as soon as I try=20
 to push to it, I get this error again. I've tried disabling the =
anti-virus, etc.
 I've spent hours Googling solutions. Nothing works! Many others have=20
 had this same issue. I never had this type of problem with SVN.

 It would be nice if Git would say what's failing when this happens,=20
 and it would be nice to get this bug fixed. It happens with all my git=20
 repositories. I don't think it's a network issue or I wouldn't be able=20
 to create a new repository on my laptop from my PC, as that would=20
 encounter the same permissions issues.

 The two machines are connected with an ethernet cable. I've done=20
 everything I can to make sure all the Windows permissions are set =
correctly, etc.

 $ git push
 Counting objects: 3, done.
 Delta compression using up to 4 threads.
 Compressing objects: 100% (3/3), done.
 Writing objects: 100% (3/3), 331 bytes | 331.00 KiB/s, done.
 Total 3 (delta 2), reused 0 (delta 0)

remote: fatal: not a git repository: '.'
[Philip] "Why is the remote end of the connection reporting the error =
that it is looking at "." (as opposed to a proper path/repo)?"

I'm not sure. I cloned ".". I think that's a legitimate thing to do.

All this stuff has worked for me for years. I'm not sure why it's =
stopped working.

[Philip] "I could easily be wrong - I haven't double checked the man =
pages at all, but thought a comment may help your research."
 error: remote unpack failed: unpack-objects abnormal exit To=20
 //lylez-laptop/Users/Administrator/bare-repositories/Tradelab-bare-rep
 ositor
 y.git/
   ! [remote rejected] timestamp_testing -> timestamp_testing (unpacker
 error)
 error: failed to push some refs to
 '//lylez-laptop/Users/Administrator/bare-repositories/Tradelab-bare-re
 posito
 ry.git/'


 $ git --version
 git version 2.17.0
________________________________________
 System Information
________________________________________
        Time of this report: 10/27/2019, 16:53:09
               Machine name: LJZ-DELLPC
                 Machine Id: {39BC0826-743F-4ECA-AFBE-66A14FBE533C}
           Operating System: Windows 10 Pro 64-bit (10.0, Build 17134)
 (17134.rs4_release.180410-1804)
                   Language: English (Regional Setting: English)
        System Manufacturer: Dell Inc.
               System Model: Inspiron 3650
                       BIOS: BIOS Date: 06/17/16 21:14:07 Ver: 05.0000B =
(type:
 BIOS)
                  Processor: Intel(R) Core(TM) i5-6400 CPU @ 2.70GHz (4=20
 CPUs), ~2.7GHz
                     Memory: 8192MB RAM
        Available OS Memory: 8096MB RAM
                  Page File: 8076MB used, 7243MB available
                Windows Dir: C:\WINDOWS
            DirectX Version: DirectX 12
        DX Setup Parameters: Not found
           User DPI Setting: 96 DPI (100 percent)
         System DPI Setting: 96 DPI (100 percent)
            DWM DPI Scaling: Disabled
                   Miracast: Available, with HDCP Microsoft Graphics =
Hybrid:
 Not Supported
             DxDiag Version: 10.00.17134.0001 64bit Unicode


 Regards,

 Lyle Ziegelmiller

--
Philip




--=20
Sent from my Android device with K-9 Mail. Please excuse my brevity.

