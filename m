Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 50F671F461
	for <e@80x24.org>; Sat, 22 Jun 2019 10:03:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726307AbfFVKDq (ORCPT <rfc822;e@80x24.org>);
        Sat, 22 Jun 2019 06:03:46 -0400
Received: from mout.web.de ([212.227.17.11]:56617 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726112AbfFVKDq (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Jun 2019 06:03:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1561197821;
        bh=+Yu8FSqRF/lMv39rDznxXiDo0anhBi4oQmj0LV4sHng=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=JxaNyB6cGcGjZecBlCeZTgzH+R1Cd874+nw3T9nXr3PgfKWnFEWLa0OMzUR8QjMfW
         qXz8wqaOp6dPhI4wv/1pSpA4DcL9t3oNOBaa+co+CRFlcKOhC+3uBh3p5j/Yj06ZA2
         cJVtwoxYRysoXo5dCpQiJGcFEEmf48ixTif8KFro=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.23] ([79.203.26.169]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LbJ4A-1iKnIt1a4g-00kvls; Sat, 22
 Jun 2019 12:03:41 +0200
Subject: [PATCH v2 3/3] config: simplify parsing of unit factors
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
References: <pull.265.git.gitgitgadget@gmail.com>
 <9613c88849e53e00e1f7ade49c6c9056309ef0b9.1560426581.git.gitgitgadget@gmail.com>
 <03a68560-8058-7436-6edb-38e276a37190@web.de>
 <f22599d4-148f-212c-282c-790f5bde1706@web.de>
 <90ef3797-78a6-f6d9-443b-387c0ab7cbe7@web.de>
 <xmqq7e9ltbe2.fsf@gitster-ct.c.googlers.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <7a0ea32c-f480-4aa9-d258-68a62373d916@web.de>
Date:   Sat, 22 Jun 2019 12:03:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <xmqq7e9ltbe2.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:CNFzCk/T5MRogAF+Ugq+Y3M/lZvVVqbTGDeE+mZKFucOiCNGVPl
 weFeNEqstqdoObbDc0Rh0Gv/BHriT/jtCAPH5wlFlsArWrjag7Y5N0ezm4dBzGnWCzsvFcj
 dEbblJVOwfA1tVEnGyEA8B1MGaw85+9gHFGRND2f9XDort/Nj7EQg0upXSdQ9ZsZPcV1v2r
 dpLddXsVK0FJShhyysBzQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:58BoxgAQ314=:ERO99LQ0P9VZV98rO871Vz
 IlE8zY1sC0Vx6hy3kzDcveg4Lx7bpqk/zEeWLW+n4HeMIMaiCY8Cjuteea0MQUqavJgHL3zSI
 is6A7f9y+i6m/1kTkT55sBOnFfaZjhqKbx17fn4VBVnIr2ZuiKc1AOIRFtpq9bD/ge+MQNw00
 bXhCc0J0aC7HO5v6CWB45ZGKaRm7nVAOQhQWgq1/toZovaNJOa5ArPaz6bhPhVAxYybg5LArz
 6GqABztKCtHJCV+ecnOLfGxl1Evii0Jut/v5F+vWFTjLvNySibhaumACutXA4yBedZxpj2/wq
 ErEa/aNcFZa+Wj2ERB39rwkTwAnibvmfB4ufF0DSlzKULnslNhODJXJRwz+U99zt1bKExY/BT
 MNK2owBu12cewV872y6UfCw+lDkKPd4RFa1BO3gfPTFhltdWbYsBC8HFs/+RANlJYS0HP7ccO
 8n3D8pGhHJXdBQT2XAZ8oP3qW/gkL0fsY+eeYCSKczaKFXZAn3i7tU+pH0x8ao204OiJq2ul0
 zibManlpj55K/ah2ecLWmtiGYQsG2Dtqt/9RMaSyK7sZ7rOB3zL0NbZoXXEaHRHQSQbwFlRUB
 FPsAy/dHWBQl8bchwJvl55NiCfoDZ+1S7fT+yJkIwoiflWPgS2DKUI7yHy2sWwvQOzI7EFNA9
 3nawuNskPBrXS9/HgLsfMVAX2rpqFqyXMa4yzPQD5CiUIo6I87r1mHXrVovdYJ7YhBxtfwEJS
 5ZyBKg33XGvL5pPznTMX9KEcXUG+k4LFtIvAkfK9TlAKY/VW90oXSTG+ttbzBnR6PL/gHm4GZ
 5YThL19p4xaMEM3pOYKsIEfkZymMLbUplL8xtzoQo/6CFs4/202m4iFrekn1Nm3FKttX/Ti1n
 t5OIpy/JbKto82sAbDs/nVGyjGJfJ3VxM3pOICF21JVEbk7Y7QSvSR+Pi4em84yw0E1GNa+bk
 TNFNHYDlmQ7PtPVL+Q/uRLDQLAv9ynFs=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Just return the value of the factor or zero for unrecognized strings
instead of using an output reference and a separate return value to
indicate success.  This is shorter and simpler.

It basically reverts that function to before c8deb5a146 ("Improve error
messages when int/long cannot be parsed from config", 2007-12-25), while
keeping the better messages, so restore its old name, get_unit_factor(),
as well.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
=2D--
Change from v1: The "else" is kept in each branch, even though it's not
needed, to match the original code from before c8deb5a146.  Other than
that this series arrives at the same end result.  Patch 3 can be
dropped easily if it's not convincing.

 config.c | 30 ++++++++++++------------------
 1 file changed, 12 insertions(+), 18 deletions(-)

diff --git a/config.c b/config.c
index a8bd1d821e..26196bdccf 100644
=2D-- a/config.c
+++ b/config.c
@@ -834,24 +834,16 @@ static int git_parse_source(config_fn_t fn, void *da=
ta,
 	return error_return;
 }

-static int parse_unit_factor(const char *end, uintmax_t *factor)
+static uintmax_t get_unit_factor(const char *end)
 {
-	if (!*end) {
-		*factor =3D 1;
+	if (!*end)
 		return 1;
-	}
-	else if (!strcasecmp(end, "k")) {
-		*factor =3D 1024;
-		return 1;
-	}
-	else if (!strcasecmp(end, "m")) {
-		*factor =3D 1024 * 1024;
-		return 1;
-	}
-	else if (!strcasecmp(end, "g")) {
-		*factor =3D 1024 * 1024 * 1024;
-		return 1;
-	}
+	else if (!strcasecmp(end, "k"))
+		return 1024;
+	else if (!strcasecmp(end, "m"))
+		return 1024 * 1024;
+	else if (!strcasecmp(end, "g"))
+		return 1024 * 1024 * 1024;
 	return 0;
 }

@@ -867,7 +859,8 @@ static int git_parse_signed(const char *value, intmax_=
t *ret, intmax_t max)
 		val =3D strtoimax(value, &end, 0);
 		if (errno =3D=3D ERANGE)
 			return 0;
-		if (!parse_unit_factor(end, &factor)) {
+		factor =3D get_unit_factor(end);
+		if (!factor) {
 			errno =3D EINVAL;
 			return 0;
 		}
@@ -896,7 +889,8 @@ static int git_parse_unsigned(const char *value, uintm=
ax_t *ret, uintmax_t max)
 		val =3D strtoumax(value, &end, 0);
 		if (errno =3D=3D ERANGE)
 			return 0;
-		if (!parse_unit_factor(end, &factor)) {
+		factor =3D get_unit_factor(end);
+		if (!factor) {
 			errno =3D EINVAL;
 			return 0;
 		}
=2D-
2.22.0
