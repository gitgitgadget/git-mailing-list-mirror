Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12B88C433F5
	for <git@archiver.kernel.org>; Fri, 14 Jan 2022 20:42:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244340AbiANUmY (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Jan 2022 15:42:24 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:52422 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239585AbiANUmX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Jan 2022 15:42:23 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B7CB71676A5;
        Fri, 14 Jan 2022 15:42:21 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=9hd+wMAqLggO
        7Vpl7OEmfMUGqk4fGwgLzfPZu+/oh7w=; b=e9zQ7Yfix90uekP2keHoh3H/wHGc
        i4qg1KXNrEz9c/xbTLL4jI0k9rsaP3atFnAjEqyCnYEJsleIMyaGIeIJwNRUs/03
        WMAVUn90sPHgMhN6k99pbhNYdlrYqmeZ8lRETDV/4oleCzrk60Ic+FgG1r003Zij
        VcvlkXxZYb4WroI=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B01941676A4;
        Fri, 14 Jan 2022 15:42:21 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 1507E1676A3;
        Fri, 14 Jan 2022 15:42:19 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Teng Long <dyroneteng@gmail.com>, git@vger.kernel.org,
        tenglong.tl@alibaba-inc.com
Subject: Re: [RFC PATCH v1 0/1] ls-remote: inconsistency from the order of
 args and opts
References: <cover.1642129840.git.dyroneteng@gmail.com>
        <xmqqfspqeun5.fsf@gitster.g>
        <220114.867db2rs0n.gmgdl@evledraar.gmail.com>
Date:   Fri, 14 Jan 2022 12:42:17 -0800
In-Reply-To: <220114.867db2rs0n.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Fri, 14 Jan 2022 20:57:17 +0100")
Message-ID: <xmqqbl0eaw2e.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 776243D2-757A-11EC-9B3B-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> We have multiple commands that are in GNU-fashion loose about whether
> you provide options first before no-option args, or after. E.g. we
> accept both of:
>
>     git push --dry-run <remote> <ref>
>
> And:
>
>     git push <remote> <ref> --dry-run

Yes, but I consider that a bug that we cannot fix due to backward
compatibility issues.

That is why my preference is to encourage users to stick to the
POSIX way in gltcli, just like we recommend "stuck" form of options
its parameter.

> But when GNU came around its option parser was generally happy to accep=
t
> options and args in either order. E.g. these both work with GNU
> coreutils, but the latter will fail on FreeBSD and various other
> capital-U UNIX-es:
>
>     touch foo; rm -v foo
>     touch foo; rm foo -v

Yes, among the harm GNU has done on mankind, this is one of the
biggest ones.  We shouldn't waste our engineering time to support
more of them in our tools.

As long as users stick to the recommended "dashed options first and
then args, among which revs come first and then pathspecs", they
will be fine.
