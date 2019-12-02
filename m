Return-Path: <SRS0=5D3W=ZY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24F13C432C3
	for <git@archiver.kernel.org>; Mon,  2 Dec 2019 12:23:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 010BD2070A
	for <git@archiver.kernel.org>; Mon,  2 Dec 2019 12:23:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727437AbfLBMXE (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Dec 2019 07:23:04 -0500
Received: from mx.unixadm.org ([176.9.96.198]:52642 "EHLO mx.unixadm.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727354AbfLBMXE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Dec 2019 07:23:04 -0500
Received: from blobfish.decix.local (unknown [46.31.123.137])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "phil", Issuer "Unixadm CA" (verified OK))
        by mx.unixadm.org (Postfix) with ESMTPS id C354A29525
        for <git@vger.kernel.org>; Mon,  2 Dec 2019 13:23:01 +0100 (CET)
Subject: Re: difftool fails with dangling symlinks, writes to targets outside
 of the repository
From:   Philippe <bqobctqyemmeacqxbrsaury3l4ka@quarantine.de>
To:     Git mailing list <git@vger.kernel.org>
References: <7e04799d-c03c-ac28-604d-ec4d30029d44@quarantine.de>
Message-ID: <c23d23d8-8a08-9ee7-d148-77b1f4611606@quarantine.de>
Date:   Mon, 2 Dec 2019 13:23:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <7e04799d-c03c-ac28-604d-ec4d30029d44@quarantine.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=quarantine.de;
        s=itchy; t=1575289381;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IfkIFQUQWcuGmmGoIGTogXG52IeTQhARQvIGBEV06hM=;
        b=FMu9POdVrcRtmOoSyFCx5AR3XqD2ypPYRz8Ghf5X2mbxP2hA1McDIVgB1iNig6ZB1XHeqQ
        3O+3Sx08P8BEtofUHyRlNu78MtswVa/WBZ8HFDRy9cFD3zHIpWKUezqEnvFEseI7heq65l
        VNtFtOkn9j8XyHDuqHDjrZcwdke3M17KC8rqy3vEy50vcgK5JqKNeuWzjRF+lV4g/y6KPa
        781LECXeiqIavFSA3sUGskqWDyie6SD9fEqLow7Wh59SLlCwZv26cf2oJYr1jCAAZzI5IR
        q6i+gxSSe9KiuEdQ1dbw8/E9QqQCMMxEJk5QwJFCXvrsXaZJz0T/wUPsV7AlpA==
ARC-Seal: i=1; s=itchy; d=quarantine.de; t=1575289381; a=rsa-sha256;
        cv=none;
        b=Ku2XhaEfL/8GljpDQZiNB2ZzFadTvZTi1fZnwXAeskUKzrf2/jzbJ3Y6x0Jx9M61/LAPvW
        n6jTZEMczvzJPmvuud0sFlzKGS7mNSK3OJHd7s9n8Vln/Y07uxxly2ga83dVBWt+iA4Q7W
        griEzAYR+ypo9Yy7Sj2nR7JdhbEMAedAqvqPJa5a9P/QY7v0bw8Tfth8+auM/uiMoerebv
        Kq1z9cJKqGZiq5tXCTHvFqRjpTOJ9HQLIulnn3xM0qsqyfwDIf88GTEIodX4QBRKzEdD04
        8CkX7pYERR0DLvYo5fEkBPkoA5ambnqiVVWSaQCDMAOE0iw9fx4KqWqT6gBCkA==
ARC-Authentication-Results: i=1;
        mx.unixadm.org;
        auth=pass smtp.auth=phil smtp.mailfrom=bqobctqyemmeacqxbrsaury3l4ka@quarantine.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi all,

since that "difftool overwrites files outside of the git
repository"-thingy is apparently not considered a bug, could you please
point me to the correct usage of difftool or a workaround?

To recall the situation:
- git repo contains a symlink pointing outside of the repository to a
non-existing file
- that symlink gets replaced by a regular file
- using 'git difftool -d ${oldstate}..${newstate}' overwrites the file
the symlink was pointing to (which might fail if the target is not writable)

Kind regards

Philippe
