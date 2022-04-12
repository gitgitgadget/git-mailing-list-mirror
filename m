Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C5F5C433F5
	for <git@archiver.kernel.org>; Tue, 12 Apr 2022 16:26:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348556AbiDLQ2y (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Apr 2022 12:28:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238958AbiDLQ2y (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Apr 2022 12:28:54 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75C8B58E5E
        for <git@vger.kernel.org>; Tue, 12 Apr 2022 09:26:36 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9264B12000E;
        Tue, 12 Apr 2022 12:26:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=/IagLps5k335wnRvVdHlyznr7IJqEVP+yh4lHj
        RyWoY=; b=wGbXZRuBM4//Si0UHnEamJkRw3ti0GL5KvKhVt/yu1DPUBGOHPIPVB
        WhdVFmhnrotaiZbHP233WB9D/Y+MdjcX14cDaCl9bLsW5CyvPNiq9giTbbZhuZUR
        N4ZJyBDkvDY3E2EGCR19Lgw93wfDewKVmwFgjZj/B/gwWD6TY9L7U=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8AB5812000D;
        Tue, 12 Apr 2022 12:26:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.214.157])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id EF04912000C;
        Tue, 12 Apr 2022 12:26:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Julien Palard <julien@palard.fr>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        =?utf-8?Q?S=C3=A9bastien?= Helleu <flashcode@flashtux.org>,
        =?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>
Subject: Re: [PATCH] Make a colon translatable
References: <-9xEw4skKJRhRp5v7WmxeS2n5xv-xmM0HWqmoiameagKhpiDOP9y3Yxj7WFy6M-jztxqug8DKopXIr_op09VlGPkUC7iG5V6xXjKh_SxHEg=@palard.fr>
        <xmqq5ynfh101.fsf@gitster.g>
        <CmgFntqFQcIxsSKePSKmmWvAMwsl-9shDqzWTT9GqI3S6PXNdhTTX6LypjY0l-R8B52pkh_MpYtq-NbbDjXT6EuZ9_S-QV4cUqxKhjZUpw8=@palard.fr>
Date:   Tue, 12 Apr 2022 09:26:33 -0700
In-Reply-To: <CmgFntqFQcIxsSKePSKmmWvAMwsl-9shDqzWTT9GqI3S6PXNdhTTX6LypjY0l-R8B52pkh_MpYtq-NbbDjXT6EuZ9_S-QV4cUqxKhjZUpw8=@palard.fr>
        (Julien Palard's message of "Tue, 12 Apr 2022 07:30:10 +0000")
Message-ID: <xmqq8rsaclom.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 51EF2AA0-BA7D-11EC-8362-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Julien Palard <julien@palard.fr> writes:

> I understand your comment while seeing my badly choosen example
> with `_("some string:")`, but in the patch isn't your proposition
> more sentence-lego-ish than mine? If I understand correctly you're
> proposing to replace:
>
>     printf("%s", _("Untracked files:"))
>
> with:
>
>     printf(_("%s:"), _("Untracked files"))

Hmph, I am talking about

diff --git i/wt-status.c w/wt-status.c
index d33f9272b7..f475194ff8 100644
--- i/wt-status.c
+++ w/wt-status.c
@@ -249,5 +249,5 @@ static void wt_longstatus_print_other_header(struct wt_status *s,
 {
 	const char *c = color(WT_STATUS_HEADER, s);
-	status_printf_ln(s, c, "%s:", what);
+	status_printf_ln(s, c, _("%s:"), what);
 	if (!s->hints)
 		return;

where the callers already supply _("Untracked files") and _("Ignored files")
without trailing colon in "what" when calling wt_longstatus_print_other(),
which is a direct caller that passes "what" to this function.

So, no, I am replacing

	printf("%s:", _("Untracked files"))

with

	printf(_("%s:"), _("Untracked files"))

and no other changes are required.  When translating "%s:", French
translation can insert nbsp before the colon to make it "%s :",
right to left languages may want to put their equivalent to colon
that comes after a heading on the left side of the "%s", etc.

> This hides information to the translator (the presence of a
> following colon while translating 'Untracked files').

With "Untracked files" and "Ignored files", we indicate certain
concepts and interpolate it in _("%s:"), i.e. a version localized to
adjust to the presentation convention of "label followed by a
separating colon".  Unless your language requires to translate
"Untracked files" differently when it is used as a "label" to be
followed by a separating colon and when it appears elsewhere in a
sentence, I am not sure how it helps to mark "Untracked files" as
appearing as a header label.

Besides, in the existing code, the form that is equivalent to

	printf("%s:", _("Untracked files"))

is being used, and where that "Untracked files" appear is two level
function calls away from the actual "%s:" (i.e. "label and
separator").  Aren't translators translating this string without
extra context?

> It would be
> OK if we were 100% sure no translations can be impacted by this. I
> only speak french and english, so I don't know. Maybe I should
> rename `what` to `heading`? I may clarify a bit, `what` make me
> feel it can be reused, but it's only used once alone on its line.

The way the function wt_longstatus_print_other() uses "what" and
"how" looks quite clear.  What kind of paths are being reported (are
they ignored files?  untracked files?  something else?) and how the
user can rectify the situation if they want these paths included in
the tracked set of paths.  I am afraid renaming to "heading" makes
it even less clear than leaving it to "what".  A word that indicates
that it refers to "category of paths" more clearly may make a good
replacement, but perhaps I am not understanding where exactly your
"this hides the information" comes from and makes you worry about
it.  Besides, would translators work off of .po and .pot files, not
the C-source?  Do they even have ready access to the variable names
to help them infer how the strings are used to begin with?

If translators truly benefit from knowing that the string "Untracked
files" is used as a heading, we could use /* TRANSLATORS: insn */
comment to help them.  Since I seem not to get where your concern
comes from, I cannot tell if it would help.

More info needed, I guess?
