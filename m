Return-Path: <SRS0=aR3Y=3R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02BC2C2D0DB
	for <git@archiver.kernel.org>; Tue, 28 Jan 2020 19:09:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDC432173E
	for <git@archiver.kernel.org>; Tue, 28 Jan 2020 19:09:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="P/syn3Bo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726647AbgA1TJ5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Jan 2020 14:09:57 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58323 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726002AbgA1TJ4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Jan 2020 14:09:56 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6CDB6437DC;
        Tue, 28 Jan 2020 14:09:54 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=q82t75fi8zsG80dtWR/SdOsbyvI=; b=P/syn3
        BoL1/WYKdB++cosU0wEi+3eJ7CaYwkj2w8NiCOvmRu0NFPaqXbQD1z00/M+CImJz
        Ln8NHwCnUiKrxE4lvgxW9FIxXmflrhPl5aTu5FKZqiDDyncn/kdTGRYGODfPYV0A
        ILFbfWDFxGrMhnhJqUWqP6sbkwu6yaZqkNpHk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=gUux6CVauQ3G4gR/bzLQsK0SBbJbW6cL
        PmD4CVY0jh2n7+RcpcdN07EN8ofC0KMm7TBQPsj1VyT+FZ1AFJvIVfvEZZ6nTlIz
        zp/mkYul5moS2TRROKRXpxdAD+jZJOdMlOET5STTh1a5NBjo6eKvcSXjXiTz6V48
        2VsiC46uZ5Y=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 66209437DB;
        Tue, 28 Jan 2020 14:09:54 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D10A2437DA;
        Tue, 28 Jan 2020 14:09:53 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     <git@vger.kernel.org>, Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 18/22] t5703: make test work with SHA-256
References: <20200125230035.136348-1-sandals@crustytoothpaste.net>
        <20200125230035.136348-21-sandals@crustytoothpaste.net>
Date:   Tue, 28 Jan 2020 11:09:52 -0800
In-Reply-To: <20200125230035.136348-21-sandals@crustytoothpaste.net> (brian
        m. carlson's message of "Sat, 25 Jan 2020 23:00:26 +0000")
Message-ID: <xmqqblqn8kjj.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C3FC2E8C-4201-11EA-A980-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> This test used an object ID which was 40 hex characters in length,
> causing the test not only not to pass, but to hang, when run with
> SHA-256 as the hash.  Change this value to a fixed dummy object ID using
> test_oid_init and test_oid.

Has the above part been split into another patch?

> Furthermore, ensure we extract an object ID of the appropriate length
> using cut with fields instead of a fixed length.

This one makes sense.

> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---
>  t/t5703-upload-pack-ref-in-want.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/t/t5703-upload-pack-ref-in-want.sh b/t/t5703-upload-pack-ref-in-want.sh
> index 1424fabd4a..5511cdcec2 100755
> --- a/t/t5703-upload-pack-ref-in-want.sh
> +++ b/t/t5703-upload-pack-ref-in-want.sh
> @@ -19,7 +19,7 @@ get_actual_commits () {
>  		}' <out | test-tool pkt-line unpack-sideband >o.pack &&
>  	git index-pack o.pack &&
>  	git verify-pack -v o.idx >objs &&
> -	grep commit objs | cut -c-40 | sort >actual_commits
> +	grep commit objs | cut -d" " -f1 | sort >actual_commits
>  }
>  
>  check_output () {
