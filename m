Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F3D5720285
	for <e@80x24.org>; Fri, 25 Aug 2017 01:19:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754252AbdHYBTt (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 Aug 2017 21:19:49 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56939 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754250AbdHYBTp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Aug 2017 21:19:45 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 671EBA51E3;
        Thu, 24 Aug 2017 21:19:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=UYeQHYW4t+UL0lHqQ1OX5d8UWhY=; b=gNYhzA
        oti6JxL6OV7pQTLc+7qSZgRIZI7x3gzB6rFc2uexcgjFwxwIu4ItuSajOKMW3yFA
        CwPm4shQQll60rPiC2dsE2pNd3ubL9fbf+C5cbNTmJt/jLoRC7zt/x8wAF3Bqbhy
        Pdceg8grXWmM7ch+rH05IVi6dxN1HhK9cvAm8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=XvCekNUozsHJeH6cWjMHQX8H/oumB8Xz
        Mny+jqtlZhCBVET16r2DxO8Kx6OQpEfxjiMNYWj8UAkJ0yHBhcRPnuvm7r6c7qcZ
        OufIjGVQ7XvhRac8p+ALfdNc7jK8WGfEri/GhkMaZbxaW9x4UQZ/l8MQ4BD5Vbmq
        rb4ha+qOopU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5E83FA51E2;
        Thu, 24 Aug 2017 21:19:39 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id BF4A5A51E0;
        Thu, 24 Aug 2017 21:19:38 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, peff@peff.net, jrnieder@gmail.com,
        sbeller@google.com, jonathantanmy@google.com
Subject: Re: [RFC 0/7] transitioning to protocol v2
References: <20170824225328.8174-1-bmwill@google.com>
Date:   Thu, 24 Aug 2017 18:19:37 -0700
In-Reply-To: <20170824225328.8174-1-bmwill@google.com> (Brandon Williams's
        message of "Thu, 24 Aug 2017 15:53:21 -0700")
Message-ID: <xmqq7exsv3yu.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 76D3AAD8-8933-11E7-AB18-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams <bmwill@google.com> writes:

> The best way to preserve functionality with old servers and clients would be to
> communicate using the same end point but have the client send a bit of extra
> information with its initial request.  This extra information would need to be
> sent in such a way that old servers ignore it and operate normally (using
> protocol v1).  The client would then need to be able to look at a server's
> response to determine whether the server understands and is speaking v2 or has
> ignored the clients request to use a newer protocol and is speaking v1.

Good. I think the idle talk last round was for the server to tell
the v1 client "we are still doing the slow ls-remote comes first
protocol with this exchange, but just for future reference, you can
use the v2 endpoint with me", which was way less desirable (even
though it may be safer).

> Patches 1-5 enable a client to unconditionally send this back-channel
> information to a server.  This is done by sending a version number after a
> second NUL byte in git://, in the envvar GIT_PROTOCOL in file:// and ssh://,
> and in an http header in http://, https://.  Patches 6-7 teach a client and
> upload-pack to send and recognize a request to use protocol v2.

All sounds sensible.

 - for git://, if you say you found a hole in the protocol to stuff
   this information, I simply believe you ;-)  Good job.

 - http:// and https:// should be a no-brainer as the HTTP headers
   give ample room to send information from the initiator side.

 - For ssh://, I do not think it is sane to assume that we can
   convince server operators to allow passing any random environment
   variable.  If the use of this specific variable turns out to be
   popular enough, however, and its benefit outweighs administrative
   burden, perhaps it is not impossible to convince them to allow
   AcceptEnv on this single variable.

Thanks.
