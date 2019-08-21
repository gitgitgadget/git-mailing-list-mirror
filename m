Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8451C1F461
	for <e@80x24.org>; Wed, 21 Aug 2019 21:57:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731055AbfHUV5i (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Aug 2019 17:57:38 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:64279 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727923AbfHUV5i (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Aug 2019 17:57:38 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 55CC686787;
        Wed, 21 Aug 2019 17:57:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=IiMUrmqGE6W/ub4ylQnnT/2cPcE=; b=Q6PNpa
        GrH9fbVBW1VwbmixM6Z5TapoHloi6aO2aCUehmneKaz3q5JcpKJtSTpjRDFF0CM8
        Gu44yUIrWdWlwlkx7KQXm1zBLVQ0gV0mHi0d3EHX+wiSCGtMa2C0aG1S0hPj5s/S
        LIdEfP2xwNDAHNbvJxGcRGER6boaQkoeKhWHU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; q=dns; s=sasl; b=yKedeQg6k/MnzM9uK7Zdag/rIkcKDs5e
        1h/THVsYlizMJBL/pulGMz9gqpKQaDOMLAo0/8txhGaMpDtLiCgi0p/n0KtDNhKP
        VrAUFiJYyjWZ27+JiZ/6eJqIhhdpd+SwiUiqaL01WJfOn0YGx3Z9lrQ0D8obFb/V
        dtvSY1KSE4M=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 4D02E86786;
        Wed, 21 Aug 2019 17:57:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 813E286784;
        Wed, 21 Aug 2019 17:57:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Mischa POSLAWSKY <git@shiar.nl>
Cc:     git@vger.kernel.org,
        =?utf-8?B?0J7Qu9GPINCi0LXQu9C10LbQvdCw0Y8=?= 
        <olyatelezhnaya@gmail.com>
Subject: Re: [PATCH] ref-filter: initialize empty name or email fields
In-Reply-To: <xmqqimqtxcou.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Mon, 19 Aug 2019 10:55:13 -0700")
References: <20190817215107.13733-1-git@shiar.nl>
        <xmqqimqtxcou.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
Date:   Wed, 21 Aug 2019 14:57:31 -0700
Message-ID: <xmqq1rxerxkk.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: ADEBCE20-C45E-11E9-9483-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Mischa POSLAWSKY <git@shiar.nl> writes:
>
>> If I understand correctly, such tags cannot be produced normally anymore.
>> Therefore I'm unsure how to make tests, and if that is even warranted.
>
> Thanks for spotting.

A quick trial to recreate a tag object seems to succeed:

    $ git cat-file tag v0.99 |
    > sed -e '/-----BEGIN/,$d' |
    > git hash-object --stdin -w -t tag
    667d141b478eee5e53d2ee05acd61bb1f640249a
    $ git cat-file tag 667d141b47
    object a3eb250f996bf5e12376ec88622c4ccaabf20ea8
    type commit
    tag v0.99

    Test-release for wider distribution.

    I'll make the first public RPM's etc, thus the tag.

So we should be able to do something along the above line.  Here is
my quick-n-dirty one.

 t/t6300-for-each-ref.sh | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
index ab69aa176d..b3a6b336fa 100755
--- a/t/t6300-for-each-ref.sh
+++ b/t/t6300-for-each-ref.sh
@@ -869,4 +869,16 @@ test_expect_success 'for-each-ref --ignore-case ignores case' '
 	test_cmp expect actual
 '
 
+test_expect_success 'show a taggerless tag' '
+	test_commit tagged &&
+	git tag -a -m "a normal tag" to-be-shown-0 HEAD &&
+	another=$(git cat-file tag to-be-shown-0 |
+		sed -e "/^tagger /d" \
+		    -e "/^tag to-be-shown/s/0/1/" \
+		    -e "s/a normal tag/a broken tag/" |
+		git hash-object --stdin -w -t tag) &&
+	git tag to-be-shown-1 $another &&
+	git for-each-ref --format="%(refname:short) %(taggername)" refs/tags/to-be-shown\*
+'
+
 test_done

