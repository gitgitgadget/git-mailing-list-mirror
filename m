Return-Path: <SRS0=7OUv=6W=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D3C3C38A2A
	for <git@archiver.kernel.org>; Fri,  8 May 2020 10:35:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6B5120A8B
	for <git@archiver.kernel.org>; Fri,  8 May 2020 10:35:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="dnISSn+z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726811AbgEHKfy (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 May 2020 06:35:54 -0400
Received: from forward106o.mail.yandex.net ([37.140.190.187]:44987 "EHLO
        forward106o.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725825AbgEHKfy (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 8 May 2020 06:35:54 -0400
Received: from mxback13o.mail.yandex.net (mxback13o.mail.yandex.net [IPv6:2a02:6b8:0:1a2d::64])
        by forward106o.mail.yandex.net (Yandex) with ESMTP id 7AF165060E76
        for <git@vger.kernel.org>; Fri,  8 May 2020 13:35:48 +0300 (MSK)
Received: from iva6-add863d6e49c.qloud-c.yandex.net (iva6-add863d6e49c.qloud-c.yandex.net [2a02:6b8:c0c:7ea0:0:640:add8:63d6])
        by mxback13o.mail.yandex.net (mxback/Yandex) with ESMTP id cDd4jCmc6W-ZmLqAbAg;
        Fri, 08 May 2020 13:35:48 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1588934148;
        bh=IWiamSj6LhquTXBQIrVnP183T91YpTsiN8mA8bwiwYI=;
        h=Subject:From:To:Date:Message-ID;
        b=dnISSn+z+QtOLy6d2Dc2Y6n6QHtJtRYsywFJiIgBGcX7Ybh8XmlaP5EPtQnhIx703
         FYCp53OReIxEVZ5sAK+bKl4QbKeiBYfI0w3OWXgkRjKb0UNwrMVMpXll4rb5TeJLzr
         kj5bHbDSymO0LF5tUDPjsP/SDwaDvGON8xWIGkBE=
Authentication-Results: mxback13o.mail.yandex.net; dkim=pass header.i=@yandex.ru
Received: by iva6-add863d6e49c.qloud-c.yandex.net (smtp/Yandex) with ESMTPSA id fEVJSZYuK8-ZlXWu1pR;
        Fri, 08 May 2020 13:35:47 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
To:     git@vger.kernel.org
From:   Konstantin Kharlamov <hi-angel@yandex.ru>
Subject: git apply -3 doesn't work
Message-ID: <d9d549eb-e888-c930-1aeb-38cd3aad1b3b@yandex.ru>
Date:   Fri, 8 May 2020 13:35:42 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As description says. To check that the 3-way merge should actually work subsitute `git apply -3` with `git am -3` in the following steps. This way it works.

# Steps to reproduce

     $ git init
     Initialized empty Git repository in /tmp/foo/.git/
     $ echo hello > file1 && git add file1 && git commit -m "initial commit"
     [master (root-commit) 8334093] initial commit
      1 file changed, 1 insertion(+)
      create mode 100644 file1
     $ git checkout -b mybranch
     Switched to a new branch 'mybranch'
     $ echo bye > file1 && git add file1 && git commit -m "change file1 text"
     [mybranch 1807900] change file1 text
      1 file changed, 1 insertion(+), 1 deletion(-)
     $ git format-patch -1 --stdout > 1.patch
     $ git checkout master
     Switched to branch 'master'
     $ mv file1 file2
     $ git add -u && git add file2 && git commit -m "renamed file1 to file2"
     $ git apply -3 1.patch
     error: file1: does not exist in index

## Expected

Git apply successfully returns

## Actual

It prints

	error: file1: does not exist in index

# Versions

git 2.26.2
