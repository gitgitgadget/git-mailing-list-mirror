Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE999C001B0
	for <git@archiver.kernel.org>; Fri,  7 Jul 2023 19:02:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232877AbjGGTCK (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Jul 2023 15:02:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231967AbjGGTCH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Jul 2023 15:02:07 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6673C26A3
        for <git@vger.kernel.org>; Fri,  7 Jul 2023 12:01:31 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0273E197C75;
        Fri,  7 Jul 2023 15:01:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=6ZAiJDTjpx3q
        A0j6aj6uL8Z5Xg4ZmBYFYIlHLxOOAPw=; b=neN7biSbnKv0ymgquBhQKGcT6bLU
        7awF2Ignch+gnapf/ttWOP2MXtxiJJb2XXH7uccENzOfYYYc/13JDzu2ZG1uCfeg
        SFLH0e907TbKrPFgMzdAAInEmtIiN8vhq151CYnPh2mctRzSfMsFt+Ecrcf8264y
        tPw3QflHzFUJs7A=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id ED290197C74;
        Fri,  7 Jul 2023 15:01:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.127.75.226])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 46AB0197C72;
        Fri,  7 Jul 2023 15:01:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: [PATCH] ls-tree: simplify prefix handling
References: <b34aa99b-2bf1-c645-bdf5-03ac258b4bf5@web.de>
Date:   Fri, 07 Jul 2023 12:01:15 -0700
In-Reply-To: <b34aa99b-2bf1-c645-bdf5-03ac258b4bf5@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Fri, 7 Jul 2023 20:34:31 +0200")
Message-ID: <xmqqh6qf8s1w.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: A65432AA-1CF8-11EE-890B-307A8E0A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> git ls-tree has two prefixes: The one handed to cmd_ls_tree(), i.e. the
> current subdirectory in the repository (if any) and the "display" prefi=
x
> used by the show_tree_*() functions.  The option --full-name clears the
> last one, i.e. it shows full paths, and --full-tree clears both, i.e. i=
t
> acts as if the command was started in the root of the repository.

Seeing "there are two" and then "the last one" made me come back to
the beginning to see if I missed the third option, as I am not used
to see the second one among two called "the last", even though it is
logically correct.  "clears the latter", perhaps, as "former vs
latter" is sensible only when there are two, may have avoided my
confusion, but that is minor.

> The show_tree_*() functions use the ls_tree_options members chomp_prefi=
x
> and ls_tree_prefix to determine their prefix values.  Calculate it once
> in cmd_ls_tree() instead, once the main prefix value is finalized.

Very nice observation and simplification.

Thanks.
