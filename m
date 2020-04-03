Return-Path: <SRS0=9X1Y=5T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 801D0C43331
	for <git@archiver.kernel.org>; Fri,  3 Apr 2020 00:25:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42A5820787
	for <git@archiver.kernel.org>; Fri,  3 Apr 2020 00:25:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mj/963Xv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389809AbgDCAZc (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Apr 2020 20:25:32 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:44288 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388951AbgDCAZb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Apr 2020 20:25:31 -0400
Received: by mail-pl1-f196.google.com with SMTP id h11so1996278plr.11
        for <git@vger.kernel.org>; Thu, 02 Apr 2020 17:25:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=0CrdFMIQUy/BKzhsuD1fsaDGXS27PjoLL3ps7KmPFL0=;
        b=mj/963XvHjKPxNoZGo8DvV/RWgtuykD1/1MOhm3Skn9q2VlS1SkbGX53C7y8fDVgow
         uD2xLF0v7DPizQs3T1mbGcTDkxuBWLGxsnQjVuMMIJKLDi8RxYep1HdfgY8Uvd/ZhvYp
         7kSzPjRdBxrESLDrBZ2N/w4tL+b2VQQ9GGT4SADvwIruhdZQDFYLbrys8r6Xu5HKyaML
         2QjuxjWwnPDlpAHKw0sG2WMetawU1Z0OZM54hlNvVlk6p8n6sHOxi2oxeIJCuQatiGMh
         mII7zg+cBhRLIjX9ZjnhAkk8sWrRABD2YgGlK5QVeYvLkzJUmqFmtsjxlKQWa5W4yJhs
         1rsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=0CrdFMIQUy/BKzhsuD1fsaDGXS27PjoLL3ps7KmPFL0=;
        b=qjeNS7PQqY09sY6aXhWGBFgmR89CmnIKBw9z4TIgNejI7A8cTB7hn42Cc+QcxAYNoS
         u8fFmkLPTTcJJ1p82CKVnHbxW7BhuNtSCYBxsZkIqNdIs5ZLHRVFTZMtW9UDfKJFbhxg
         aA/t3bhX/O9U5nPmF2x32rP6+5qO+AZBR5NkMb8uMyAbL/SDFXEbLGZFxepe+N8zYGy3
         mrvgFPc0kVyA+k53ufQxQN1d8kBd2zVuOvk0tiAVw7dFjPUORgEe8hbixWO2SxbLZKLE
         UA64NPJ4uK/2MmcWG1SsQF8JfmAZ0GVr6zqf5HmDzsGAch1R03xq9ufKXd0eO0+a4dPi
         Il0w==
X-Gm-Message-State: AGi0PuadZWj2kvxkkfnq88cE/yi+ND+G1SH2ofJyLJ+yE+7kr9kVES0E
        o199waYfoX93UmiY4grqdGU=
X-Google-Smtp-Source: APiQypKNgT2O5cCM1v3zrZazqKTzs7KeY6+dQB4v3Cqo3i6cVB1k6suASyPbDcrNd/ugIQWTATFojg==
X-Received: by 2002:a17:90a:ac18:: with SMTP id o24mr6621545pjq.62.1585873530296;
        Thu, 02 Apr 2020 17:25:30 -0700 (PDT)
Received: from localhost ([2402:800:6375:207b:be21:746a:7a56:9d4d])
        by smtp.gmail.com with ESMTPSA id k70sm4133023pga.91.2020.04.02.17.25.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2020 17:25:29 -0700 (PDT)
Date:   Fri, 3 Apr 2020 07:25:28 +0700
From:   Danh Doan <congdanhqx@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 5/5] Documentation: document merge option --no-gpg-sign
Message-ID: <20200403002528.GB29543@danh.dev>
References: <20200331064456.GA15850@danh.dev>
 <cover.1585821581.git.congdanhqx@gmail.com>
 <d35dd89c52e427861c38d17e43c61fca149dbfd5.1585821581.git.congdanhqx@gmail.com>
 <xmqqo8s93go8.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqo8s93go8.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2020-04-02 11:07:19-0700, Junio C Hamano <gitster@pobox.com> wrote:
> Đoàn Trần Công Danh  <congdanhqx@gmail.com> writes:
> 
> > Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
> > ---
> >  Documentation/merge-options.txt | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/Documentation/merge-options.txt b/Documentation/merge-options.txt
> > index 40dc4f5e8c..c46e4fe598 100644
> > --- a/Documentation/merge-options.txt
> > +++ b/Documentation/merge-options.txt
> > @@ -61,9 +61,12 @@ When not possible, refuse to merge and exit with a non-zero status.
> >  
> >  -S[<keyid>]::
> >  --gpg-sign[=<keyid>]::
> > +--no-gpg-sign::
> >  	GPG-sign the resulting merge commit. The `keyid` argument is
> >  	optional and defaults to the committer identity; if specified,
> > -	it must be stuck to the option without a space.
> > +	it must be stuck to the option without a space. "--no-gpg-sign"
> > +	is useful to countermand both `commit.gpgSign` configuration variable,
> > +	and earlier "--gpg-sign".
> 
> Shouldn't [4/5] also add '--no-gpg-sign' to the header like the
> above?

Yes, my bad. Since it's very small change.
Could you please help me do it instead.

-- 
Danh
