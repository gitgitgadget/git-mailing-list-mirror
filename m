Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E580BC64E7B
	for <git@archiver.kernel.org>; Mon, 30 Nov 2020 19:29:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6494D2067C
	for <git@archiver.kernel.org>; Mon, 30 Nov 2020 19:29:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="AHKjFHZg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728887AbgK3T3n (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Nov 2020 14:29:43 -0500
Received: from mout.web.de ([212.227.15.14]:41719 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728899AbgK3T3g (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Nov 2020 14:29:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1606764456;
        bh=toAVTDF6tCjnpRZhcIrBV6ZZwZ0XRYpOk8fFIo080j4=;
        h=X-UI-Sender-Class:To:Cc:From:Subject:Date;
        b=AHKjFHZguiSSmQ42hWTTSOlzuHHCxxAUyOJjSnFW7UAz2XsdAfWen6Js0Zv9GHYgN
         USbxTwF9MDNmL5adNNJRvDinMyTwlnj0GjmiylcNYUG110ah/H6C7VrOlzMIIxcJQE
         Z4KCuDu9ey4C30Pa/Ye1aoxE08E7fgJ6lyYLZLs4=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([79.203.17.45]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MbQfs-1kR2zs1iRI-00IoCy; Mon, 30
 Nov 2020 20:27:36 +0100
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] fetch-pack: disregard invalid pack lockfiles
Message-ID: <c54233ce-ff72-ca29-68c2-1416169b8e42@web.de>
Date:   Mon, 30 Nov 2020 20:27:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:bQNyej/ZH3GuDvl/DZsld+78YP5leACqRVcWiJgqbZhz44lN21F
 WPEUrRLuAxLN+t2bjw+kJz74Z0AtfJ4TLhqQt0uqR81puOtjq2wVf73LALwUkfqO1MKP9qa
 Cw1FgF0DuOgYpZJjRg+7jb1B3+Cw/JslNuQE+7ko1TbGlvqxc8PwEMA+MI91mZA1IQcAqAz
 Yb8IlQ4Qtq0bPV+Nsiqjg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:hhHJt0gyXcc=:9wWO2FE2uc/hpDSePVAasr
 UQg6IeUXKAjQc8RsgcNT4ryEIFIxhC5Q3VWBQP2H/jLqRhzQtsRCXCsCOEmVj30+AwlTuHObp
 9ocsh5EQ2fLHLJlIeU+JWCPuFij5Ky2j67546OqSdX4wJ48WxC9tSqy7JyvGDG+bpomLtagvJ
 Hm9MpyqcydLfYG5PyzXEbEK+TF2gtDTpZ4kZD0Q31oOITHlV+D7iXPDdJ4cdrL5BRdpk8VpvE
 jxforgNLxd5bkV7CYHNEwBtfcwmR/diefnHh4uWsIDQUFrPbZzKiJMJsTwxqXCrHJjwXM9Vn1
 b4f6bw9TTLWXCYl5NClNSyP6Oy/34WU54YHWyXpj5mWqLNsJ0hMSTXx7oVOSPmUZT5OAL2zHi
 qhVUvMn/x8My3T8DdowVA6qlKi6yWmjSG9fbD6byZJUnaPMhfCCSv3DXq8psFoEjzN+pe9b3A
 s8Wm2RYCn0D/uzQTUxW2RacLFc/UMF8fXO36xI64Vzlj8WdhytDYz3/21njXSzR8Fb4Owxd6L
 lT9cx/GTKjL+RZDz7GhEIUKTGMCHuFtyVPp4wNGv32QAVag/B6P1PKun2b4+PqCVKRnAltKpq
 J0SKmahomd2/7HMAXnJD/zeZY9zU9CPv1BNd229pxgXLgR0rQ3AW7Wo45ApZNAYf0SIk+zQKM
 WgDEKe7m/Jrxge6rwemfM2/ROSkYoWTLT2cNRi16Oc1We7eedCxtR3KiYYsHWg78Wt/3zSeBZ
 aJKjpnRyXSBcdDDUOYtfQyKKicwhSs2OuQiFri/dTGa6aLwxeOlVf90CkVjlh+bKFL0gThTAy
 61voQcGvo8jmOGNNQYJOvn25GMuBM8zUXpMeMwweH+WlLFwGikzguGdLYIsEDfTUi8ZNXU1Gz
 6N2sLn+TaYV5VWyG7FuA==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

9da69a6539 (fetch-pack: support more than one pack lockfile, 2020-06-10)
started to use a string_list for pack lockfile names instead of a single
string pointer.  It removed a NULL check from transport_unlock_pack() as
well, which is the function that eventually deletes these lockfiles and
releases their name strings.

index_pack_lockfile() can return NULL if it doesn't like the contents it
reads from the file descriptor passed to it.  unlink(2) is declared to
not accept NULL pointers (at least with glibc).  Undefined Behavior
Sanitizer together with Address Sanitizer detects a case where a NULL
lockfile name is passed to unlink(2) by transport_unlock_pack() in t1060
(make SANITIZE=3Daddress,undefined; cd t; ./t1060-object-corruption.sh).

Reinstate the NULL check to avoid undefined behavior, but put it right
at the source, so that the number of items in the string_list reflects
the number of valid lockfiles.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 fetch-pack.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fetch-pack.c b/fetch-pack.c
index b10c432315..4625926cf0 100644
=2D-- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -915,8 +915,9 @@ static int get_pack(struct fetch_pack_args *args,
 	if (start_command(&cmd))
 		die(_("fetch-pack: unable to fork off %s"), cmd_name);
 	if (do_keep && pack_lockfiles) {
-		string_list_append_nodup(pack_lockfiles,
-					 index_pack_lockfile(cmd.out));
+		char *pack_lockfile =3D index_pack_lockfile(cmd.out);
+		if (pack_lockfile)
+			string_list_append_nodup(pack_lockfiles, pack_lockfile);
 		close(cmd.out);
 	}

=2D-
2.29.2
