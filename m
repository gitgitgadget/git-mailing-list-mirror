Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8533E1F97E
	for <e@80x24.org>; Sat,  6 Oct 2018 21:14:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725829AbeJGESp (ORCPT <rfc822;e@80x24.org>);
        Sun, 7 Oct 2018 00:18:45 -0400
Received: from mail-io1-f53.google.com ([209.85.166.53]:35266 "EHLO
        mail-io1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725778AbeJGESp (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 Oct 2018 00:18:45 -0400
Received: by mail-io1-f53.google.com with SMTP id w11-v6so13216895iob.2
        for <git@vger.kernel.org>; Sat, 06 Oct 2018 14:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=+E1aqgHc8j+ePr/4iK+BcK/hzP6L0HJx+D5NFjOvVR8=;
        b=Pb9te751Komk2GPHqDyoOxhUIzDiV7WUt6vzQEwbv8iAWEGR42s/EHPK109ccCnT1N
         5wzf+s5Ek70niGuCsnCpap5xGA9XKXMj9L/ziF5Gt6KdkFigJBU37NmsEBwcTDb70av8
         jw8miC99w5kpbyKbC5IVuouOhs52b8nSWVTk7uXbvh7HOTPKH+khYMj4YjkVp1MD2ZEn
         vQfh/gy5l43igVBe9ldwOQ5TSSZDay+LoDZaO/tFYnZT5gHiMgO8II4XE5Xh1Ig4S0L/
         NIQat8k5TWj07LXjeTDwstVL2UY3E6ed3VDrLbTTxPAo+b750y3VI+eWg34FrEgy7IuY
         ktJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=+E1aqgHc8j+ePr/4iK+BcK/hzP6L0HJx+D5NFjOvVR8=;
        b=gig58Ri9BDmRuTPnYDOmWUZ9paUewl26I6Q2c06EJ+8xA6E0i33gF9DtcCw8g7FK8i
         TU7sqJ92zE7E4zNLVvHJxWT5+lb2Et5iz6VQWI3RkSF9sJbgbyrU5qO0UpiPCtg79dZO
         4vbcFk6dmF9tQCk7DrtJD8bzflpsJPap8f/XH+2SqhCsLZczUk0z+PeVN8EpD0L+Yk6T
         284ahpdJlOIjCuozRkg2x5yExdatEUlY4r5VCX5T3n46LzMR7Xrwk4eCcy5cJDRMrFLC
         Tp9rJZi8tpy73Kx1QK2Dg6sMYkMmDqwKkeI4dJ47K3AMeIBh2pCTCAquXC5pDOB8zBBl
         lLhA==
X-Gm-Message-State: ABuFfojni9VbGgNWgpKXcCg4ImUrz1IXCiz+0+h/SxFiA3qRQo6cEd+X
        ddAdNktd0u/a1dN2fSlqO3AVPQDhHdZl6B8x/8RcexyO
X-Google-Smtp-Source: ACcGV634SO966UE5JEKkdF5VmINIe6KD/SKwYFWm1mSOVgCmu60Bnrmm7ltL5/S7RBv5T8ZfNE4bS1XKNkU7wOqw8RY=
X-Received: by 2002:a6b:6209:: with SMTP id f9-v6mr2058545iog.11.1538860436516;
 Sat, 06 Oct 2018 14:13:56 -0700 (PDT)
MIME-Version: 1.0
From:   Farhan Khan <khanzf@gmail.com>
Date:   Sat, 6 Oct 2018 17:13:45 -0400
Message-ID: <CAFd4kYC5psSkXxrHVU11b5bufFFVr-qP=S_Fn9AegCyADLw+HA@mail.gmail.com>
Subject: Understanding Index Header
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi all,

I am writing a program that parses out the .git/index file. I am
reading the git index header documentation, but I seem to be getting
jibberish data.
https://github.com/git/git/blob/master/Documentation/technical/index-format.txt

The first 12 bytes are the signature, version and entries. Great so far.

Afterwards, I try to read the extension signature, which the
documentation says: "4-byte extension signature. If the first byte is
'A'..'Z' the
extension is optional and can be ignored.". I am getting jibberish. Is
this expected?

Then, the extension size comes back as 35560000 (after ntohl()). That
seems extremely high. My structure is as follows:

struct _indexfile_hdr {
        unsigned char   sig[4];         /* Always "DIRC" */
        uint32_t        version;        /* Version Number */
        uint32_t        entries;        /* Number of extensions */
        unsigned char   extsig[4];      /* Extension signature */
        uint32_t        extsize;        /* Size of the extension */
        uint8_t         sha[8];         /* SHA1 of index before checksum */
} __packed;

Am I doing something wrong? Is there some offset or padding that I missed?

Thanks,
--
Farhan Khan
PGP Fingerprint: B28D 2726 E2BC A97E 3854 5ABE 9A9F 00BC D525 16EE
