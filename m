Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 804DC20437
	for <e@80x24.org>; Thu, 12 Oct 2017 11:08:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752704AbdJLLIn (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Oct 2017 07:08:43 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64775 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752519AbdJLLIm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Oct 2017 07:08:42 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1D570A08A9;
        Thu, 12 Oct 2017 07:08:42 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=mBrOl5l6FELfAT6TOUluBXyTWW0=; b=KAtaOJ
        4a5PjjxHY0DAwwNFzrgARtokzkKhA1GpQjdtTFxMJqwgjw2kRs15Tj5zA3gtPDLQ
        Yg//0EObvIpByptwdeauGBHT5Ov0Mnmf7o69bMUlkz2sIsqL16oaKdKzoxy5jV43
        1oeetyY2DnAkAhKGVdPPd6ExlYlWWJpPZo98I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=m2Gm3sbELjc2clMSxI36QfHsC9yFvU2s
        fgaxN+nr1u0gCpx1mp7h6ZD1nnNGJAY8DSWy8cqFyGRHzU+2CVKaqtS+TPuEZHif
        ZI+xC1ihdi/d87xACaeU1oTOqMYLDS4uYzuMxoYUhVv0Esd8DcX14bH7nb6Z6ml/
        /Km+M6byOHk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 14D55A08A8;
        Thu, 12 Oct 2017 07:08:42 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 85498A08A7;
        Thu, 12 Oct 2017 07:08:41 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "W. Trevor King" <wking@tremily.us>
Cc:     Git <git@vger.kernel.org>,
        =?utf-8?Q?=C5=81ukasz?= Gryglicki <lukaszgryglicki@o2.pl>
Subject: Re: [PATCH] pull: pass --signoff/--no-signoff to "git merge"
References: <18953f46ffb5e3dbc4da8fbda7fe3ab4298d7cbd.1507752482.git.wking@tremily.us>
        <xmqqefq92mgw.fsf@gitster.mtv.corp.google.com>
Date:   Thu, 12 Oct 2017 20:08:40 +0900
In-Reply-To: <xmqqefq92mgw.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Thu, 12 Oct 2017 10:17:51 +0900")
Message-ID: <xmqq7ew0zkqv.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B494DA06-AF3D-11E7-93CA-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> 	get_signoff () {
> 		git cat-file commit "$1" | sed -n -e '/^Signed-off-by: /p'
> 	}
>
> Some may say "cat-file can fail, and having it on the LHS of a pipe
> hides its failure", advocating for something like:
>
> 	get_signoff () {
> 		git cat-file commit "$1" >sign-off-temp &&
> 		sed -n -e '/^Signed-off-by: /p' sign-off-temp
> 	}

Actually we should use git itself for things like this, e.g.

	git -C dst show -s --pretty='format:%(trailers)' HEAD >actual &&
	test_cmp expect actual



