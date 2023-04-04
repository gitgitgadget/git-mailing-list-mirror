Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4F43C761A6
	for <git@archiver.kernel.org>; Tue,  4 Apr 2023 19:51:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236000AbjDDTve (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Apr 2023 15:51:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230004AbjDDTvd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Apr 2023 15:51:33 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1A8FA8
        for <git@vger.kernel.org>; Tue,  4 Apr 2023 12:51:31 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id v6-20020a05600c470600b003f034269c96so10522473wmo.4
        for <git@vger.kernel.org>; Tue, 04 Apr 2023 12:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680637890; x=1683229890;
        h=subject:from:to:content-language:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=vOWWptlMwS7x0v9qMR/X7GZF8/y6INJkVuY+7+tB2Ok=;
        b=B/jK6oynLNtlTK4EmIKgfS7Kq1wKAg9FsdAPMkiO0kqRPx+wRJhakiXjBJgDV2DK3y
         4RVF0smEnPxJ9pcNA2O8goExiZ295/2TJ0RM8xwIjNmadWjZT5FHPHIXuuy8AXTOJzXw
         qDy1Bn0aGEpndIAbZQpzaKPkSzUsiF1hK2zzjovxLDr2CcYpM+EeDEeLUcYrwr4DxpBN
         5uOTfWoO8F9STxUbR+aT70t10N+u86a+QcDsj5bVVRrhEea9CVls5tWqyyFVceZH+u1x
         pCHQycH5PZMrZ2zIkdSnOKrqIXJBb/VP4kIpr6yEBHxcXOsxiXNckRJHyGdyiyF3kJ0d
         0VNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680637890; x=1683229890;
        h=subject:from:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vOWWptlMwS7x0v9qMR/X7GZF8/y6INJkVuY+7+tB2Ok=;
        b=5+iEHppUnuqPHeqQr/8e2xvld59nJNLM/Gj3bW/74uY15VeOPKPlvkClkAlkSD0PWH
         TiYagXh7Nqgdkil6x1Q6I3XFUtFacHYBqAdT7+3/g+yz81i4nAvorAzYG5gv2qf2/zM3
         n6i266ajzu357kWFIQ7/PJwltGh4dJq14vgmaNNLoNfQqtcKmiaJ4TGDmdZKfD6LRmxQ
         AliGMKqIcsu3NvMiW1MWF422YoCHIx3QHPcPwJa/5LlziIb+uFkfkESd5elQFEZ7AGhZ
         g5GTz0m1zAvaYkPddVxJk12Abz/uEHUBbkL7yPXllltIXFHED5EJfdv/9lmRYixVzxh9
         +7dw==
X-Gm-Message-State: AAQBX9fjyzctcP9Zww0DUYyKXwWt21yDomvtv4IfcpwuVC7qg0sOQ1i2
        lf9+NcAdPkHcn29k2QYx/xgiFcTtDjU=
X-Google-Smtp-Source: AKy350ZUH+AhJtzt3t99zPhUvMuKD6YdVE+qvjEbRH4uSOO6GRHtalZiOu8cPVAHyvaY69ggS/yXUQ==
X-Received: by 2002:a7b:cd0d:0:b0:3eb:42fc:fb30 with SMTP id f13-20020a7bcd0d000000b003eb42fcfb30mr3107927wmj.32.1680637890271;
        Tue, 04 Apr 2023 12:51:30 -0700 (PDT)
Received: from [192.168.0.160] ([170.253.51.134])
        by smtp.gmail.com with ESMTPSA id j23-20020a05600c1c1700b003ee443bf0c7sm23159227wms.16.2023.04.04.12.51.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Apr 2023 12:51:29 -0700 (PDT)
Message-ID: <a0b6d751-25fd-a132-f8a5-9844e5d9b8a6@gmail.com>
Date:   Tue, 4 Apr 2023 21:51:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Content-Language: en-US
To:     Git Mailing List <git@vger.kernel.org>,
        Alejandro Colomar <alx@nginx.com>
From:   Alejandro Colomar <alx.manpages@gmail.com>
Subject: Dubious diff using --diff-algorithm=histogram
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------87Nq48cOLlF1Vw37cCeg5auj"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------87Nq48cOLlF1Vw37cCeg5auj
Content-Type: multipart/mixed; boundary="------------2JqdZMn5Lb09me0t7YKvL3UE";
 protected-headers="v1"
From: Alejandro Colomar <alx.manpages@gmail.com>
To: Git Mailing List <git@vger.kernel.org>, Alejandro Colomar <alx@nginx.com>
Message-ID: <a0b6d751-25fd-a132-f8a5-9844e5d9b8a6@gmail.com>
Subject: Dubious diff using --diff-algorithm=histogram

--------------2JqdZMn5Lb09me0t7YKvL3UE
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,

I've met some strange diff with the histogram algorithm.  I know this
has a lot of magic in it, and it's probably not so trivial to improve,
and maybe my code base is so weird that it makes the histogram do crazy
stuff, but I wanted to show it to you in case there's anything that can
be improved.

So, patience is showing a better diff than histogram, which shouldn't
happen usually, and less in this case, where p++ is such a common thing
to do (although maybe this nxt_slow_path() macro is called a lot in the
file and confuses the histogram?).

Code base: <https://github.com/nginx/unit.git>

Cheers,
Alex

---

alx@asus5775:~/src/nginx/unit/space$ git diff --diff-algorithm=3Dhistogra=
m=20
diff --git a/src/nxt_http_parse.c b/src/nxt_http_parse.c
index 8646a6ce..92bdfb1f 100644
--- a/src/nxt_http_parse.c
+++ b/src/nxt_http_parse.c
@@ -340,10 +340,10 @@ nxt_http_parse_request_line(nxt_http_request_parse_=
t *rp, u_char **pos,
=20
 space_after_target:
=20
-    if (nxt_slow_path(end - p < 10)) {
-
         p++;
=20
+    if (nxt_slow_path(end - p < 10)) {
+
         if (p =3D=3D end) {
             return NXT_AGAIN;
         }
alx@asus5775:~/src/nginx/unit/space$ git diff --diff-algorithm=3Dpatience=
=20
diff --git a/src/nxt_http_parse.c b/src/nxt_http_parse.c
index 8646a6ce..92bdfb1f 100644
--- a/src/nxt_http_parse.c
+++ b/src/nxt_http_parse.c
@@ -340,10 +340,10 @@ nxt_http_parse_request_line(nxt_http_request_parse_=
t *rp, u_char **pos,
=20
 space_after_target:
=20
+        p++;
+
     if (nxt_slow_path(end - p < 10)) {
=20
-        p++;
-
         if (p =3D=3D end) {
             return NXT_AGAIN;
         }
alx@asus5775:~/src/nginx/unit/space$ git diff --diff-algorithm=3Dmyers=20
diff --git a/src/nxt_http_parse.c b/src/nxt_http_parse.c
index 8646a6ce..92bdfb1f 100644
--- a/src/nxt_http_parse.c
+++ b/src/nxt_http_parse.c
@@ -340,10 +340,10 @@ nxt_http_parse_request_line(nxt_http_request_parse_=
t *rp, u_char **pos,
=20
 space_after_target:
=20
-    if (nxt_slow_path(end - p < 10)) {
-
         p++;
=20
+    if (nxt_slow_path(end - p < 10)) {
+
         if (p =3D=3D end) {
             return NXT_AGAIN;
         }
alx@asus5775:~/src/nginx/unit/space$ git diff --diff-algorithm=3Dminimal =

diff --git a/src/nxt_http_parse.c b/src/nxt_http_parse.c
index 8646a6ce..92bdfb1f 100644
--- a/src/nxt_http_parse.c
+++ b/src/nxt_http_parse.c
@@ -340,10 +340,10 @@ nxt_http_parse_request_line(nxt_http_request_parse_=
t *rp, u_char **pos,
=20
 space_after_target:
=20
-    if (nxt_slow_path(end - p < 10)) {
-
         p++;
=20
+    if (nxt_slow_path(end - p < 10)) {
+
         if (p =3D=3D end) {
             return NXT_AGAIN;
         }



--=20
<http://www.alejandro-colomar.es/>
GPG key fingerprint: A9348594CE31283A826FBDD8D57633D441E25BB5

--------------2JqdZMn5Lb09me0t7YKvL3UE--

--------------87Nq48cOLlF1Vw37cCeg5auj
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAmQsf7kACgkQnowa+77/
2zJ4wBAAp77sRlDA7atv65ZjLwjGoq7ipNJH1J35t+kJXsynFs9MUxA0GS0mIZJg
gfp2O/gN5Ji49YMAFoE1F+B+FXUQzRMtz/H/mJ03ITeLuPIMDd7TyKZwsWNYO/qh
zNrvJcXShl7GRunE4R/uQRSBqgSdZr8HKKjCRow2ns6MwDY0flY7HMLqurb+pQrt
CdALQwiEaCprdeRzi26+QE36kThr8uvN71NpiywWYlcKWZHg85m2v8yvijPjzFxG
TC4kHyz0rFr1b6pnNHDw8TtvdGRtU5YTnzojwJldurSYRbAi8yBiywgWGjG9Go9b
oqeJGN9b5hv6ykXc1Ug4ILSuHQzr5goJjUTlttxM/tw/9qJUVR/6/S30acpSSLv8
/rJAl/vJE0GHcTUtse/a/wvxKDF9aT6/x5i4XKojK3TG5dyEN5yYGOHC0jHvA+oS
Xw4OXH/AgteEa+QnAhhwMHk/5kCiJWxD7/2Ds5ELhoeX4ud5B26AYwzO4BjeDC0f
69uFW8FVkZBpQTg8P7hjVHRrxjbIiO3p4uGYREBtV0k2EJ8XzUHgeU6QPtQ9i5bp
LeRwIE2ovHPndMnY8jhqKDynGuMlHos3Z/q+BvHHeS9J6L1D8V2bqlQDDjVA06+W
EkjCEkAQi9+jYW+JwCXdxKoTr7+j/+Dl1fcQeGP2a36bHt1vmD4=
=/Hv5
-----END PGP SIGNATURE-----

--------------87Nq48cOLlF1Vw37cCeg5auj--
