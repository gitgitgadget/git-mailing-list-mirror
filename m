Return-Path: <SRS0=8h89=7R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AF19C433E0
	for <git@archiver.kernel.org>; Thu,  4 Jun 2020 15:11:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2AFC4206DC
	for <git@archiver.kernel.org>; Thu,  4 Jun 2020 15:11:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Ixeg1VzX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729107AbgFDPLT (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Jun 2020 11:11:19 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:58482 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728587AbgFDPLS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Jun 2020 11:11:18 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B7A13BCE47;
        Thu,  4 Jun 2020 11:11:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=R3WSCFJiZyMjSzBqIsrtMAre1Ac=; b=Ixeg1V
        zXH9GIXTHS5cF/dfHrE5iL1xlAT+QO/bwLA/xeYyjgNBT+yoIi9DCzZXYb/vSqLS
        aQ3e2alUnBdFL4Vk3jlt0jhmyHI5RvHuQ3/1tREPsiDPnvIB7zp/XoiW1isHZv5F
        S1cm7SrGmTFdo/hUAO+c8aETS3EfSE2iCwUR8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=LjG1gcyd69HBZYaEh9+/yd/OAHQlJ8Xd
        SfmY8C67d9RM2Lf7YWGmQHALj+11/2FsEZabfSykjpgzMS+WEAPq3IY2NumLzMX9
        7kF659wt2sko1uU+zbfBiYj8BfK2NXE+f6GJYLrelZTzSVgmJC/qkB3Yy8mq//+v
        q9PlMZWXj5o=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id AFCE5BCE46;
        Thu,  4 Jun 2020 11:11:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id EF009BCE45;
        Thu,  4 Jun 2020 11:11:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kalle Kromann <kalle.kromann@man-es.com>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: The commit-msg hook is not invoked by git-merge as specified in documentation
References: <AM0PR08MB55379DD182941E93F3BD3D37D7880@AM0PR08MB5537.eurprd08.prod.outlook.com>
        <xmqq367crlti.fsf@gitster.c.googlers.com>
        <AM0PR08MB553711CE7CE5D39EC2CE8422D7890@AM0PR08MB5537.eurprd08.prod.outlook.com>
Date:   Thu, 04 Jun 2020 08:11:14 -0700
In-Reply-To: <AM0PR08MB553711CE7CE5D39EC2CE8422D7890@AM0PR08MB5537.eurprd08.prod.outlook.com>
        (Kalle Kromann's message of "Thu, 4 Jun 2020 08:27:29 +0000")
Message-ID: <xmqq8sh2rhm5.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A2BD8F30-A675-11EA-9B02-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kalle Kromann <kalle.kromann@man-es.com> writes:

> And the git version was the latest available from apt-get in WSL, 2.7.4.

Wow, that's ancient.  

"git merge" started calling commit-msg hook f8b86359 (builtin/merge:
honor commit-msg hook for merges, 2017-09-07), which first appeared
in 2.15 (from Oct 2017, that is also ancient in Git timescale) IIUC.


