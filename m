Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF7A9C433F5
	for <git@archiver.kernel.org>; Sun, 28 Nov 2021 19:27:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357060AbhK1Tay (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 28 Nov 2021 14:30:54 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55610 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357339AbhK1T2y (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 Nov 2021 14:28:54 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A57DE104F3D;
        Sun, 28 Nov 2021 14:25:37 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=WJnByymwweoM
        aQOeBHoBWsHotl9VZAM4JbG2HWsQJDU=; b=Uw8JWqfbzJBlmfHlk7pFFXeufhGj
        Nhztp3U30LVQfYr2FTfv2UMqZLuFvkvSGyysaRZBtvnbNVofvMjznC15cEbL3KCT
        P5wtNvGDpd2r3FVEJQUHnszOLlbevNVvRV6KAk/1AF02W1f+rH51AZfOxCBAOHWi
        +UKy3855N4WZfCY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8B1FC104F3B;
        Sun, 28 Nov 2021 14:25:37 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D45AC104F3A;
        Sun, 28 Nov 2021 14:25:36 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Han-Wen Nienhuys <hanwen@google.com>,
        Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: Re* [PATCH 2/4] refs: trim newline from reflog message
References: <pull.1145.git.git.1637590855.gitgitgadget@gmail.com>
        <dfb639373234a6b8d5f9110380a66ffccbe0b1d6.1637590855.git.gitgitgadget@gmail.com>
        <xmqq35nnddw7.fsf@gitster.g>
        <CAFQ2z_PE7TMj=qfQVroK_gRfZk-xF9PKhk2yxqF-bB+2aA7eoQ@mail.gmail.com>
        <xmqqczmqajdk.fsf@gitster.g>
        <CAFQ2z_Mct+KBZ3vO6udwqeiHYA8od8CGH_w5BO5LaidP-AYDsg@mail.gmail.com>
        <xmqqzgpu7grv.fsf@gitster.g> <xmqqczmn71ru.fsf_-_@gitster.g>
        <211128.86r1b0gnv6.gmgdl@evledraar.gmail.com>
        <xmqqpmqk5co6.fsf@gitster.g>
Date:   Sun, 28 Nov 2021 11:25:35 -0800
In-Reply-To: <xmqqpmqk5co6.fsf@gitster.g> (Junio C. Hamano's message of "Sun,
        28 Nov 2021 10:59:37 -0800")
Message-ID: <xmqqk0gs5bgw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: F6D5400C-5080-11EC-9BC1-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>> Nitpicking aside, perhaps these two pargaraphs would be better as simp=
ly
>> replaced by:
>>
>>     Consult "Git internal format" in git-commit-tree(1) for
>>     details about the "<unix timestamp> <time zone offset>" format, an=
d
>>     see show_one_reflog_ent() for the parsing function.
>
> Much nicer; this is developer facing and reducing risk of
> inconsistency by incorrectly duplicating is much more important than
> having the info available in a single place.

Having actually read the description, I do not think
"Documentation/date-formats.txt::Git internal format" is a good fit.
We are describing the format of a single string there (e.g. <unix
timestamp> and <time zone offset> form a single string with one SP
in between), but the parameters are integral types.

Specifically because the "Git internal format" is textual, an
example "+0100" given there makes it sufficiently clear that the
offset is a "a sign followed by 4 digits" string, but those who need
to use the value in "int tz" must know that is represented as a
positive one hundred, not sixty, which does not have to be captured
there for the intended audience of date-formats.txt pagelet.

Here is what I came up with

---- >8 -------- >8 -------- >8 -------- >8 -------- >8 ----
Subject: [PATCH v2] refs: document callback for reflog-ent iterators

refs_for_each_reflog_ent() and refs_for_each_reflog_ent_reverse()
functions take a callback function that gets called with the details
of each reflog entry.  Its parameters were not documented beyond
their names.  Elaborate a bit on each of them.

Helped-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * rewrite timestamp and tz, adjusting the internal format's
   description from Documentation/date-formats.txt pagelet, as
   pointed out by =C3=86var.

 refs.h | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

 The indented patch shows the part that was changed from the
 previous one.

    diff --git i/refs.h w/refs.h
    index 4fa97d77cf..f6fed5c7d8 100644
    --- i/refs.h
    +++ w/refs.h
    @@ -467,13 +467,15 @@ int delete_reflog(const char *refname);
      * The committer parameter is a single string, in the form
      * "$GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL>" (without double quot=
es).
      *
    - * The timestamp parameter gives the seconds since epoch when the re=
flog
    - * entry was created.
    - *
    - * The tz parameter is an up to 4 digits integer, whose absolute val=
ue
    - * gives the hour and minute offset from GMT (the lower 2 digits are
    - * minutes, the higher 2 digits are hours).  A negative tz means wes=
t of,
    - * and a positive tz means east of GMT.
    + * The timestamp parameter gives the time when entry was created as =
the number
    + * of seconds since the UNIX epoch.
    + *
    + * The tz parameter gives the timezone offset for the user who creat=
ed
    + * the reflog entry, and its value gives a positive or negative offs=
et
    + * from UTC.  Its absolute value is formed by multiplying the hour
    + * part by 100 and adding the minute part.  For example, 1 hour ahea=
d
    + * of UTC, CET =3D=3D "+0100", is represented as positive one hundre=
d (not
    + * postiive sixty).
      *
      * The msg parameter is a single complete line; a reflog message giv=
en
      * to refs_delete_ref, refs_update_ref, etc. is returned to the

diff --git c/refs.h w/refs.h
index 48970dfc7e..f6fed5c7d8 100644
--- c/refs.h
+++ w/refs.h
@@ -462,7 +462,29 @@ int delete_reflog(const char *refname);
=20
 /*
  * Callback to process a reflog entry found by the iteration functions (=
see
- * below)
+ * below).
+ *
+ * The committer parameter is a single string, in the form
+ * "$GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL>" (without double quotes).
+ *
+ * The timestamp parameter gives the time when entry was created as the =
number
+ * of seconds since the UNIX epoch.
+ *
+ * The tz parameter gives the timezone offset for the user who created
+ * the reflog entry, and its value gives a positive or negative offset
+ * from UTC.  Its absolute value is formed by multiplying the hour
+ * part by 100 and adding the minute part.  For example, 1 hour ahead
+ * of UTC, CET =3D=3D "+0100", is represented as positive one hundred (n=
ot
+ * postiive sixty).
+ *
+ * The msg parameter is a single complete line; a reflog message given
+ * to refs_delete_ref, refs_update_ref, etc. is returned to the
+ * callback normalized---each run of whitespaces are squashed into a
+ * single whitespace, trailing whitespace, if exists, is trimmed, and
+ * then a single LF is added at the end.
+ *
+ * The cb_data is a caller-supplied pointer given to the iterator
+ * functions.
  */
 typedef int each_reflog_ent_fn(
 		struct object_id *old_oid, struct object_id *new_oid,
