Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC9A9C433EF
	for <git@archiver.kernel.org>; Sat, 21 May 2022 11:33:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236143AbiEULc6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 May 2022 07:32:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355821AbiEULcU (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 May 2022 07:32:20 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6C803EA85
        for <git@vger.kernel.org>; Sat, 21 May 2022 04:30:19 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id gi33so11366760ejc.3
        for <git@vger.kernel.org>; Sat, 21 May 2022 04:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=yJzhizI3zYtH980k+4sSIcbvf65I8AapP+aCD6diZEQ=;
        b=JTgfSLEGN5XrrokAc6Z2QgMxg9++pCWAaemNbUj2trPUJYvOo6GFFXeTLLiWhuPDrm
         l0qSd87MghlRCPn13R29WnAGerwJklRvFguxFbjdmOCbMYrEm3uqM5C6TZQHA/4mJN0E
         66I9PBVl4kWvkAG7QVcw1fz3fazUQ0naoWH/Fl+n/zE0S8wSe4GQJTShCJOYnpXMw64r
         OGpM5E2C8IITtt/RHqbAgct5Z7YTHJSshLskxyl2BrwUW4ip6Edo6q0kjeTcIyLrgVOT
         qBbEtGX2dQS7bZYEQQtGMr3/7R4Vk3N07UhuckA/ykPLQu+I5NQJFx7DnRWr+TvB30R1
         yYCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=yJzhizI3zYtH980k+4sSIcbvf65I8AapP+aCD6diZEQ=;
        b=QMRi1aeYpgH8b4r6yJItHkZyNh15vKCv1qgVxxoAE42XH1KRQ3ynGb3vJu+15EpDjj
         MhOF1z4AeRuzMwSs81gf8T/AqwIL4Gl8sME/jqQxGHfTXLKVykWiey67WDdjWn/1KLvq
         2X8ygCDghSHudXl2djdDajvQFYyXIY/58gMcUxbZ7qXmh2jMCWWiPfBBzGXvwg/a8ybC
         +Y2i7Wl46eTc9tYM6YUXbmvp4w9+DBDyUDAZos4cikCCaazp+V0rx/kE1O9neQ3lGbii
         crQR7yXnYri0W+eWbuULFjqUTyRRTssbJ2MQcTjb0YpYOkZKNhV8NRVuX00KF8ToZXTM
         pTTw==
X-Gm-Message-State: AOAM530ambxHlx+wpWGB6DOGCSP/fRwFnhUtKoJNRahsmcM/LpLZXjQ2
        FFF/ksSv5T4zVM0udPU7qCumPaA4rSDbxA==
X-Google-Smtp-Source: ABdhPJzo/oEAPUfQvvrzezwfBrrQDAudgeeCcaQluZPofoCAJvftI9QoApW0Wm18arRdh+EVEPXc6Q==
X-Received: by 2002:a17:907:8a16:b0:6fe:49b5:350b with SMTP id sc22-20020a1709078a1600b006fe49b5350bmr11991589ejc.610.1653132618181;
        Sat, 21 May 2022 04:30:18 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id z7-20020a05640235c700b0042b0fcfe966sm2734096edc.37.2022.05.21.04.30.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 May 2022 04:30:17 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nsNJI-002eSa-F9;
        Sat, 21 May 2022 13:30:16 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, derrickstolee@github.com, gitster@pobox.com,
        jrnieder@gmail.com, larsxschneider@gmail.com, tytso@mit.edu
Subject: Re: [PATCH v5 00/17] cruft packs
Date:   Sat, 21 May 2022 13:17:20 +0200
References: <cover.1638224692.git.me@ttaylorr.com>
 <cover.1653088640.git.me@ttaylorr.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <cover.1653088640.git.me@ttaylorr.com>
Message-ID: <220521.868rqv15tj.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, May 20 2022, Taylor Blau wrote:

>   - The new section in pack-format.txt (describing the ".mtimes" format) now
>     says at the top "all 4-byte numbers are in network byte order", and avoids
>     repeating "network [byte] order" throughout that section to reduce
>     confusion.

Suggestion (outside this series) since that's fixed perhaps a small
stand-alone patch to fix the existing "network order" occurances in the
same file?

> ...and that's pretty much it. In any case, a range-diff is included below.
> Thanks again for all of the thoughtful feedback on this series.

It seems this didn't make it on-list, but for the last round (well, it
seems I replied to v1 by accident) A sent this (at
https://lore.kernel.org/git/220519.86ilq14u1a.gmgdl@evledraar.gmail.com/
if it eventually shows up):
	
	Return-Path: <avarab@gmail.com>
	Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
	        by smtp.gmail.com with ESMTPSA id en21-20020a17090728d500b006fa9820b4a2sm1979775ejc.165.2022.05.19.04.54.26
	        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	        Thu, 19 May 2022 04:54:26 -0700 (PDT)
	Received: from avar by gmgdl with local (Exim 4.95)
		(envelope-from <avarab@gmail.com>)
		id 1nrejZ-0026V8-AE;
		Thu, 19 May 2022 13:54:25 +0200
	From: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
	To: Taylor Blau <me@ttaylorr.com>
	Cc: git@vger.kernel.org, gitster@pobox.com, larsxschneider@gmail.com,
	 peff@peff.net, tytso@mit.edu, brian m. carlson <bk2204@github.com>
	Subject: Re: [PATCH 05/17] pack-mtimes: support writing pack .mtimes files
	Date: Thu, 19 May 2022 13:48:42 +0200
	References: <cover.1638224692.git.me@ttaylorr.com>
	 <deece9eb70e9750bb8350946679b521e59139fe2.1638224692.git.me@ttaylorr.com>
	User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
	In-reply-to: <deece9eb70e9750bb8350946679b521e59139fe2.1638224692.git.me@ttaylorr.com>
	Message-ID: <220519.86ilq14u1a.gmgdl@evledraar.gmail.com>
	MIME-Version: 1.0
	Content-Type: text/plain
	X-TUID: ta0yc5HgmrrD
	
	
	On Mon, Nov 29 2021, Taylor Blau wrote:
	
	> +static void write_mtimes_header(struct hashfile *f)
	> +{
	> +	hashwrite_be32(f, MTIMES_SIGNATURE);
	> +	hashwrite_be32(f, MTIMES_VERSION);
	> +	hashwrite_be32(f, oid_version(the_hash_algo));
	> +}
	
	Given the history noted in
	https://lore.kernel.org/git/RFC-patch-2.2-051f0612ab9-20220519T113538Z-avarab@gmail.com/
	maybe we can say this ship has just sailed at this point.
	
	But since this is a new format I think it's worth considering not using
	the 1 or 2 you get from oid_version(), but the "format_id",
	i.e. GIT_SHA1_FORMAT_ID or GIT_SHA256_FORMAT_ID.
	
	You'll use the same space in the format for it, but we'll end up with
	something more obvious (as the integer encodes the sha1 or sha256 name).
	
	AFAICT this code is just copied from your earlier work on *.rev, which
	in turn seems copied from earlier work on midx & commit-graph, which
	seems to have used this way of referring to the hash version more as an
	accident than anything explicitly indended...
	
	Then again we could just say that both are equally valid at this point,
	especially given the use in adjacent formats.

I.e. do we think continuing to use 1 v.s. 2 in new formats over instead
of 0x73686131 and 0x73323536 is the right choice?

Other than that the only question I have (I think) on this series is if
Jonathan Nieder is happy with it. I looked back in my logs and there was
an extensive on-IRC discussion about it at the end of March, which ended
in you sending: https://lore.kernel.org/git/YkICkpttOujOKeT3@nand.local/

But it seems Jonathan didn't chime in since then, and he had some major
issues with the approach here. I think those should have been addressed
by that discussion, but it would be nice to get a confirmation.
	
> Taylor Blau (17):
>   Documentation/technical: add cruft-packs.txt
>   pack-mtimes: support reading .mtimes files
>   pack-write: pass 'struct packing_data' to 'stage_tmp_packfiles'
>   chunk-format.h: extract oid_version()
>   pack-mtimes: support writing pack .mtimes files
>   t/helper: add 'pack-mtimes' test-tool
>   builtin/pack-objects.c: return from create_object_entry()
>   builtin/pack-objects.c: --cruft without expiration
>   reachable: add options to add_unseen_recent_objects_to_traversal
>   reachable: report precise timestamps from objects in cruft packs
>   builtin/pack-objects.c: --cruft with expiration
>   builtin/repack.c: support generating a cruft pack
>   builtin/repack.c: allow configuring cruft pack generation
>   builtin/repack.c: use named flags for existing_packs
>   builtin/repack.c: add cruft packs to MIDX during geometric repack
>   builtin/gc.c: conditionally avoid pruning objects via loose
>   sha1-file.c: don't freshen cruft packs
>
>  Documentation/Makefile                  |   1 +
>  Documentation/config/gc.txt             |  21 +-
>  Documentation/config/repack.txt         |   9 +
>  Documentation/git-gc.txt                |   5 +
>  Documentation/git-pack-objects.txt      |  30 +
>  Documentation/git-repack.txt            |  11 +
>  Documentation/technical/cruft-packs.txt | 123 ++++
>  Documentation/technical/pack-format.txt |  19 +
>  Makefile                                |   2 +
>  builtin/gc.c                            |  10 +-
>  builtin/pack-objects.c                  | 304 +++++++++-
>  builtin/repack.c                        | 185 +++++-
>  bulk-checkin.c                          |   2 +-
>  chunk-format.c                          |  12 +
>  chunk-format.h                          |   3 +
>  commit-graph.c                          |  18 +-
>  midx.c                                  |  18 +-
>  object-file.c                           |   4 +-
>  object-store.h                          |   7 +-
>  pack-mtimes.c                           | 126 ++++
>  pack-mtimes.h                           |  15 +
>  pack-objects.c                          |   6 +
>  pack-objects.h                          |  25 +
>  pack-write.c                            |  93 ++-
>  pack.h                                  |   4 +
>  packfile.c                              |  19 +-
>  reachable.c                             |  58 +-
>  reachable.h                             |   9 +-
>  t/helper/test-pack-mtimes.c             |  56 ++
>  t/helper/test-tool.c                    |   1 +
>  t/helper/test-tool.h                    |   1 +
>  t/t5329-pack-objects-cruft.sh           | 739 ++++++++++++++++++++++++
>  32 files changed, 1834 insertions(+), 102 deletions(-)
>  create mode 100644 Documentation/technical/cruft-packs.txt
>  create mode 100644 pack-mtimes.c
>  create mode 100644 pack-mtimes.h
>  create mode 100644 t/helper/test-pack-mtimes.c
>  create mode 100755 t/t5329-pack-objects-cruft.sh
>
> Range-diff against v4:
>  -:  ---------- >  1:  f494ef7377 Documentation/technical: add cruft-packs.txt
>  1:  8f9fd21be9 !  2:  91a9d21b0b pack-mtimes: support reading .mtimes files
>     @@ Documentation/technical/pack-format.txt: Pack file entry: <+
>       
>      +== pack-*.mtimes files have the format:
>      +
>     ++All 4-byte numbers are in network byte order.
>     ++
>      +  - A 4-byte magic number '0x4d544d45' ('MTME').
>      +
>      +  - A 4-byte version identifier (= 1).
>      +
>      +  - A 4-byte hash function identifier (= 1 for SHA-1, 2 for SHA-256).
>      +
>     -+  - A table of 4-byte unsigned integers in network order. The ith
>     -+    value is the modification time (mtime) of the ith object in the
>     -+    corresponding pack by lexicographic (index) order. The mtimes
>     -+    count standard epoch seconds.
>     ++  - A table of 4-byte unsigned integers. The ith value is the
>     ++    modification time (mtime) of the ith object in the corresponding
>     ++    pack by lexicographic (index) order. The mtimes count standard
>     ++    epoch seconds.
>      +
>      +  - A trailer, containing a checksum of the corresponding packfile,
>      +    and a checksum of all of the above (each having length according
>      +    to the specified hash function).
>     -+
>     -+All 4-byte numbers are in network order.
>      +
>       == multi-pack-index (MIDX) files have the following format:
>       
>  2:  cdb21236e1 =  3:  67c4e7209d pack-write: pass 'struct packing_data' to 'stage_tmp_packfiles'
>  3:  1d775f9850 =  4:  fc86506881 chunk-format.h: extract oid_version()
>  4:  6172861bd9 =  5:  788d1f96f2 pack-mtimes: support writing pack .mtimes files
>  5:  5f9a9a5b7b =  6:  2a6cfb00bf t/helper: add 'pack-mtimes' test-tool
>  6:  b8a38fe2e4 =  7:  edb6fcd5ec builtin/pack-objects.c: return from create_object_entry()
>  7:  94fe03cc65 =  8:  e3185741f2 builtin/pack-objects.c: --cruft without expiration
>  8:  da7273f41f =  9:  1cf00d462c reachable: add options to add_unseen_recent_objects_to_traversal
>  9:  58fecd1747 = 10:  d66be44d9a reachable: report precise timestamps from objects in cruft packs
> 10:  1740b8ef01 = 11:  1434e37623 builtin/pack-objects.c: --cruft with expiration
> 11:  5992a72cbf ! 12:  0d3555d595 builtin/repack.c: support generating a cruft pack
>     @@ t/t5329-pack-objects-cruft.sh: test_expect_success 'expired objects are pruned'
>      +		git repack &&
>      +
>      +		tip="$(git rev-parse cruft)" &&
>     -+		path="$objdir/$(test_oid_to_path "$(git rev-parse cruft)")" &&
>     ++		path="$objdir/$(test_oid_to_path "$tip")" &&
>      +		test-tool chmtime --get +1000 "$path" >expect &&
>      +
>      +		git checkout main &&
> 12:  1b241f8f91 = 13:  4b721d3ee9 builtin/repack.c: allow configuring cruft pack generation
> 13:  ffae78852c = 14:  f9e3ab56b1 builtin/repack.c: use named flags for existing_packs
> 14:  0743e373ba ! 15:  e9f46e7b5e builtin/repack.c: add cruft packs to MIDX during geometric repack
>     @@ builtin/repack.c
>       static int pack_everything;
>       static int delta_base_offset = 1;
>      @@ builtin/repack.c: static void collect_pack_filenames(struct string_list *fname_nonkept_list,
>     + 		fname = xmemdupz(e->d_name, len);
>     + 
>       		if ((extra_keep->nr > 0 && i < extra_keep->nr) ||
>     - 		    (file_exists(mkpath("%s/%s.keep", packdir, fname))))
>     +-		    (file_exists(mkpath("%s/%s.keep", packdir, fname))))
>     ++		    (file_exists(mkpath("%s/%s.keep", packdir, fname)))) {
>       			string_list_append_nodup(fname_kept_list, fname);
>      -		else
>      -			string_list_append_nodup(fname_nonkept_list, fname);
>     -+		else {
>     -+			struct string_list_item *item = string_list_append_nodup(fname_nonkept_list, fname);
>     ++		} else {
>     ++			struct string_list_item *item;
>     ++			item = string_list_append_nodup(fname_nonkept_list,
>     ++							fname);
>      +			if (file_exists(mkpath("%s/%s.mtimes", packdir, fname)))
>      +				item->util = (void*)(uintptr_t)CRUFT_PACK;
>      +		}
> 15:  9f7e0acac6 = 16:  43c14eec07 builtin/gc.c: conditionally avoid pruning objects via loose
> 16:  07fa9d4b47 = 17:  1e313b89e8 sha1-file.c: don't freshen cruft packs

