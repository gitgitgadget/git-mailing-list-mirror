Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E06EC433EF
	for <git@archiver.kernel.org>; Mon, 11 Apr 2022 07:02:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243031AbiDKHEi (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Apr 2022 03:04:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233719AbiDKHEf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Apr 2022 03:04:35 -0400
Received: from mail-4323.proton.ch (mail-4323.proton.ch [185.70.43.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57BF333A00
        for <git@vger.kernel.org>; Mon, 11 Apr 2022 00:02:20 -0700 (PDT)
Date:   Mon, 11 Apr 2022 07:02:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=palard.fr;
        s=protonmail3; t=1649660537;
        bh=uZy7G0zii4IUFS0C93P8irfI5z9MTOajAIvD6imM/Us=;
        h=Date:To:From:Cc:Reply-To:Subject:Message-ID:From:To:Cc:Date:
         Subject:Reply-To:Feedback-ID:Message-ID;
        b=Tc0xFC3fG+Tmra1Z8zu6BXj/SaMduU/y0TtwHaJDUMMNMYg0ZgPb4ucfu20Tm1BPh
         Bf54jy0y1fl806YZa6o6KZ9980TaEArgGBI09T5yvP8Fdrm9Wbmk2qYYGFiQOuBMLL
         CipbAEG34aHVO3KVaZg6CrOQgoMcHJOPgYhSzpvimQakI1zXKS+fmZ3Y+KwfuH67Kv
         kZ6bQGkIlR9OC/GpjryVL7G8uazaeewtyjm4UnhfNxKM/RPUEEhw/I1sfbiTwlroLD
         R/RsryFYe76kORsGIlWrkeV0ru0DPglsT9iTUvoRNl7boQ9qaSD7obGsu50EqfmJXO
         rvyKSBslD1MTg==
To:     "git@vger.kernel.org" <git@vger.kernel.org>
From:   Julien Palard <julien@palard.fr>
Cc:     =?utf-8?Q?S=C3=A9bastien_Helleu?= <flashcode@flashtux.org>,
        =?utf-8?Q?Jean-No=C3=ABl_Avila?= <jn.avila@free.fr>
Reply-To: Julien Palard <julien@palard.fr>
Subject: [PATCH] Make a colon translatable
Message-ID: <-9xEw4skKJRhRp5v7WmxeS2n5xv-xmM0HWqmoiameagKhpiDOP9y3Yxj7WFy6M-jztxqug8DKopXIr_op09VlGPkUC7iG5V6xXjKh_SxHEg=@palard.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In french we use a no-break space before colon, so with formatting
like:

    printf("... %s: ...", _("some string"))

We can't cleanly add our no-break space, so I think:

    printf("... %s ...", _("some string:"))

is better for translators.

Signed-off-by: Julien Palard <julien@palard.fr>
---
 wt-status.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/wt-status.c b/wt-status.c
index d33f9272b7..ef0c276c3d 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -248,7 +248,7 @@ static void wt_longstatus_print_other_header(struct wt_=
status *s,
 =09=09=09=09=09     const char *how)
 {
 =09const char *c =3D color(WT_STATUS_HEADER, s);
-=09status_printf_ln(s, c, "%s:", what);
+=09status_printf_ln(s, c, "%s", what);
 =09if (!s->hints)
 =09=09return;
 =09status_printf_ln(s, c, _("  (use \"git %s <file>...\" to include in wha=
t will be committed)"), how);
@@ -1863,9 +1863,9 @@ static void wt_longstatus_print(struct wt_status *s)
 =09=09wt_longstatus_print_submodule_summary(s, 1);  /* unstaged */
 =09}
 =09if (s->show_untracked_files) {
-=09=09wt_longstatus_print_other(s, &s->untracked, _("Untracked files"), "a=
dd");
+=09=09wt_longstatus_print_other(s, &s->untracked, _("Untracked files:"), "=
add");
 =09=09if (s->show_ignored_mode)
-=09=09=09wt_longstatus_print_other(s, &s->ignored, _("Ignored files"), "ad=
d -f");
+=09=09=09wt_longstatus_print_other(s, &s->ignored, _("Ignored files:"), "a=
dd -f");
 =09=09if (advice_enabled(ADVICE_STATUS_U_OPTION) && 2000 < s->untracked_in=
_ms) {
 =09=09=09status_printf_ln(s, GIT_COLOR_NORMAL, "%s", "");
 =09=09=09status_printf_ln(s, GIT_COLOR_NORMAL,
--
2.35.1

--=C2=A0
Julien Palard
https://mdk.fr
