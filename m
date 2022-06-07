Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5050FC433EF
	for <git@archiver.kernel.org>; Tue,  7 Jun 2022 10:27:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240974AbiFGK1g (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jun 2022 06:27:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240999AbiFGK1c (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Jun 2022 06:27:32 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89A45506EC
        for <git@vger.kernel.org>; Tue,  7 Jun 2022 03:27:25 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id g205so15139029pfb.11
        for <git@vger.kernel.org>; Tue, 07 Jun 2022 03:27:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Zme8pb6+ipA6h3QHUDQb7aFGCN7qzC+x4Y1qlfJFFyc=;
        b=bNuRLxH67fU11W1txb/vzE1mUA6W90cllW9ah1hVAmRZhYZmQmO2xA8EvywXXk3auP
         ljUwhfJH52wYUCvwRggCtzk1wJ7Vc/pU7hboz+a3ehKFD6b1sOpUsqiiGC+l0EEND5CS
         HcJUhoq6Q3JHKFsUv+ZNtAE152JTXNbOJt+eDaukAv5Cf0H0Bgv8WNfepcQryize2swi
         I54eGdEre8u/+F2EKA4jDH5RA5eiNmYnli/g7S0haI1Ao/YXVPcTTryRn52qhJ5+NViT
         oEQ0JDPTuV6KIYpnI1z8ov0u858LlP8zb5Kgc0tB7ruVcihTRE+4kpHVfyFtx2idU5HY
         kmHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Zme8pb6+ipA6h3QHUDQb7aFGCN7qzC+x4Y1qlfJFFyc=;
        b=7/TJGbcEHdF36wRKBb/oUVxPwoSIeYVzvYieN6zcG2NQvEHc4nbVdWXZkIpCAg8I76
         NsZstuuYv7OGImeiP4iDannFWSn25YDJglRjjXfkHCAaZxijwQ0p67c+24iZ4HGoRBiJ
         KTdN/9nBVj8P1TKUQzfmsvIrXVOTMhgb368xNQgU70yfp4HYVRVfgwNajLw8DaJtfEjI
         D7GuUIjp0nizAgq+L/CU0Bgs7Hdq/GJ/BGFZONMSPlq93ZGD0nkg19rrMZff1hBVGnOv
         /lC+rUaliKzmc9FsjyOKDiN0fnXrtvDK6GEySe2MZQYF+qa3zzct3QdDdSmEJFZo9ahg
         7vhg==
X-Gm-Message-State: AOAM532W6LjfVM5h09Uv/do0Z9o500nUB+3rOTT/KNT8SXB/W1gM3lTq
        CZP9iJj3GwmvizaN7l1ChGgfW7D/pHA=
X-Google-Smtp-Source: ABdhPJwwvT0VI6r2xeVE1gZsVYx1rU5kqo+Qwc8RqTEqTr+srxF8i9qaz/dBV3VnQALwQR81u2d6iA==
X-Received: by 2002:a65:604d:0:b0:3fc:57c8:e6eb with SMTP id a13-20020a65604d000000b003fc57c8e6ebmr25698049pgp.260.1654597644802;
        Tue, 07 Jun 2022 03:27:24 -0700 (PDT)
Received: from localhost.localdomain ([2409:4061:2e40:bf3e:b12a:56c2:95a0:2691])
        by smtp.gmail.com with ESMTPSA id l191-20020a6391c8000000b003fc5b1db26fsm12506346pge.52.2022.06.07.03.27.19
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 07 Jun 2022 03:27:24 -0700 (PDT)
From:   Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>,
        Git <git@vger.kernel.org>, Vicent Marti <tanoku@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH 1/2] bitmap-format.txt: fix some formatting issues
Date:   Tue,  7 Jun 2022 15:55:04 +0530
Message-Id: <20220607102504.2243-1-chakrabortyabhradeep79@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <xmqqsfohbxbp.fsf@gitster.g>
References: <xmqqsfohbxbp.fsf@gitster.g>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> wrote:

> Identify those who may have input with "git log --no-merges" and add
> them here, perhaps?

Thanks, I hopefully cc'd all the people who can give some input about the
patch except Peff. I got to know that he took a break so I decided not to
cc him (will surely do if you say). I would love to hear from other people
who has knowledge on asciidoc.

I previously informed Taylor and Kaartic about the patch but forgot to
cc them :P

Another thing to note that the checksum that I included in the last
commit is suggested by Taylor himself. I was having problem to understand
some portion of `load_bitmap_header()` (because I wasn't aware of the
trailing checksum) when he cleared my doubt by saying that a trailer
checksum exists and also suggested to make a PR addressing that -

> I'm glad that it was helpful! If you think others may be confused by the same, feel free to write a patch modifying Documentation/technical/bitmap-format.txt to point out the trailing checksum.

Junio wrote -

> Are we missing another step that must come much earlier than this
> patch?  It seems to me that Documentation/Makefile does not even
> consider that we should feed this file to AsciiDoc.

I also think the same. At first, I thought this is intentional. When
I ran `make doc` (to test the resulting html file), it didn't generate
any html file for bitmap-format.txt. But thankfully there is an online
asciidoc editor[1] where you can check the resulting html file. You also
can check the resulting html by copy-pasting the content[2] of my github
branch bitmap-format file to that editor.

Will write a patch for it.

The current broken page can be found at - https://git-scm.com/docs/bitmap-format

> Do these blank lines hurt very badly how the end-result is formatted
> in HTML?  Does the extra indentation between the line with "The
> following flags are supported" on it and the two bullet items in the
> header make the output better in significant way?

Answering to the first question - yes, those are necessary to improve
the html readability (you can verify that by including and removing the
blank lines in the editor and obsering the changes). This ensures that
all the related paragraphes are contained in the same block.

The extra identations are not necessary. I add those because I thought
that these would be visually better for html page readers. If you think
it does the opposite, I can remove those.

I tried to use two bullets as less as possible ( In most cases, nested
lists came under <pre> blocks, so I didn't have to use two bullets).
But in one case, I had to use it for nested lists (Try the editor to
see the rendered output).

> These changes make the input text much harder to read, and are not
> very welcome, so unless they are part of "fixing generated HTML is
> broken", please omit them.  As evidenced by the lack of HTML output
> in the build system, a lot more folks read this document in text than
> in HTML, and readability of the source matters.

Okay, I will then remove those extra indentations. But besides that, all
are necessary.

I admit that readability of source matters but I think html pages are
also important (even more important)  for people who don't have the
source codes and want to know the git internals.

Thanks :)

[1] https://asciidoclive.com/edit/scratch/1
[2] https://github.com/Abhra303/git/blob/fix-doc-formatting/Documentation/technical/bitmap-format.txt
