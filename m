Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62E17C4338F
	for <git@archiver.kernel.org>; Fri, 20 Aug 2021 20:32:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4ADE461163
	for <git@archiver.kernel.org>; Fri, 20 Aug 2021 20:32:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239479AbhHTUdL (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Aug 2021 16:33:11 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:65405 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238656AbhHTUdL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Aug 2021 16:33:11 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C859115F299;
        Fri, 20 Aug 2021 16:32:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=HAHg9SOEbdjQtyKfTIbeRp3p+T6N2RRLwJD9Gw
        sztxU=; b=NgcJ8ScVl5Zc2YSkpJIUplmRaYqc24Fvi0FttSH+7UUX/a2lae/o0r
        85uuJXJh7ob001K9kShWnkXlse3sAFyVE7EthOtzZoCQImPpKA2ADGoerZyT5sxV
        AIxNWfFeD665iWfGEKPnm+3wkUmwMMhjT2l/cyzNPmB4HC2eR+XNM=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C1F7D15F298;
        Fri, 20 Aug 2021 16:32:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.116.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 1177E15F295;
        Fri, 20 Aug 2021 16:32:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Thiago Perrotta <tbperrotta@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 3/3] send-email docs: mention format-patch options
References: <20210820004604.9948-1-tbperrotta@gmail.com>
        <20210820004604.9948-4-tbperrotta@gmail.com>
Date:   Fri, 20 Aug 2021 13:32:28 -0700
In-Reply-To: <20210820004604.9948-4-tbperrotta@gmail.com> (Thiago Perrotta's
        message of "Thu, 19 Aug 2021 20:46:04 -0400")
Message-ID: <xmqqh7fjuaar.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BD9441AA-01F5-11EC-93D8-D5C30F5B5667-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thiago Perrotta <tbperrotta@gmail.com> writes:

> Currently git-send-email(1) does not make it explicit that format-patch
> options are accepted.

It may be a feature ;-), as running format-patch while send-email is
running encourages a wrong workflow.

But as long as we allow users to do so, we'd need to desribe it.


> Signed-off-by: Thiago Perrotta <tbperrotta@gmail.com>
> ---
>  Documentation/git-send-email.txt | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
> index 3db4eab4ba..05dd8ded44 100644
> --- a/Documentation/git-send-email.txt
> +++ b/Documentation/git-send-email.txt
> @@ -42,6 +42,8 @@ and the "Subject:" of the message as the second line.
>  OPTIONS
>  -------
>  
> +Options from linkgit:git-format-patch[1] are also accepted.
> +

The program works in two majorly different modes.  It either takes

 * message files that are already proof-read and copy-edited from
   the filesystem and sends them out, or 

 * format-patch options to generate message files out of the commits
   and send them out without any proofreading.

The documentation for OPTIONS has various sections, starting from
Composing, then Sending, Automating, Administering, and Information.

By having this new sentence before all the sections gives a wrong
impression that format-patch options are accepted in both modes.
But the format-patch options are relevant only when we are using the
latter operation mode.  Unlike that, all the options documented
under these sections starting from Composing are applicable to both
modes.

We may want to clarify that we have two modes near the top of the
document, perhaps like the attached, and extend the description a
bit there.

 Documentation/git-send-email.txt | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git c/Documentation/git-send-email.txt w/Documentation/git-send-email.txt
index 3db4eab4ba..8adc8ace79 100644
--- c/Documentation/git-send-email.txt
+++ w/Documentation/git-send-email.txt
@@ -9,7 +9,8 @@ git-send-email - Send a collection of patches as emails
 SYNOPSIS
 --------
 [verse]
-'git send-email' [<options>] <file|directory|rev-list options>...
+'git send-email' [<options>] <file|directory>...
+'git send-email' [<options>] <format-patch options>
 'git send-email' --dump-aliases
 
 
@@ -19,7 +20,8 @@ Takes the patches given on the command line and emails them out.
 Patches can be specified as files, directories (which will send all
 files in the directory), or directly as a revision list.  In the
 last case, any format accepted by linkgit:git-format-patch[1] can
-be passed to git send-email.
+be passed to git send-email, and options understood by
+linkgit:git-format-patch[1] can be passed.
 
 The header of the email is configurable via command-line options.  If not
 specified on the command line, the user will be prompted with a ReadLine


