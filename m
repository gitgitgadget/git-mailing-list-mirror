Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F1DBECDFA1
	for <git@archiver.kernel.org>; Tue, 25 Oct 2022 22:41:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232648AbiJYWlQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Oct 2022 18:41:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232796AbiJYWlL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Oct 2022 18:41:11 -0400
Received: from mermet.sourcephile.fr (revolt129.abo.ilico.org [80.67.180.129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0DDF89ADF
        for <git@vger.kernel.org>; Tue, 25 Oct 2022 15:41:03 -0700 (PDT)
Date:   Wed, 26 Oct 2022 00:40:58 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sourcephile.fr;
        s=20200101; t=1666737658;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ocEf7UIiGbP0bELMXgOUTqOI9IZnb7UKu2gccbHKMps=;
        b=LUeaHKwQFh8sH53NpNCSEHRPc6hL+7+4VUmEw+WnlinuFY4by29+xjN2jtK+w1eWQr1WZ0
        QgBad4mwXHmOGFGu4vtgCU/6Gh55r+cpkRbqgrPl+1b6rk4HwoN6J37xkYviCrzFAo1UYq
        F66oSVbhqV+YS0jHh63/Wf5L6zKJ5l7hrC7QdQFgTjyC8HZRwbgcNZ1JuyxFjx3tK8I9ED
        Wn0L4rTruUOKK7uwueU0Nvx06DNkaTgnJ8U3supN+KeYZcEYD1sgRu2essPqWm90IDEFG9
        2hpPkDGUbF5mY8O5YxNQIWttr6CU7VdP0CSnIx1Dddq5ZKzgnjNO1dZpcU9DdUwkn1taMZ
        C48xgl8lQTYLgkwjX7tZrMl1lI13lDHIQPMPnhdqHaQFnuU8tlDo6bhXxVMPIkMFX6sj9P
        BtibMRULM6ihCBetJpKl4UOaBw9Pp4iHoRm9ZdEFTR82Zj1BDDyWahC2iiyaGBP5wmA/xP
        dhR0jLfGjp7nOCNhmBK9zvZBu56Cyv54zYY5N/lIHFnnAevFsBduN7AM8oVFkYg9W7WHo7
        kmkyUcxyJ4i2uJmgkoV6HtJGAI+Ov5ZGdoH4nKghqCLRUyNHD00FU94n3yzAPqwLfOiFEu
        rWMUJWv31bkbfQOs82feOrPTZcx7LpKp3ljrE4QwbkNzNeKKR4acc=
From:   Julien Moutinho <julm+git@sourcephile.fr>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Eric Wong <e@80x24.org>
Subject: Re: FORCE_DIR_SET_GID denied inside nix's build sandbox
Message-ID: <20221025224058.7kc4x43lkkncmak3@sourcephile.fr>
References: <20221025163024.uutqv7w24yi4eo5i@sourcephile.fr>
 <xmqq7d0nonbw.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <xmqq7d0nonbw.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Le mar. 25 oct. 2022 09h54 -0700, Junio C Hamano a =C3=A9crit=C2=A0:
> But if you use 0600, then the group ownership should not matter, so
>=20
>     /* Copy read bits to execute bits */
>     new_mode |=3D (new_mode & 0444) >> 2;
>     if (new_mode & 060)
> 	new_mode |=3D FORCE_DIR_SET_GID;
>=20
> might be what you want?
That change makes more sense indeed,
and does relax the chmod enough
to solve our problem when running public-inbox tests
into nix's build sandbox.

Thank you!

PS: please let me know if you need me to submit a proper patch,
otherwise I'm leaving this up to you if you don't mind.
