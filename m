Return-Path: <SRS0=KD4O=32=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7738BC33CAC
	for <git@archiver.kernel.org>; Thu,  6 Feb 2020 16:17:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E35A21741
	for <git@archiver.kernel.org>; Thu,  6 Feb 2020 16:17:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="aoVWBFim"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727687AbgBFQR6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Feb 2020 11:17:58 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:51730 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727379AbgBFQR6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Feb 2020 11:17:58 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 3BF25BD833;
        Thu,  6 Feb 2020 11:17:56 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=h71+e+cAHYwugrIK4wSauW56Nnc=; b=aoVWBF
        im1s4TzmGGngJ/QSUXk42saGf+Uq7hsoesVnujsxM/I1rx2UQu6Qi0h7qVBw8DIy
        fdfszwOHSNNhSNxCXT5il7vALQkmQoz5l+aLIv8UaMfNOa3sQxUsq98FF8kecfzS
        6g+ikeflTm/owYSBssYUZnv371gZgMoqHIr70=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Lo/CmJQWkOeEhZd9VezYQwhR4XR1/p4j
        ALQENCzrV7ZWMPaL58g6VsEK02Ef3Oxv1E7sqMYHuXExN3DoEKKnZKLimBV9CYES
        eINWU0bx4M8FSI7lmIf0EkMSRYBrmyF4pYAAcY4rZUD25zrPxovcl6iZ2QH+1quX
        zKSHivxrRQg=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 351C0BD832;
        Thu,  6 Feb 2020 11:17:56 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 5BEF0BD831;
        Thu,  6 Feb 2020 11:17:53 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>, git@vger.kernel.org
Subject: Re: bug? illegal text in commit log
References: <20200204010524-mutt-send-email-mst@kernel.org>
        <b005193f-24b7-7b6f-f3dc-c7a98db14ed7@web.de>
        <xmqqimkm6o4r.fsf@gitster-ct.c.googlers.com>
        <20200206012854-mutt-send-email-mst@kernel.org>
Date:   Thu, 06 Feb 2020 08:17:50 -0800
In-Reply-To: <20200206012854-mutt-send-email-mst@kernel.org> (Michael
        S. Tsirkin's message of "Thu, 6 Feb 2020 01:34:11 -0500")
Message-ID: <xmqqlfpfg05t.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3A37B0AC-48FC-11EA-923B-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Michael S. Tsirkin" <mst@redhat.com> writes:

> It might be intended for other purposes, for example instructions:
>
> To try out the new foobar flag, execute the following script:
>
> git apply --foobar << EOF
> --- a.txt       2020-02-04 01:09:27.927026571 -0500
> +++ c.txt       2020-02-04 01:06:57.404688233 -0500
> @@ -1 +1 @@
> -AA
> +BB
> EOF
>
> indenting would break the script, and make it harder for users
> to follow the instructions.

Sorry, but that sounds like a made-up example to me.

Why would anybody write that in the log message, instead of placing
it in the documentation?  The log message will be lost to those who
receive tarballs, and even to those who clone the source it needs
active effort to dig one particular change out.

