Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE1E9C433F5
	for <git@archiver.kernel.org>; Tue, 11 Jan 2022 12:15:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239674AbiAKMPE (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Jan 2022 07:15:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239613AbiAKMPD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Jan 2022 07:15:03 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A016C06173F
        for <git@vger.kernel.org>; Tue, 11 Jan 2022 04:15:03 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id i5so12762333edf.9
        for <git@vger.kernel.org>; Tue, 11 Jan 2022 04:15:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=fAs0lheyuKlzEx4WUTdbvrugq6BI6+0HDs5qteXv+v0=;
        b=j9k2VcWzK2RwvNT/HueXDLW8oZ4QkV2BjLgtlL22ztyEUfUhUxeSkKZeIcVr4I7Wij
         d3W97Y7Molguoc/K6K03entSNQ5eacpZK1aAc7Qvt1dXN/jmLjYHyjp2Ta3prvaRIWST
         SOy1QPHfc+KhnngWk9MWePJ1kytinTt4q8EQqjd7YPAmXIxmYqn6maPv80eSFad/4o4V
         gUYNje/wm70I1ZLwwkBD7Gov+dwyBdcv1uSCfeV767paB0RS6/01SJFOeyURN7sWeOAR
         sp8pX+x9BoscxglzWejFYez7yYFa0OMXCxr6ueJhH+HLLGQyXOq+d4+UV2o/IuPngfOo
         pHXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=fAs0lheyuKlzEx4WUTdbvrugq6BI6+0HDs5qteXv+v0=;
        b=Q3O/tOmQNLgVqmUQljrIJ1PtZt3OE8FYh1xQTRipKbOrKvTo2Z69n99v4pw0EsDCHg
         DSBoHKcLAs4zltjEz4X/yuTwXCXWmh/ZiAa+pVXUMFZmGeQYBMUvISuCyLbSZsywtiuC
         htVKKm0NBFRI+EKfHlWF5hF0rQ+qPVPDl7UP92UYn4r9rlE4Lgo1A7vw2i9KBXoxCHPW
         hU4jMF3OzOKjf3z49+4dik5X2ga9ORahtlBKDTC9zi9HKTOBl2rODj328HeXMn+VXrAi
         0vSz69eLjuBtGVWOvt8xjRce1QaBGeWnjgnJah0CNQYW8tvjFO0IV7A7EJic9ojwkWUS
         nKKg==
X-Gm-Message-State: AOAM531KM9rVdqPbPhdAiQC+shlxa/u6QJoxVtUxhTw9mEs3elN/u1Xt
        RfLVy41WS6VKXvHG1OBjrcR874YOt0QqBw==
X-Google-Smtp-Source: ABdhPJyHBiGq/9t1MTKSmkGtaDVBFWMqo4StefLFts0jFMKby7d9F/GNt682yp/cGIUieAEoqdRIOA==
X-Received: by 2002:aa7:d8d4:: with SMTP id k20mr4124932eds.17.1641903301596;
        Tue, 11 Jan 2022 04:15:01 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id 14sm3508739ejk.215.2022.01.11.04.15.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jan 2022 04:15:01 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1n7G3I-000bIf-MA;
        Tue, 11 Jan 2022 13:15:00 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v2 0/2] builtin add -p: fix hunk splitting
Date:   Tue, 11 Jan 2022 13:07:52 +0100
References: <pull.1100.git.1640010777.gitgitgadget@gmail.com>
 <pull.1100.v2.git.1641899530.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <pull.1100.v2.git.1641899530.gitgitgadget@gmail.com>
Message-ID: <220111.861r1ezcxn.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Jan 11 2022, Phillip Wood via GitGitGadget wrote:

> Thanks to Junio and =C3=86var for their comments on V1. I've updated the =
commit
> message and added a helper function as suggested.

This v2 LGTM as far as the functionality of the end-state is concerned.

As a remaining nit the complete_file() helper you introduce in 2/2
changes 2/4 places that increment "hunk->splittable+into".

I grabbed this PR and came up with this amendmend to it which adds a 2/3
step that converts 3/3 of them, followed by adding the 4th user in your
2/2 (now patch 3/3):
https://github.com/git/git/compare/master...avar:phillipwood-avar/wip/add-p=
-fix-hunk-splitting-v2.1

It changes nothing as far as the end-state is concerned, but I think it
makes this easier to read & follow. The actual behavior change becomes a
one-line addition to add-patch.c, instead of being mixed up with the
refactoring of adding the new helper.

If you'd like to pick that up & run with it as a v3 that's fine by me,
and if not that's also fine :) Just a suggestion.

A range-diff between your v2 here and that linked-to
phillipwood-avar/wip/add-p-fix-hunk-splitting-v2.1:

1:  cc8639fc29d =3D 1:  34392397f04 t3701: clean up hunk splitting tests
-:  ----------- > 2:  c082176f8c5 add-file.c: use static helper to check ma=
rker =3D=3D +|-
2:  b698989e265 ! 3:  defca0baba4 builtin add -p: fix hunk splitting
    @@ Commit message
         Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
=20=20=20=20=20
      ## add-patch.c ##
    -@@ add-patch.c: static int is_octal(const char *p, size_t len)
    - 	return 1;
    - }
    -=20
    -+static void complete_file(char marker, struct hunk *hunk)
    -+{
    -+	if (marker =3D=3D '-' || marker =3D=3D '+')
    -+		/*
    -+		 * Last hunk ended in non-context line (i.e. it
    -+		 * appended lines to the file, so there are no
    -+		 * trailing context lines).
    -+		 */
    -+		hunk->splittable_into++;
    -+}
    -+
    - static int parse_diff(struct add_p_state *s, const struct pathspec *p=
s)
    - {
    - 	struct strvec args =3D STRVEC_INIT;
     @@ add-patch.c: static int parse_diff(struct add_p_state *s, const str=
uct pathspec *ps)
      			eol =3D pend;
=20=20=20=20=20=20
      		if (starts_with(p, "diff ")) {
    -+			complete_file(marker, hunk);
    ++			complete_file(marker, &hunk->splittable_into);
      			ALLOC_GROW_BY(s->file_diff, s->file_diff_nr, 1,
      				   file_diff_alloc);
      			file_diff =3D s->file_diff + s->file_diff_nr - 1;
    -@@ add-patch.c: static int parse_diff(struct add_p_state *s, const str=
uct pathspec *ps)
    - 				file_diff->hunk->colored_end =3D hunk->colored_end;
    - 		}
    - 	}
    --
    --	if (marker =3D=3D '-' || marker =3D=3D '+')
    --		/*
    --		 * Last hunk ended in non-context line (i.e. it appended lines
    --		 * to the file, so there are no trailing context lines).
    --		 */
    --		hunk->splittable_into++;
    -+	complete_file(marker, hunk);
    -=20
    - 	/* non-colored shorter than colored? */
    - 	if (colored_p !=3D colored_pend) {
=20=20=20=20=20
      ## t/t3701-add-interactive.sh ##
     @@ t/t3701-add-interactive.sh: test_expect_success 'correct message wh=
en there is nothing to do' '
