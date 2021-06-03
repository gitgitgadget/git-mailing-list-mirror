Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A37A7C47083
	for <git@archiver.kernel.org>; Thu,  3 Jun 2021 00:56:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D3A8613DC
	for <git@archiver.kernel.org>; Thu,  3 Jun 2021 00:56:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbhFCA5p (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Jun 2021 20:57:45 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63982 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbhFCA5n (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Jun 2021 20:57:43 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2D79CC37FF;
        Wed,  2 Jun 2021 20:55:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=4bBBpe4v1HJQ
        zUvPl+GsaxX82A9mcN8c7tvbWrMcnJo=; b=tvcFEDhImLAx3fouOy20SndnM6j8
        Pb/Jxuvt4NlyzQLjr8RXtWBDLjaDr8uZFPwp9pKd5hCP7ibgv74Rthuq32gEMqmn
        jPhqa5zSghNb2zl9gP84E02j64bfmlkgk1JrgYTAEVoyUBRJAfMTY/E0jLjLnDna
        7dhSr6at+IF/80M=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 25E4BC37FE;
        Wed,  2 Jun 2021 20:55:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.172.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 9671BC37FC;
        Wed,  2 Jun 2021 20:55:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Ilias Apostolou <ilias.apostolou.zero@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Request feature: =?utf-8?Q?=E2=80=93no-submodule?=
References: <c5709df6-c357-56b4-f0e0-673bc8b4e668@gmail.com>
        <YLfqiLbpPXWXHlBi@nand.local>
Date:   Thu, 03 Jun 2021 09:55:57 +0900
In-Reply-To: <YLfqiLbpPXWXHlBi@nand.local> (Taylor Blau's message of "Wed, 2
        Jun 2021 16:31:04 -0400")
Message-ID: <xmqq8s3r7oma.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 75934162-C406-11EB-BD9A-FD8818BA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> On Wed, Jun 02, 2021 at 01:31:11PM +0300, Ilias Apostolou wrote:
>> Hello Git community.
>>
>> As you already know, git ls-files command lists all of the tracked fil=
es,
>> but submodule names are included.
>>
>> My team would like a =E2=80=93no-submodule switch to exclude those.
>
> In all honesty, though this seems like a niche request for ls-files to
> fulfill, ls-files already has quite the collection of options, so I
> wouldn't be sad to see it learn how to do this, too.

I would be somewhat sad for two reasons.

 - If "I am not interested in any submodule" in a project with
   submodules is a common thing people would want, teaching a trick
   only to "ls-files" is an expensive and ineffective approach, and
   adding the option to everything would just be ugly.  "git diff
   --no-submodule"?  "git add --no-submodule ."?

 - Is "not interested in any submodule" so special and fundamental,
   or is it merely because the project the original requestor is
   looking at happens to have an optional submodule? If the project
   had that optional part as a subdirectory instead, would the
   request have been not --no-submodule but something else?  What
   happens when the project that led to the original request
   acquires another submodule that is more interesting, or what if
   the requestor's interest shifts and makes some submodules
   interesting but others not?  Would the --no-submodule option
   become totally useless in such a case?

I wonder if the "attr" magic of the pathspec, that allows you to
choose paths based on the attributes you set on them, is what the
original requestor missed.

