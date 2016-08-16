Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 643621F859
	for <e@80x24.org>; Tue, 16 Aug 2016 18:23:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752238AbcHPSXA (ORCPT <rfc822;e@80x24.org>);
	Tue, 16 Aug 2016 14:23:00 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61579 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750917AbcHPSW7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Aug 2016 14:22:59 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 379BB34533;
	Tue, 16 Aug 2016 14:22:58 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=W3TbFpVDg21SAbb2kc3fZ10zFSY=; b=ec3Ere
	L0xCLrruQOTwlRWJ2h12HlBpP0mSym9WqvDiM6qqI7KBeXO+2vjbLRVSpMYb2O6L
	81YRKm9pkjT0No7/7m5BptFo+yutBaU281yXSvN5ZRWU5OT/P3Bi6kp3RSiVJnea
	JA2aCqWCA9iS3YGWl83FBe++KC4MnHTllJKsk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=JyZqNjyGlV4lPHt5Uy2B4tpsNgPwhn0R
	SCkuW6fVG4vN1tTvYNMhjvJXy7Zfi9qTBVJMI8xTFtTE/vr6maIZBX+EH92jvqD7
	P45y3I0l7cINThwFhm67fnaaaI+6kmk7SbHoq9G6WHocfz0CRTTU9TiqZhTZoJPP
	2je6xfkpRZw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 2F9B134532;
	Tue, 16 Aug 2016 14:22:58 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A4E9634531;
	Tue, 16 Aug 2016 14:22:57 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Jacob Keller <jacob.e.keller@intel.com>
Cc:	git@vger.kernel.org, Stefan Beller <stefanbeller@gmail.com>,
	Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
	Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH v6 2/3] graph: add support for --line-prefix on all graph-aware output
References: <20160815230702.30817-1-jacob.e.keller@intel.com>
	<20160815230702.30817-3-jacob.e.keller@intel.com>
Date:	Tue, 16 Aug 2016 11:22:55 -0700
In-Reply-To: <20160815230702.30817-3-jacob.e.keller@intel.com> (Jacob Keller's
	message of "Mon, 15 Aug 2016 16:07:01 -0700")
Message-ID: <xmqqlgzwd14w.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 74F59012-63DE-11E6-AFE3-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Jacob Keller <jacob.e.keller@intel.com> writes:

> To make this work, we have to fix a few bugs in the graph API that force
> graph_show_commit_msg to be used only when you have a valid graph.
> Additionally, we extend the default_diff_output_prefix handler to work
> even when no graph is enabled.
>
> This is somewhat of a hack on top of the graph API, but I think it
> should be acceptable here.

Unlike the opt-prefix-length I removed in 1/3, the length of the
line-prefix will never change during the lifetime of a single
diff_options struct, so it might turn out that repeated strlen()
on it for each and every line output is wasteful.

Other than that, I didn't spot anything immediately questionable.

Thanks.
