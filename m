Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95E46C43334
	for <git@archiver.kernel.org>; Tue, 28 Jun 2022 18:07:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233963AbiF1SHe (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Jun 2022 14:07:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234209AbiF1SHc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Jun 2022 14:07:32 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 869CA1EAD6
        for <git@vger.kernel.org>; Tue, 28 Jun 2022 11:07:31 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id CF64E197641;
        Tue, 28 Jun 2022 14:07:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=0Lz42NYy+uUydC95tOmPlQPwcqc4kbA6pHkZJk
        /Di08=; b=GaUnUAKyOn1z6YtagScEMIyiCOyMOpQUK0ZEnGAfpMHsHIh15c3PH3
        gPxaxsDf+6d/8IRCR5HqNV98w2h7Sc158mqVoD9xfNYrvuTSL+7f2x5WCZBu1rEn
        gQecBaqFEELFf/mGnoqexHba2ptpGZQN/Tx/aZ0ybUIXw6ofZnxwo=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C74C1197640;
        Tue, 28 Jun 2022 14:07:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 5B1BD19763E;
        Tue, 28 Jun 2022 14:07:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Teng Long <dyroneteng@gmail.com>
Cc:     avarab@gmail.com, derrickstolee@github.com, git@vger.kernel.org,
        me@ttaylorr.com, tenglong.tl@alibaba-inc.com, git@jeffhostetler.com
Subject: Re: [PATCH v5 4/5] pack-bitmap.c: retrieve missing i18n translations
References: <cover.1656403084.git.dyroneteng@gmail.com>
        <065b7c9ccb5a412526a934f9b67c8be64a40fc7f.1656403084.git.dyroneteng@gmail.com>
Date:   Tue, 28 Jun 2022 11:07:26 -0700
In-Reply-To: <065b7c9ccb5a412526a934f9b67c8be64a40fc7f.1656403084.git.dyroneteng@gmail.com>
        (Teng Long's message of "Tue, 28 Jun 2022 16:17:49 +0800")
Message-ID: <xmqqfsjok6g1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2B400D1C-F70D-11EC-96EB-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Teng Long <dyroneteng@gmail.com> writes:

> Subject: Re: [PATCH v5 4/5] pack-bitmap.c: retrieve missing i18n translations

The verb "retrieve" is puzzling.

> In pack-bitmap.c, some printed texts are translated,some are not.

"," -> ", ".

> Let's support the translations of the bitmap related output.

>  	if (bitmap_size < 0) {
> -		error("Failed to load bitmap index (corrupted?)");
> +		error(_("Failed to load bitmap index (corrupted?)"));

If we were to do this, to avoid burdening translators with double
work, we probably would want to fix the "C" locale version of the
string, either as a preliminary clean-up before this step, or as
part of this step.  From Documentation/CodingGuidelines:

        Error Messages

         - Do not end error messages with a full stop.

         - Do not capitalize the first word, only because it is the first word
           in the message ("unable to open %s", not "Unable to open %s").  But
           "SHA-3 not supported" is fine, because the reason the first word is
           capitalized is not because it is at the beginning of the sentence,
           but because the word would be spelled in capital letters even when
           it appeared in the middle of the sentence.

         - Say what the error is first ("cannot open %s", not "%s: cannot open")

