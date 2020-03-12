Return-Path: <SRS0=YYoh=45=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA058C10DCE
	for <git@archiver.kernel.org>; Thu, 12 Mar 2020 21:41:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C86720637
	for <git@archiver.kernel.org>; Thu, 12 Mar 2020 21:41:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L0L8UNVe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726594AbgCLVl3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Mar 2020 17:41:29 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35552 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726491AbgCLVl3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Mar 2020 17:41:29 -0400
Received: by mail-wr1-f66.google.com with SMTP id d5so9149892wrc.2
        for <git@vger.kernel.org>; Thu, 12 Mar 2020 14:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=14YBRDzrjCLo7HEIaihvr/jG5G0ssG+XLQG6NQaffJc=;
        b=L0L8UNVeZS3zK1KnW7VyEdiRXH/32y9x0QQyZQBnqxAarOK2ibjCyldaNcuFGLHe8g
         S6g5xQru7TsL9snk7ECTe+PmIBTJuzlG3RAlJQgIPOoV/P7HJPmWD7RkBjMxsqz12aAS
         LaCmYWNATr7goPJLYwTuSu8nzf+umTd3Z9R+CsG261RB8JTdYKxIjZJXB8TQSpvTLb/q
         9nl2DRvU3HP+y/aviYKzWp73t3YMq3DHuh08A08ImBridTyVE/2sFnoF1E+iDcRU4JIQ
         3hrHszFd0CdCtDyhonM6pifVjaGBhRyfh0pK41UOdFHDrGLQgcYKV0QytpIngasiuLLS
         W1KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=14YBRDzrjCLo7HEIaihvr/jG5G0ssG+XLQG6NQaffJc=;
        b=IybjNTmz8/x0hqmohRIxcGxw7LpmEUhTJjwg9vB4SecaUaWBwfzo0xpc4Kp49CRj4V
         ok4tPEdDaxOX6H2n59Uk+ymGOItbDlXzywMJpYX2Bir0ONvg9R8/8YOZWoUsHmYKTqKV
         z44A1TNl3+OxzFmThIPz3d48mHYa3c3BkEy3dtNhpdTodQa+mLj5kmAKKWbJ26MjHY0o
         kkMHqi0cXcDJWCKHzzvuJiSDIACbOc91/gPw9rDW/M4s1OTWLoMDhgNMe6SVPx20WPPk
         ilbaZmZnXiMQ+E6X5lXg2o+SI7J+L0KCab71FCEzjDCfaPYPLHFDfaYUZtUtJnHIwFGw
         FUKw==
X-Gm-Message-State: ANhLgQ29SLO+RRJkZvA1K3yHpR9jea4Uwg20OhKOZ82CC1gFYg+HWplU
        Cbv4/GpYHv7VBIL5CvjpOqs=
X-Google-Smtp-Source: ADFU+vuKePoRkpt6od7PVP31fMgScXfUKn0u6Y3OKlSzKwLVA54S0ahPBgoXIlf9tdswcpkSJXFFMg==
X-Received: by 2002:adf:f545:: with SMTP id j5mr13023231wrp.295.1584049285720;
        Thu, 12 Mar 2020 14:41:25 -0700 (PDT)
Received: from doriath (87-231-246-247.rev.numericable.fr. [87.231.246.247])
        by smtp.gmail.com with ESMTPSA id 9sm14292992wmx.32.2020.03.12.14.41.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2020 14:41:24 -0700 (PDT)
Date:   Thu, 12 Mar 2020 22:41:23 +0100
From:   Damien Robert <damien.olivier.robert@gmail.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        William Baker <William.Baker@microsoft.com>
Subject: Re: [PATCH v2 1/1] midx.c: fix an integer overflow
Message-ID: <20200312214123.sqja3fvuiaaspxwp@doriath>
X-PGP-Key: http://www.normalesup.org/~robert/pro/files/Damien_Olivier_Robert.asc
X-Start-Date: Thu, 12 Mar 2020 22:31:40 +0100
References: <20200228162450.1720795-1-damien.olivier.robert+git@gmail.com>
 <20200312173520.2401776-1-damien.olivier.robert+git@gmail.com>
 <a538c497-a79d-43be-3d00-c7a619acc4e6@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a538c497-a79d-43be-3d00-c7a619acc4e6@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From Derrick Stolee, Thu 12 Mar 2020 at 14:28:11 (-0400) :
> I _think_ the t/tXXXX directories are used for this kind of data storage,
> so you could generate an empty multi-pack-index from an older version of
> Git then store it there.

Yes I anticipated that and have one available on hand :)
It weights 1116 characters.

> > -	if (flags & MIDX_PROGRESS)
> > -		progress = start_sparse_progress(_("Verifying OID order in multi-pack-index"),
> > -						 m->num_objects - 1);
> > -	for (i = 0; i < m->num_objects - 1; i++) {
> > -		struct object_id oid1, oid2;
> > +	if (m->num_objects == 0)
> > +		midx_report(_("Warning: the midx contains no oid."));
> 
> Should this "Warning: " be here? The other calls to midx_report() do not have such prefix.

Right, I agree it should not.

> Also, it may be valuable to return from this block so you do not need to put the block below in a tabbed block, reducing the complexity of this patch.

Agreed: we don't want to run the other checks anyway if we don't have any
objects.

That'll be for v3 once I get advice on what to do for tests.
