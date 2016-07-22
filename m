Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3A38E203E2
	for <e@80x24.org>; Fri, 22 Jul 2016 19:39:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752378AbcGVTju (ORCPT <rfc822;e@80x24.org>);
	Fri, 22 Jul 2016 15:39:50 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58902 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751998AbcGVTjt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jul 2016 15:39:49 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 3DD9F2C9BC;
	Fri, 22 Jul 2016 15:39:48 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=YNXgNNNvp+5UE07LSkMSX74h7WM=; b=cgZRWZ
	egI9esmZIG0z5n1HFZFYvICJyyQxNReEPT/Fvwx1QSSK0ENRxohrBAyj9rrqXN+I
	eX5IbZ8WtPYkKK0IBuoRBJzJ6Xk2H+5b8lgtyegQaWPMkOjbiQZV4tmJ26LOE5RM
	w2qV1DZUthr/ZJ7yFTC6T+bHMo/mK5x/E3jc8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=I7lLOiJ54XBpyUGYuISMzkW+7lZScWqH
	z8g7I+6SpX9s95Zdx+C62mKkz775nxOiV6upNcq4P/Up7Y2R1D3bvBluaDkZMZvC
	/othwDg4I89oiII2RAhTXohUhg2z2dQq6MlEC6Id3vueLrOEQPg9hwAeHtodfKEl
	SRCI3WZi/ac=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 365C02C9B9;
	Fri, 22 Jul 2016 15:39:48 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 9FDA92C9B8;
	Fri, 22 Jul 2016 15:39:47 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Johannes Sixt <j6t@kdbg.org>
Cc:	Stefan Beller <sbeller@google.com>,
	Git Mailing List <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH 2/2] submodule-helper: fix indexing in clone retry error reporting path
References: <8c0e116b-b604-ee83-197a-538eedf6e0ea@kdbg.org>
	<4d40da99-2f66-a380-840f-1828dc5b9324@kdbg.org>
Date:	Fri, 22 Jul 2016 12:39:45 -0700
In-Reply-To: <4d40da99-2f66-a380-840f-1828dc5b9324@kdbg.org> (Johannes Sixt's
	message of "Fri, 22 Jul 2016 21:15:39 +0200")
Message-ID: <xmqqeg6la2da.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0C5B1732-5044-11E6-B407-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Johannes Sixt <j6t@kdbg.org> writes:

> 'git submodule--helper update-clone' has logic to retry failed clones
> a second time. For this purpose, there is a list of submodules to clone,
> and a second list that is filled with the submodules to retry. Within
> these lists, the submodules are identified by an index as if both lists
> were just appended.
>
> This works nicely except when the second clone attempt fails as well. To
> report an error, the identifying index must be adjusted by an offset so
> that it can be used as an index into the second list. However, the
> calculation uses the logical total length of the lists so that the result
> always points one past the end of the second list.
>
> Pick the correct index.
>
> Signed-off-by: Johannes Sixt <j6t@kdbg.org>
> ---

Looks very similar to

  http://public-inbox.org/git/20160721013923.17435-1-sbeller%40google.com/

but these two patch series looks more thorough.

I expect I'd queue these two instead, after seeing Acks from Stefan.

Thanks.
