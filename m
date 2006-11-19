X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: [WISH] Store also tag dereferences in packed-refs
Date: Sun, 19 Nov 2006 21:09:01 +0100
Message-ID: <e5bfff550611191209s63982818vd3999b543e68e8df@mail.gmail.com>
References: <e5bfff550611180115j135746a1h916e8ae029d1374d@mail.gmail.com>
	 <7vmz6oeh2k.fsf@assigned-by-dhcp.cox.net>
	 <20061118184345.GO7201@pasky.or.cz>
	 <e5bfff550611181047w6712774fkccc697d312b87c7e@mail.gmail.com>
	 <7vac2oefuz.fsf@assigned-by-dhcp.cox.net>
	 <e5bfff550611181628o41e11652ycd17ddad5dd21225@mail.gmail.com>
	 <Pine.LNX.4.64.0611181706250.3692@woody.osdl.org>
	 <e5bfff550611190140n3277ee26v95feba26dd3348fa@mail.gmail.com>
	 <Pine.LNX.4.64.0611190945500.3692@woody.osdl.org>
	 <e5bfff550611191107o63d89d8bp5ff4080803a0d784@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Sun, 19 Nov 2006 20:09:49 +0000 (UTC)
Cc: "Junio C Hamano" <junkio@cox.net>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=BBTN81QFpS1EEE6mwVCMA+hKK/Vb/fUWdVXNeZr0fMFH19wB0RU5yOWGwAtNB405CzLgNI6coScJatHcWzV3DQT2a7Z/qGslXMpEVFPRrfch0xto+8YXDRAoLrXofrfUzsJSylPNclFpe6ye7773o0nDvAjoMHXLml2r86/opuc=
In-Reply-To: <e5bfff550611191107o63d89d8bp5ff4080803a0d784@mail.gmail.com>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31859>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Glsz4-0004ga-66 for gcvg-git@gmane.org; Sun, 19 Nov
 2006 21:09:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S933141AbWKSUJl (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 19 Nov 2006
 15:09:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933142AbWKSUJl
 (ORCPT <rfc822;git-outgoing>); Sun, 19 Nov 2006 15:09:41 -0500
Received: from py-out-1112.google.com ([64.233.166.176]:547 "EHLO
 py-out-1112.google.com") by vger.kernel.org with ESMTP id S933141AbWKSUJk
 (ORCPT <rfc822;git@vger.kernel.org>); Sun, 19 Nov 2006 15:09:40 -0500
Received: by py-out-1112.google.com with SMTP id a29so857247pyi for
 <git@vger.kernel.org>; Sun, 19 Nov 2006 12:09:06 -0800 (PST)
Received: by 10.35.8.13 with SMTP id l13mr6970041pyi.1163966941544; Sun, 19
 Nov 2006 12:09:01 -0800 (PST)
Received: by 10.35.42.4 with HTTP; Sun, 19 Nov 2006 12:09:01 -0800 (PST)
To: "Linus Torvalds" <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org

On 11/19/06, Marco Costalba <mcostalba@gmail.com> wrote:
>
> When finished I will do additional cold chache (reboot) tests.
>

Previous delay was not reproduced. This time I tested also with git
show-ref -d (dereferencing tags), always with cold-cache.

It does not seems there are strange delays, but total time it's high
(very I/O bound)


- LINUX TREE

$ pwd
/git/linux-2.6

$ time strace -o tracefile -Ttt git show-ref -d >> /dev/null
0.02user 0.01system 0:02.39elapsed 1%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (127major+894minor)pagefaults 0swaps

$ grep -v ' <0.0[012]' tracefile >> tracefile_slowest.txt
$ cat tracefile_slowest.txt
20:51:49.695511 execve("/home/marco/bin/git", ["git", "show-ref",
"-d"], [/* 78 vars */]) = 0 <0.065006>
20:51:49.946258 open(".git/objects/info/alternates", O_RDONLY) = -1
ENOENT (No such file or directory) <0.091447>
20:51:50.070555
stat64(".git/objects/e0/30f8294a5b9f8179dae10cdbf9dcf32aa64110",
{st_mode=S_IFREG|0444, st_size=284, ...}) = 0 <0.037669>
20:51:51.822469
stat64(".git/objects/7a/9d289b6650bf78df77ab463bedc2919df89833",
{st_mode=S_IFREG|0444, st_size=285, ...}) = 0 <0.048868>
20:51:51.930582
stat64(".git/objects/80/c218812786f619c9a1ce50d0e7c32c7afde4de",
{st_mode=S_IFREG|0444, st_size=210, ...}) = 0 <0.030057>
20:51:51.981951
stat64(".git/objects/44/597f65f6af3c692560a639f61d25398d13d1b6",
{st_mode=S_IFREG|0444, st_size=249, ...}) = 0 <0.037440>
20:51:52.023469 exit_group(0)           = ?


- GIT TREE

$cd /home/marco/programmi/git
$ time strace -o tracefile -Ttt git show-ref -d >> /dev/null
0.04user 0.04system 0:02.47elapsed 3%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (91major+794minor)pagefaults 0swaps

$ grep -v ' <0.0[012]' tracefile >> tracefile_slowest.txt
$ cat tracefile_slowest.txt
20:55:04.844584
stat64(".git/objects/d0/f877fb601ac0076fd69ec4f48f71f9247771c8",
{st_mode=S_IFREG|0444, st_size=190, ...}) = 0 <0.046100>
20:55:04.944839
stat64(".git/objects/e2/67c2f6f0784e242883b7d3fe5f36ef63d6950d",
{st_mode=S_IFREG|0444, st_size=179, ...}) = 0 <0.033536>
20:55:05.057966
stat64(".git/objects/41/292ddd37202ff6dce34986c87a6000c5d3fbfa",
{st_mode=S_IFREG|0444, st_size=180, ...}) = 0 <0.072937>
20:55:05.432107
stat64(".git/objects/7d/09fbe4ab7f080a8f8f5dcef7e0f3edf5e26019",
{st_mode=S_IFREG|0444, st_size=396, ...}) = 0 <0.035952>
20:55:05.592877
stat64(".git/objects/92/d7605b6d9312a29efa30b1baa4d7c880a0be41",
{st_mode=S_IFREG|0444, st_size=280, ...}) = 0 <0.032139>
20:55:05.738173
stat64(".git/objects/05/56a11a0df6b4119e01aa77dfb795561e62eb34",
{st_mode=S_IFREG|0444, st_size=557, ...}) = 0 <0.031572>
20:55:06.176786
stat64(".git/objects/88/3653babd8ee7ea23e6a5c392bb739348b1eb61",
{st_mode=S_IFREG|0444, st_size=442, ...}) = 0 <0.030382>
20:55:06.549025
stat64(".git/objects/95/f1e36cc34e8738e5c431aac47d6fea18913db0",
{st_mode=S_IFREG|0444, st_size=395, ...}) = 0 <0.031731>
20:55:06.844432
stat64(".git/objects/ba/f0bfcb4b335438e9359835f2c27cccf20e54a3",
{st_mode=S_IFREG|0444, st_size=182, ...}) = 0 <0.033688>
20:55:06.922993 exit_group(0)           = ?


