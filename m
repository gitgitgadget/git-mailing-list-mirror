Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 956301FF30
	for <e@80x24.org>; Tue, 22 Nov 2016 03:37:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755009AbcKVDhW (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 Nov 2016 22:37:22 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53489 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754521AbcKVDhV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Nov 2016 22:37:21 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A1830517A2;
        Mon, 21 Nov 2016 22:37:20 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Gou25gWA4z9U+5P/pabzvFIcZ8U=; b=HFmwtN
        MV3qibsavvGCpUgfROzQFZKt/8U3PYzG8vD4QRUW8RFjU/DRbK3wvxiKmilPg9Ch
        3wbjmnjxB6bAuQ8PdvdKdF1zMbc4Kgh9s9OGOuCNqQrYY1LRl31gAIea9lG/m3/8
        JFkVEo5xJddJEwUg+H4CfiVn6GVEfURN6hpLk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=i9NO5ChYX8pNW069jHxhA1Az/38ZCMCO
        NpVy5pO7mBsk9CHC8cv4HmwIbuMqChtpf4MpZqIDNdCNWuQJUqPrr1CS/wQf0uz5
        YB+rd9nsOCHySRTGA9LMSHWC6EBLMvcJ5Tg1AtZVwH5zcgNIYB1pwmwEL2lYAuPx
        jmEluX4k2eU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 998DE517A1;
        Mon, 21 Nov 2016 22:37:20 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 136CE517A0;
        Mon, 21 Nov 2016 22:37:20 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, bmwill@google.com, jacob.keller@gmail.com
Subject: Re: [PATCHv2 2/3] submodule-config: rename commit_sha1 to commit_or_tree
References: <20161121232709.8906-1-sbeller@google.com>
        <20161121232709.8906-3-sbeller@google.com>
Date:   Mon, 21 Nov 2016 19:37:18 -0800
In-Reply-To: <20161121232709.8906-3-sbeller@google.com> (Stefan Beller's
        message of "Mon, 21 Nov 2016 15:27:08 -0800")
Message-ID: <xmqq8tscgp75.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F8EE2A46-B064-11E6-870D-3AB77A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> It is also possible to pass in a tree hash to lookup a submodule config.
> Make it clear by naming the variables accrodingly. Looking up a submodule
> config by tree hash will come in handy in a later patch.
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---

Yeah, I noticed that while reading the previous round, too, but...

> -`const struct submodule *submodule_from_name(const unsigned char *commit_sha1, const char *name)`::
> +`const struct submodule *submodule_from_name(const unsigned char *commit_or_tree, const char *name)`::
>  
>  	The same as above but lookup by name.

Doesn't (the) "above", aka submodule_from_path() want the same
treatment?  

Also the explanation of "above" has room for improvement.  Namely it
says:

    Lookup values for one submodule by its commit_sha1 and path.

I do not think the commit-sha1 (or commit-or-tree-object-name) is
"ITS" object name for the submodule.  The name belongs to the
containing superproject commit (or tree), no?

    Given a tree-ish in the superproject and a path, return the
    submodule that is bound at the path in the named tree.

is what I would write for that one.  Thinking about it a bit
further, "treeish_name" would be a much better name for the variable
than "commit_or_tree", as "treeish" is an established short and
sweet word that means "commit_or_tree", and having a "name"
somewhere in the variable name makes it clear that we are not
passing the pointer to an in-core object (e.g. "struct commit *").

> +test_expect_success 'using tree sha1 works' '
> +	(
> +		cd super &&
> +		tree=$(git rev-parse HEAD^{tree}) &&
> +		commit=$(git rev-parse HEAD^{commit}) &&
> +		test-submodule-config $commit b >expect &&
> +		test-submodule-config $tree b >actual &&
> +		test_cmp expect actual
> +	)
> +'

Perhaps also test a tag that points at the commit?
