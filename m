Return-Path: <SRS0=p0jH=64=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8052C433DF
	for <git@archiver.kernel.org>; Thu, 14 May 2020 18:04:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B3F5320657
	for <git@archiver.kernel.org>; Thu, 14 May 2020 18:04:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="CCBufQdL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726139AbgENSE0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 May 2020 14:04:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726075AbgENSE0 (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 14 May 2020 14:04:26 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7437CC061A0C
        for <git@vger.kernel.org>; Thu, 14 May 2020 11:04:26 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id b8so1554896pgi.11
        for <git@vger.kernel.org>; Thu, 14 May 2020 11:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=OH7LBF9pfmrcYmPPjUZLj/i58JVbSahWB8TKEUArTfc=;
        b=CCBufQdLhMN96vpPDa/Q0RvPt3VMV0jDtblgUGcIKplrnDSQvucMQdvdIfKjXX02PE
         vftLVugj4uDFYdH4+mNzxfm35tKgAfBYCNSWR7vuxgTOnmB5k1IAWA+0xUXuv2kN4Fj/
         0OfnC0L7oEcqAT1dYUUgZbVu9NiCwmEntamcl2fJzoaYEKL99jDyNI0M2zjiK/YRs2cs
         EbrolEb94pQFyS6HT47qAV0M3xPn2gjW55Co9MZHPVwoFbE6RDuQ9BOwnPqagHkqGyRT
         RuGk+dzCejV7KdoIoBogJJDqnv9tHS2RQbd7kl5yQ0/HeTC3D6K7RFN/mSswNYNz8ZNO
         7fgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OH7LBF9pfmrcYmPPjUZLj/i58JVbSahWB8TKEUArTfc=;
        b=fK7d0wVu8bGU/KYZJNZdw5WLzGkmyppW+Y97n0ec3a07CZCeTrQEFFskZ+jCByzYHp
         8O/UdDyBAny2/aDPxLcUFHI3HQBDJw06JlzKZXp0j2zuqnZLjdm3DadbWpC84MJZvaf1
         T7PA7Qrp94/CkTbUpNvQnnHoxu8WtDcaAcSck5ARwu8xF+yn8ysNZzO1tvCXUsFR+Rto
         Hiay1TCja/bsOHFy4bCrFAYIhW16Ogqe+fSHUTJj9LSC41FjmOnTvuKA9guht7Do+Bii
         SBWu5tkUTzc2j6si43vRIG2dPrPHKfUXFQtwiQ4cDTHkgZlS1KMkTgCqf2jNbEp/rU+7
         NfJQ==
X-Gm-Message-State: AOAM530y4Kz711PtlOsmYv7VavhiVPcmcfY0k9UXp8ZGOGLZE8N4itFx
        2Rh3++cWTztYeMmBiXxhiGfP5w==
X-Google-Smtp-Source: ABdhPJxXaNj62UsqSPNg9ucvrzZarmHbbUhgKVrwcFY/cHhs45l5VJC3k6OZRXzIFGMskbjNQbxOUQ==
X-Received: by 2002:a63:2a93:: with SMTP id q141mr4945695pgq.129.1589479465907;
        Thu, 14 May 2020 11:04:25 -0700 (PDT)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id e12sm2817346pfm.10.2020.05.14.11.04.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2020 11:04:25 -0700 (PDT)
Date:   Thu, 14 May 2020 12:04:24 -0600
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        dstolee@microsoft.com, gitster@pobox.com, szeder.dev@gmail.com
Subject: Re: [PATCH v3 5/8] builtin/commit-graph.c: dereference tags in
 builtin
Message-ID: <20200514180424.GB86181@syl.local>
References: <cover.1588641176.git.me@ttaylorr.com>
 <cover.1589407014.git.me@ttaylorr.com>
 <56403dd377b996d21a4da1e01ffd6e691ac120bd.1589407014.git.me@ttaylorr.com>
 <20200514180150.GB2430834@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200514180150.GB2430834@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 14, 2020 at 02:01:50PM -0400, Jeff King wrote:
> On Wed, May 13, 2020 at 03:59:44PM -0600, Taylor Blau wrote:
>
> > -static int read_one_commit(struct oidset *commits, const char *hash)
> > +static int read_one_commit(struct oidset *commits, struct progress *progress,
> > +			   const char *hash)
> >  {
> > +	struct commit *result;
> >  	struct object_id oid;
> >  	const char *end;
> >
> >  	if (parse_oid_hex(hash, &oid, &end))
> >  		return error(_("unexpected non-hex object ID: %s"), hash);
> >
> > -	oidset_insert(commits, &oid);
> > +	result = lookup_commit_reference_gently(the_repository, &oid, 1);
> > +	if (result)
> > +		oidset_insert(commits, &result->object.oid);
> > +	else
> > +		return error(_("invalid commit object id: %s"), hash);
> > +
> > +	display_progress(progress, oidset_size(commits));
> > +
>
> I expected this to switch to deref_tag() here, but it looks like you do
> it in the final commit. That makes sense, since this step is really just
> copying the existing logic.

I went back and forth on this. I figure that the behavior change should
come in the final commit, so this is keeping things consistent at this
point in the series.

> > @@ -249,6 +265,8 @@ static int graph_write(int argc, const char **argv)
> >  cleanup:
> >  	UNLEAK(pack_indexes);
> >  	strbuf_release(&buf);
> > +	if (progress)
> > +		stop_progress(&progress);
> >  	return result;
>
> Really minor nit, but stop_progress(), like display_progress(), handles
> NULL already. So you can lose the "if" here.

Mm. If there's nothing else (besides the review of 4/8 which I already
sent a replacement patch for), I'd prefer to leave this as-is to avoid
another reroll. Hopefully since this isn't hurting anything with the
extra if statement, it shouldn't matter too much.

If you feel strongly, I'm happy to re-send this series, or this patch.

> -Peff

Thanks,
Taylor
