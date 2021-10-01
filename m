Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 964FFC433EF
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 09:19:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7524361A05
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 09:19:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352927AbhJAJVl (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Oct 2021 05:21:41 -0400
Received: from mout.web.de ([212.227.17.11]:55749 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229681AbhJAJVk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Oct 2021 05:21:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1633079991;
        bh=v/OvrM/HVyePSlOY7IhwJjEDPmtLc9DUT0zljf2IDJI=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:References:Date:In-Reply-To;
        b=EuWtUL2koIoYxIqwcOm7YcnuLmRKXjij7W85lEjCS+l9tF1aGt61oAVe9NE+F2FlO
         7aJO1wKbRHqi4CEOqNgHx8SW1k+2V0f0Ozb2dgdNt7M5AGxHVkzSCiysokrBj2Lqj3
         ow49l5hHiY8KPYKS6EnQPucYljUrHKwZBKYMA9dg=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from Mini-von-Rene.fritz.box ([79.203.20.171]) by smtp.web.de
 (mrweb102 [213.165.67.124]) with ESMTPSA (Nemesis) id
 0MBkLb-1mdhLc35HD-00AmHO; Fri, 01 Oct 2021 11:19:51 +0200
Subject: [PATCH 8/9] p0071: test performance of llist_mergesort()
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
References: <943b1e01-465e-5def-a766-0adf667690de@web.de>
Message-ID: <9ecbd8c8-2907-7955-0b85-f9bbae8475d1@web.de>
Date:   Fri, 1 Oct 2021 11:19:51 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <943b1e01-465e-5def-a766-0adf667690de@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:rwHQTJ4RAfwpTnK2NncBIEJuNp1fM8F7U3Oio7QD9ywdzw+QWsr
 AEMzZLuFcQm9pv1/RxmS4N7c0aPPWqpJ5B1yxN4PgQZP7BGy2JY0jd5ugV5xsApbxBL0min
 Jx5YISalrXS1uOcpaupVCI2mPbSNVTpWweQTrkh+tDgY2FHM9HuRlKflNyvdW3PS8PsT39g
 PXh51af5qZWqdCn8fWfBA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:F2W+qKeBMHw=:zpNeRHjAQVAtkqJHaAb0z3
 HgABrTlWq6CIRkuEtU/Lqar1LAEgOP6FBchDkaKNzMJT9aKBw811oeD7IPkiUvZxZTjfF/J14
 2EzvwGWRHindsXmISkBHoXtYqSu7j6iePlO4kfgOnfVVSu5rh4Guf6HCBaoTysG/bQcm0bYWK
 qExFeAnQM3Cm8gzcqa5hAHgcmS36eXcrLHCpepSrTGTZWuk10/0noaHa8pAfi0Q1y4HW2v/vv
 ZhWvMlhbtJfcs2bCZMDAXh+YUVQtPEBsH8KrUVjcJFlA0h+ArNYceBaUsvJuY6V9RC6LEkWcL
 fY9fWEQjKSkl0DyOxJdNKHefmGnsM4xjDfAliwjRLzAP+p37XfrrTg9E2QLKt1p/jZcST4IQI
 7YXJit+zjckYW5VMyg6Csm4AeC5ah70u36MMLWWIBqwcbSFexHDHmg8vGfz5cRxwzAcPP22gG
 aYt2lDAxboR9m6wp6jxhthccikKdGP/SDESEywTwGHYOUwC/T7Wi1CmDYreXi+8EZk5YNObQK
 Fr8w9iaBweP5QkHlnHNANw2JNEbCagLB+AWpGi28N8i7QgVbBI48eX/wTpbunIienQkXzlD0y
 WwzxO9RXeM5AWq+lg3TFY/KJNvfGd2f3/RI/iyjP5uFS3EQ3YiN3Bi4dUGkjlnpS/ky8YniKe
 cohWgZBZa5a6euiHi7CdzzWm46hSrDgOoeRwWPHT3tbikJgEUyC8MUPFjKQFgpPjF1E3eWZsd
 GzrctBJVbBfeFvFGewQ7FNXExKFjhb8UKUl4RR5is8CoBgw8Gli0hcERhAswt6md8I/74krMw
 OZrs/UEfDipYsgrpV4WLNRvl7w6C7nLMzqfyLmW2Fb01EJROOann4sezIIljSL7CKTwjeVvNE
 MRwj8GLAl6TcUKsjtKuYjfECzNaHYewTvelRodV7sx/s5+dwf2gNMX4qUNG6V4P/ldJbvrOeS
 Y/JNVlSZDo3SuN4F9e/b0LxiWqn1YG8M+MHBseOBLm+31dUtEZJ5QgZDO5tbXt2EN8estfWUU
 ubOnzJs3J9Vfa7VsyY4hFPDKLKbqiLwAmRavMYawl2cjU/KbXzAUF4amKd9oxxmKEyOvnUyBd
 fjrkZQFdSrH9H8=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 t/perf/p0071-sort.sh | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/t/perf/p0071-sort.sh b/t/perf/p0071-sort.sh
index 5b39b68f35..ed366e2e12 100755
=2D-- a/t/perf/p0071-sort.sh
+++ b/t/perf/p0071-sort.sh
@@ -38,4 +38,15 @@ do
 	"
 done

+for file in unsorted sorted reversed
+do
+	test_perf "llist_mergesort() $file" "
+		test-tool mergesort sort <$file >actual
+	"
+
+	test_expect_success "llist_mergesort() $file sorts like sort(1)" "
+		test_cmp_bin sorted actual
+	"
+done
+
 test_done
=2D-
2.33.0
