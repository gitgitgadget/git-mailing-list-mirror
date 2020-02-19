Return-Path: <SRS0=H/u6=4H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8F3BC5ACC4
	for <git@archiver.kernel.org>; Wed, 19 Feb 2020 21:18:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 971D3208C4
	for <git@archiver.kernel.org>; Wed, 19 Feb 2020 21:18:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="UEqG1DbP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727677AbgBSVSI (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Feb 2020 16:18:08 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:51845 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726645AbgBSVSI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Feb 2020 16:18:08 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 03491C5BD0;
        Wed, 19 Feb 2020 16:18:03 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Il1jtmFMgKpRkWiEZBKZBWziqyA=; b=UEqG1D
        bPCpWgsYZpDiKfRBtxrzdN4z2piE4R4QsSNYia5hnhauIEznitfwe4OblxDZj+qk
        EEgkQqOp0qiN4XisxGCBNXB5etafzEhRS2SH8I+strhS8xoAz8IGk2xoV+hElnC/
        MhuMbNuaa17KaZ7zFBsDIjYktrEQSuvyB4B4E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=o1EH1Q7wDTzqj9cmcHYtGWxQcJYw5XmD
        lEr4khuMM6YyR4VAaJbgCHtSMJbZqBOmQiiInV/tIqM2dsHBxNLtB8zJbUT6181O
        XIGa0L0t11inyj0IUqaTPtjHOvApCOvXgefuJ+0nbC/yjndpItBLoQhlyaK08FIp
        YjDuaCkGPxk=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id EEC98C5BCF;
        Wed, 19 Feb 2020 16:18:02 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 1ECB8C5BCC;
        Wed, 19 Feb 2020 16:17:59 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 1/2] partial-clone: demonstrate bugs in partial fetch
References: <pull.556.git.1582129312.gitgitgadget@gmail.com>
        <dbc1bdcae16f8b9941add514264b0fe04cda48c0.1582129312.git.gitgitgadget@gmail.com>
        <xmqqimk2e1vl.fsf@gitster-ct.c.googlers.com>
        <CAPig+cT+MO_JmZf_qfxu8ZkPLWDOpZSe8rZxt-7LK4d6+RJ6JA@mail.gmail.com>
Date:   Wed, 19 Feb 2020 13:17:57 -0800
In-Reply-To: <CAPig+cT+MO_JmZf_qfxu8ZkPLWDOpZSe8rZxt-7LK4d6+RJ6JA@mail.gmail.com>
        (Eric Sunshine's message of "Wed, 19 Feb 2020 15:59:48 -0500")
Message-ID: <xmqqblpue0oq.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4E729BB6-535D-11EA-BD4E-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Wed, Feb 19, 2020 at 3:52 PM Junio C Hamano <gitster@pobox.com> wrote:
>> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
>> > +test_expect_failure 'verify fetch succeeds when asking for new tags' '
>> > +     git clone --filter=blob:none "file://$(pwd)/srv.bare" tag-test &&
>> > +     for i in I J K
>> > +     do
>> > +             test_commit -C src $i &&
>> > +             git -C src branch $i
>> > +     done &&
>> > +     git -C srv.bare fetch --tags origin +refs/heads/*:refs/heads/* &&
>> > +     git -C tag-test fetch --tags origin
>> > +'
>>
>> Is this about an ultra-recent regresssion?  When applied directly on
>> top of v2.25.0, this one seems to pass already without any change.
>
> True, although both fail when applied atop "master".

I flipped the first one (i.e. test #24) to expect success and run
bisect between 3f7553ac ("Merge branch 'jt/t5616-robustify'",
2020-02-12) and the tip of 'master'.

Interesting that bisecting it points at 684ceae3 ("fetch: default to
protocol version 2", 2019-12-23).

diff --git a/t/t5616-partial-clone.sh b/t/t5616-partial-clone.sh
index 9a9178fd28..099406c2f1 100755
--- a/t/t5616-partial-clone.sh
+++ b/t/t5616-partial-clone.sh
@@ -384,6 +384,32 @@ test_expect_success 'fetch lazy-fetches only to resolve deltas, protocol v2' '
 	grep "want $(cat hash)" trace
 '
 
+test_expect_success 'verify fetch succeeds when asking for new tags' '
+	git clone --filter=blob:none "file://$(pwd)/srv.bare" tag-test &&
+	for i in I J K
+	do
+		test_commit -C src $i &&
+		git -C src branch $i
+	done &&
+	git -C srv.bare fetch --tags origin +refs/heads/*:refs/heads/* &&
+	git -C tag-test fetch --tags origin
+'
+
+test_expect_failure 'verify fetch downloads only one pack when updating refs' '
+	git clone --filter=blob:none "file://$(pwd)/srv.bare" pack-test &&
+	ls pack-test/.git/objects/pack/*pack >pack-list &&
+	test_line_count = 2 pack-list &&
+	for i in A B C
+	do
+		test_commit -C src $i &&
+		git -C src branch $i
+	done &&
+	git -C srv.bare fetch origin +refs/heads/*:refs/heads/* &&
+	git -C pack-test fetch origin &&
+	ls pack-test/.git/objects/pack/*pack >pack-list &&
+	test_line_count = 3 pack-list
+'
+
 . "$TEST_DIRECTORY"/lib-httpd.sh
 start_httpd
 
-- 
2.25.1-440-g39558b81cc

