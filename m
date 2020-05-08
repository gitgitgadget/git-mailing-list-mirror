Return-Path: <SRS0=7OUv=6W=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45857C38A2A
	for <git@archiver.kernel.org>; Fri,  8 May 2020 17:51:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 167B92184D
	for <git@archiver.kernel.org>; Fri,  8 May 2020 17:51:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HsUir556"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726825AbgEHRva (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 May 2020 13:51:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726636AbgEHRv3 (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 8 May 2020 13:51:29 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C80ACC061A0C
        for <git@vger.kernel.org>; Fri,  8 May 2020 10:51:29 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id j2so1700202qtr.12
        for <git@vger.kernel.org>; Fri, 08 May 2020 10:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/YVZGpk0E4MdmVIAxt9BrhpAvHwhKj+IyvzEkLL3j0w=;
        b=HsUir556hF4nkgCyijxJnN5WjwF5dkASJqBAEUspKypaPmrQMeGKHu0JiRmR9GVQxu
         S0mXABjSglwd0aHo03u3RkXILDo2NS3sRgPtlMJS55N02KXSfV62LeFbEA2fwNro2WRR
         qmUsTBaeOVqlu7co2hrwin38SEPJ10ZsmgCwaWVee6TnNGWPQrbS3EkWe5SE1KmnmxE2
         OjyhVrLCC2bSXsCkgwV6QlCL9TOlMDz5ThvQPjUilOr1YYE6IPDZiF/4OFqVMeBo7YIh
         MWHTfkSmOkNEIIDxU1dGQdvV+6OKapgXXH1acyjjwb4jBUSMzwDV7RsDG/hk52Pdwjx4
         iKhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=/YVZGpk0E4MdmVIAxt9BrhpAvHwhKj+IyvzEkLL3j0w=;
        b=qLEOjf/pbt5znJQEz5rAj7VT8HHQGtShsVq8TNtGIGexiFAsIM9DPp1cg3MsAuIEGi
         bVxHUV3Aea0iBMm4xSmc8JPBvygBJDr32vgahwnky0HJfFj26nAp5bRofCgEvJrR6ziM
         dzCMm9w6/HI56ALNydn5WIqgO3zaKdewAF2/6BdByE/5ytJT36d/X5REPg0eET+2758q
         eYaVVkwEgWxtXSFSqNLUjF0LB1Et3ADytjOh+Xk6eGDu1IpkAARZEzdFtQS/UOCQHpk6
         OKybLBknVB+VtDAxM/6Pyok2x1yFRMzJlS498J7vFYDdh/zKaVV7gy3iR+IJDw1afahK
         1BXA==
X-Gm-Message-State: AGi0PuYRzcRgWbH2HrjEt3z4aUiP/pmvbQLxWloSFQIENX9GHlFQ7Mq9
        cQu/l8mb5NL9oaskhuAzb3SGF4Wp
X-Google-Smtp-Source: APiQypId1NYVK0MpUDdiV3dqERMy/UgjnIolByl4hjzBdRAfd5hC6K/m+FUEOTFVxlt4OyN9zQohsg==
X-Received: by 2002:ac8:5645:: with SMTP id 5mr4206116qtt.151.1588960288843;
        Fri, 08 May 2020 10:51:28 -0700 (PDT)
Received: from flurp.local (user-12l2dpj.cable.mindspring.com. [69.81.55.51])
        by smtp.gmail.com with ESMTPSA id o3sm1948880qtt.56.2020.05.08.10.51.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2020 10:51:27 -0700 (PDT)
Date:   Fri, 8 May 2020 13:51:21 -0400
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Christian Couder <christian.couder@gmail.com>,
        Shourya Shukla <shouryashukla.oo@gmail.com>,
        chrisitan.couder@gmail.com, Denton Liu <liu.denton@gmail.com>,
        git <git@vger.kernel.org>
Subject: Re: Re* [PATCH v4] submodule: port subcommand 'set-url' from shell
 to C
Message-ID: <20200508175121.GA20180@flurp.local>
References: <xmqqwo5o6hzp.fsf@gitster.c.googlers.com>
 <20200507044028.GA5168@konoha>
 <xmqqv9l849i4.fsf@gitster.c.googlers.com>
 <20200508054728.GA8615@konoha>
 <CAP8UFD0=_8D8hkT5VVPV_F++dr131bkjby357fA+QfhQxktcMg@mail.gmail.com>
 <xmqq8si21mlz.fsf_-_@gitster.c.googlers.com>
 <CAPig+cQP_9onrq-z5db1GhXSSHaeKJ+UhNewWP25wLCsMRzSrA@mail.gmail.com>
 <xmqqpnbezaga.fsf@gitster.c.googlers.com>
 <20200508161315.GA3504@flurp.local>
 <xmqq4ksqz8jq.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq4ksqz8jq.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 08, 2020 at 09:38:17AM -0700, Junio C Hamano wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
> > + - Do not explicitly compare an integral value with constant 0 or '\0',
> > +   or a pointer value with constant NULL.  For instance, to validate a
> > +   counted array ptr that has cnt elements, write:
> 
> I think this should be
> 
>       counted array <ptr, cnt> is initialized but has no elements, write:

You're right. Here's a corrected version. I also applied s/a/that/ in
the second line to improve the grammar a bit.

--- >8 ---

From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3] CodingGuidelines: do not ==/!= compare with 0 or '\0' or
 NULL

Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 Documentation/CodingGuidelines | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
index 390ceece52..803a3b9bde 100644
--- a/Documentation/CodingGuidelines
+++ b/Documentation/CodingGuidelines
@@ -236,6 +236,18 @@ For C programs:
         while( condition )
 		func (bar+1);
 
+ - Do not explicitly compare an integral value with constant 0 or '\0',
+   or a pointer value with constant NULL.  For instance, to validate that
+   counted array <ptr, cnt> is initialized but has no elements, write:
+
+	if (!ptr || cnt)
+		BUG("empty array expected");
+
+   and not:
+
+	if (ptr == NULL || cnt != 0);
+		BUG("empty array expected");
+
  - We avoid using braces unnecessarily.  I.e.
 
 	if (bla) {
-- 
2.26.2.737.gf3227dd3d3
