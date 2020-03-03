Return-Path: <SRS0=wY2r=4U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8A16C3F2D1
	for <git@archiver.kernel.org>; Tue,  3 Mar 2020 16:25:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAFA420870
	for <git@archiver.kernel.org>; Tue,  3 Mar 2020 16:25:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZLS/KwvD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730352AbgCCQZS (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Mar 2020 11:25:18 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:33036 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729784AbgCCQZS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Mar 2020 11:25:18 -0500
Received: by mail-wm1-f65.google.com with SMTP id a25so2733644wmm.0
        for <git@vger.kernel.org>; Tue, 03 Mar 2020 08:25:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=ZuPF1MubXk5PFwfUoT8woJJ4zrT1m+37IVF6bwUIxZE=;
        b=ZLS/KwvDDrOLzfZ0RYQeblPwB38v83b+a3Wrfv3bNwoWtBubixmsQF5Pj3TlDoGxzh
         KgFzIUSz0jRK438qx7wQMGvPc4/B1BcsSfNwZkidle9pLoCR2b1slD0nhTed3xTsaLhr
         rpm+fYjeVdlGIrgoHV/7oTEs8O6yAsWlFpYY7sFDGTSMivmNrZRLRT70cOiAqir0u+pE
         NlSo74LgiR95/1fkrev85vOJBYCFBOsOFwLcskdCRC+BjPKJmjt0yKZb7xyhG7n+yQ1w
         PC8/tcwZvrhdRYdrur6NEsW9K8cESxE1mLHXit8gt1O8PxPRy71Ben0Ce17wzzd2Vffr
         XPOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=ZuPF1MubXk5PFwfUoT8woJJ4zrT1m+37IVF6bwUIxZE=;
        b=uflIUOxSBnaDQb/yJfompUnWx0OCLmHsvQbvGDt3fq3awx8av+yTsg7/7ZDRnufAcl
         N6oFbqAJCkGEAeQt8ehohZ10rDskN4Vp1nBA4TpqX+l1LAL52QB+igyFGtcQammBtepj
         Ajmh7pcGmZXmgM/g3fFKv18H882giLbK2nUL2QThb8N7fEHLljGnG4VyCBtiEI1qKz5G
         sINLEa3ahC8ZoPDBR54mZz3Uh/xRGygz25S1pL02wkdo1NkTS9U7q5Gx1nAY+GIx8U0B
         BYIMot/paCwFsu97+j0jTILcx3qQU5JBm7WVZjyquScbFHlYOL6N55KTYUTVBPsqVAeU
         7q8w==
X-Gm-Message-State: ANhLgQ3M+FvSofHQzOMIEZYufDCgYu4ChF4DqVHTiIjynJxWkwJGoI7S
        Go7ad0DdQG0L7CprYrPpuiJ6fnbCeOc=
X-Google-Smtp-Source: ADFU+vt1VoEqglSBRGZLmv8jehTdGDnU1f3EsY/qkWKwJJQmWumZLQXIhVUdHaBxDzWnk3y28c7fjw==
X-Received: by 2002:a1c:f71a:: with SMTP id v26mr5139692wmh.85.1583252716441;
        Tue, 03 Mar 2020 08:25:16 -0800 (PST)
Received: from feanor (87-231-246-247.rev.numericable.fr. [87.231.246.247])
        by smtp.gmail.com with ESMTPSA id d15sm31938308wrp.37.2020.03.03.08.25.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2020 08:25:15 -0800 (PST)
Date:   Tue, 3 Mar 2020 17:25:14 +0100
From:   Damien Robert <damien.olivier.robert@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/1] remote.c: fix handling of push:remote_ref
Message-ID: <20200303162514.dkmulpq5fw3t6hpt@feanor>
X-PGP-Key: http://www.normalesup.org/~robert/pro/files/Damien_Olivier_Robert.asc
X-Start-Date: Tue, 03 Mar 2020 17:16:23 +0100
References: <20200228172455.1734888-1-damien.olivier.robert+git@gmail.com>
 <20200228182349.GA1408759@coredump.intra.peff.net>
 <20200301220531.iuokzzdb5gruslrn@doriath>
 <20200302134842.GB1176622@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200302134842.GB1176622@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From Jeff King, Mon 02 Mar 2020 at 08:48:42 (-0500) :
> And I think all of this may be duplicated with git-push itself (which
> would also be nice to get rid of, but last time I looked into it was
> hard to refactor it to do so).

I had a quick look at git-push but the duplication does not seems too bad.

> > In the 'upstream' case, the auxiliary function would return
> > branch->merge_name[0]. So the question is: can
> > tracking_for_push_dest(branch->merge_name[0]) be different from
> > branch->merge[0]->dst?

> Those will both return tracking refs. I think you just want
> merge[0]->src for the upstream case.
> And yes, the two can be different. It's the same case as when the
> upstream branch has a different name than the current branch.

I meant, now that we have branch_get_push_remoteref, can we replace
the body of branch_get_push_1 by
	remote = remote_get(pushremote_for_branch(branch, NULL));
	ret = tracking_for_push_dest(remote, branch_get_push_remoteref(branch), err);
(we would need to add error handling in branch_get_push_remoteref but that
is easy)

Currently that is exactly what branch_get_push_1 does, except in the
PUSH_DEFAULT_UPSTREAM where it returns branch->merge[0]->dst.
But branch->merge is set up in `set_merge`, where we have:
		ret->merge[i]->src = xstrdup(ret->merge_name[i]);
		...
		if (dwim_ref(ret->merge_name[i], strlen(ret->merge_name[i]),
			     &oid, &ref) == 1)
			ret->merge[i]->dst = ref;
So my question was: can dwim_ref(branch->merge[0]->src) be different from
tracking_for_push_dest(branch->merge[0]->src)?

> Yeah, I think that's going to be the easiest. It would be nice to avoid
> repeating that switch(), but frankly I think the boilerplate you'll end
> up with trying to handle the two cases may be worse than just repeating
> it.

That's what I went with. We can always refactorise branch_get_push_1 to use
branch_get_push_remoteref afterwards.

> It may be worth adding a comment to each function to mention the
> other, and that any changes need to match.

I tried to add a comment, but I don't know if it is helpful enough.
