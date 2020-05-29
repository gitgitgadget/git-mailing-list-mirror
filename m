Return-Path: <SRS0=mJAO=7L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1F83C433E0
	for <git@archiver.kernel.org>; Fri, 29 May 2020 18:07:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C1214206A4
	for <git@archiver.kernel.org>; Fri, 29 May 2020 18:07:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="PbppchHb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727995AbgE2SHG (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 May 2020 14:07:06 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:53825 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727975AbgE2SHF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 May 2020 14:07:05 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 6DA5FBD14D;
        Fri, 29 May 2020 14:07:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ZCd+Ivw4Fhb+aPossJjos6xUkTg=; b=Pbppch
        Hbwh2wOZv3lnbCvoaOsjTC2lOcSJGCaBuXHX4gJN5yw6xDwsqQ6gGE+y8pYgjO/a
        NuKLQmlM/pK9DyG2O9ezn2GC7M6Xce0vwjZnxH10GIVR20p0RXqCma/Qm3PeikoG
        Rw1rcsRyMclokNEJfgQPZqhYJLIErPbvijbhM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ElnzU0Kasmo9Q6kWpRFDN56R8rjejRrx
        J65vHXBACjHniqCZpL37OrLQ3PrHgAtqqqsAVviFwv9RjT9//rjck01+hZ47TsC8
        +jcmH/gftzIS5Q/eefccoQlNnsBVHqDGaSAvjkQJaD4aiX9toX4cC5eDEnmf7h+b
        kuKJYXI3J8s=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 64953BD14C;
        Fri, 29 May 2020 14:07:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.231.104.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id A22EFBD148;
        Fri, 29 May 2020 14:06:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Xin Li <delphij@google.com>, git@vger.kernel.org,
        sandals@crustytoothpaste.net, iankaz@google.com,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH v4] fetch: allow adding a filter after initial clone.
References: <20200528025359.20931-2-delphij@google.com>
        <xmqqsgfk3xtd.fsf@gitster.c.googlers.com>
        <20200528171924.GC58643@google.com>
        <CAOhzdugK7FQSnWruUrX8gQ98AF6kGvNWqPfHmE+qjGjBgzvmiQ@mail.gmail.com>
        <20200528191739.GA114915@google.com>
        <20200529000432.146618-1-delphij@google.com>
        <20200529010119.GE114915@google.com>
Date:   Fri, 29 May 2020 11:06:58 -0700
In-Reply-To: <20200529010119.GE114915@google.com> (Jonathan Nieder's message
        of "Thu, 28 May 2020 18:01:19 -0700")
Message-ID: <xmqqk10uzkcd.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 30CA41B8-A1D7-11EA-B94C-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

>> diff --git a/t/t2404-worktree-config.sh b/t/t2404-worktree-config.sh
>> index 286121d8de..9536d10919 100755
>> --- a/t/t2404-worktree-config.sh
>> +++ b/t/t2404-worktree-config.sh
>> @@ -23,8 +23,10 @@ test_expect_success 'config --worktree without extension' '
>>  '
>>  
>>  test_expect_success 'enable worktreeConfig extension' '
>> +	git config core.repositoryformatversion 1 &&
>>  	git config extensions.worktreeConfig true &&
>
> Yes, makes sense.  Does this patch need it, or could this go in a
> separate patch?

I think it is the consequence of unrelated change in this hunk:

@@ -506,9 +510,15 @@ static int check_repository_format_gently(const char *gitdir, struct repository_
 		die("%s", err.buf);
 	}
 
-	repository_format_precious_objects = candidate->precious_objects;
-	set_repository_format_partial_clone(candidate->partial_clone);
-	repository_format_worktree_config = candidate->worktree_config;
+	if (candidate->version >= 1) {
+		repository_format_precious_objects = candidate->precious_objects;
+		set_repository_format_partial_clone(candidate->partial_clone);
+		repository_format_worktree_config = candidate->worktree_config;
+	} else {
+		repository_format_precious_objects = 0;
+		set_repository_format_partial_clone(NULL);
+		repository_format_worktree_config = 0;
+	}
 	string_list_clear(&candidate->unknown_extensions, 0);
 
 	if (repository_format_worktree_config) {

We used to honor extensions.*, as long as the version of Git
understand it, even in a repository whose version is still v0.

I am not sure if this backward incompatible change is necessary for
the purpose of "allow safe upgrade of repository format version"
topic, but as you hinted, it does smell like it belongs to a
separate (and much larger and potentially controversial) patch.

Thanks for carefully reading.

