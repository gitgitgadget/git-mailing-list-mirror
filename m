Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DAA611F462
	for <e@80x24.org>; Tue,  4 Jun 2019 17:57:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726538AbfFDR5Z (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Jun 2019 13:57:25 -0400
Received: from mail-pf1-f202.google.com ([209.85.210.202]:43386 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbfFDR5Y (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Jun 2019 13:57:24 -0400
Received: by mail-pf1-f202.google.com with SMTP id j7so5617152pfn.10
        for <git@vger.kernel.org>; Tue, 04 Jun 2019 10:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=W+2KmQEjTc0Vs4CfPldSdvknXxurbhKd2I7SJQ1KzVI=;
        b=ogXhZ/Z3iq0XdgMteGa4gZR4McJm5M8/bPjTi3vWP+hzZCB71may8YHeRei26gkh0b
         fcZacFDqSzjwKE27sKoPMeUUHM8MNIvYMWOCbBj/upXrr50OqGTPIuyCd+VVVfoN19TC
         Ds1o5bSfURu8506obdckEXy96vicN5GBsK9ByUbLJCR//kIoa6qfXe/+Bl2lgjb3JRMp
         eFPuXPxrotJzpzKOEzgF5RmuV6Up/G+bPnU0w9YqYJXaFHjCpuIR9s3nQ2NAqId57biw
         /ZmrMAcwr1Bhx6aJGxAgQlqXgxgGEntVQ7wHPCiHZQYlDLk4WXgX/Y1ul2IgFJ+YeBeX
         leHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=W+2KmQEjTc0Vs4CfPldSdvknXxurbhKd2I7SJQ1KzVI=;
        b=jdOBLCEfHlnMSbG+0Q3O7/seopDdooLxJwTy+vtD+3653Mu1jYxfXFAAawP/wJNlxZ
         TGxpdni4uB/bVZ2b0jsArHXN62G9fu76Pm0sGexwMrK1mqCsXeChEhAsRGhek3iR3eGg
         DSDfycsO07bEHZMAJTdW2tp4uDi3vcjLcLv7W+WGuYL58uzd2NT0m4GICXLExYRYBJrI
         PfzK9IwUrSupCfoirZLyp66Hc9J0HbrtW0o2SnlHSC9tlqUF7T2dhzmBesIwqMU0zOly
         ScQsw5fcZKVQ5KRUnQVtIChpBc1NrLhvKOwMHynrQuFb4bENpiwzx4IuhHQSqKQ5QAmp
         mdYw==
X-Gm-Message-State: APjAAAVaVG/+10zL61BL4fOTh859MCjherTBl+ZG+qcHGAhBFcES3HPK
        DZ3XpHLEqBhwid239G+O05XS6xYstSN5HolcgOBiwf/CyXOAwH0YUExQAA3/zTDb5X+8l5QOHzU
        fVC3I60mnirfVvNFTJ8BByLYzFGqkmqAyGraoWL1sC1VHZnFB6lVda36zko0=
X-Google-Smtp-Source: APXvYqx4DThlu7M0tBID7bCdZjPJbh8wJQhxnFAeyZSCc/kD+oZXDNHvHUeYMRLDtJyMcs0/8W3K2THpMlgP
X-Received: by 2002:a63:ed16:: with SMTP id d22mr37026410pgi.35.1559671043528;
 Tue, 04 Jun 2019 10:57:23 -0700 (PDT)
Date:   Tue,  4 Jun 2019 10:57:04 -0700
In-Reply-To: <cover.1559670300.git.matvore@google.com>
Message-Id: <9628f0bfeda578a1c7d157d61b87f5c430567d74.1559670300.git.matvore@google.com>
Mime-Version: 1.0
References: <cover.1559670300.git.matvore@google.com>
X-Mailer: git-send-email 2.22.0.rc1.311.g5d7573a151-goog
Subject: [PATCH v2 1/2] url: do not read past end of buffer
From:   Matthew DeVore <matvore@google.com>
To:     git@vger.kernel.org
Cc:     Matthew DeVore <matvore@google.com>, sandals@crustytoothpaste.net,
        jeffhostetler@microsoft.com, l.s.r@web.de, gitster@pobox.com,
        spearce@spearce.org, jrn@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

url_decode_internal could have been tricked into reading past the length
of the **query buffer if there are fewer than 2 characters after a % (in
a null-terminated string, % would have to be the last character).
Prevent this from happening by checking len before decoding the %
sequence.

Helped-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
Signed-off-by: Matthew DeVore <matvore@google.com>
---
 url.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/url.c b/url.c
index 25576c390b..9ea9d5611b 100644
--- a/url.c
+++ b/url.c
@@ -39,21 +39,21 @@ static char *url_decode_internal(const char **query, in=
t len,
 		unsigned char c =3D *q;
=20
 		if (!c)
 			break;
 		if (stop_at && strchr(stop_at, c)) {
 			q++;
 			len--;
 			break;
 		}
=20
-		if (c =3D=3D '%') {
+		if (c =3D=3D '%' && (len < 0 || len >=3D 3)) {
 			int val =3D hex2chr(q + 1);
 			if (0 <=3D val) {
 				strbuf_addch(out, val);
 				q +=3D 3;
 				len -=3D 3;
 				continue;
 			}
 		}
=20
 		if (decode_plus && c =3D=3D '+')
--=20
2.21.0

