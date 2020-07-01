Return-Path: <SRS0=EAeL=AM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88505C433DF
	for <git@archiver.kernel.org>; Wed,  1 Jul 2020 09:53:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E75C12073E
	for <git@archiver.kernel.org>; Wed,  1 Jul 2020 09:53:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=neanderfunk.de header.i=@neanderfunk.de header.b="Ca15lJXB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729770AbgGAJxI (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Jul 2020 05:53:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729125AbgGAJxH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Jul 2020 05:53:07 -0400
X-Greylist: delayed 584 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 01 Jul 2020 02:53:07 PDT
Received: from mail.nadeshda.org (mail.nadeshda.org [IPv6:2001:41d0:1:a31a::210])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ADB4C061755
        for <git@vger.kernel.org>; Wed,  1 Jul 2020 02:53:07 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7CA331769D3
        for <git@vger.kernel.org>; Wed,  1 Jul 2020 11:43:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=neanderfunk.de;
        s=default; t=1593596596;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ng6150v9B6OCSKwsjnhhYzRJBaOwehJGoC4uY729tkI=;
        b=Ca15lJXBqCF5Qm4tiAXtP+ZIyIwztKYdb2RitOic+eA+aHxrvG+5hr/ml9MB6O7O03M0/9
        lU7+/cj8sCOXqE5SQvgOAuDzfLRnEWRznSrC98ODfonZ2LUyWfvI5Fyd4nh8fX86IQzqNn
        ciCyiftVtN2zTjDbhXz3CJvNGagp3q38TUXL1xb4mxp6Q4+6V8FGHIa4Ff1HBJOJSLWcaU
        6CahKQH0gkBlLm/kBmKNfuaoD8cDaXF4xpfMQP6UfHk7xHi6R0GlzzacccD9Mr/LcDmFDy
        hoxrkEf9KcKcNDnUv/6/lyYnXE+3f06NTrFcbrdHOAxQsxGxY/g+mFgUq6YW4Q==
Subject: Interrupted system call
References: <14b3d372-f3fe-c06c-dd56-1d9799a12632@yahoo.de>
To:     git@vger.kernel.org
From:   "R. Diez" <rdiez@neanderfunk.de>
Message-ID: <c8061cce-71e4-17bd-a56a-a5fed93804da@neanderfunk.de>
Date:   Wed, 1 Jul 2020 11:43:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <14b3d372-f3fe-c06c-dd56-1d9799a12632@yahoo.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi all:

First of all, many thanks for Git.

After a 3-month pause, I recently updated my Ubuntu 18.04.4. I am using a PPA to keep Git more up to date, so I have now "git version 2.27.0".

I am now getting this kind of errors:

fatal: failed to read object cf965547a433493caa80e84d7a2b78b32a26ee35: Interrupted system call

error: unable to mmap /home/rdiez/[blah blah]/SrcRepo.git/objects/2e/f96ffba4c0d60f36c8779758f82752be380689: Interrupted system call

I am using a mount point for a network share. Keep in mind that Git thinks it is working on a local directory, so there should be no sockets 
or non-blocking I/O involved.

The problem is probably caused by using SMB to connect to an outdated Windows server. It has been working for years, but at some point in 
time it is bound to fail. The Linux kernel itself seems to introduce bugs in the SMB/CIFS code every now and then.

Nevertheless, I am surprised to get such an "Interrupted system call" from Git. A long time ago I learnt that it is OK for many syscalls to 
get interrupted, so you have to loop around them. See here for more information:

http://250bpm.com/blog:12

As a result, users should never actually get an "Interrupted system call" error from any software, at least when no sockets or non-blocking 
I/O is involved.

How can I pin-point this problem? I would like to know where Git is encountering this error, so that I can troubleshoot it, and maybe report 
yet another bug to the Linux SMB/CIFS maintainer.

Thanks in advance,
   rdiez
