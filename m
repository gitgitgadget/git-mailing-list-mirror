Return-Path: <SRS0=tPyM=DS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 136A3C43467
	for <git@archiver.kernel.org>; Sun, 11 Oct 2020 16:03:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C84A720776
	for <git@archiver.kernel.org>; Sun, 11 Oct 2020 16:03:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="YYYjelYP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387769AbgJKQD6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 11 Oct 2020 12:03:58 -0400
Received: from mout.web.de ([212.227.17.11]:39593 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387553AbgJKQDe (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Oct 2020 12:03:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1602432209;
        bh=b7XtouWcvtCdulRYdaNwm3gNK9wuGZvnygXBy+A3CG4=;
        h=X-UI-Sender-Class:To:Cc:From:Subject:Date;
        b=YYYjelYPSL6la3s4RLG+w8EHNqfKzAMOiz4hvsknFsCLubPPa2VmJXReCfLd4XAni
         iWe/JoOMpfMxdmGknb5scRRtzT4MgqWEgAuOZB3Ly+YaYySQ/+ZlFGEjoPcueIP6yG
         kj8uDwGb4vFe/jxdy2s1z44BwaRZGUO1RqmhCjaw=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([91.47.158.172]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MRl5x-1ktzVw2ezJ-00Szz7; Sun, 11
 Oct 2020 18:03:29 +0200
X-Mozilla-News-Host: news://nntp.public-inbox.org:119
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] grep: handle deref_tag() returning NULL
Message-ID: <bd488081-390f-bad2-0fd3-c5c77ce57795@web.de>
Date:   Sun, 11 Oct 2020 18:03:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:St8x///RmZUXJMyJdGNZJEyPkXAsf+2C6mTLGuXewakWPDgqNS2
 e6x/c+6821xT385ito3MuQQZ3czjR+3GEgjDxs0ex/C68kiXXvnf6h6srQz+wRc/i32JtEb
 ILBSwOAWz5+jrI0SJCLEk3NXTu6nSdtpEEmuUappWwhNKetTnNXwAuLXSrdjJovIhkcIqp/
 Baof+7XdYb6Tcw0M8KilA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:JI58XIXdRPA=:kNStyXsLPbUNWZkeQ+BcoG
 YnjPL0UVrSUAEZKnOVvwkUK7TpSGN4oAKACh12gcCxqgrWi0m3JSJvvS8JT6YuMRmiHIhq0u3
 9paP7usW99QO1uhg01dpGnkvDnjHaB2p2v2+8u8kmCrFBJVwvyZXQyr4ZJLhxDbf2uv6RcYtu
 VCYY8baiTZM/AI9WSTamwvgVKGYJu9qWpPdHoZ2TcXAGI+TCGrNtqn5afrhpXaWCDYNGoMTWy
 71MK5zgjukH7IU9T9UPLGy0EvPeKSfdclrXOk9v80qSwkEouX2uKNJyJN38EHxFOtsN/ow+dJ
 fnvo4bjZNAxNBPkru8QwqDMUUl6KnPs4Ek8IhAYhF81PyD1Q2cHbnGeHHCENZ+C0Ab5gtak4I
 MjYn/KTwXB3dPxHOM5MXCAn84yC17WLPFD9guJJt5LGbzjYn6LkUp2D08mnPijB0lnlP13raS
 ah1Q0/tEaNabvq4E4izJkoLQmcs/1d3SkReneVlwonUk3uqi9Y/e8pnoNoT75v8GEV1YZmwgN
 WsWVN/iLxN/VDKkzQLpLdqplclMUAV/2576+p3Yc3tjVKO6TkGyTjAMjtpbfQ6tRpCOUqdvcF
 gdQVGYXaHxFZ/UlwHIPRNQJ10+XnDGh013QrjjNsfFd3gEuuQ6NClWeZOaapdeztkopuwM+na
 4Fb2t8vwt0wjwmZzUEGgwZQXwj8Osr2bD2nda9phH7U6pryn3O7XjMMo+KOoX5PPpWuCdSVij
 X2E5Lv5rvWF6eSC+J+Ovgm5y9De9d0YWRHh2ae6lRkSEp/QbIWOMhZlZt6lZLj/qxU5skbwIQ
 ynUVpOZLnW4WnQoAz+fct4IDAnbjlC7oLnALFyceXo+LS78mjFUKFshiCSQiOGLKInkhMlDbe
 DPYQG2aNojmqPM5eoMbHa4LJdrpdP86V4v6Ve/UUsRSrD1SSR/jMxxedOhx0NBiT7CHjlvyAZ
 v2w/G9fLP1wipO5tdn9ewcjtTmyqntnJPzg/aG0wV+YSstHE9D+OzIIXuGt6w+3BYF9hSU/hL
 99DW88CpPPD56yVwS1abNEOhRANYrNBAfj4zJXzysZVCyyRWCxirb/eBwC4Kl4OGrf3oDep2P
 Q77pSRHJ8u88REbu7uO+AZhy10EQtY5nO5b34q7G/pPWfnFhP57UmQ7YLgQIgZN6T0u/BEqWF
 6YZkns6EI/e3pTte+YeLhYG0o86m5Ko+0ke9s9bxTrljGtrB54YTn5hqfNrV7qNl/XdwsJaew
 5KKyPysOUZKfxzjJC
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

deref_tag() can return NULL.  Exit gracefully in that case instead
of blindly dereferencing the return value.

.name shouldn't ever be NULL, but grep_object() handles that case
explicitly, so let's be defensive here as well and show the broken
object's ID if it happens to lack a name after all.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
Patch generated with --function-context for easier review.

 builtin/grep.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/builtin/grep.c b/builtin/grep.c
index c8037388c6..e58e57504c 100644
=2D-- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -658,31 +658,42 @@ static int grep_object(struct grep_opt *opt, const s=
truct pathspec *pathspec,
 static int grep_objects(struct grep_opt *opt, const struct pathspec *path=
spec,
 			const struct object_array *list)
 {
 	unsigned int i;
 	int hit =3D 0;
 	const unsigned int nr =3D list->nr;

 	for (i =3D 0; i < nr; i++) {
 		struct object *real_obj;

 		obj_read_lock();
 		real_obj =3D deref_tag(opt->repo, list->objects[i].item,
 				     NULL, 0);
 		obj_read_unlock();

+		if (!real_obj) {
+			char hex[GIT_MAX_HEXSZ + 1];
+			const char *name =3D list->objects[i].name;
+
+			if (!name) {
+				oid_to_hex_r(hex, &list->objects[i].item->oid);
+				name =3D hex;
+			}
+			die(_("invalid object '%s' given."), name);
+		}
+
 		/* load the gitmodules file for this rev */
 		if (recurse_submodules) {
 			submodule_free(opt->repo);
 			obj_read_lock();
 			gitmodules_config_oid(&real_obj->oid);
 			obj_read_unlock();
 		}
 		if (grep_object(opt, pathspec, real_obj, list->objects[i].name,
 				list->objects[i].path)) {
 			hit =3D 1;
 			if (opt->status_only)
 				break;
 		}
 	}
 	return hit;
 }
=2D-
2.28.0
