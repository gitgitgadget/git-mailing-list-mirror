Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3411E1F463
	for <e@80x24.org>; Mon,  9 Sep 2019 18:41:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727587AbfIISlq (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Sep 2019 14:41:46 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:57565 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726674AbfIISlq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Sep 2019 14:41:46 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 2F06C92EBA;
        Mon,  9 Sep 2019 14:41:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=eGoqGbkXpH+RlUFjrqlrGn1HdPI=; b=Rku79b
        mf123UWHnerKJRPeaBf9UPMNurVOrW9XLOjlNee3WatswBqmsSjeU7zG5TlkWHi8
        o26XqOJSujBCdH/LJ7WOuz8zfLzjpxHg2Bu3KHJfg7pjN4IcXqNxmWfOTkWy1xWb
        ABtZ0VVHK9S32V1LDAz8aN5i8IVdXIWWuIyJU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=JOmhdzv1gI0Q/241xsvek5VyRmAK7iZZ
        gZzsN/s3WHDOY25H7ti7Bx40MBb9a7xxk8A5qS0nKTIekICT2X+bVHzbtgyQgod7
        P//t+11Uq8QAnuFLGpig2npBFE48LKeTWJ6VGxcR7vjB1hV1xLOsXWtC/LmKDgn7
        PgCsUujHnbM=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 2832192EB9;
        Mon,  9 Sep 2019 14:41:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 3C7A292EB5;
        Mon,  9 Sep 2019 14:41:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Blake <eblake@redhat.com>
Cc:     Christian Schoenebeck <qemu_oss@crudebyte.com>,
        qemu-devel@nongnu.org, git@vger.kernel.org, berrange@redhat.com,
        stefanha@gmail.com, Greg Kurz <groug@kaod.org>,
        dgilbert@redhat.com, antonios.motakis@huawei.com
Subject: Re: [Qemu-devel] [PATCH v6 0/4] 9p: Fix file ID collisions
References: <cover.1566503584.git.qemu_oss@crudebyte.com>
        <46fe6c73-961f-d72a-77de-88491b6f223c@redhat.com>
        <4642438.ai5u8AxThJ@silver> <1897173.eDCz7oYxVq@silver>
        <305577c2-709a-b632-4056-6582771176ac@redhat.com>
Date:   Mon, 09 Sep 2019 11:41:39 -0700
In-Reply-To: <305577c2-709a-b632-4056-6582771176ac@redhat.com> (Eric Blake's
        message of "Mon, 9 Sep 2019 09:05:45 -0500")
Message-ID: <xmqqd0g9jorg.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 76DE39FE-D331-11E9-A20F-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Blake <eblake@redhat.com> writes:

> How hard would it be to improve 'git format-patch'/'git send-email' to
> have an option to ALWAYS output a From: line in the body, even when the
> sender is the author, for the case of a mailing list that munges the
> mail headers due to DMARC/DKIM reasons?

I'd say that it shouldn't be so hard to implement than realizing
what ahd why it is needed, designing what the end-user interaction
would be (i.e.  command line options?  configuration variables?
should it be per send-email destination?) and stating all of the
above clearly in the documentation and the proposed commit log
message.

The reason you are asking is...?  Am I smelling a volunteer?
