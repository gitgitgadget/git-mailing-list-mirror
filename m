Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E543B201C8
	for <e@80x24.org>; Sat, 11 Nov 2017 02:06:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754888AbdKKCGh (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Nov 2017 21:06:37 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57532 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754143AbdKKCGh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Nov 2017 21:06:37 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 29539A4FEF;
        Fri, 10 Nov 2017 21:06:32 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=0IT4oIPTwlPrWByEIwE8ANybr8M=; b=b1LnGw
        CL+dRM2+cPWoonTKGypKlB7RbY+nJf1blYFo8dGM7eCAmTz7IkMWtF1HpK/pzeHb
        jDIK+pArrGRYkWPOLknmarqUVXHZBLeAMP9vWrYt0iaqCFm5O5dKBp1H/3ddIeFI
        zO46jcGBW/dCTHFodhdphcwlfYlMx3qvbrWlY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=CFgHjAM0+pajpNzCZiYpzcKYCuOntc6Z
        BTi9fjL3CTSXnaHkG9kDVq4bbj5r5ucmGOv38K+Paj+y3L7MsRGw9xzpf3v7ROcl
        jrZD6lw5LOP/cuzHV7PFRTfFWA0xNjUJl9odS94FzmSDLx6bcaUJ2hTJVFIZppSi
        5AAQ7rd6yF4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 21E7FA4FEE;
        Fri, 10 Nov 2017 21:06:32 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 91B5DA4FED;
        Fri, 10 Nov 2017 21:06:31 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Igor Djordjevic <igor.d.djordjevic@gmail.com>
Cc:     anatoly techtonik <techtonik@gmail.com>, git@vger.kernel.org
Subject: Re: Unify annotated and non-annotated tags
References: <CAPkN8x+MELCnttE+xptKzYXsYPWqbiE59LABrwNBhFroayc+wQ@mail.gmail.com>
        <ec4be1c2-a0cc-cec8-a566-06c11c8abe06@gmail.com>
Date:   Sat, 11 Nov 2017 11:06:30 +0900
In-Reply-To: <ec4be1c2-a0cc-cec8-a566-06c11c8abe06@gmail.com> (Igor
        Djordjevic's message of "Sat, 11 Nov 2017 02:46:39 +0100")
Message-ID: <xmqqh8u1efh5.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EF9DA2DC-C684-11E7-940B-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Igor Djordjevic <igor.d.djordjevic@gmail.com> writes:

> If you would like to mimic output of "git show-ref", repeating 
> commits for each tag pointing to it and showing full tag name as 
> well, you could do something like this, for example:
>
> 	for tag in $(git for-each-ref --format="%(refname)" refs/tags)
> 	do
> 		printf '%s %s\n' "$(git rev-parse $tag^0)" "$tag"
> 	done
>
>
> Hope that helps a bit.

If you use for-each-ref's --format option, you could do something
like (pardon a long line):

git for-each-ref --format='%(if)%(*objectname)%(then)%(*objectname)%(else)%(objectname)%(end) %(refname)' refs/tags

without any loop, I would think.


