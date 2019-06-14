Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 16A781F462
	for <e@80x24.org>; Fri, 14 Jun 2019 19:50:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725869AbfFNTux (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Jun 2019 15:50:53 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:58586 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725808AbfFNTuw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Jun 2019 15:50:52 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 45F8F69C8A;
        Fri, 14 Jun 2019 15:50:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=qCuAsFrc8flbGpqkq9cvYlcA5bc=; b=Dh7bhD
        qbX+6+7DaIs6aCkuoSnQ4mSgt8MYafsiAQD7UqElUDWI9//PqqidrnS4gU4ZxqR7
        3PQ4so0SQEehOc19OQsrOTft9oxRKeXf1AW/D68kqwl097fggW12ylIWTDuYfOQm
        Z0i546lPEwVEr9yk4PtlKkYgpJHXFkaJkibUA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Xw1IxU6KtJVCAbGG30znjM8IGcyzBcnZ
        GDaAP1P0wIgBKK2M+WBlMj+D9srByvmLQmv+d7oXiGupS6tkAmiAx27AQlnXH4b3
        44H7j8+6Stu+YALc1wjpfG07M37G24tSF6WykmcvJrUqyYCp2ElRy3Ymr92y6VSE
        HIBDr3qC0JA=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 3D69D69C88;
        Fri, 14 Jun 2019 15:50:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 5DC5469C84;
        Fri, 14 Jun 2019 15:50:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Matthew DeVore <matvore@google.com>
Cc:     git@vger.kernel.org, jonathantanmy@google.com, jrn@google.com,
        dstolee@microsoft.com, jeffhost@microsoft.com, jrnieder@gmail.com,
        pclouds@gmail.com, peff@peff.net, emilyshaffer@google.com,
        matvore@comcast.net
Subject: Re: [PATCH v3 00/10] Filter combination
References: <20190601003603.90794-1-matvore@google.com>
        <cover.1560462201.git.matvore@google.com>
Date:   Fri, 14 Jun 2019 12:50:46 -0700
In-Reply-To: <cover.1560462201.git.matvore@google.com> (Matthew DeVore's
        message of "Thu, 13 Jun 2019 14:51:23 -0700")
Message-ID: <xmqqpnngt089.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B4D1267E-8EDD-11E9-85D7-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Matthew DeVore <matvore@google.com> writes:

> It has been a while since a sent a roll-up. Here are the changes since v2:
>
>  - Re-use more URL-encoding logic in strbuf.c
>    * This was partially achieved by changing the helper function to accept a
>      function that will indicate whether some character must be escaped.
>  - Re-use more URL-decoding logic in url.c
>  - changed the filter_spec strbuf to a string_list to avoid explicit
>    initialization
>  - Remove logic to "expand" tree:#k and tree:#m filter specs since there is no
>    server that supports tree:# but does not support tree:#k, as they were
>    implemented at the same time.

Since the v2 of this topic, cc/list-objects-filter-wo-sparse-path
was merged to the mainline before Git 2.22 was tagged.  As we won't
be merging this topic to any maintenance track anyway, it is
probably a good time to rebase it on v2.22.0, to avoid unnecessary
conflicts.

Thanks.
