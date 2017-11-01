Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1EC6F20450
	for <e@80x24.org>; Wed,  1 Nov 2017 03:46:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754095AbdKADq0 (ORCPT <rfc822;e@80x24.org>);
        Tue, 31 Oct 2017 23:46:26 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63377 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751390AbdKADq0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Oct 2017 23:46:26 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id AB10194261;
        Tue, 31 Oct 2017 23:46:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=CHFAjZHqvVDCKvL4DIm3eunsS2A=; b=g0iGQx
        2CxlkEwvCf8zrzEzZc5l5TqzyzgIZD8Gv41zUijM2fj9UuhgZmxtoQ6kCNZT497Y
        vPXxM+IorrPgOk6ySsS04zL+8hUwebMEUcPNFFDCKf6fDvCmCXcQk1180XTqoYmi
        OEdg2AMtUcxi470OroBB6l0GEooXYirzH67r8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=QFz4m5grGVz56qOqCa1DliEvQS8MIhFI
        vWM3mdrF37r8p9nFowlyEAPsDZwoVVVM598RrSwaZvJj4Koj/+/md30J3akmOiMd
        suZhFfCpyu2SgYTj3+rXKcrCLfpqXoAolG2vKePRPATfWBxB244pyhh6d6hfsEqk
        Wv/IxC9UAtg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A21D794260;
        Tue, 31 Oct 2017 23:46:25 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id F047F9425F;
        Tue, 31 Oct 2017 23:46:24 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Johannes.Schindelin@gmx.de, git@vger.kernel.org,
        jacob.keller@gmail.com, me@ikke.info
Subject: Re: [PATCHv2 1/7] list-objects.c: factor out traverse_trees_and_blobs
References: <20171031003351.22341-1-sbeller@google.com>
        <20171031211852.13001-1-sbeller@google.com>
        <20171031211852.13001-2-sbeller@google.com>
Date:   Wed, 01 Nov 2017 12:46:23 +0900
In-Reply-To: <20171031211852.13001-2-sbeller@google.com> (Stefan Beller's
        message of "Tue, 31 Oct 2017 14:18:46 -0700")
Message-ID: <xmqqvaiuvey8.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3BDBC1C2-BEB7-11E7-8188-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> With traverse_trees_and_blobs factored out of the main traverse function,
> the next patch can introduce an in-order revision walking with ease.
>
> In the next patch we'll call `traverse_trees_and_blobs` from within the
> loop walking the commits, such that we'll have one invocation of that
> function per commit.  That is why we do not want to have memory allocations
> in that function, such as we'd have if we were to use a strbuf locally.
> Pass a strbuf from traverse_commit_list into the blob and tree traversing
> function as a scratch pad that only needs to be allocated once.

Makes sense.

I still don't think base_path is any clearer than base that was used
in the original, though.

