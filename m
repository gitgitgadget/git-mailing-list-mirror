Return-Path: <SRS0=QgeI=7Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1004C433E0
	for <git@archiver.kernel.org>; Thu, 11 Jun 2020 23:16:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9CDB420842
	for <git@archiver.kernel.org>; Thu, 11 Jun 2020 23:16:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="RUp211JV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726349AbgFKXQi (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Jun 2020 19:16:38 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55251 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726285AbgFKXQi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Jun 2020 19:16:38 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 19C6178849;
        Thu, 11 Jun 2020 19:16:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=V3hLONSzEeIS
        QzJ/bhkHkrbWzMo=; b=RUp211JV74byxfKJfZE2gI6sgTd3YMBck284+QlIRu1r
        oK/fDmGRTLhWkTz/GDxW5bWF3KrpW4FZTjcceMRYfT6/U0OnYslywu86LMI+Q2M7
        6A9lPm/4EYSso0J1mjoCDB6D2B3DTEA3XPaIkUJGAOOav+CB0y7PMR3oG7bIDqc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=pSe2MI
        vNhL+RCkO7lARG7/Gi6P5R52Sbmb7p3I+a2oM/6+ZFVG8RG/pdNDU1obf+soyIzM
        czSx1aWhqqxh25IjGjHZBwGJyL4AaRfrC9qoZqkX2JrC5gH9BV4eRatSG3H+sK7/
        SXIZQxfhu3yYjiM4U8v4Pr54cbnP6UciAndRA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 11DBB78848;
        Thu, 11 Jun 2020 19:16:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 966F078847;
        Thu, 11 Jun 2020 19:16:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ed Avis <ed.avis@qmaw.com>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: git log --name-only improvement: show old file name in rename
References: <BL0PR11MB3460BEB60550854661B5178B9D800@BL0PR11MB3460.namprd11.prod.outlook.com>
Date:   Thu, 11 Jun 2020 16:16:34 -0700
In-Reply-To: <BL0PR11MB3460BEB60550854661B5178B9D800@BL0PR11MB3460.namprd11.prod.outlook.com>
        (Ed Avis's message of "Thu, 11 Jun 2020 11:19:14 +0000")
Message-ID: <xmqqsgf1i46l.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 984A8EBC-AC39-11EA-937C-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ed Avis <ed.avis@qmaw.com> writes:

> The git-log manual page says
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0--name-only
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Show only names of changed fil=
es.
>
> But when a file has been renamed, only the new name is printed, not the=
=20
> old.=C2=A0 I think it would be more useful and more correct to print bo=
th=20
> names.=20

It is just you who thinks it would be more useful.

Scripts written by people over the last 10 years that expect to see
new name would certainly hate to see two names start appearing
there.

Perhaps you can use --summary at the same time?
