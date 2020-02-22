Return-Path: <SRS0=hy0J=4K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B742C35671
	for <git@archiver.kernel.org>; Sat, 22 Feb 2020 18:51:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B571206ED
	for <git@archiver.kernel.org>; Sat, 22 Feb 2020 18:51:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="Xskm5Nbw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726859AbgBVSvV (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 22 Feb 2020 13:51:21 -0500
Received: from mout.web.de ([212.227.15.14]:37891 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726550AbgBVSvV (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Feb 2020 13:51:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1582397476;
        bh=hPrzISv+zXGeDAcszNcmDep0KtF0SKOwfja6JkjA1qE=;
        h=X-UI-Sender-Class:To:Cc:From:Subject:Date;
        b=Xskm5NbwiQrjFXEkWSWDmQXSNSxfb/y9qDEXvb6AfpeExTHpDrlUdJLcXRFEvWEXB
         v1wmCUxz5JQG7t2IRhk08M7k6vDAnn8dq0qWBCHNvLbrNWRw94XyN2m1tjfsGsCWpp
         kK/xzg3S30tdTJHfvMt+cwGVWPRbFfrsejwKVbu4=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([79.203.21.89]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0Lz3CK-1jRatQ19ea-014EmE; Sat, 22
 Feb 2020 19:51:16 +0100
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] quote: use isalnum() to check for alphanumeric characters
Message-ID: <0157c714-2d9b-7896-f5dc-232d82a46625@web.de>
Date:   Sat, 22 Feb 2020 19:51:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:L0dnK1/GB7tEhBgAON1/wXJxaKE2twAJ6Dpi+BSEGG7TEWERZ9t
 D+Q3RCP2eAlZuhifShWp4lcSEkUbduSZ3L0JUeUhZiJmPY2KYGQJ4WGGOfF61Tweq9pZ7v+
 rNYIZ00VcXtaNxWKxAQaN+0tJw4L52g9nq+H9S+YQoesJT65qDiv1JLEhqFLJKCpCMUGbGj
 kgWXeDJVRhbJ3jAhNGGJQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:jVOqsUmeLZU=:qJuj3RPxr+hUPD2VKyYBIS
 IzHJeJ0Vz3Wy8oKdeiBWkWbf2e4ChtRc3JqDOvruFOfRalMF+AX5KxEPqYiIm8QLh87Q4ljzo
 VQ0YK+WJUyUgqoEub9+XzGHwI+sc70swFjl5Qa8VI/tDbv5Z+vDzdh1tlxCZCilplzsAsfUKM
 znRN6S35bxRwolO5ZkOEkZkfLpfN7zj6Zfn2vZNiePUE7j2589ioGWWvLg/V9JjiQOJU8Am8P
 oms3HRN84rUvSG1LWq3ayOAkJtoICILqQ83P3QRW+SGtRyFhVVfSDVNq5/VBVqYK311zluRhz
 +mRawXspSecUwcNtUm5CIIh+ioR8lIgCWTXwCWY9gHy9DfbZLrbXLcVhWKIJaG7fV7gQYUKmM
 DFGZDzEsaVi56TUkMPAXPcUrINda+97mKYJWcjFJtiQoOGRANFL1Bq7ysmLgioyuaHx3SsQL8
 /jeMKUeM/2DcT8iQdd6XDuLHHDONXG3+tuJGCK/L5pZSskBT+0RhPgqsVYVifPOS6nrF00+yY
 LvzOxdECTeNqeuhHYG1gOMU7BfGZYGG0WdIBHmKWbyBTGaY7vXbBFDJfnS3NA8gdgnLKI39LB
 OB1m7LHZERVDrAEOkuUk+HjEyLSGHwFxjiH7f2hZcYV5cXsuZUcOD+jW+3+sAteZO4GYVpQYz
 hPdIeLa4H5svSuQWoG6wVJ8MSOh7jmxxDtvKwZKc/4AnSZ0Qge+Ppy+G7B+CF7GF/as5+T4ED
 KB/q5dQYX0kC1KsHzsrCEYTdAOTsAZtcnO+tU3rGI+lG3znihuaXoe8cPjL7Kw4GcVjHTaOcD
 Jfa2+2YodiZh8k7MrCqwcp5I8C4h9BIDNTHaXzsEcha4fJAN4QYFSVDLVy51SIzNtYeVjYOvy
 5KMOLa7CTyUA/gAUGKofO7x9hYc87fz7lr+fwbyK8po7n9kV1kl+Dc/XWtRwKrFRb0DGnRf5N
 A2xVrZXASmlSfTyN3pk9TwrWmQ9zQerV81p9NcP++msbK7OGHggwP2/KP7Kx9YGwRyQZdlEYA
 yfmiO3M4WPVq64cQMDxWJhwn+7SwY/gouy3z7oOo5OHfg19ZfZrLpArWmXKk706dOKRIscDy2
 VQfRLT5dTUvOX66oRBH0frjuBkmv/8vCOiGiZ6hxroh+6FVapZjBYeKXT0MYcgbWy33vNY82T
 5eum0JrBOWTljkaS3O1gSslpmOgT2FJTqXeE7Q25aYpjWFW4cEsQV8LmKPid0hgbSBMXNk7Dd
 0ozpXqIxL4yonhmzI
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

isalnum(c) is equivalent to isalpha(c) || isdigit(c), so use the
former instead.  The result is shorter, simpler and slightly more
efficient.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 quote.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/quote.c b/quote.c
index 24a58ba454..bcc0dbc50d 100644
=2D-- a/quote.c
+++ b/quote.c
@@ -55,7 +55,7 @@ void sq_quote_buf_pretty(struct strbuf *dst, const char =
*src)
 	}

 	for (p =3D src; *p; p++) {
-		if (!isalpha(*p) && !isdigit(*p) && !strchr(ok_punct, *p)) {
+		if (!isalnum(*p) && !strchr(ok_punct, *p)) {
 			sq_quote_buf(dst, src);
 			return;
 		}
=2D-
2.25.1
