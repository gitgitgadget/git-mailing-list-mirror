Return-Path: <SRS0=h4OP=2D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F753C7CFE6
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 20:39:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7376D24741
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 20:39:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="MSV+zp7h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728528AbfLMRry (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Dec 2019 12:47:54 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:64637 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728445AbfLMRry (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Dec 2019 12:47:54 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E768DA7BD9;
        Fri, 13 Dec 2019 12:47:51 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Qn/aVec4EELRqzQQsEEQerpHyeA=; b=MSV+zp
        7h36ozXcRHJIQxTlSrJ5VNkGQZuMP61g2QiQp3wsCdzKy5iUEKS9g/0g7O1cqky1
        qn8COdT8eZRPx/d2syiklugXDli8xvEJw3Db+M9MwAFp901gRdR9doAXqeNQH0Ox
        MNf8BAmDSJdaFbxMc7xGV93j4hEbRsIJWPOck=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=oWPYpfD3KCkgDl6x5I86m7dijVIh2eKo
        ji0YLUND4mGltpw2xYLEZ7T3fsYN4Pg3AhiAh51gAtgag5GLcRXdKjwgGHjYa9PK
        lbjAPg2laEx+udgeZMF7xvSZ4X6H5zziVGeQZLFUfYCI3zZsA8DqM2KvzCR800fc
        AC9D3kCA1VE=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E0BA0A7BD8;
        Fri, 13 Dec 2019 12:47:51 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 075C7A7BD7;
        Fri, 13 Dec 2019 12:47:48 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: Gmail munges dates?
References: <20191213015753.GA14249@generichostname>
Date:   Fri, 13 Dec 2019 09:47:46 -0800
In-Reply-To: <20191213015753.GA14249@generichostname> (Denton Liu's message of
        "Thu, 12 Dec 2019 17:57:53 -0800")
Message-ID: <xmqqy2vgkth9.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AD8F4AD0-1DD0-11EA-84CF-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

> Unfortunately, it seems like mutt wasn't the culprit, it was Gmail
> that's been munging the dates. For example, in this patch[1], the date
> shows as
>
> 	Date: Thu, 12 Dec 2019 16:44:50 -0800
>
> even though locally, the output of the format-patch shows as
>
> 	Date: Mon, 9 Dec 2019 19:25:34 +0100

"git send-email" records the timestamp of sending.  If you really
want to force a specific author date, you could add a in-body Date:
but it is discouraged in mailing-list centric workflow, because it
is more natural for everybody other than the author to consider that
the time the patch hits the list, i.e. the public eyes, is when the
patch was "authored".

