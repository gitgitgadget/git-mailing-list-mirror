Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3A490202D7
	for <e@80x24.org>; Wed,  8 Mar 2017 18:14:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754080AbdCHSOr (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Mar 2017 13:14:47 -0500
Received: from mail-qk0-f179.google.com ([209.85.220.179]:36437 "EHLO
        mail-qk0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754026AbdCHSOq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Mar 2017 13:14:46 -0500
Received: by mail-qk0-f179.google.com with SMTP id 1so79083608qkl.3
        for <git@vger.kernel.org>; Wed, 08 Mar 2017 10:14:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=vmNtpxJrW6BwiDJjhKBOic2Z6YmFxyWBvIsU57ndDFc=;
        b=QHzQ/Z0WEX4oVQef6EfhS4vlqCHnkue4xktf/vk72+Uo6TS2OER9Q+uLtY2vMWkiGS
         4ooao3NqiUMy4pRtdlqKSiN1YTuobUj1BvYIFO0K2JdE8PYjTgAmnOy9SHQPG3MqdOK0
         TZHoV98BTeceWYkEzSI7tVI8MnMRQJRd+AVeR4QuAeUii5ruOjD/KvrCBK/GsH7e+BgF
         cdV6Y63FphJifgux8MYGYvlYmVsySUZ0puwz9+2ut7qjP80FnQl4Ku/XlimxxVoZw8As
         iikBxYrVBV/elI9DdojK1HEliC6dbS1ky43cEfGc9yczxCatm98hzwOsLTV1BZNgpN5o
         Dzzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=vmNtpxJrW6BwiDJjhKBOic2Z6YmFxyWBvIsU57ndDFc=;
        b=etJjopTrNiQvK9Yv4Ssz8GJQXQBx+JxijYhEBzq/S1czBTQ5pkT7ek899V7vNTXStb
         rRaY5DZQqwgHzrju/hcm5zWHiP2aYN/kOhbQk7MhRgOzY6tD6XtrvnXOrTVLEHNo+B4q
         8L73zlvUaCQUPM2pLeo2kK/XTG/Ab+jdWFXu40/JC/6zBCikOEQjilKh4/ykGAYxaaY7
         u4r8KHLP/geEiK1CMU3VHOyYvWANwzMcWeJPkcKHBfCXTN50j0rWCTXFnRVxoHgxmZ92
         RsaAD3T0X0wXUWhiivhgtkN51O1N0RYnrn4ys9nHkiluupKWYESKLAE4Se3tIYx1G8+1
         t3wg==
X-Gm-Message-State: AFeK/H2IRYvM8hxJKmytACPnrWpmny38VAJ3Lyx6iirrP/Sm3dLvkJGCfi7ijKD8fuIXEKjgPPU1OXtRC7LKdg==
X-Received: by 10.55.209.28 with SMTP id s28mr8721210qki.178.1488996884408;
 Wed, 08 Mar 2017 10:14:44 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.165.66 with HTTP; Wed, 8 Mar 2017 10:14:24 -0800 (PST)
From:   Guillaume Wenzek <guillaume.wenzek@gmail.com>
Date:   Wed, 8 Mar 2017 19:14:24 +0100
Message-ID: <CAAvNd=ir1qNQVaKphdg51AfGnsNgTrfvW2L6cca3SHiZrWNgHA@mail.gmail.com>
Subject: BUG Report: git branch ignore --no-abbrev flag
To:     git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,
After updating to git 2.12.0 on Monday I noticed that the "git branch"
wasn't behaving as usual.
As of today `git branch -vv --no-abbrev` outputs short hashes instead
of long one (as requested by --no-abbrev)[1]

git branch -vv --no-abbrev
* (HEAD detached at 2.12.1)                        1c69bf2 Add
recap-release since previous release messages didn't go out.
  master                                           eb70249
[origin/master] Fix: support parsing "git://" remote URI to Github URL


Expected output:

git branch --vv --no-abbrev
* (HEAD detached at 2.12.1)
1c69bf24be6de096d801435378be85a936ab0f29 Add recap-release since
previous release messages didn't go out.
  master
eb70249e724f933255b4d8c7096092f2764942b4 [origin/master] Fix: support
parsing "git://" remote URI to Github URL

[1] https://git-scm.com/docs/git-branch#git-branch---no-abbrev

I don't have any relevant configuration set.
