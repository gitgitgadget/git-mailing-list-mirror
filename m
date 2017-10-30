Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ADEC4202A0
	for <e@80x24.org>; Mon, 30 Oct 2017 00:58:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751638AbdJ3A6G (ORCPT <rfc822;e@80x24.org>);
        Sun, 29 Oct 2017 20:58:06 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63140 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751429AbdJ3A6F (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Oct 2017 20:58:05 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6DDF7BA0C1;
        Sun, 29 Oct 2017 20:58:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=jI+J9dn8ZRyRBJoBSyWus8bsq9Y=; b=MVeDoq
        9HN9tpGrMCkTqbpqGJnltZug+qlhBmyGRzta+esZOCFFWKZpNZ82EN6o6Os3ZOXF
        +CekMn9tgiG0rEvky2i5hrn04nHnwKEd1gTZSIAV82hTvRRrQy/HBXEO4uA+Tr7j
        7HA4Vh+EwzSTMkCHK1u7WN0AfJKYoE3LargGU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=fagpz7aroCiVtoe8mLp2KRhIVO4f8ZNq
        pCrXG5XqH7GjCipwqCLj4EDdbvpn9vVDvCSUVYLqU+tXAttmuD0kMJkG6az3vwR9
        TCvpF+rhiCaM+Sd0g6QeUjWoOQYnbft+BZax5swHEeG/N3MALERRd+B28AePikA1
        0FnvXTjQvRw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 65E23BA0C0;
        Sun, 29 Oct 2017 20:58:05 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id CCAEDBA0BE;
        Sun, 29 Oct 2017 20:58:04 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     RPS <jim@resplendentwebservices.com>
Cc:     git@vger.kernel.org
Subject: Re: Wildcards with git rm
References: <cbb7340e-aa8c-1980-41eb-95cd965d4037@resplendentwebservices.com>
Date:   Mon, 30 Oct 2017 09:58:03 +0900
In-Reply-To: <cbb7340e-aa8c-1980-41eb-95cd965d4037@resplendentwebservices.com>
        (RPS's message of "Sat, 28 Oct 2017 07:38:44 -0400")
Message-ID: <xmqqk1zd8nac.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 62D6E898-BD0D-11E7-99CF-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

RPS <jim@resplendentwebservices.com> writes:

> git rm doesn't seem to be very useful without the use of shell
> wildcards, especially with the use of a .gitignore file. If a
> .gitignore file is used, the git rm command does not consider the
> .gitignore file, and errs out when an ignored file is present.

Do you mean

	$ git rm COPY*

would complain about COPYING~ on your filesystem, which would match
the pattern "*~" you have in your .gitignore file, after editing the
tracked COPYING file?

If so, you may choose to tell your shell _not_ to expand wildcards,
as it does not know what is ignored, by doing

	$ git rm COPY\*

instead.  That would allow "git rm" to expand wildcards _with_ the
knowledge of what is and is not ignored.  The shell does not know
(probably you could teach if you wanted to, but it does not want to
know) and care about .gitignore files when it does its wildcard
expansion.
