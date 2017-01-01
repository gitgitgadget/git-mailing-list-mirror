Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4A8301FEB3
	for <e@80x24.org>; Sun,  1 Jan 2017 03:28:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754800AbdAAD2u (ORCPT <rfc822;e@80x24.org>);
        Sat, 31 Dec 2016 22:28:50 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58573 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754625AbdAAD2t (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 31 Dec 2016 22:28:49 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C1FC35D720;
        Sat, 31 Dec 2016 22:28:48 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Pm+yYsFO2M6oHF/avEyzQ4pT/ao=; b=c7omYg
        Kyp/trkXuHCLya4hmPU5fwUQ7FpE21SN+ZH/nKa+aB/fqlRba4P6YdhtX4yUcEuz
        BX14zvjN4ZkOXhn6u8TQSjWsydddwPEA/o232UAzszje/F7LBZS0vzTnTNv6xKMe
        wbEGs0BjRn1VJs4xEoHUsOrek4iO7/jsJTxME=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=XoD6XQboA+vWwOigra9q+KgDB7rFG5Vp
        FxA7zWplgBev/VZqLxpz7FYtBzWQ9yoknCGNpFfR63FuLgfmHPwjUeSg2z5Cuq8O
        HYGgt8sXWlo4bHvyJTBmdL5zW0iul8nYUHQBpqbuydriGoFjekN3EXGrxZm6cYPH
        ZLb7Atna/KM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B959F5D71F;
        Sat, 31 Dec 2016 22:28:48 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 35AB65D71E;
        Sat, 31 Dec 2016 22:28:48 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        David Turner <novalis@novalis.org>
Subject: Re: [PATCH v3 11/23] log_ref_setup(): separate code for create vs non-create
References: <cover.1483153436.git.mhagger@alum.mit.edu>
        <d9f96df1bb2d5b9a95388da04b770ea9f317c491.1483153436.git.mhagger@alum.mit.edu>
Date:   Sat, 31 Dec 2016 19:28:47 -0800
In-Reply-To: <d9f96df1bb2d5b9a95388da04b770ea9f317c491.1483153436.git.mhagger@alum.mit.edu>
        (Michael Haggerty's message of "Sat, 31 Dec 2016 04:12:51 +0100")
Message-ID: <xmqqful34fww.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 685C5FE2-CFD2-11E6-B6BB-E17F7A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Michael Haggerty <mhagger@alum.mit.edu> writes:

> +			if (errno == ENOENT || errno == EISDIR) {
> +				/*
> +				 * The logfile doesn't already exist,
> +				 * but that is not an error; it only
> +				 * means that we won't write log
> +				 * entries to it.
> +				 */
> +			} else {

It may be valid C, but an

	{
		/*
		 * an empty block without any statement,
		 * not even a null statement.
		 */
	}

always makes me a bit nervous.  Have a line with a semicolon without
anything else (other than the indent) at the end and it will read
nicer, at least to me.
