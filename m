Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DB1602101D
	for <e@80x24.org>; Mon,  4 Jul 2016 23:20:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932596AbcGDXUi (ORCPT <rfc822;e@80x24.org>);
	Mon, 4 Jul 2016 19:20:38 -0400
Received: from mail-pf0-f170.google.com ([209.85.192.170]:34333 "EHLO
	mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753729AbcGDXUh convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 4 Jul 2016 19:20:37 -0400
Received: by mail-pf0-f170.google.com with SMTP id h14so64284848pfe.1
        for <git@vger.kernel.org>; Mon, 04 Jul 2016 16:20:37 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=beanbaginc-com.20150623.gappssmtp.com; s=20150623;
        h=from:content-transfer-encoding:subject:message-id:date:to
         :mime-version;
        bh=3fYEE3OEBVIvuffbaprrzQJ3S1k1c0P36iBBKbJpDYc=;
        b=j/kZxR9CRnjMuF/rtmDAzYVzhCrCdEEfyMVXFJEbXVDYYDEH19Iz9VMxPgftkkmjJM
         QyP/0WvZb0PXfH1QUBDps8LHrtcfX2/wjz/UG6dND4HUD3XQdjQRSbarJHJoEi9IGPaY
         OZRpwvsa4fz90umwaXH1vE3S86u9ZEP/cWaI4cF6zOtXJhVA08cLMrQ9ofaw/9QUh9xA
         0QfksPFLJ9jMTy22F76BFpzjhKzS6/76aaVmfR9sLiWjwD2BgwIE6iL4qTHYLnTbJXD3
         +MF7bSk56ERWEQul9ioyButLceyvWZP0yHrzGm+2PtRGYhXXodKXRLitUAuSP1a2CXfr
         tmVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:content-transfer-encoding:subject
         :message-id:date:to:mime-version;
        bh=3fYEE3OEBVIvuffbaprrzQJ3S1k1c0P36iBBKbJpDYc=;
        b=URKXz54jyMneHIu1AQUenHUOiMJGVw5K4J+jlugoCS3sE7qFLijNYX/ZlqVfaPpUqf
         5oHvz00XXpzE5hW5ba4n/HT1FYAh4VvRV0GS5ShhrKo6tgGY+S6VMtdQGK4eNJhSqov4
         Q2hiu+lDLVZpv+80KQWEF7yJWSdYcGDCtgH0JPAQJCKlzJ+FMnLzg5w6pjfvQZaV/8kY
         Fyr9cS4yAXjL7wUOm0ziTNrOxVTRJn0MgD/8Kzt3itGtb+F/ObNDDQNb3nBheeFD4/DY
         NWQ5uZ91KIyAshA5JcCBjZk8AmaqikjXJNekbyqyX8ZyK4wzZLgYsyDtoCpwTy7so/dw
         uOHw==
X-Gm-Message-State: ALyK8tJhnM0+xF74UhBc4urvYotQqiGS58f6VLk0MzDQJXlOtTk8sfWflwWEsVqJTUMo3g==
X-Received: by 10.98.131.206 with SMTP id h197mr26458315pfe.124.1467674436844;
        Mon, 04 Jul 2016 16:20:36 -0700 (PDT)
Received: from [192.168.7.128] (static24-72-59-35.r.rev.accesscomm.ca. [24.72.59.35])
        by smtp.gmail.com with ESMTPSA id ct7sm394699pac.13.2016.07.04.16.20.36
        for <git@vger.kernel.org>
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 04 Jul 2016 16:20:36 -0700 (PDT)
From:	Barret Rennie <barret@beanbaginc.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Subject: [RFC] notes.<REF>.rewriteMode configuration option
Message-Id: <2A2C7F26-A929-45F0-83FE-E18CFAA35E7A@beanbaginc.com>
Date:	Mon, 4 Jul 2016 17:21:01 -0600
To:	git@vger.kernel.org
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
X-Mailer: Apple Mail (2.3124)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi all,

The project I work on currently heavily uses git. We would like to add some
tools based around detecting how branches change over time for code review, so
that users can compare commits as they change. We'd like to do this via adding
metadata in git notes, so that we can detect when commits are ammended or
squashed. While digging around in the `git notes` help, I noticed there is
support for `notes.<ref>.mergeStrategy` but not `notes.<ref>.rewriteMode`
configuration options. I was wondering if you would be interested in a patch
that adds support for a `notes.<ref>.rewriteMode` configuration option that
would take precedence for doing note rewrites for the given ref (like how
`notes.<ref>.mergeStrategy` takes precedence for merges).

Regards,
Barret Rennie

