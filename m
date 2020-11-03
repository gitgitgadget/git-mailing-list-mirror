Return-Path: <SRS0=XO6Y=EJ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73DADC2D0A3
	for <git@archiver.kernel.org>; Tue,  3 Nov 2020 18:20:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 28D0A20786
	for <git@archiver.kernel.org>; Tue,  3 Nov 2020 18:20:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="xStoKmJh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728621AbgKCSUE (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Nov 2020 13:20:04 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:57620 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725892AbgKCSUD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Nov 2020 13:20:03 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 1F5CDE3908;
        Tue,  3 Nov 2020 13:20:02 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=kNrR8Y1vDRHw
        dZ2XspaJCk0z2cQ=; b=xStoKmJhmliEeSmp4Rx+HK8ccT7U3SIWkv2q43JShJ2F
        yLnemdahrZ6WUGNZGH4Ga4CwqnqiP9Ja9oAh0xkbVTT400w97JPshQmyKt+aZWHl
        grp2tVd66vG8wCqhsuYcb/17N4aLGGTCtGW47KNUYVdLXSMXLyL/Rp5Z8GxBhPM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=iRIIxH
        w4TCMfWTyFsh7fXB6YB3DhuOVEcLSQEBJeu8kb+q/IQh6OHjmmNlEJViXfvKkhHV
        lml+f9VC0n6ShqmtiHuKOwCjBhUJd8TWCgb54yp3Cka9SvTTqBRaATGcWHqIcZ9s
        nubN2d6dlVX1VL8Zg8dAxSLVqTITLsjTzMTUc=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 176E6E3907;
        Tue,  3 Nov 2020 13:20:02 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 45AFEE3904;
        Tue,  3 Nov 2020 13:19:59 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     jnareb@gmail.com (Jakub =?utf-8?Q?Nar=C4=99bski?=)
Cc:     "Abhishek Kumar via GitGitGadget" <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Abhishek Kumar <abhishekkumar8222@gmail.com>
Subject: Re: [PATCH v4 09/10] commit-reach: use corrected commit dates in
 paint_down_to_common()
References: <pull.676.v3.git.1597509583.gitgitgadget@gmail.com>
        <pull.676.v4.git.1602079785.gitgitgadget@gmail.com>
        <bb9b02af32d028fc0c26d372aa490e260c74e74d.1602079786.git.gitgitgadget@gmail.com>
        <85y2jiqq3c.fsf@gmail.com>
Date:   Tue, 03 Nov 2020 10:19:57 -0800
In-Reply-To: <85y2jiqq3c.fsf@gmail.com> ("Jakub =?utf-8?Q?Nar=C4=99bski=22?=
 =?utf-8?Q?'s?= message of "Tue,
        03 Nov 2020 18:59:03 +0100")
Message-ID: <xmqq7dr2s3oy.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 2EBED784-1E01-11EB-837E-E43E2BB96649-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

jnareb@gmail.com (Jakub Nar=C4=99bski) writes:

> I suspect that there are cases (with date skew) where corrected commit
> date gives better performance than committer date heuristics, and I am
> quite sure that generation number v2 can give better performance in cas=
e
> where paint_down_to_common() uses generation numbers.

Thanks for a well reasoned review.

>
> .................................................................
>
> Here begins separate second change, which is not put into separate
> commit because it is fairly tightly connected to the change described
> above.  It would be good idea, in my opinion, to add a sentence that
> explicitely marks this switch, for example:
>
>   This change accidentally broke fragile t6404-recursive-merge test.
>   t6404-recursive-merge setups a unique repository...
>
> Maybe with s/accidentaly/incidentally/.

Also "setup" is not a verb.  "... sets up a unique repository".

> Or add some other way of connection those two parts of the commit
> messages.
> ...
>> As this has already causes problems (as noted in 859fdc0 (commit-graph=
:
>> define GIT_TEST_COMMIT_GRAPH, 2018-08-29)), we disable commit graph
>> within t6404-recursive-merge.
>
> Very nice explanation.
>
> Perhaps in the future we could make this test less fragile.

If "separate second change" is distracting, would it be an option to
fix the test before this step, perhaps?

Thanks.
