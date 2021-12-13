Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D5D8C433FE
	for <git@archiver.kernel.org>; Mon, 13 Dec 2021 14:31:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230272AbhLMOb2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Dec 2021 09:31:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239374AbhLMOb1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Dec 2021 09:31:27 -0500
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A27C7C061574
        for <git@vger.kernel.org>; Mon, 13 Dec 2021 06:31:27 -0800 (PST)
Received: by mail-io1-xd36.google.com with SMTP id m9so18773755iop.0
        for <git@vger.kernel.org>; Mon, 13 Dec 2021 06:31:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=dEx/27ig3zBNLKBIWJI9whk3Mc1OOay+kxXQYmyJSq0=;
        b=cxP4A7ATQFYIcZGYSfuiUwBxzG34+a7Dn+XY/EPsfcP2RY0Pri/qceuUgxnJyFizfQ
         ueczwJ0c0bEFJVDS6basdCvhofZFANO+W/2kEd9k5lT1V7Zo9w7lY0YU1OPxRTOevBiv
         c7Lw0BRyitXKaS3NxfLramIlNYcgCg59AoYj9an1wldTw1U/Au3o2/NZqYvnECzW+JAP
         dJaudBcQ96bb2f8v4Ej5L4lMq5im9xZ1bQj4TpFZCHUGtvV6zeksHHsv+3Re0pN+UcE4
         6I8lW6xR7NqrjbW11wBNpE/DqzNXhSwxY/vqk71SZ8nuSsVSeY67s/FwmF1SPKeneVGh
         Kcjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dEx/27ig3zBNLKBIWJI9whk3Mc1OOay+kxXQYmyJSq0=;
        b=4oxP6i8FrxhyLYPmgC3FJnk8+c32A5CqJhQ7wqKvcmH2DOvAUO25yACz8MRSExTpYZ
         2p+0zlGKnWNtMkST29uSavU4PFFtLFQ+WhEIywUOXpr9RFs1SYNoEU698chlrjjw2dHj
         DolOAGhfb0CAvhjo4RYwJG4ifzdfXlvHwLK2PqlPDPETv6kDpY1cjSIKSsSyQ5vYjw/6
         9uwq30Jugi89C+U5LHeTD022kvfjDpWMa5OqQw6f1CTeytWzkYvUj/36AmRg0CdyqAuz
         FT8ZcuGJ4WK1IFEHu7RwzBnwcjMZFD1s8JD3BPMqebyZk2DKaZgUgyC6+nMJZbKlxWRh
         H67Q==
X-Gm-Message-State: AOAM531HgTkhEi3jTeraiajDU+w5SaPStidTwh6+IIHi05fvTQwaNH2h
        rmAYozqNMnVrBjbbsrnBhsiskA==
X-Google-Smtp-Source: ABdhPJx/y72sLf623G/XIUGyI2/BhANEML5NP80Rfuy9d7+bt4g29QOfbK9RXu5IzpdqYERIge22xQ==
X-Received: by 2002:a5d:9d92:: with SMTP id ay18mr35009406iob.130.1639405887007;
        Mon, 13 Dec 2021 06:31:27 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id c7sm6865731iob.28.2021.12.13.06.31.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Dec 2021 06:31:26 -0800 (PST)
Date:   Mon, 13 Dec 2021 09:31:25 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>,
        git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH 0/2] midx: prevent bitmap corruption when permuting pack
 order
Message-ID: <YbdZPWlqSyfcTYhR@nand.local>
References: <cover.1638991570.git.me@ttaylorr.com>
 <bf100d0c-66c7-d402-4790-9c5797e8baf3@gmail.com>
 <YbENofRtY0BPMEUd@coredump.intra.peff.net>
 <YbOeEjNic5ETGcdy@nand.local>
 <YbPVP0BvYcVsfOrf@nand.local>
 <YbQBZX+Wo3zlOcWc@nand.local>
 <6ea31bb3-3363-ece0-9947-b303d5975263@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6ea31bb3-3363-ece0-9947-b303d5975263@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 13, 2021 at 09:00:55AM -0500, Derrick Stolee wrote:
> I think the root cause is that the object order can change when the
> preferred pack changes with the same set of pack-files. Suppose we
> added more complicated ways of deduplicating objects across the packs?
> Then whatever we include here based on preferred packs and mtimes
> would need to be updated to match.
>
> However, if we store the contents of the .rev file in the MIDX itself,
> then we don't need that extra layer of indirection.

Yeah, towards the end of the weekend I started to lean towards putting
the whole object order inside of the MIDX.

You're definitely right that the root of the problem is the object order
is stored separately from the MIDX itself. And we probably could get
pretty creative and figure out what the minimal amount of information
needed to fingerprint an object order is. But the amount of time I spent
thinking about each proposal did not leave me with the obvious sense
that there still weren't ways around that could change the object order
without changing the MIDX's checksum.

> I'm leaning towards keeping the contents of the PORD chunk as-is, but
> renaming it to something like OORD (for object order). Then, we can
> carefully transition from using the .rev file to reading this chunk.
> We will want to continue looking for the .rev file when this chunk does
> not exist.

Agreed. What do you think about a series that just writes the chunk but
does not read it? That would solve the bug in the immediate-term. Then
we can go back and transition from the .rev file to the new chunk.

Reading the revindex chunk over the .rev file is pretty easy, as
demonstrated by the patch below.

What I'm less certain about is how we should write tests to make sure
the old strategy works, too. Do we want to run the MIDX bitmap tests
twice in a separate mode each (one that writes .rev files and one that
writes chuns in the MIDX)? Something else? Thoughts welcome.

--- 8< ---

diff --git a/pack-revindex.c b/pack-revindex.c
index 70d0fbafcb..d59ae73198 100644
--- a/pack-revindex.c
+++ b/pack-revindex.c
@@ -301,6 +301,20 @@ int load_midx_revindex(struct multi_pack_index *m)
 	if (m->revindex_data)
 		return 0;

+	if (m->chunk_revindex) {
+		/*
+		 * If the MIDX `m` has a `RIDX` chunk, then use its contents for
+		 * the reverse index instead of trying to load a separate `.rev`
+		 * file.
+		 *
+		 * Note that we do *not* set `m->revindex_map` here, since we do
+		 * not want to accidentally call munmap() in the middle of the
+		 * MIDX.
+		 */
+		m->revindex_data = (const uint32_t *)m->chunk_revindex;
+		return 0;
+	}
+
 	get_midx_rev_filename(&revindex_name, m);

 	ret = load_revindex_from_disk(revindex_name.buf,
