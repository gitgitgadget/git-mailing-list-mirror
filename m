Return-Path: <SRS0=lJm1=AA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15DBBC433E0
	for <git@archiver.kernel.org>; Fri, 19 Jun 2020 16:33:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF29C21852
	for <git@archiver.kernel.org>; Fri, 19 Jun 2020 16:33:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="eXteMiYL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395140AbgFSQdv (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Jun 2020 12:33:51 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63306 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389086AbgFSQds (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Jun 2020 12:33:48 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7A2286DF98;
        Fri, 19 Jun 2020 12:33:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=PIO5CEd8qylv
        LZbnWqJcAsu7DU0=; b=eXteMiYLwAUJnCTk3XnOTVIdvW0SDGUxhqUzpMhLk5HG
        zybhZsR/EXEDmuY9/1+WBi2pCHf8XXIlIQhG9G6fGgXd8hckSbY3GjP137DjKAt/
        u1PiokJRkdwqQ+hrhw0CEcm7Ipsz1lGR4YjNKzfpzGztNLbohZGG4uezkD78c9M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=tGjaQN
        epI+K29lgFJnGtXNUvt9dvBVSNk3lnrbNdcfdazvZZbRYxHyIEvq7otR8FXVfVi0
        IDlibByILyGMbVTes1H8JMClNU71DvbP+DEyjhVT8QjkLtxrKqgHJYMH28YlLqEh
        u6CEEMCDYM6zDQWvT/EVfmWGtStAY6jrTqTYQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 719526DF97;
        Fri, 19 Jun 2020 12:33:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 01ACB6DF96;
        Fri, 19 Jun 2020 12:33:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, dstolee@microsoft.com,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v2 2/2] git-prompt: include sparsity state as well
References: <pull.808.git.git.1592350413.gitgitgadget@gmail.com>
        <pull.808.v2.git.git.1592513398.gitgitgadget@gmail.com>
        <17254b30a5bcbbe3e14dd47272dfcb4c867030dd.1592513398.git.gitgitgadget@gmail.com>
        <20200619161528.GI2898@szeder.dev>
Date:   Fri, 19 Jun 2020 09:33:45 -0700
In-Reply-To: <20200619161528.GI2898@szeder.dev> ("SZEDER =?utf-8?Q?G=C3=A1?=
 =?utf-8?Q?bor=22's?= message of
        "Fri, 19 Jun 2020 18:15:28 +0200")
Message-ID: <xmqqftarj9qu.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: A562443E-B24A-11EA-B2A0-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER G=C3=A1bor <szeder.dev@gmail.com> writes:

>> +	local sparse=3D""
>> +	if [ "$(git config --bool core.sparseCheckout)" =3D=3D "true" ]; the=
n
>> +	    sparse=3D"|SPARSE"
>
> Nit: indentation.

Also, do we want "=3D=3D" there?  I thought [ ... ] (unlike [[ ... ]])
was a mere synonym for "test", to which "=3D=3D" is a bug.

