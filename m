Return-Path: <SRS0=mA98=7A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5658C433E0
	for <git@archiver.kernel.org>; Mon, 18 May 2020 15:30:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D0F120758
	for <git@archiver.kernel.org>; Mon, 18 May 2020 15:30:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CWKhTkdS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727942AbgERPa2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 May 2020 11:30:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726958AbgERPa2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 May 2020 11:30:28 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50713C061A0C
        for <git@vger.kernel.org>; Mon, 18 May 2020 08:30:28 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id 5so2178998pjd.0
        for <git@vger.kernel.org>; Mon, 18 May 2020 08:30:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=d8CYvW6MJuMr6Xo8hcM3mfYA7MmCayUI7I8Oi7kPjuA=;
        b=CWKhTkdSAySICBI2A1jshldT1HsMnu+0IHAd6/ibaLXbRkcuvga68M/wF2BinwV0uZ
         X2GM4UByA+5HFxaeretUst1L2WdmcCq0iZuuCXEzBPIgL5wOuhfES+CQwp3ki3sd93RM
         myUIw5NMCbFURpEceW8C4i9/BBbcxi4sDKtTtsrOEGAcZ3JlkE01WI5AxHfosdU7s1LA
         qyw50wkP1O2/lT77vIm7XIrlfvVOzF6OIp/YpnIdRngPsZi6d9cVmPHy0klj1n4gA+C2
         sD9+BtHLrU+bAowss5u8z0i1qdKqWez8LX8SxAaqnB04XET2U9vuVfPW3J94OOBy6NVs
         J4DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=d8CYvW6MJuMr6Xo8hcM3mfYA7MmCayUI7I8Oi7kPjuA=;
        b=J3nO0W0MJxiletxEAbG/+TNqrxL1UzH/6l53FUgCIMIVXS28oMapkmxABUy+BeUhJ6
         f++sx96/ZoEzRA9SaotlFjNoHN1VIxCXVUjPb+Hgvu5T/eiJCfWAGWTsGfERlIe2aJFq
         VeTQWQS4cp/M4HxxAoDakfXmqASTWu7wXuH4Dk2fFOvGegV3aZjfJqbPRiv01VqAXNpL
         jll221oYh0agurqhGSToBRpaM0/DAqWr5fla2viPSmAQZIGApbr+HJaMUWB3Yg3aqTTg
         BtT6gOaarW5KxNE/rAKpFxpYhXvhbf2Dv/zkkWnld/3IJ0WzihFAewl9ZQ3ckPDnA9w7
         anHQ==
X-Gm-Message-State: AOAM531jBMDcysUHVvwD1p9gYlAZAdaYLywVj26dADRYpPXEJ3ZYt9iX
        sK7Om4oN6xYuMk4CXDg3L3E=
X-Google-Smtp-Source: ABdhPJyklN1trE7KZCXFON9X/bFZ6M6pZyUx1XgcgDoNyXplnoDqlvKiknQIWBm9gIE0fIwzG+sE4g==
X-Received: by 2002:a17:902:d886:: with SMTP id b6mr16886557plz.263.1589815827805;
        Mon, 18 May 2020 08:30:27 -0700 (PDT)
Received: from localhost ([2402:800:6374:cedc:d509:3e82:1f34:e3c4])
        by smtp.gmail.com with ESMTPSA id t10sm738230pjj.19.2020.05.18.08.30.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2020 08:30:26 -0700 (PDT)
Date:   Mon, 18 May 2020 22:30:25 +0700
From:   =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
To:     Darren Tucker <dtucker@dtucker.net>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/7] Redirect grep's stderr top null too.
Message-ID: <20200518153025.GD1980@danh.dev>
References: <20200518100356.29292-1-dtucker@dtucker.net>
 <20200518141311.GC1980@danh.dev>
 <CALDDTe13_utn7E+QF1AgndX_6nPph=Gr1hesLwfV8e9LwgUPOQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALDDTe13_utn7E+QF1AgndX_6nPph=Gr1hesLwfV8e9LwgUPOQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2020-05-19 00:29:47+1000, Darren Tucker <dtucker@dtucker.net> wrote:
> On Tue, 19 May 2020 at 00:13, Đoàn Trần Công Danh <congdanhqx@gmail.com> wrote:
> >
> > Hi Darren,
> >
> > On 2020-05-18 20:03:50+1000, Darren Tucker <dtucker@dtucker.net> wrote:
> > > Prevents pollution of configure output on platforms that don't have
> > > grep -a.
> >
> > From your other's patch, I think you're in HP-UX,
> 
> Yes (it's not my usual platform but I had occasion to test something
> on it so revived an old system).
> 
> > would you mind also run the test.
> >
> > Since t5703 also uses "grep -a"
> 
> It fails with:
> $ ./t5703-upload-pack-ref-in-want.sh
> sed: There are too many commands for the s/\n// function.

I think this was introduced at 878f988350 (t/test-lib: teach
--chain-lint to detect broken &&-chains in subshells, 2018-07-11)

The chainlint.sed is too complicated for a mortal like me to
understand, I added Eric to Cc.

> ok 1 - setup repository
> sed: There are too many commands for the s/\n// function.
> not ok 2 - config controls ref-in-want advertisement
> #
> #               test-tool serve-v2 --advertise-capabilities >out &&
> #               ! grep -a ref-in-want out &&
> #
> #               git config uploadpack.allowRefInWant false &&
> #               test-tool serve-v2 --advertise-capabilities >out &&
> #               ! grep -a ref-in-want out &&
> #
> #               git config uploadpack.allowRefInWant true &&
> #               test-tool serve-v2 --advertise-capabilities >out &&
> #               grep -a ref-in-want out

I'm thinking about:
-----------8<------------
diff --git a/t/t5703-upload-pack-ref-in-want.sh b/t/t5703-upload-pack-ref-in-want.sh
index a34460f7d8..92ad5eeec0 100755
--- a/t/t5703-upload-pack-ref-in-want.sh
+++ b/t/t5703-upload-pack-ref-in-want.sh
@@ -49,15 +49,18 @@ test_expect_success 'setup repository' '
 
 test_expect_success 'config controls ref-in-want advertisement' '
 	test-tool serve-v2 --advertise-capabilities >out &&
-	! grep -a ref-in-want out &&
+	perl -ne "/ref-in-want/ and print" out >out.filter &&
+	test_must_be_empty out.filter &&
 
 	git config uploadpack.allowRefInWant false &&
 	test-tool serve-v2 --advertise-capabilities >out &&
-	! grep -a ref-in-want out &&
+	perl -ne "/ref-in-want/ and print" out >out.filter &&
+	test_must_be_empty out.filter &&
 
 	git config uploadpack.allowRefInWant true &&
 	test-tool serve-v2 --advertise-capabilities >out &&
-	grep -a ref-in-want out
+	perl -ne "/ref-in-want/ and print" out >out.filter &&
+	test_file_not_empty out.filter
 '
 
 test_expect_success 'invalid want-ref line' '
------------------->8-----------

> #
> sed: There are too many commands for the s/\n// function.
> ok 3 - invalid want-ref line
> sed: There are too many commands for the s/\n// function.
> ok 4 - basic want-ref
> sed: There are too many commands for the s/\n// function.
> ok 5 - multiple want-ref lines
> sed: There are too many commands for the s/\n// function.
> ok 6 - mix want and want-ref
> sed: There are too many commands for the s/\n// function.
> ok 7 - want-ref with ref we already have commit for
> sed: There are too many commands for the s/\n// function.
> FATAL: Unexpected exit with code 0
> 
> If I use gnu sed and native grep, only #2 fails as above.  If I use
> gnu grep and gnu sed it passes with a warning from (gnu) printf:
> $ ./t5703-upload-pack-ref-in-want.sh
> printf: \3: invalid escape

Look like HP-UX's printf doesn't understand octal escape.
This may be a problem, since we've a patch to fix git-bisect's replace
for Windows, which is using "printf \015"
Cc-ing Junio for checking.


-- 
Danh
