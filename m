Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CED3C433EF
	for <git@archiver.kernel.org>; Thu,  7 Jul 2022 16:46:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235804AbiGGQqB (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Jul 2022 12:46:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232119AbiGGQqB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Jul 2022 12:46:01 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9E0224F05
        for <git@vger.kernel.org>; Thu,  7 Jul 2022 09:45:59 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C0BBD13CACD;
        Thu,  7 Jul 2022 12:45:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=RGL+EFFpkNWY0Bl2Qza2GV6SzYi4fIAW1qRsu+
        InR6I=; b=xmdUbupGRIE8c0dA6fyjF+2Is9YRiRyUa8r+9UxuzD5cIfKm3gPBD4
        mizv6DWnmmb1qG56OURBfzqzJGWezvFIV5jQMn1KQ7u5d9JxBzRXdXCBIvltuG8h
        gW98eqMV+bhd8bsjY3nkouuOfnInPNLC5SI1mBMdCyLddfC5npBYc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B0E1413CACC;
        Thu,  7 Jul 2022 12:45:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0AEB313CACB;
        Thu,  7 Jul 2022 12:45:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Teng Long <dyroneteng@gmail.com>
Cc:     avarab@gmail.com, derrickstolee@github.com, git@jeffhostetler.com,
        git@vger.kernel.org, me@ttaylorr.com, tenglong.tl@alibaba-inc.com
Subject: Re: [PATCH v5 4/5] pack-bitmap.c: retrieve missing i18n translations
References: <xmqqfsjok6g1.fsf@gitster.g>
        <20220707115912.75774-1-dyroneteng@gmail.com>
Date:   Thu, 07 Jul 2022 09:45:56 -0700
In-Reply-To: <20220707115912.75774-1-dyroneteng@gmail.com> (Teng Long's
        message of "Thu, 7 Jul 2022 19:59:12 +0800")
Message-ID: <xmqq8rp43m7v.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 46B41BD4-FE14-11EC-BF2D-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Teng Long <dyroneteng@gmail.com> writes:

> On Date: Tue, 28 Jun 2022 11:07:26 -0700, Junio C Hamano wrote:
>
>
>> The verb "retrieve" is puzzling.
>
> I use "retrieve" because I think they should be there but actually missing.
> But If it's not appropriate here I will change another word like "add".

To retrieve is to get/bring something back and regaining possession
of, which implies that the thing existed somewhere already but at a
wrong/different place, and the only thing you are doing is to move
it to the right place, but in this case, the translations did not
exist.  The patch is marking more strings for translation.  And the
act of marking them for translation will cause i18n/l10n folks to
translate these strings, which will (finally) allow _("...") to
retrieve the translated strings at runtime.

So "retrieve" is indeed involved somewhere in the process, but using
the verb skips a few steps.

    Subject: [PATCH 4/5] pack-bitmap.c: mark more strings for translations

perhaps?

>> If we were to do this, to avoid burdening translators with double
>> work, we probably would want to fix the "C" locale version of the
>> string, either as a preliminary clean-up before this step, or as
>> part of this step.  From Documentation/CodingGuidelines:
>
> Yes.
>
> Does git have any NOT "C" Locale string?

Sorry, but I am not sure what you are asking.  What I meant is that
a hunk like this from the patch in discussion:

 	if (bitmap_size < 0) {
-		error("Failed to load bitmap index (corrupted?)");
+		error(_("Failed to load bitmap index (corrupted?)"));
 		ewah_pool_free(b);
 		return NULL;
 	}

makes translators to first translate the above string, but we will
fix the "C" locale version (that is, the string inside _() that is
used as the key to the .po database when retrieving the translated
version) to follow our error message formatting convention to read
something like

	error(_("failed to load bitmap index (corrupted?)"));

or even

	error(_("failed to load bitmap index (corrupted?): '%s'"),
	      filename);

And the translators have to redo the work.  If a preliminary patch
fixed these up before bothering translators with more strings to
translate, they do not need to translate the current, known to be
faulty, version of messages.

> Another doublt is I found something like in:
>
>     File: ./contrib/completion/git-completion.bash
>     923    LANG=C LC_ALL=C git merge -s help 2>&1
>
> I think LC_ALL=C will override LANG=C in these cases, so I think
> `LC_ALL=C git merge -s help 2>&1` is OK here.

In practice, yes, but the code is following the convention to reduce
common confusion caused by leaving some lower precedence but common
environment variables (i.e. LANG) as their original values.

Does the line in the completion script have anything to do with
[PATCH 4/5], or is this merely your curiosity?  Avoid mixing in
unrelated things into the topic, which will only make the review
cycle unnecessarily longer, but raise a separate discussion if you
have to.

Thanks.
