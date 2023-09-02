Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB1FCC83F2C
	for <git@archiver.kernel.org>; Sat,  2 Sep 2023 18:38:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231451AbjIBSik (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 2 Sep 2023 14:38:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230465AbjIBSij (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Sep 2023 14:38:39 -0400
Received: from mout.web.de (mout.web.de [212.227.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7559D9B
        for <git@vger.kernel.org>; Sat,  2 Sep 2023 11:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=s29768273; t=1693679914; x=1694284714; i=l.s.r@web.de;
 bh=cFS9Wzw0gJ1Ry1BnbRqo5hdGxLdCIwaWEz4mOn2J2UU=;
 h=X-UI-Sender-Class:Date:To:From:Subject;
 b=XlnIiyJkSikgli/BLcDNbFN2J2Cvv16/Siw19o3TepAwRtpecEBFngHlNk+MZJdP7IAD/Ln
 EC0NzSKAcpg+dDpBR1TaXJV8dPn+28UiYT+NUkkUGx7Bdf8eaj74NtnU0Z8Aqa+HhBNmJL47N
 G2F/skBhjekKElaMgY0sbHWxx6tB3TKVjKe+NNytMfN0dOJg6RM+B/f4khw2eHiLiBV2TIl0z
 IfjKhbNWtZUM6Dp1Wop/dzZqTHgdWUw2srmJByuIvsZ0MAUU0xEw4cbl9yJTki9ucPRTOyvLt
 38GnBJT6jZMN7etJrnv8Uc87RNrz9Rxlh2Z7WWA9+ylwDcwbgFzQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.152.246]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N5Ug4-1pa9iK2BWU-0172iD for
 <git@vger.kernel.org>; Sat, 02 Sep 2023 20:38:34 +0200
Message-ID: <5a86c8f8-fcdc-fee9-8af5-aa5ecb036d2e@web.de>
Date:   Sat, 2 Sep 2023 20:38:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Content-Language: en-US
To:     Git List <git@vger.kernel.org>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] name-rev: use OPT_HIDDEN_BOOL for --peel-tag
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:PFOJzgipubUxR0FFsKZCt0u1e7M4BpGZyaWMPkjQsxxiDeF9cyn
 R03oxmW6+xMHE6WlrOqUff8gqxst6wUmmp6y/wOK+Jv9vmJljAXQ2QVTOTeTXZpSc+Qqpmc
 oMljTjjeIthepF/t9byJvyFfaPGk6h3p9FwWhPF4/lb7KHsPhCmxqn36uhFCuDFvO8te54k
 t2K/T27yP3ZlIJ73WFvfw==
UI-OutboundReport: notjunk:1;M01:P0:AVd+EVyXHt0=;jXQFUnjbDoUnK7eMw/uC9zm2s4f
 1ngxeNN6uKJKBQQSvv6r92qsDvJoungGO7ysmncqDncts0Q6znYopyWNeykJxGr5jzh3U4pzL
 JiO2QotlM67VItbWVsDjRtowuHTEuWxtOb7FIMsNNsnYo9UsUtF5E0rIziuOeRhiPH+hL1KoT
 wNR7vGdOitE3v7nh8u9fi8/rseMK9Tlhy8UowfqVFOLn4NAM6LR8e5zEsmcigkB/1nACTn64G
 3TurACFS/pndz2vqNsM9xcQPkeQwhJXoBQGgAxv91AxGOHbJ30lL0U3t2hgB5+imoCGxDgWPp
 TXa+mTO9TRoy+WWVvY6ykvnbuMguX/hbkGqVhPuZuh6sBsguNRdXXxrC4DfOl3ojFXwZZjIxo
 Yqm/P/L0KJJoOLnH98y13ePX8v/eBSFgAvkijYOxc3WzxBevcZ4jxWB0st3FNmBAajanQQqF5
 3aWLpbjlhZFWU24IsMehqzovseQfsR+oHCs9A/OjesrrwQuuZOe5eqmG3lAIJbKAxqmXNomSr
 8vSol3odfypOa+erppVtBBpnXt8bRZAC0soUIfLKdsErQ//FHE/HrayqHUrvtRhc2emmRnsRV
 4UpdMU8Li+M2Nre0lWcHrs4a/Bp5xVI1eyFwbjnGnMh+jy4a3/QLok3dAEpOjy8r9VKItQV7h
 pZbi5SKybpRDYNqR006oW6OWPw2hVDCEcVufxG212L3Z6Jc/OwvNdUBLA4pMxC3i7tfp+5qYx
 MugXpylvfFE7zvJpVaiW6o72outeUVrxW/6DRo4iNtTTtvuX/ZhghcPm0+Q2NNc4kyg2hv/bN
 LsuyePD+kS/D1VC5Nwd5LuXrLhA5yQ3AuROol4BsFPgCi2X9rhYR5B06qTWtW2VZ3OP7BCoEW
 jw+yOBSDSAbwTuGUX1rMTIPOgrOfrWsWJ7y84b1R4yKXaXoD/5iogZo1efg+HPEbWQQV3x3P3
 9Hkt6g==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

adfc1857bd (describe: fix --contains when a tag is given as input,
2013-07-18) added the option --peel-tag, defining it using a positional
struct option initializer and a comment indicating that it's intended to
be a hidden OPT_BOOL.  4741edd549 (Remove deprecated OPTION_BOOLEAN for
parsing arguments, 2013-08-03) added the macro OPT_HIDDEN_BOOL, which
allows to express this more succinctly.  Use it.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 builtin/name-rev.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/builtin/name-rev.c b/builtin/name-rev.c
index c706fa3720..2dd1807c4e 100644
=2D-- a/builtin/name-rev.c
+++ b/builtin/name-rev.c
@@ -582,12 +582,8 @@ int cmd_name_rev(int argc, const char **argv, const c=
har *prefix)
 		OPT_BOOL(0, "undefined", &allow_undefined, N_("allow to print `undefine=
d` names (default)")),
 		OPT_BOOL(0, "always",     &always,
 			   N_("show abbreviated commit object as fallback")),
-		{
-			/* A Hidden OPT_BOOL */
-			OPTION_SET_INT, 0, "peel-tag", &peel_tag, NULL,
-			N_("dereference tags in the input (internal use)"),
-			PARSE_OPT_NOARG | PARSE_OPT_HIDDEN, NULL, 1,
-		},
+		OPT_HIDDEN_BOOL(0, "peel-tag", &peel_tag,
+			   N_("dereference tags in the input (internal use)")),
 		OPT_END(),
 	};

=2D-
2.42.0
