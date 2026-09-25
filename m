Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B699D64A8D
	for <git@vger.kernel.org>; Fri, 25 Sep 2026 08:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790324800; cv=none; b=NvEuoSMZGubAZqQGH2SvhjF2WTKLxdr0TS6urTbKc6PHjEXjW0Vl+vxMDtVzofFtTx0BVkV4GqWf/IXuh8zWO1+HwsP+ykjgb2igrLG3rnig/w69QrJixhXK6xFOSgaUf30bz3Ajmq4/ngLG1DDVeRAkV3bcE5xPxQ6G2p0399U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790324800; c=relaxed/simple;
	bh=vUCQvjDGieVpedK79OzIMIjVxYCoLmNvoVg2o1aBvBs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HpLgRyFp8QqnpUO0q/Iw5JHrrbH1Hw16ZS1+fX8USQx3VT4NyQ57DNDRw79JSQIWsNAoKo4arlVtzWb5c0ko53/6rZItlb4FV1QolZtJsFfhxTwHdYCHGrlGdOJD/2noDFe7O2DzyBOMNoC9J0M2bXl8A6CkULCn0wufykb6e1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=Su3V9Syz; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="Su3V9Syz"
Received: (qmail 50789 invoked by uid 106); 25 Sep 2026 08:26:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=vUCQvjDGieVpedK79OzIMIjVxYCoLmNvoVg2o1aBvBs=; b=Su3V9SyzugmWClb+z+YA524jSaavh45sYlPA6ecP9O6Oexgk3ucM9GvHblbbb2P+PfuOdtGmKP+XZPsnwHa30YKKiJzxxT9n9arGLvSuMysaMFminI8DujCBrfbWJQqk4ma0eYu4jRq8w8tt4djIKxYgmO1mQRRz0HdRAd4hF8RjH2O5Cl7xVa+bHMRHpPBzPEJee0zrNiOZlcDbuJUsyUhtl0dqpFVv3bCpGfW4jsrWXc521+CprZviKgqaocT2nkaI7z3Zc0k9Peg1FKwJ7xoM5ccPje7984O3lys6iM9V0Hid+vzS5CuwLReBVYqli574SRQ16ZlFPxi8LIXlDw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 25 Sep 2026 08:26:37 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 202798 invoked by uid 111); 25 Sep 2026 08:26:36 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 25 Sep 2026 04:26:36 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 25 Sep 2026 04:26:36 -0400
From: Jeff King <peff@peff.net>
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Cc: git@vger.kernel.org
Subject: Re: [BUG] revision: premature =?utf-8?Q?fr?=
 =?utf-8?Q?ee-and-null_causes_=E2=80=9Cunknown_option_`=28null=29`?=
 =?utf-8?B?4oCd?=
Message-ID: <20260925082636.GA1493716@coredump.intra.peff.net>
References: <74796901-ffb1-4cf3-bd63-7294328f70bc@app.fastmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <74796901-ffb1-4cf3-bd63-7294328f70bc@app.fastmail.com>

On Fri, Sep 25, 2026 at 02:28:57AM +0200, Kristoffer Haugsbakk wrote:

> git shortlog -n --not-an-option master
> [...]
>
> I expected it to print the option in quotes. Instead it printed `(null)`
> which I think is the placeholder for when the `%s` arg is `NULL`.
> [...]
> 
> I have bisected this to cd439487 (revision: manage memory ownership of
> argv in setup_revisions(), 2025-09-19).

Yep, definitely my fault. I don't have time to do a full write-up now,
but the most direct solution is:

diff --git a/revision.c b/revision.c
index ee1df92d1d..501a4ba36e 100644
--- a/revision.c
+++ b/revision.c
@@ -2768,13 +2768,13 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 void parse_revision_opt(struct rev_info *revs, struct parse_opt_ctx_t *ctx,
 			const struct option *options,
 			const char * const usagestr[])
 {
 	int n = handle_revision_opt(revs, ctx->argc, ctx->argv,
 				    &ctx->cpidx, ctx->out, NULL);
 	if (n <= 0) {
-		error("unknown option `%s'", ctx->argv[0]);
+		error("unknown option `%s'", ctx->out[ctx->cpidx - 1]);
 		usage_with_options(usagestr, options);
 	}
 	ctx->argv += n;
 	ctx->argc -= n;
 }

But I think instead doing this:

diff --git a/revision.c b/revision.c
index ee1df92d1d..7b858d54c1 100644
--- a/revision.c
+++ b/revision.c
@@ -2340,7 +2340,8 @@ static void overwrite_argv(int *argc, const char **argv,
 	if (*value != argv[*argc]) {
 		mark_argv_for_free(opt, revs, argv[*argc]);
 		argv[*argc] = *value;
-		*value = NULL;
+		if (opt && opt->free_removed_argv_elements)
+			*value = NULL;
 	}
 	(*argc)++;
 }

will restore some of the hidden assumptions made by pre-cd439487 code.
So it would fix this case, along with any other lurkers.

I know that's probably quite opaque. ;) I'll fully explain what's going
on in a follow-up tomorrow, but I wanted to post the solution quickly so
nobody else wasted time digging.

Thanks for a clear report.

-Peff
