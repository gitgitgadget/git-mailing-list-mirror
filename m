Return-Path: <SRS0=ZAU+=3M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F480C33CAA
	for <git@archiver.kernel.org>; Thu, 23 Jan 2020 23:03:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31447218AC
	for <git@archiver.kernel.org>; Thu, 23 Jan 2020 23:03:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ZRdIXIBN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729596AbgAWXDl (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Jan 2020 18:03:41 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:55105 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728803AbgAWXDl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Jan 2020 18:03:41 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E179FB5F82;
        Thu, 23 Jan 2020 18:03:38 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=54NO7SxiJPDfrEC8SYtwhbNXnXg=; b=ZRdIXI
        BNiCuo3yMC8/qfu5+k8ZK8fs6HuxvBfFZCmG1/lWvc62Jq6ehHHDKVaUqcQA5lOo
        MB79kVZO92XI//MqR5DY4Eh70JevPLolivEjdK3gutk/9nzExUw/TcK3Um2DxWZW
        g19VyEkNaGuJaFNjrLWanbpvjyrxEuoWIvZaU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ls2ATXK5J9NBU/xO4JY7xbPSX6bPhH5Y
        aQlLllSeT2/nlN7p++Fch7KShR9kGmdQazRHgnRZXQBmTROdlDjyILyBRZ2OHXL3
        jugiWT+pmYhRpysYDPt3dB/9xslUGKvAqq9vo1NKGKU+Bjf0Rg91wfKjX/kpzKzr
        MC2i5q2Op9o=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id D996EB5F81;
        Thu, 23 Jan 2020 18:03:38 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 08964B5F80;
        Thu, 23 Jan 2020 18:03:35 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Bert Wesarg <bert.wesarg@googlemail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Matthew Rogers <mattr94@gmail.com>
Subject: Re: [PATCH 7/7] remote rename: gently handle remote.pushDefault config
References: <cover.1579598053.git.bert.wesarg@googlemail.com>
        <d10d3049ce9824f6925dddeb12cc130627a8c478.1579598053.git.bert.wesarg@googlemail.com>
Date:   Thu, 23 Jan 2020 15:03:33 -0800
In-Reply-To: <d10d3049ce9824f6925dddeb12cc130627a8c478.1579598053.git.bert.wesarg@googlemail.com>
        (Bert Wesarg's message of "Tue, 21 Jan 2020 10:24:55 +0100")
Message-ID: <xmqqftg53hdm.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 95CA7B2A-3E34-11EA-AF5F-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Bert Wesarg <bert.wesarg@googlemail.com> writes:

> @@ -746,6 +769,26 @@ static int mv(int argc, const char **argv)
>  			die(_("creating '%s' failed"), buf.buf);
>  	}
>  	string_list_clear(&remote_branches, 1);
> +
> +	struct push_default_info push_default;

Likewise.  decl-after-stmt is not allowed.
