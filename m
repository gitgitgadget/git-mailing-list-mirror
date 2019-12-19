Return-Path: <SRS0=FxFb=2J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3E99C43603
	for <git@archiver.kernel.org>; Thu, 19 Dec 2019 17:35:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C878821655
	for <git@archiver.kernel.org>; Thu, 19 Dec 2019 17:35:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="eHPMuCSh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726903AbfLSRfx (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Dec 2019 12:35:53 -0500
Received: from mout.web.de ([212.227.15.14]:51247 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726818AbfLSRfx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Dec 2019 12:35:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1576776944;
        bh=3ouGd0to6hqX4/uiciHkCMbVg+IU+p6kq3CwmajmQJk=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:References:Date:In-Reply-To;
        b=eHPMuCShWLOOUbTemrO62Ui13tz77PZmp60bhlGkglXzDgMkg08hWYPi3NElMAWPQ
         mu3MECgCHgTR65HFDR1NIq+2O7BCNR1Xc/HD4ZFrmthEw9onb2+/wZlLDPAGMSdyHl
         z5tmb6VafTR2QY9Z1MjZTlITvp6kl5g6IeZoQcuw=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([79.203.27.9]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0M2dxF-1hrwxR2g4r-00sJc0; Thu, 19
 Dec 2019 18:35:44 +0100
Subject: [PATCH v2] t4015: improve coverage of function context test
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
References: <fedd48bd-28e8-ccc8-ae50-42d9b2ea1c16@web.de>
Message-ID: <86fbb0fd-6b77-5d11-69cd-f0994a8ed759@web.de>
Date:   Thu, 19 Dec 2019 18:35:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <fedd48bd-28e8-ccc8-ae50-42d9b2ea1c16@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:BVY0KwAZJ1La/3hMIJo//gEJNbHTwDHw2BJCOwvOVtC5hJZNLSD
 M7H9LpjQOb4IhnCXC6qcOhwXzY8WJXsiREc31rHhfys4F+YMYjbNGql5+0X1c9dZCZ+3NoT
 u1owcuWdTzbxfwjHrKjCYAOtoJigbbUDtqD4YmX2l5E7BD/cVnQtuDKpgXuxKEncCkvbQ1V
 PQer2UZ2VySvNh5xqMXqw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:lwcZwqvTXQA=:2GE7fA9G93FgqG6oWplogC
 FZy2ns/BhE6aP/yjEJdeN0lQ+0iM8OmnBvjt5Gy4KWEO+p8Irh9aXvtjzOZS4RXHca9spJ4Jo
 EE6pQfwai77joYqIZ0u0KiZ/hLxj+7HGbZ0GlWplqhUMmPFOiNqDzbRc0xj/C+H5zPxcdzbc3
 Jf+uinc3HUBAI4KpZdqEEHcVp9tyBK/B0z/WgW+nMXcvqdhOstSNqwMYBwWrK4pZD8UdUkWQC
 e/hMT458Q2WYIv09DnvAMfss2u6IHiAAkx4a8hsAcUAtM8UEuFf/7qTHZ+wyEeqr2zDPByYRE
 uYqClv+QS4+EQHlJ8bFqiZiBB6KV8lZiLfuGwXQ7XBJMyfzbVSYrRDfk3kLopWbkDUyO/DukW
 T/UYw+TcMxqeWnFgAJyX8VzqhogexVjs39+HKxXb9a8FteAKtQWaiAPLW5XddWbIPJDEnm4Lg
 W2RKIi4OTNvMe5jo3l0GRtGGMthJOBleGC6sbtkQGGOLNLKwXPL3DNlrDjNX60nv3i9FzYUHm
 5omPj7oiGboZ47mc4n/nZww80EbMe4/dRpbLzVthfYnKg09cCg3hjutlnqBI8hhfw0+KGg679
 URb4P2agW6mBuYzwskrWhBDdHeiVqyNKDguP+hKFc20FJmNHI5sU8AIk9h97/cUUTCEcWnS29
 s4ztiko0vkstX8l+jToFG7pwJCUqVU+CPFrIUOz4i7FI4cEC2WtjrVSO1Uup+JQQ7oWIE4nw8
 jkPpK8+7F11PSvACncXTB3lrV9DyfMhsNhkub2faJTzy6oOrqFp3X5+6fYF8fky0wb+FMacn7
 YFWcO1GKkHKRI0DPEpRvUxo531eURBpEgfnVgmor7oHdmFdYQNn4uWcmgxiW9Or13/OdCY9BR
 mHHlq/fAAET9XePOQ2ztKCEaCtNtT/xWExFY3vDo4WoDu4HH4dFdkig+JhltJFCaqAmVgRW6p
 GB5qx6DuhXTZfUFMvWDpBp7onSoS+GRDzHAzDM98AtsRU5Nf6CjA/odgN31V/4a4iU6o7NUjp
 jmipxhTp1h4dnr8pItXW9jTnR6M8TJsKTsFf6QPuVpjLgvJr2lj3V51h1PQJsYEFpzZ4nRxLr
 zDYyOw/dxPbURcXqpIl1MmzIf9pgDUtDR28xvn77qzF2rWGoReA+sy3FdE0jzTh6AQgFWpLpf
 XEp5gkFsUguz6BG+pGN+Xb8ECr4vyBtmJBFO1Ywbg2sdlb/cDYqdu64hOiXVg4mxtjDKGr3qX
 VdRJ5ky5Cy9DfkAt78vCto2ttEnFq/dVN2zj+/g==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a test that includes an actual function line in the test file to
check if context is expanded to include the whole function, and add an
ignored change before function context to check if that one stays hidden
while the originally ignored change within function context is shown.

Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
Changes:
* Keep existing test intact, add a new one instead.
* Use unique content for the part before the function context to make
  clear that it's independent.

 t/t4015-diff-whitespace.sh | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/t/t4015-diff-whitespace.sh b/t/t4015-diff-whitespace.sh
index 65615e2fa9..88d3026894 100755
=2D-- a/t/t4015-diff-whitespace.sh
+++ b/t/t4015-diff-whitespace.sh
@@ -2068,4 +2068,27 @@ test_expect_success 'combine --ignore-blank-lines w=
ith --function-context' '
 	test_cmp expect actual
 '

+test_expect_success 'combine --ignore-blank-lines with --function-context=
 2' '
+	test_write_lines    a b c "" function 1 2 3 4 5 "" 6 7 8 9 >a &&
+	test_write_lines "" a b c "" function 1 2 3 4 5    6 7 8   >b &&
+	test_must_fail git diff --no-index \
+		--ignore-blank-lines --function-context a b >actual.raw &&
+	sed -n "/@@/,\$p" <actual.raw >actual &&
+	cat <<-\EOF >expect &&
+	@@ -5,11 +6,9 @@ c
+	 function
+	 1
+	 2
+	 3
+	 4
+	 5
+	-
+	 6
+	 7
+	 8
+	-9
+	EOF
+	test_cmp expect actual
+'
+
 test_done
=2D-
2.24.1
