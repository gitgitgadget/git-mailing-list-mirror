Return-Path: <SRS0=KQVw=7S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 696B8C433DF
	for <git@archiver.kernel.org>; Fri,  5 Jun 2020 17:04:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 38055206DB
	for <git@archiver.kernel.org>; Fri,  5 Jun 2020 17:04:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="emJDaqz3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726236AbgFEREm (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Jun 2020 13:04:42 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64983 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726026AbgFEREm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Jun 2020 13:04:42 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CFF0F6744C;
        Fri,  5 Jun 2020 13:04:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=2Jhs7nXVciOA
        97SJhK74OYu6+ME=; b=emJDaqz3PbGDx6qWFrJyeIs6DvjqV13QIfBO61JWhRgY
        kh4KefH/ps6rMQPwmwLjlqjvHwwILTeZD3aSFY8DOkClo06Uim479V6kA2qV94js
        IDESj000EL+xUZXcnip8cH7bOKC6loYV0O8JUyV9tXdNmy9rkHqfH5eNYiLcsJ8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=os0I9X
        crSPpHUpT0mnXWj3g9BzG1SpF9hPUaGq0jXdmpw0ocOVhTRsFWJ08DxWRC/ieQBO
        I53n8+BSxab92VZjPjOzfx5M9M0jODl8Z2N5UTPVofJtdPdKfBhU73kve5gG/TzX
        HonTefaTESavtY2pJcEvypS/csYIG7qJOnMqo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BF62F6744B;
        Fri,  5 Jun 2020 13:04:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id ECE8267448;
        Fri,  5 Jun 2020 13:04:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Max Resnick <max.resnick@forgerock.com>
Cc:     git@vger.kernel.org
Subject: Re: name-ref on annotated-tags is null terminated, but lightweight tags arent
References: <20200605165109.jr6mjl6xz7upofdy@forgemax.local>
Date:   Fri, 05 Jun 2020 10:04:38 -0700
In-Reply-To: <20200605165109.jr6mjl6xz7upofdy@forgemax.local> (Max Resnick's
        message of "Fri, 5 Jun 2020 09:51:09 -0700")
Message-ID: <xmqqa71ho34p.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: A40E2654-A74E-11EA-90D0-C28CBED8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Max Resnick <max.resnick@forgerock.com> writes:

> What did you do before the bug happened? (Steps to reproduce your issue=
)
> I was using name-rev to resolve a commits tag name. Annotated tags seem
> to have a null termination and lightweight tags dont.

> =E2=9D=AF git name-rev --tag --name-only
> 38bdebc9107cab4ab3718d0581632702e74d9209
> annotated-tag^0
>
> /tmp/null-termination-issue on =EE=82=A0 master
> =E2=9D=AF git name-rev --tag --name-only
> a340894d3ee655ae6c336a85b42d2215d52609e3
> lightweight-tag

Presumably the long hexadecimal are supposed to be on the same line
as the "name-rev" command itself?

There is nothing broken in the above output.  The anotated tag
(annotated-tag in your example) is an object that merely points at
another object (in which case, the object whose name is 38bdebc9,
which I guess would be a commit) and it itself has an object name
different from 38bdebc9.  The suffix "^0" (which has nothing to do
with null-termination) means "I do not mean the tag object itself,
but the object that is pointed by it".

On the other hand, your lightweight-tag is directly pointing at the
object a340894d, so saying "lightweight-tag" is sufficient, as there
is no extra layer of indirection (i.e. a tag object) involved.

Hope it helps.
