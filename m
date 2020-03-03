Return-Path: <SRS0=wY2r=4U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99BE1C3F2C6
	for <git@archiver.kernel.org>; Tue,  3 Mar 2020 22:24:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6922220870
	for <git@archiver.kernel.org>; Tue,  3 Mar 2020 22:24:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PdK4PKJG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727870AbgCCWY2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Mar 2020 17:24:28 -0500
Received: from mail-wr1-f50.google.com ([209.85.221.50]:43906 "EHLO
        mail-wr1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727322AbgCCWY2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Mar 2020 17:24:28 -0500
Received: by mail-wr1-f50.google.com with SMTP id h9so5518026wrr.10
        for <git@vger.kernel.org>; Tue, 03 Mar 2020 14:24:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=GrhrvVYnoDREiPieTwDCjth2ZhrdYwe2y8iZd2bOSP4=;
        b=PdK4PKJGV+sKTuj5ui8pooy+8eA3vTouUFHvTxLYPtU1vAeJp4JvL+8raEUnHjnH32
         DfMANF8Vn9bVOYIqwp1NvQyAKHDNZafD9qbo9NLm2dTW95B7WZPzmD7+EPqUYWPKFm6a
         Tjvz9YetuxHbT8GAKo9xdvn5wCuFIoyox9NeZ8f6vzmmZu/YfIAfLM5o9ZlkZ7VdILaD
         pA1a6gAUyoIqX9g0p6Gndwc/nraAK+MGpQI4lbyloR1ERLjvZ2ABXtGjhMileAFSSLyl
         LmUN6Qt+Xw0B9H3L4VIqabTXRYGqYrw3YvLHefTvC4dlcCFfR9j9J6w8XmuZdigSnEOt
         f3Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=GrhrvVYnoDREiPieTwDCjth2ZhrdYwe2y8iZd2bOSP4=;
        b=ol622GDt41zDdUtzHkkKNO+1a1QFpMNm/B8zvScXf2pLR66nzSOgnY1HFLOtAHbxav
         8luBQJ+dcFacuAXr8WpKi6kzLOPQkgjBGRGH717LKbTsHyR8msi7w5Cxpat6x8EXnylm
         dqyaUjw6rCCLkY/MCuMeq9o7fAkPt5odnfZ07PDV1EhE92jE4oDXrkYnZY9aOleUlfY+
         Dp1Pdf3oJf8ChcWEdNx+CQ0UAJOCqa+RRIF8HYOQHmggeaXNdYQfd+icSbKFqrmgcbz+
         4OhdCpjlRWPrOiqXdATDVo6Co2fH/xY3xgT971JYNWjvMmNldUuZiQQgk4hY9Ri+E4sw
         is8w==
X-Gm-Message-State: ANhLgQ2Yzu8k4fn5tqiQb+rjcJv2KspMJNd0T3BT1Hq4xVX5K1wvJNyw
        CIF2duRAmddXI2GRJCu1HX6G6jMfOJg=
X-Google-Smtp-Source: ADFU+vsioGiTIhZ4BqMFglaNs2rWakK2wjFiHo77AEEA4hExH/podApRjRySFhkDwAl0rS4UKEUSIQ==
X-Received: by 2002:adf:de12:: with SMTP id b18mr186606wrm.268.1583274266021;
        Tue, 03 Mar 2020 14:24:26 -0800 (PST)
Received: from doriath (87-231-246-247.rev.numericable.fr. [87.231.246.247])
        by smtp.gmail.com with ESMTPSA id c8sm9421908wrt.19.2020.03.03.14.24.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2020 14:24:25 -0800 (PST)
Date:   Tue, 3 Mar 2020 23:24:23 +0100
From:   Damien Robert <damien.olivier.robert@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 2/2] remote.c: fix handling of %(push:remoteref)
Message-ID: <20200303222423.wfbjuuwp3263qesv@doriath>
X-PGP-Key: http://www.normalesup.org/~robert/pro/files/Damien_Olivier_Robert.asc
X-Start-Date: Tue, 03 Mar 2020 23:10:07 +0100
References: <20200302133217.GA1176622@coredump.intra.peff.net>
 <20200303161223.1870298-1-damien.olivier.robert+git@gmail.com>
 <20200303161223.1870298-3-damien.olivier.robert+git@gmail.com>
 <xmqqtv358fkk.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqtv358fkk.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From Junio C Hamano, Tue 03 Mar 2020 at 10:21:31 (-0800) :
> Mental note: this function was moved down, the main part of the
> logic extracted to a new branch_get_push_remoteref() helper, which
> in addition got extended.

Exactly.

> That's a fairly expensive way to write
> 	if (remote->push.nr)
> 		return apply_refspecs(&remote->push, branch->refname);
> one-liner.

You anticipated the question I asked afterwards :)

> > +	case PUSH_DEFAULT_UPSTREAM:
> > +		{
> > +			if (!branch || !branch->merge ||
> > +			    !branch->merge[0] || !branch->merge[0]->dst)
> > +			return NULL;
> > +
> > +			return branch->merge[0]->src;
> > +		}
> 
> This is strangely indented and somewhat unreadable.  Why isn't this
> more like:

Sorry I missed the indentation for the return NULL.
 
> 	case PUSH_DEFAULT_UPSTREAM:
> 		if (branch && branch->merge && branch->merge[0] &&
> 		    branch->merge[0]->dst)
> 			return branch->merge[0]->src;
> 		break;
> 
> and have "return NULL" after the switch() statement before we leave
> the function?

We could, I agree this is more readable. If we return NULL after the
switch, we need to put the
> > +	BUG("unhandled push situation")
in a default clause a you say.

The reason I wrote the code as above is to be as close as possible to
`branch_get_push_1`. If we make the changes you suggest, I'll probably need
a preliminary patch to change `branch_get_push_1` accordingly.

> > +	case PUSH_DEFAULT_UNSPECIFIED:
> > +	case PUSH_DEFAULT_SIMPLE:
> > +		{
> > +			const char *up, *cur;
> > +
> > +			up = branch_get_upstream(branch, NULL);
> > +			if (!up)
> > +				return NULL;
> > +			cur = tracking_for_push_dest(remote, branch->refname, NULL);
> > +			if (!cur)
> > +				return NULL;
> > +			if (strcmp(cur, up))
> > +				return NULL;
> 
> This is probably not all that performance critical, so
> 			up = branch_get_upstream(branch, NULL);
> 			current = tracking_for_push_dest(remote, branch->refname, NULL);
> 			if (!up || !current || strcmp(current, up))
> 				return NULL;
> might be easier to follow.

I don't mind but likewise in this case we should probably change
branch_get_push_1 too.

> By the way, I have a bit higher-level question.  
> 
> All of the above logic that decides what should happen in "git push"
> MUST have existing code we already use to implement "git push", no?

Yes.

> Why do we need to reinvent it here, instead of reusing the existing
> code?  Is it because the interface into the functions that implement
> the existing logic is very different from what this function wants?

Mostly yes. The logic of git push is to massage the refspecs directly, for
instance:
	case PUSH_DEFAULT_MATCHING:
		refspec_append(&rs, ":");
	case PUSH_DEFAULT_CURRENT:
		...
		strbuf_addf(&refspec, "%s:%s", branch->refname, branch->refname);
	case PUSH_DEFAULT_UPSTREAM:
		...
		strbuf_addf(&refspec, "%s:%s", branch->refname, branch->merge[0]->src);

And the error messages are also not the same, and to give a good error
message we need to parse the different cases.

It may be possible to refactorize all this, but not in an obvious way and
it would be a lot more work than this patch series.

-- 
Damien Robert
http://www.normalesup.org/~robert/pro
