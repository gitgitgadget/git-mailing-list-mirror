Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2920BC433F5
	for <git@archiver.kernel.org>; Tue,  4 Oct 2022 16:17:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229633AbiJDQRv (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Oct 2022 12:17:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229917AbiJDQRt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Oct 2022 12:17:49 -0400
Received: from mout.web.de (mout.web.de [217.72.192.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 655DA5A8B3
        for <git@vger.kernel.org>; Tue,  4 Oct 2022 09:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1664900260; bh=6ZwMiYT2B3Rx/N/6/ZkYex6FDc4YbVKegU9VHhNWZGs=;
        h=X-UI-Sender-Class:Date:To:Cc:From:Subject;
        b=eiQ28pyyjdhLKNoZz68dcXmraqBx1iWssYDxbLRwQrAsar7VzUDcPiflHrUiLglzA
         YzMUI/9cmFwyB9RovTOvPLgB9TuF37UhSwJiYD2HPcDpruCchRf+/2r9L8KcIm2tYm
         0SGmAOuht8RK0DGadVF2AuF2zh4WtrWzyFgiXRrUAZNYr/QA7YOdEzAPA4jj9iojv8
         TQXSfRSoVaElucNqrmk8k6U1ewWmQ+BON78zHCFh162hDtJt39cowQYlLQ1/OlIHSV
         YFMr0FhFBlYLBnurUZb+95CY9IXpf/sFIhxr0QgWV1zlg6dot8m0cHDcC9Zmynp6nF
         YIyux57Fr0Ypw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.26.45]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MYLmq-1okeRS17kw-00VkwB; Tue, 04
 Oct 2022 18:17:40 +0200
Message-ID: <ab33f72e-d552-7bd7-bf04-3c476d32b5b6@web.de>
Date:   Tue, 4 Oct 2022 18:17:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.3.1
Content-Language: en-US
To:     Git List <git@vger.kernel.org>,
        Derrick Stolee <derrickstolee@github.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] gc: simplify maintenance_task_pack_refs()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:VnnyxS3esjJCEBLa/58pEVw2KzvElMLq4n7pBCRHZDPZLRk3bF8
 KIiro1UVp+pZ4eFqU0YcknKMpbcdu0D+T2UhslFvnuIBjLxV1sCloLnmtN3zAF5o795AUvr
 5qZQg3l1/0KFBehVpng8KW1Js+MiPMNqiQyMzh6BhMAlvNRZUs9RtIFcDLTiiD/lB1oRL89
 dhXLbIDLcaXFGNyzVal0Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:N9ePCKx0Yqg=:QNIV1egHfm+AkLTAoRASew
 c/IZsdD8C9Ry7nPkKxOimu6G3s59iRecVP9xPoCmjj/ncvNZBKM/FNL5s6eo2ZiK8gyV2NvTH
 0dM6TrFo709fJ5aTUuMfZO0y9gYKbSvjjCZDG2b2A55iBjRCTCAd7VakzQP+Il5FAhPU0BPXy
 Gi/Ne+W9/LfHEeMG80SV8WQxYO8eXUkDSPDgH+u2IwH2jsxwprw7BeCZyd+EbJRpzzmeqxe5O
 TV/dX7KeTPT+FNAoG4qz1HMXBWayFrZHOq39bbFGPuaJep6Wj95ZgN5eE6l+dw7EL0SLfEky2
 jnKWKyZXBAzTFEQdEdmGuvxeg4cvxH3RohBGmuNZl3mOsqCi+oGZg79cOCOkpM6+l8tk+rHDe
 R/4VGT7Q2zmQoLGUdC4vlJgDnBrititgxAPBMzdve98fcDv7zBOQgkaOlU/JWzKcz2jO54fuD
 WrsqNnyAOkVY5MiWZueTo0MPaj6DFc+trycZbLnMo+2uMf869LLveX+A5Io/XSrSgA9ENrbR4
 zKg+hi6sdrjuYV/K5c9APXchSa2HON7B5rr7436ieOfr2QqafgZew9k26iOlMMAndPUJ0OexB
 8lTkBbn3pq1Dus8km4dNdrqv/IiqCgZiUs6arTZv2tiRm1H3Tdzn44ip780PbGMF//vE/ACLW
 WKE2TEjdWMTLrvp/12HLLr+k9X+VOGVyop+xhiSuiIAbiAjDfWra6zVz4uQNBKbTlAZMwa98Z
 fX184+kup8LVULYU+UHsCPS3+xHTU1G1tfmB2eOG9jGlLF+8S6EM0nSb1wRNTgmch+myIxeZ4
 6MDFWXP7FOmiK5RGFk7+CSuUz590lUXFm488msZqIFebhR3Fo0yah2/l4HPndC5jeTnyD/CUZ
 yXJwOc7uZ06r0bTVSOP6YpLmvKSzQAWDkIYtVn+CT2x1VhK1fzjcPrMC49jRKKgrpEkRI+Qgm
 J/oWzVBtD572ox/bybJDzIPnVsVu34KXUThk9d41ufWjSxcgWWTcPgnXt8jKNQGZUrPK85tef
 ytfUm6UvqGCdU+rWOi7chdzsBg31wI3LBIUfGOBSsEf1eOqEqtNXZCwk/tLMoTQSBeM8edbP9
 pAG2WQpDWYvySe6qHnuPY/WaS6R/WnzMpCr1ewCXZO8UBE0USK7w9U0TSoX1Ay0Gyy9FBxIyG
 9oMxc=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Pass a constant string array directly to run_command_v_opt() instead of
copying it into a strvec first.  This shortens the code and avoids heap
allocations.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
This patch is a bit silly because it doesn't actually fix anything, but
I can't resist pointing out the possible code size reduction.  And if
opts becomes used eventually it's probably easier to use the args member
of struct child_process instead of supplying our own strvec.

 builtin/gc.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index 2753bd15a5..ceff31ea00 100644
=2D-- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -167,16 +167,9 @@ static void gc_config(void)
 struct maintenance_run_opts;
 static int maintenance_task_pack_refs(MAYBE_UNUSED struct maintenance_run=
_opts *opts)
 {
-	struct strvec pack_refs_cmd =3D STRVEC_INIT;
-	int ret;
+	const char *argv[] =3D { "pack-refs", "--all", "--prune", NULL };

-	strvec_pushl(&pack_refs_cmd, "pack-refs", "--all", "--prune", NULL);
-
-	ret =3D run_command_v_opt(pack_refs_cmd.v, RUN_GIT_CMD);
-
-	strvec_clear(&pack_refs_cmd);
-
-	return ret;
+	return run_command_v_opt(argv, RUN_GIT_CMD);
 }

 static int too_many_loose_objects(void)
=2D-
2.37.3
