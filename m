Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D9FE3588B
	for <git@vger.kernel.org>; Tue,  7 Nov 2023 18:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="m9k5AdEa"
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD3CBB0
	for <git@vger.kernel.org>; Tue,  7 Nov 2023 10:22:54 -0800 (PST)
Received: by mail-qk1-x733.google.com with SMTP id af79cd13be357-7789aed0e46so396708485a.0
        for <git@vger.kernel.org>; Tue, 07 Nov 2023 10:22:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1699381373; x=1699986173; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=O1dkNQi63QEI7xMy2Y32BSrfoLvA9fy6BVdSUTkOAqk=;
        b=m9k5AdEa8uQM9sr92TPAaHDm47I3ZQzI67atFm7VzmcXZHGMQu6AE+ZOLdfK4zWUJ9
         C32LpVxeQ02jnrsVR72BnFJpPRkZlYAD5waCANLY23h5L2rEX8JZPA7lq2km152x7J+s
         n1oCFJIRjG9qLCXiHcU27m4QPf4/Toyjab90U/pBSr3IMoP+v/dRgsR538o5vTLs2r7K
         b4AsCWVpxWokboOG7izc7NXwHFJAEP8GcaaIcgyXg9SuutwODpac/q/+uNk2b5J+uvp7
         xmTFYzM12CGNe4p/xzLNnIfg+LS7lK6nCoer4rULaHk9OFZ2ozWteSRyIbsCgHJuwc6N
         fvYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699381373; x=1699986173;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O1dkNQi63QEI7xMy2Y32BSrfoLvA9fy6BVdSUTkOAqk=;
        b=FaAejSi7NKfngxVhrzXOur7Lv99MK1XzCKRlasOiUzShk13FP7xf8IZarF4KMMVT6m
         PtTPZ0pBK6mD2u1AxF7MWcRg+sHdRa5+8wmEG1QFd7y+UDA43TIA5ZARNvfjAJP/xc4b
         WoP467CyX88xNc20XX+1JhvF6AnjkHA8vstOu5gt+DuBOem07nstEvXP8ID8TLpkM4kT
         5uWxnOPUHoXHVhFUZnOvmz8WeeltLfjrEHQRk6lPEsLoxzCtzBBgZgV4F2GNc96neVJ0
         tzOC3yt7COsjlU2FuNp1TtgaFM4Y4jQWWACp7XMZvR9od9ERJGuFLzo2s94AWORN/pd4
         y6pA==
X-Gm-Message-State: AOJu0YyFNOcVkuSKNmA+faxx/mMezyRPhK5YTMXqhLO5k15rtwxv4JRb
	Fx1AlnhUCW6UQTzklt2ShiT6pryRAi9vXfnMizSRHw==
X-Google-Smtp-Source: AGHT+IH1ijBPnFjoEYtaiyzY6An04/P2irlO973tBk9PRv0zzXKSH/CZ0kKiE00LezcNDhgKjPbU4g==
X-Received: by 2002:a05:620a:40c7:b0:774:3147:4274 with SMTP id g7-20020a05620a40c700b0077431474274mr39049433qko.14.1699381373541;
        Tue, 07 Nov 2023 10:22:53 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id d24-20020a05620a167800b0076cbcf8ad3bsm144394qko.55.2023.11.07.10.22.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Nov 2023 10:22:53 -0800 (PST)
Date: Tue, 7 Nov 2023 13:22:52 -0500
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Patrick Steinhardt <ps@pks.im>,
	Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [RFC PATCH 0/3] replay: implement support for writing new objects to
 a pack
Message-ID: <cover.1699381371.git.me@ttaylorr.com>
References: <ZUpepnSCSxL8i96b@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZUpepnSCSxL8i96b@nand.local>

(Based on a combination of Christian's cc/git-replay and my
tb/merge-tree-write-pack branches).

This RFC demonstrates extending the new `--write-pack` option that
`merge-tree` recently learned to the `replay` builtin as well.

The approach is as follows:

  - write a pack out after each step in the replay operation, so that
    subsequent steps may see any new object(s) created during previous
    steps

  - combine those packs into one before migrating them back into the
    main object store

This is accomplished with a combination of the bulk-checkin and
tmp-objdir APIs, with some minor modifications made to when we flush out
and finalize bulk-checkin transactions.

The benefit to this approach is that we bound the number of inodes
required per replayed commit to a constant (by default, 3: one for the
.pack, one for the .idx, and another for the .rev file), instead of
having each operation take an unbounded number of inodes proportional to
the number of new objects created during that step. We also only migrate
a single pack back to the main object store.

In other words, this makes the maximum number of inodes required by
'replay' grow proportional to the number of commits being replayed,
instead of the number of new *objects* created as a result of the replay
operation.

Taylor Blau (3):
  merge-ort.c: finalize ODB transactions after each step
  tmp-objdir: introduce `tmp_objdir_repack()`
  builtin/replay.c: introduce `--write-pack`

 Documentation/git-replay.txt |  4 ++++
 builtin/replay.c             | 18 ++++++++++++++++++
 merge-ort.c                  |  5 ++++-
 t/t3650-replay-basics.sh     | 37 ++++++++++++++++++++++++++++++++++++
 tmp-objdir.c                 | 13 +++++++++++++
 tmp-objdir.h                 |  6 ++++++
 6 files changed, 82 insertions(+), 1 deletion(-)

-- 
2.42.0.446.g0b9ef90488
