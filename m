Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7AB061F461
	for <e@80x24.org>; Sun,  8 Sep 2019 17:58:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730686AbfIHR65 (ORCPT <rfc822;e@80x24.org>);
        Sun, 8 Sep 2019 13:58:57 -0400
Received: from mout.web.de ([212.227.15.3]:42975 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730531AbfIHR64 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Sep 2019 13:58:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1567965532;
        bh=rVPBWlNIEjchLTwATWM6ihUouiZOhlSBup022NoCWLU=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=R09de9jbSqOr4MQlhpYsYCs+bYtst6HzH5cdXNi6551zRDwR7xIRMXsWbRCBwbivQ
         mUVU3QxDktLpM0rA/WNQWQy//9scFE7lhquxhB2H+gfMrfWD/WAKjyLtvlS899iqtp
         IALfzXrS8SdanxLlNhE+ddprg/NxPkgYIpKMbCVc=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([79.203.24.71]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0M8L3a-1iKrNe2MIk-00vwdG; Sun, 08
 Sep 2019 19:58:52 +0200
Subject: [PATCH 2/2] log-tree: call load_ref_decorations() in
 get_name_decoration()
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?Q?=c3=89tienne_SERVAIS?= <etienne.servais@voucoux.fr>,
        git@vger.kernel.org,
        =?UTF-8?Q?Rafael_Ascens=c3=a3o?= <rafa.almas@gmail.com>
References: <D941A96E-E5A8-4C86-A200-0BECA30216D1@voucoux.fr>
 <37283d4e-3f79-a6b1-425a-f90704fbcce2@web.de>
 <xmqq36ijl6qu.fsf@gitster-ct.c.googlers.com>
 <5de287e9-a8e8-780a-7d39-2229b61914ca@web.de>
 <xmqqh86zjmcg.fsf@gitster-ct.c.googlers.com>
 <64bc5556-b098-7991-b7c2-3483277bb73c@web.de>
 <xmqqwofuia0x.fsf@gitster-ct.c.googlers.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <c0e01bd5-667e-1f29-f355-dd0eda8c8e6e@web.de>
Date:   Sun, 8 Sep 2019 19:58:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <xmqqwofuia0x.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:qL1B7Jd+a1L8UM8VUMp+AcJf4VGx/61pQrLeraVvCYcnMQYzmTZ
 cBgsHs79vYbesoUkou2vcdm45Vdr9GO3y5vh4ZZf/NmESD9tYII9EfxeeXQ/wnKDVTl4HYN
 8Z8WPMi+A73gi8cml5sEaB0rqwW2B50R9NNz2K+JbAb6B8Mv9NfUQb2nU90JXVofhRaib0G
 gaPW2ejr54LnQM7TdM/4A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:5NbNMbpm3Q0=:vRlQuWY0cYs89krguBHBJm
 WIGHYhsuiGvSu08cGfR+o+hBVF+EHiCTDrllmALU/Y4x8NHg3ZrfuaUjdAmQ4ybEmQKENbpyj
 H9cdI1My/BQvVTGJHidqboV5lK0FBeTbrm6lMZXwOh/EZj0RnIbbgzjoaQTexpnwaxPD0Tueg
 HvIhtE58l3aFCbVFSl2+F2a76OwhDtdQbeslF88tMu/lRgQibsEsA0tpn9OerC5pIa8qwkrpM
 Y9NZleKmQBw3qLU5msWX0Or0n0v13RdN7RnisWaGT82FZUGcKHYQm85pT74aKvJpw98t126wY
 RCYvidSfwi/NTTMglVy65vEHjOzgaxxhDUP76j02x3qb+rWkrLtE4IfGLa8O7/qEU3g9YJ+la
 jvV7c6Z/yta/zlxQmzaSNysfjq/YVkT+Y38r69L3HxLrIU015ghagcJnRu7fThgYIxUS8al+A
 e8AlOfq3cqEgKYklE//uAqfhOPTIfQAXCzqQzJvOcoogM/sCLoUV9EpnHhw7xkdIgLIzROXoX
 lOvbZPM3Q79jMCnL4gy0FdlqudlQz3gghzSRqGl2rFA8Ik+QOU4X99NovKw25+dBAXtPlmDKO
 P2ov3mVEjiMOKVOefEc1yGrx9A0BZyH0MwQLjJrPqflPFvyTjqo19AWgsK4drvVT7KcXI2H6X
 XxW2VtgD3FGfKGTi4kElsEyAlzK+uG5QDAA/an5ILT96s/iLCkVe9E1tw2vEG8rb+R1nxpfp7
 6OX+EBEFmF8zcQhmwxXOmSmMhxFmFTiMCZJcUy6Z3L7hrlT+vjzjZUx5pwbrbV70YNeAr7gUy
 4QHChCEGSVj+tTa3nXwtvRMEE9NRK71B/hAbrIp9JnHdAT/F7zZ5Z9iaZlV6yBB8TDqTFRM58
 pQhc2OccaKu1X0BDcwnES/DNM+GRmCQ72Fh5I6zqZFpeoRx/YJufIEXP9wwdbE64yf3SKwd4N
 pLpTM0YARdi3SmEC0pdahXxIH7H7lNyTAgwKsQtamhCjsFtJAJHH0y0zsPLVmKJavWTsS57JD
 B76cdpcosCXZaBzWXRNi8MpkC04Eyeq/pdiVzTUmH9GHxrvYpVbW7vuc5W981leWmP8P3OaXM
 P2d4mEr9B5im/BqerrCrjCqw70Vv2GquQyxzdaohNw/jmfLVUo+4DE++kGxtBcooNbJYJ5I24
 E10527LzUkl7Dnon7kigHpXVmUof9R4xUrCGVTO1mtvbLtwfnPU5aHVLKuj6VitrAfndo=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Load a default set of ref name decorations at the first lookup.  This
frees direct and indirect callers from doing so.  They can still do it
if they want to use a filter or are interested in full decorations
instead of the default short ones -- the first load_ref_decorations()
call wins.

This means that the load in builtin/log.c::cmd_log_init_finish() is
respected even if --simplify-by-decoration is given, as the previously
dominating earlier load in handle_revision_opt() is gone.  So a filter
given with --decorate-refs-exclude is used for simplification in that
case, as expected.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 log-tree.c     | 1 +
 pretty.c       | 2 --
 revision.c     | 1 -
 t/t4202-log.sh | 2 +-
 4 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/log-tree.c b/log-tree.c
index 1e56df62a7..2d5710e707 100644
=2D-- a/log-tree.c
+++ b/log-tree.c
@@ -77,6 +77,7 @@ void add_name_decoration(enum decoration_type type, cons=
t char *name, struct obj

 const struct name_decoration *get_name_decoration(const struct object *ob=
j)
 {
+	load_ref_decorations(NULL, DECORATE_SHORT_REFS);
 	return lookup_decoration(&name_decoration, obj);
 }

diff --git a/pretty.c b/pretty.c
index e4ed14effe..b32f036953 100644
=2D-- a/pretty.c
+++ b/pretty.c
@@ -1239,11 +1239,9 @@ static size_t format_commit_one(struct strbuf *sb, =
/* in UTF-8 */
 		strbuf_addstr(sb, get_revision_mark(NULL, commit));
 		return 1;
 	case 'd':
-		load_ref_decorations(NULL, DECORATE_SHORT_REFS);
 		format_decorations(sb, commit, c->auto_color);
 		return 1;
 	case 'D':
-		load_ref_decorations(NULL, DECORATE_SHORT_REFS);
 		format_decorations_extended(sb, commit, c->auto_color, "", ", ", "");
 		return 1;
 	case 'S':		/* tag/branch like --source */
diff --git a/revision.c b/revision.c
index 07412297f0..1df3061e95 100644
=2D-- a/revision.c
+++ b/revision.c
@@ -2063,7 +2063,6 @@ static int handle_revision_opt(struct rev_info *revs=
, int argc, const char **arg
 		revs->simplify_by_decoration =3D 1;
 		revs->limited =3D 1;
 		revs->prune =3D 1;
-		load_ref_decorations(NULL, DECORATE_SHORT_REFS);
 	} else if (!strcmp(arg, "--date-order")) {
 		revs->sort_order =3D REV_SORT_BY_COMMIT_DATE;
 		revs->topo_order =3D 1;
diff --git a/t/t4202-log.sh b/t/t4202-log.sh
index 01c95d1375..bb66d1d93c 100755
=2D-- a/t/t4202-log.sh
+++ b/t/t4202-log.sh
@@ -837,7 +837,7 @@ test_expect_success 'decorate-refs and decorate-refs-e=
xclude' '
 	test_cmp expect.decorate actual
 '

-test_expect_failure 'decorate-refs-exclude and simplify-by-decoration' '
+test_expect_success 'decorate-refs-exclude and simplify-by-decoration' '
 	cat >expect.decorate <<-\EOF &&
 	Merge-tag-reach (HEAD -> master)
 	reach (tag: reach, reach)
=2D-
2.23.0
