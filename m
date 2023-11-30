Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="kIBkGh6O"
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E10010DF
	for <git@vger.kernel.org>; Thu, 30 Nov 2023 11:19:55 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-6cdfb721824so115462b3a.3
        for <git@vger.kernel.org>; Thu, 30 Nov 2023 11:19:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1701371994; x=1701976794; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=99joWaELC5DmRxFYPujP5VRS322P28XaQznt2EJYB18=;
        b=kIBkGh6OMF6U+eztlNCIrRFfn/2A+aR1csVCeBrJRN+6lSvj1/iKttG+P1ryIgeLqJ
         qxfnlYei+DMD9lhoJvezuwsjHe/O0juU08N7DsxYn1QSEQUtAM5O5hQmqgkDzxvmnlbA
         hZCfbKIHVeNcgxV8f9OaLwW9I/z17HQdA1fHwfdMAvCd1QcgQPAeMslwrwe757RkDVeO
         oHP86rZgSMxqFILrFbiH8eZ4xHgtfGR7PCrC3EjK7JAry7raL+ts0IycDJTd7sGzeohC
         /EVNNvBBsjFEYlSJEbdYVdELpk9oo3pSyAzBNeAvKOEBA9Sby1xp2ybk/octrZrprSaK
         xOQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701371994; x=1701976794;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=99joWaELC5DmRxFYPujP5VRS322P28XaQznt2EJYB18=;
        b=VSqUsY2P3ANzknjwAECMnujKMe+V+xbJ7jsaJQCY+IP2DI3IepR1Xq3Bj5HcsNe3S2
         iWGWucTCwPWuBoYC601huFtuNTf24T8EdUf0wv9Ktf/5oaTJGPV8Num82a+uF7FvIYs+
         tx4+kjKsmLDw1+Dq1bzFCNgfn72EjviTQzYwSwKQs/ThjklFW1klAJTLbrpS+qrKzc0m
         z5aAN58A4XGlaNcCcyZuAYAGPrCysZ4XyhNCGs8MTavHoUNzhTamx0n8jT4fOe4eVj5g
         MQ5APcpNLPv7r+qE+Na0/75tLLTs8CHl9a0299YHUG0cnBiehlY181Wu9qvjwqSMvMS7
         cvJA==
X-Gm-Message-State: AOJu0Yy1kBTrtzi0Z508vp7EctHgVKgz8Z3yC0FN0VttxDSAq1M46h62
	Be2E4+DqdseOHGdcDrs7jWJ/qNAvO2ErEABo31s=
X-Google-Smtp-Source: AGHT+IFVd/iuV8xTUuWqgTRDAOjEy1eQKvLaVpJFKnCi2qdZedzkNIk0Rx0x07xiMYvOBPNNAA9c+Q==
X-Received: by 2002:a05:6870:5ba3:b0:1fa:3be6:3b2a with SMTP id em35-20020a0568705ba300b001fa3be63b2amr18880691oab.30.1701371982790;
        Thu, 30 Nov 2023 11:19:42 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id v15-20020a05620a122f00b0077d606bec92sm749529qkj.108.2023.11.30.11.19.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 11:19:42 -0800 (PST)
Date: Thu, 30 Nov 2023 14:19:41 -0500
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 04/24] midx: factor out `fill_pack_info()`
Message-ID: <ZWjgTfz0ufVoPgbw@nand.local>
References: <cover.1701198172.git.me@ttaylorr.com>
 <ccf1337305db60f1c8174e9b309e2a9e04ce1487.1701198172.git.me@ttaylorr.com>
 <ZWhhfXoovgYzIYE0@tanuki>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZWhhfXoovgYzIYE0@tanuki>

On Thu, Nov 30, 2023 at 11:18:37AM +0100, Patrick Steinhardt wrote:
> On Tue, Nov 28, 2023 at 02:08:05PM -0500, Taylor Blau wrote:
> > When selecting which packfiles will be written while generating a MIDX,
> > the MIDX internals fill out a 'struct pack_info' with various pieces of
> > book-keeping.
> >
> > Instead of filling out each field of the `pack_info` structure
> > individually in each of the two spots that modify the array of such
> > structures (`ctx->info`), extract a common routine that does this for
> > us.
> >
> > This reduces the code duplication by a modest amount. But more
> > importantly, it zero-initializes the structure before assigning values
> > into it. This hardens us for a future change which will add additional
> > fields to this structure which (until this patch) was not
> > zero-initialized.
> >
> > As a result, any new fields added to the `pack_info` structure need only
> > be updated in a single location, instead of at each spot within midx.c.
> >
> > There are no functional changes in this patch.
> >
> > Signed-off-by: Taylor Blau <me@ttaylorr.com>
> > ---
> >  midx.c | 35 +++++++++++++++++++----------------
> >  1 file changed, 19 insertions(+), 16 deletions(-)
> >
> > diff --git a/midx.c b/midx.c
> > index 3b727dc633..591b3c636e 100644
> > --- a/midx.c
> > +++ b/midx.c
> > @@ -464,6 +464,17 @@ struct pack_info {
> >  	unsigned expired : 1;
> >  };
> >
> > +static void fill_pack_info(struct pack_info *info,
> > +			   struct packed_git *p, char *pack_name,
> > +			   uint32_t orig_pack_int_id)
> > +{
> > +	memset(info, 0, sizeof(struct pack_info));
> > +
> > +	info->orig_pack_int_id = orig_pack_int_id;
> > +	info->pack_name = pack_name;
> > +	info->p = p;
> > +}
>
> Nit: all callers manually call `xstrdup(pack_name)` and pass that to
> `fill_pack_info()`. We could consider doing this in here instead so that
> ownership of the string becomes a tad clearer.

That's a great idea. I think we'd also want to mark the pack_name
argument as const, not just because xstrdup() requires it, but also
because it communicates the ownership more clearly.

I'll squash something like this in:

--- >8 ---
diff --git a/midx.c b/midx.c
index b8b3f41024..6fb5e237b7 100644
--- a/midx.c
+++ b/midx.c
@@ -465,13 +465,13 @@ struct pack_info {
 };

 static void fill_pack_info(struct pack_info *info,
-			   struct packed_git *p, char *pack_name,
+			   struct packed_git *p, const char *pack_name,
 			   uint32_t orig_pack_int_id)
 {
 	memset(info, 0, sizeof(struct pack_info));

 	info->orig_pack_int_id = orig_pack_int_id;
-	info->pack_name = pack_name;
+	info->pack_name = xstrdup(pack_name);
 	info->p = p;
 }

@@ -557,8 +557,7 @@ static void add_pack_to_midx(const char *full_path, size_t full_path_len,
 			return;
 		}

-		fill_pack_info(&ctx->info[ctx->nr], p, xstrdup(file_name),
-			       ctx->nr);
+		fill_pack_info(&ctx->info[ctx->nr], p, file_name, ctx->nr);
 		ctx->nr++;
 	}
 }
@@ -1336,7 +1335,7 @@ static int write_midx_internal(const char *object_dir,
 			}

 			fill_pack_info(&ctx.info[ctx.nr++], ctx.m->packs[i],
-				       xstrdup(ctx.m->pack_names[i]), i);
+				       ctx.m->pack_names[i], i);
 		}
 	}
--- 8< ---

> > -		if (open_pack_index(ctx->info[ctx->nr].p)) {
> > +		if (open_pack_index(p)) {
> >  			warning(_("failed to open pack-index '%s'"),
> >  				full_path);
> >  			close_pack(ctx->info[ctx->nr].p);
>
> Isn't `ctx->info[ctx->nr].p` still uninitialized at this point?

Great catch, thank you!

> > @@ -1330,10 +1333,10 @@ static int write_midx_internal(const char *object_dir,
> >  				if (open_pack_index(ctx.m->packs[i]))
> >  					die(_("could not open index for %s"),
> >  					    ctx.m->packs[i]->pack_name);
> > -				ctx.info[ctx.nr].p = ctx.m->packs[i];
>
> Just to make sure I'm not missing anything, but this assignment here was
> basically redundant before this patch already, right?

I think that's right, but in either case we're assigning the pack once
at the end of each loop iteration via a single call to fill_pack_info().
Since we're using ctx.m->packs[i] in both places (after a call to
prepare_midx_pack()), we should be OK here.

Thanks,
Taylor
