Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 01A0F1F453
	for <e@80x24.org>; Fri,  2 Nov 2018 05:23:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728058AbeKBO3V (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Nov 2018 10:29:21 -0400
Received: from mail-io1-f49.google.com ([209.85.166.49]:39238 "EHLO
        mail-io1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727350AbeKBO3U (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Nov 2018 10:29:20 -0400
Received: by mail-io1-f49.google.com with SMTP id n11-v6so554916iob.6
        for <git@vger.kernel.org>; Thu, 01 Nov 2018 22:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=qIVGsgQS2Cn7IUkTfsBOnhw1G7tps8Mfb8spCjQux84=;
        b=U8mGd/44l9h0h4XwfRhTgr1g6r7OVGbxO8Clhlkrx5zWmKZ6IJ2U/k8g+KdZnq88kq
         0WKH5C1DclBvIjs41uF71ZBKZcxg/wXZJlIwgaaD1ncsxvOCspRzkQ47esEulDDl7BU8
         migYfpdGk0dc3mb8G6eC0ERFcjV4xLPK0+YvqXn4/7OdFqaHVRIT+2R5SbuVuAXK0eqU
         dXP7ejlhbd6zNV7iwS3QUOQzc7QWEkAj57EK0Z5vR8vhtyTd/zGDrKO9QHNvkYoN1NY7
         MdQ0gAUr0Ro847EkUkWTDiUJ/BV3YjzsCurmFbXjfbrEoXLwHu8azeLv2Ee81ZjwjzkD
         llSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=qIVGsgQS2Cn7IUkTfsBOnhw1G7tps8Mfb8spCjQux84=;
        b=H8f+0Yy6wzh6GYMxWjOY9wXswJhEzds1jPJcsYmN34Pbc/CCpdzotePgvO93rhC+1h
         2ROw0wXXmBTLcLixPaHbOqp8UytYh/NeCTOE06dUXKeK+fAieG/r7V9iF9OGdwskEIZI
         UeMmphqXbn4UQkPA1tCgBH5g/MjWMfYpd1af/5fB+/VxGCOjFm5W5qzMpF26QHOUKqYz
         pfXSN5xjezOmOLmWAw3rqeexM8X8ivk/w2I2fHKl3EETPn3HYvm8nBPoRsGnw52jwCeU
         MKe2idL51OwiDC3Ji0OsxMwKk3RxjEZ9W5cV2pNyH19jGq6gF6UTPf9U/XeOsIDupMWd
         ElHQ==
X-Gm-Message-State: AGRZ1gJuMpS5bjLEAkBPE//QqUzDb9w3EknmLbmuyByuMKIEZm3qZs+7
        j2VgME+sK3zt8iHmTbC/7mnu66vEoYf/MTIAixZWBRt9
X-Google-Smtp-Source: AJdET5eA9/jpDRvvjL8AAV8bfwTHWp+nUJc/0s6IETHZl4/hm6+9jl+EMCTzOSeTdgsr1Qvj5bHL6j6ATQYEYtAzry4=
X-Received: by 2002:a6b:3fc5:: with SMTP id m188-v6mr8031711ioa.188.1541136206306;
 Thu, 01 Nov 2018 22:23:26 -0700 (PDT)
MIME-Version: 1.0
From:   Farhan Khan <khanzf@gmail.com>
Date:   Fri, 2 Nov 2018 01:23:15 -0400
Message-ID: <CAFd4kYBDWMvVgDmNTzwOK9Q7n_Fb0NrvNAFgHtKvkLkRFWqUKw@mail.gmail.com>
Subject: Understanding pack format
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi all,

I am trying to understand the pack file format and have been reading
the documentation, specifically https://git-scm.com/docs/pack-format
(which is in git's own git repository as
"Documentation/technical/pack-format.txt"). I see that the file starts
with the "PACK" signature, followed by the 4 byte version and 4 byte
number of objects. After this, the documentation speaks about
Undeltified and Deltified representations. I understand conceptually
what each is, but do not know specifically how git parses it out.

Can someone please explain this to me? Is there any sample code of how
to interpret each entry? Where is this in the git code? That might
serve as a good guide.

I see a few references to "PACK_SIGNATURE", but not certain which
actually reads the data.

Thanks!
--
Farhan Khan
PGP Fingerprint: B28D 2726 E2BC A97E 3854 5ABE 9A9F 00BC D525 16EE
