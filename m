Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C1B5A1F453
	for <e@80x24.org>; Fri,  8 Feb 2019 20:11:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727860AbfBHULf (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Feb 2019 15:11:35 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54616 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727415AbfBHULd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Feb 2019 15:11:33 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6CC4D149F6B;
        Fri,  8 Feb 2019 15:11:31 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=date:from:to
        :cc:subject:message-id:references:mime-version:content-type
        :in-reply-to:content-transfer-encoding; s=sasl; bh=3Zv1L31uLuHxE
        GW6DIj7be3q+mw=; b=StFrvc4/+bm6pNuVI+QE+9M49is8e5Huy8g9MW3GfKj4Y
        6D0JoKC9B8l0h9gBMjR/gz4lclI8hB4pVGYp+mFU+oYFxOJ0WckaR9aWwA/PVmxH
        waH5J21T8CGGws3b5rFIV1N1/qNo+IF1spDoGsXrwGAHXNzVqwessS2N9IHhjM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=date:from:to:cc
        :subject:message-id:references:mime-version:content-type
        :in-reply-to:content-transfer-encoding; q=dns; s=sasl; b=jcQn6+5
        N3QKhCjOQ82RVLf6GyRo28PcajNlnsPl3x1s0/YYlec7D5wS9VFXCbNAJlcews6K
        /Zph7DKCTE0y7k8GiVTHdexoqndnZwoSPE9TRsIJwRK9/0rzckdfOXxeXVaABn5C
        akRhAwqN6XhjNFMnAZf/op+HjtfCk17Na5Rs=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 636A5149F6A;
        Fri,  8 Feb 2019 15:11:31 -0500 (EST)
Received: from zaya.teonanacatl.net (unknown [71.173.194.225])
        (using TLSv1.2 with cipher AES256-SHA (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id CDE64149F69;
        Fri,  8 Feb 2019 15:11:30 -0500 (EST)
Date:   Fri, 8 Feb 2019 15:11:29 -0500
From:   Todd Zullinger <tmz@pobox.com>
To:     SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>
Cc:     "Randall S. Becker" <rsbecker@nexbridge.com>,
        Jeff King <peff@peff.net>,
        'Junio C Hamano' <gitster@pobox.com>, git@vger.kernel.org,
        'Linux Kernel' <linux-kernel@vger.kernel.org>,
        git-packagers@googlegroups.com
Subject: Re: [Breakage] Git v2.21.0-rc0 - t5403 (NonStop)
Message-ID: <20190208201128.GD30548@zaya.teonanacatl.net>
References: <000d01d4bf9b$d5d48da0$817da8e0$@nexbridge.com>
 <20190208111002.GU10587@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20190208111002.GU10587@szeder.dev>
User-Agent: Mutt/1.11.1 (2018-12-01)
X-Pobox-Relay-ID: B9646A38-2BDD-11E9-8887-DF19F34BB12D-09356542!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER G=E1bor wrote:
> On Fri, Feb 08, 2019 at 05:48:27AM -0500, Randall S. Becker wrote:
>> We have a few new breakages on the NonStop port in 2.21.0-rc0. The fir=
st is in t5403, as below:
[...]
>> The post-checkout hook is:
>> #!/usr/local/bin/bash
>> echo "$@" >$GIT_DIR/post-checkout.args
>>=20
>> This looks like it is a "bash thing" and $GIT_DIR might have to be in =
quotes, and is not be specific to the platform. If I replace=20
>>=20
>> echo "$@" >$GIT_DIR/post-checkout.args
>>=20
>> with
>>=20
>> echo "$@" >"$GIT_DIR/post-checkout.args"
>>=20
>> The test passes.
>=20
> Wow, this is the second time this "redirection to a filename with
> spaces under Bash" issue pops up today, see the other one here:
>=20
>   https://public-inbox.org/git/20190208031746.22683-2-tmz@pobox.com/T/#=
u

Indeed, I was surprised to see another one today.

It made me wonder how I had missed it in my own testing.
This one requires SHELL_PATH to be bash, while I only set
TEST_SHELL_PATH to bash for the improved -x tracing in the
fedora builds.

I ran the tests again with SHELL_PATH as bash on fedora and
this was the only failure I saw (other than the one from my
earlier message, that is).

--=20
Todd
