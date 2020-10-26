Return-Path: <SRS0=PD7l=EB=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F188EC4363A
	for <git@archiver.kernel.org>; Mon, 26 Oct 2020 15:08:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B3A602224A
	for <git@archiver.kernel.org>; Mon, 26 Oct 2020 15:08:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kpx/lJep"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1783194AbgJZPIX (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Oct 2020 11:08:23 -0400
Received: from mail-wr1-f41.google.com ([209.85.221.41]:40515 "EHLO
        mail-wr1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729820AbgJZPIS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Oct 2020 11:08:18 -0400
Received: by mail-wr1-f41.google.com with SMTP id h5so12991490wrv.7
        for <git@vger.kernel.org>; Mon, 26 Oct 2020 08:08:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:openpgp:autocrypt:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=5ZhFBWr2n6/dy2cqrVQXuGzfRigZBMl34bEay9yjZQ4=;
        b=kpx/lJepKrW99dEIMCuyDyz1L8HscN4P2NXANnzG0th3jTG81fQWQ3MR1yjbOa7noc
         wLN6mhPNw7kENG/0FnvoP+UorVzZrRbOTiUkXj/ZAjflwTTGt9FVKVjwhbyow9Y9rGYS
         ljv0r276dozVbU8f0g3Vb90sWz6SMM05Wyay5IuUkt08u3mcLvbALGSZh+4aBiPHaNyl
         ClI293GaXG7CN3owWodrrYtZoW/810whjh8r/ibJUHuPIZpBoygF24XtwBl5uEW0/S3d
         nSqMVBKx8u5LnbxoGn2wueJenX37cPi7JMSmazwDBkS+Q4o5l3x3syMWXwSUmeSqMo33
         DPTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:openpgp:autocrypt:subject:message-id
         :date:user-agent:mime-version:content-language
         :content-transfer-encoding;
        bh=5ZhFBWr2n6/dy2cqrVQXuGzfRigZBMl34bEay9yjZQ4=;
        b=BOTb35+HWQStzbmGM5otc1w1y720jsiPg+XZhRdUUm/49XH+9w+iVhJ0aEOocT5dUE
         ms6lkoWK1882fTJAPLPVjwdXMCjS66gz/IRIj7U0JhqLW/4NZ2nOL1prthkhkS1Yma4w
         Hv33sdyAIE9RudghnMM9rUfhO2DUNSrWsBWEM4ksbg/8OR/fEhv/5T9p2A7FlDlNp936
         XCPkHPjoYfwOTOESEaBKpCgnPoUA3XwMCGdVr8g2o01xpcMMjR9zylIFTe8Lw8Xo5Nci
         PaEyhixqJ/rBfP+xDBFd6ZOyLtmKUfRaVSkZrqMQ2Y79dd/40hIh3+M7Y06H1f19vT7F
         3Ebg==
X-Gm-Message-State: AOAM531uGyXjR4fBGOeHFPE4qfp9t7yfDM4POMP33eYuKjqped7Gtzd6
        IgUKYm8NLDvAZCzxRmsgPsc=
X-Google-Smtp-Source: ABdhPJz+R9L/fKIdRonBNaNgkfrEA+yaP+u6S44lEb2THKpBGWAmBFv8WlexPMdugx4kyIwA09WWMA==
X-Received: by 2002:adf:82ab:: with SMTP id 40mr18062762wrc.420.1603724895620;
        Mon, 26 Oct 2020 08:08:15 -0700 (PDT)
Received: from [192.168.178.32] (pd9e1c454.dip0.t-ipconnect.de. [217.225.196.84])
        by smtp.gmail.com with ESMTPSA id s2sm20410761wmh.9.2020.10.26.08.08.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Oct 2020 08:08:14 -0700 (PDT)
To:     GIT Mailing-list <git@vger.kernel.org>
From:   Ephrim Khong <dr.khong@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=dr.khong@gmail.com; keydata=
 mQENBF2KH3QBCACy66z3LoDOvFnn3Jl07bZvGy8IWXoClBLBEVQEDMgX6/2VskvAiDFYXjYY
 CBnpMZS7pkHyMj2nAuk8rfz8ofhTMxW1YthQGAGJt0eYMp9dymKG4O9c6Lzwlb54lwWet1AE
 x326ePst0QaBkvksN8HmoqNrTZVth2U+IiAI5y7RJB65ZsXmHoXBt4pfPEoQ01WFTXBrQ2ZR
 LHcweZQdU1uhwPjCB6JV9pNTclzFfQyqqga/JbbDbbplhL5XhA15VJq+3CJSM3Y0M1UGEOUv
 5dcWC15x65jlX4yDIrXUYkWq48byHlC8B75n9EnMAvmkFZ09ntSjwsRJmLILxr8cz9jtABEB
 AAG0H0JlcnRyYW0gRHJvc3QgPGRyb3N0QG12dGVjLmNvbT6JAVQEEwEIAD4WIQS1maF3SJAK
 Ql3nP+zsYjhbV87efwUCXYofdAIbAwUJA8OCLAULCQgHAgYVCgkICwIEFgIDAQIeAQIXgAAK
 CRDsYjhbV87ef8CdB/0SR6LhFh7ll8S2uTgwU8giPMuhUN2ZVgr6xVpfI0w5+307BcDLA7az
 JVvRtsSCHHNoZYOvtTq8C+PaiijKkTz30Cn/DYonLe77WAx5WDDvcOxHwrAA1lH8sXJ1QsSw
 B6CExXNHdGu/WeDSErLRUwcf65sIJvS41ZNu2jIOBWxYwXgYFt8Onur8ClqEj4fmMkClb0hD
 gXhgI4iDEM8D5brvd2IoMw7yWZA6awHpDja2SgfambGZ+2kgwEp5UQ3aa3A+s+/wM9Yd5Mv4
 RO2B+BlcEkEPV1OQw7egJW7+C3y7LTozkmzaKK+P3pVbsbP1EkVcnLrGgKvpLm0hChDrD35O
 uQENBF2KH3QBCADTEdr/rxzjxh2VBvyq84iHZYsBflSFIefM/dpyJb3a2/gdikAlbHmMJGL6
 jCZC2mneQ2wNjzsFNQKH714RojYjYYgtNpsDvoB51+gc9Erm38rXWXe9EgXKw2DR7KiSh2D0
 UvwMFgOcUT07e3pbBqzJMe0FN0AXiYWD4xH4zo0gBTbj20iigcNaBvHGRYobHg+ODHg1CXjg
 1ViO8JeVXyM1u3ENR35oTzAuCO3Hc9A9fUZk7L8A2ORK/Lgorig/6LZx/xnh6T2DUl8XADo8
 rgm2Tov6bNQUKdVFybnSMUusNWfcHid3YJ3XeGZsHEj6vlR09sXMqTO+yH3/4J71iu83ABEB
 AAGJATwEGAEIACYWIQS1maF3SJAKQl3nP+zsYjhbV87efwUCXYofdAIbDAUJA8OCLAAKCRDs
 YjhbV87ef3+fB/9rWJ68qI7TVsLlRNYicAaJdRSfsIPjYKsUPpYGLvyX6MTSWHwwD7+WzbHy
 KAuw+sycGfnelxY2+bUCE10+XxSWIE2lShPafmnLIFz6BES6hdjTSuYVRz8+SnxDU6IxjfWi
 xJbMjw5ha52GWKq75tRMeKnEOJpCFiNtAi3yvOPlov+qP3RP7mLtXISjW35GYQfJK0GTH8tR
 QJKz22iL7huh4BXe4E1jZoNjuIO0UTP5/koARaHJx2OGwXO1jYEvvYeYphXkJNl8vlY4OaSf
 kOW/ulC2xjVKJyhYU/fvkRR/xQNgOK2CqMhFtzG2SkAIKjlSw5J2neRzmgxQOzLdtdhV
Subject: Tracking a merge bug
Message-ID: <120922f1-67a9-9ae2-2e9c-56e20935e0f9@gmail.com>
Date:   Mon, 26 Oct 2020 16:08:13 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear All,

I am trying to find the root cause for what I believe might be a strange
bug in git merge.  I have a feature branch A which branched off master
not too long ago, and want to bring it up to date with master:

    git checkout A
    git merge master

which yields

    Removing somefile
    Removing anotherfile
    error: add_cacheinfo failed to refresh for path 'c/d/e.sh'; merge
aborting.

the offending file, c/d/e.sh, does not exist in my feature branch but
was added to master since branching off. After aborting, the working
directory is in an inconsistent state and c/d/e.sh exists with the
correct content.

Below is a stacktrace - the merger handles the file as a rename
(apparently there is a similar / identical file 'c/f/g.sh' that is
renamed to 'c/d/e.sh'), but that fails because the file has MODE_CHANGED
set. (Which appears strange - at the time where the merge is aborting,
the file apparently was already written to the working directory. Is it
renaming two different files to the same target file?).

Any hint is appreciated, especially where to look: Is the root cause
more likely to be at the filesystem level (the stat returns something
off), or in the merge logic? What else could be wrong here?


The stacktrace looks roughly as follows:

-> read-cache.c, ie_modified(): ie_match_stat returned 63, which is
		MTIME_CHANGED	| CTIME_CHANGED | OWNER_CHANGED |
		MODE_CHANGED | INODE_CHANGED | DATA_CHANGED
	and is_modified() returns 63 because MODE_CHANGED is set.

-> read-cache.c, refresh_cache_ent(): at the call to ie_modified

-> read-cache.c, refresh_cache_entry()

-> merge-recursive.c, add_cacheinfo(), is in the refresh-path (i.e.
make_cache_entry() worked, but refresh_cache_entry() will fail)

-> merge-recursive.c, update_file_flags(), after the update_index: label

-> merge-recursive.c, update_file()

-> merge-recursive.c, handle_content_merge() is in the very last
update_file() call, close to the end of the function

-> merge-recursive.c, handle_rename_normal()

-> merge-recursive.c, process_entry()
	is in the RENAME_NORMAL / RENAME_ONE_FILE_TO_ONE block

-> [...]

Thanks
- Eph
