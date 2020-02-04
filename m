Return-Path: <SRS0=lL1X=3Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85DADC3524A
	for <git@archiver.kernel.org>; Tue,  4 Feb 2020 06:15:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 506D920674
	for <git@archiver.kernel.org>; Tue,  4 Feb 2020 06:15:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O95gtqry"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727023AbgBDGPC (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Feb 2020 01:15:02 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:48877 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726898AbgBDGPC (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 4 Feb 2020 01:15:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580796901;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=RqWJPib2XlyWIeeusVsZPUiZJXnp6I0jGXGfMaeyZu8=;
        b=O95gtqryGlMq7I9HT24ujZ3pMz+zMeErOhv6328OabLt0xv7/9FeMS+SESU9HdKd4LR3KY
        ohgmujAxYiRgBtzC4giG8bYmswsi4NjJMs3OLQfL7pJGjoUPv0IEMyGDItQbBJT2Y9V6IU
        cpBqoISLuX601RzwgHTnEBohpMVJU80=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-432-_7mNnAlwMGWkzwJ7Pzkdsw-1; Tue, 04 Feb 2020 01:14:57 -0500
X-MC-Unique: _7mNnAlwMGWkzwJ7Pzkdsw-1
Received: by mail-qt1-f198.google.com with SMTP id d9so11676489qtq.13
        for <git@vger.kernel.org>; Mon, 03 Feb 2020 22:14:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=RqWJPib2XlyWIeeusVsZPUiZJXnp6I0jGXGfMaeyZu8=;
        b=RNqOBKg4n1n5+spjIeuLptIgQ5pHY9NuogAdW0v+wTmbOKpKJpgGpnJraYbFSAh5Io
         huND4abmAhxbuxEzRRsdhpcoLle91d3mfoQjYZd72Nx67s8f4blpk1ur+4JbkAy5Ff0L
         jX93TkthhUdY5nN+y/XP22bGqptQ0e/QO5IcMkPpEkfc0idAmwiLOkXSnD9xsXQMiwsZ
         4WL5xSaYdYJNGJTSj0aoI2y32DMoCTVLj7ivDwR4mMvqzajBhEIVT/tIhcvF5433Ile3
         KJktfP3UN9quk9LExVZuDyR7GzPWEQGCYi6h+R2chrM/xMUTZn9/mJvTfFngzG2j4oB7
         DGtQ==
X-Gm-Message-State: APjAAAXOMpKQtQdk8kuybuWrUOjr4qio9dtmVIf8j9K2g2fbrFmjt1PG
        W591Cp7IS4iHwrx00KtJ9Iy8VoCbXTO6AJNMSsUQOe5BitHKB+9E12YWzjvYeLSP+pFbbTw7ELq
        9dRyxA8fyEXay
X-Received: by 2002:a05:620a:126d:: with SMTP id b13mr10156519qkl.124.1580796894891;
        Mon, 03 Feb 2020 22:14:54 -0800 (PST)
X-Google-Smtp-Source: APXvYqz821/sfD3xWonZkcXsUyOQ+VzOlBTs1GHZqkI/xDrW2yofNa8k1vwCh9gkUAH9zkbijCZNmg==
X-Received: by 2002:a05:620a:126d:: with SMTP id b13mr10156452qkl.124.1580796893165;
        Mon, 03 Feb 2020 22:14:53 -0800 (PST)
Received: from redhat.com (bzq-109-64-11-187.red.bezeqint.net. [109.64.11.187])
        by smtp.gmail.com with ESMTPSA id m21sm10500746qka.117.2020.02.03.22.14.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2020 22:14:52 -0800 (PST)
Date:   Tue, 4 Feb 2020 01:14:48 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Subject: bug? illegal text in commit log
Message-ID: <20200204010524-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It seems that it's not too hard to make commits such that
the standard way of git format-patch -> email -> git am
fails.

For example:

[mst@tuck ~]$ mkdir gittest
[mst@tuck ~]$ cd gittest/
[mst@tuck gittest]$ git init
Initialized empty Git repository in /home/mst/gittest/.git/
[mst@tuck gittest]$ echo AA > a.txt
[mst@tuck gittest]$ git add a.txt
[mst@tuck gittest]$ git commit
[master (root-commit) 46e2cd1] original
 1 file changed, 1 insertion(+)
 create mode 100644 a.txt
[mst@tuck gittest]$ echo AA > b.txt
[mst@tuck gittest]$ echo BB > c.txt
[mst@tuck gittest]$ diff -u b.txt c.txt > bc.diff
[mst@tuck gittest]$ echo "this change" > commitlog.txt
[mst@tuck gittest]$ echo >> commitlog.txt
[mst@tuck gittest]$ cat bc.diff >> commitlog.txt
[mst@tuck gittest]$ echo BB >> a.txt
[mst@tuck gittest]$ git commit -a -F commitlog.txt 
[master c5f40b2] this change
 1 file changed, 1 insertion(+)
[mst@tuck gittest]$ git format-patch HEAD~1..
0001-this-change.patch
[mst@tuck gittest]$ git reset --hard HEAD~1
HEAD is now at 46e2cd1 original
[mst@tuck gittest]$ git am 0001-this-change.patch
Applying: this change
error: sha1 information is lacking or useless (c.txt).
error: could not build fake ancestor
Patch failed at 0001 this change
hint: Use 'git am --show-current-patch' to see the failed patch
When you have resolved this problem, run "git am --continue".
If you prefer to skip this patch, run "git am --skip" instead.
To restore the original branch and stop patching, run "git am --abort".

A work around is "don't do it" - avoid putting anything that looks like
a unified diff in the commit log.

However:
- Users don't know what other restrictions exist
- User sending the patch has no way to detect failure,
  it's only visible to user receiving the patch

Ideas:
- validate commit log and warn users?
- find a way to escape text in git format-patch, and unescape in git am?


Thanks,
-- 
MST

