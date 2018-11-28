Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 67BFE1F97E
	for <e@80x24.org>; Wed, 28 Nov 2018 04:12:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727019AbeK1PMx (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Nov 2018 10:12:53 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:62264 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726972AbeK1PMx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Nov 2018 10:12:53 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 3D47C31CA0;
        Tue, 27 Nov 2018 23:12:41 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=PeM+m3lXZzJpOBfD9idjNX6tekY=; b=JUilnb
        XEEJjW7vaoX0S3JufplMR8IStlHdg59C7auOQyl9d32QD7uZmPjMNqu6mrq+zDRt
        mKmyxcc+AlY1BAPexE/vnStTKFjk5wDDdsLB88p8byWNUIpCNcxQzu+Al/Uq4Gh0
        sJpQAeVMhXW6TeYKgu6XF7hPSPCL6xPyx/3IA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=BJZ1MZeLCEI+yz2IndPfwek0a9Mcv8JB
        aD3s77XxHbN9fuUeJ8nsokTMAF1z8FGQvAXHTt7L0tPJFOkS+XVE4NauZoTx+UU6
        EaIIVaDKDlC+iZOv6zcyqQ0hLcKcVMJ7GW3MpzgVGMECJqzzAp4vH28bytWduclh
        vwlu3zlV8Vk=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 3601A31C9F;
        Tue, 27 Nov 2018 23:12:41 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.187.50.168])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 4E26531C9E;
        Tue, 27 Nov 2018 23:12:38 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        git@vger.kernel.org, svnpenn@gmail.com
Subject: Re: [PATCH v1/RFC 1/1] 'git clone <url> C:\cygwin\home\USER\repo' is working (again)
References: <5bf18396.1c69fb81.20780.2b1d@mx.google.com>
        <20181126173252.1558-1-tboegi@web.de>
        <nycvar.QRO.7.76.6.1811271346550.41@tvgsbejvaqbjf.bet>
Date:   Wed, 28 Nov 2018 13:12:36 +0900
In-Reply-To: <nycvar.QRO.7.76.6.1811271346550.41@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Tue, 27 Nov 2018 13:49:35 +0100 (STD)")
Message-ID: <xmqqwooxsuvf.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D787FD0C-F2C3-11E8-A9DA-F5C31241B9FE-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> It takes a little folding and knotting of the brain to understand that
> this `!skip_dos_drive_prefix(&pos)` has *nothing* to do with the comment
> `unc paths` nor with the test whether the paths starts with two directory
> separators.
>
> As a consequence, I would highly suggest to turn this into:
>
> 	if (skip_dos_drive_prefix(&pos))
> 		; /* absolute path with DOS drive prefix */
>   	/* unc paths */
> 	else if (is_dir_sep(pos[0]) && is_dir_sep(pos[1])) {
>
> That makes the code a lot easier to understand, and as a consequence a lot
> harder to mess up in the future.

Excellent.  With or without "unc paths" comment, the separation does
make the logic more clear.
