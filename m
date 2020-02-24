Return-Path: <SRS0=prLJ=4M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA318C11D2F
	for <git@archiver.kernel.org>; Mon, 24 Feb 2020 18:01:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF8D320836
	for <git@archiver.kernel.org>; Mon, 24 Feb 2020 18:01:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="OBNQfHuN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727746AbgBXSBQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Feb 2020 13:01:16 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:57284 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726208AbgBXSBP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Feb 2020 13:01:15 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B3C37A5CF7;
        Mon, 24 Feb 2020 13:01:13 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Z1JAhIqVS6V01oUxocIhUgRWwM0=; b=OBNQfH
        uNWhi+kLW+jtzrgrs3xvFUVh0ot4OzhlWOED/5R18CSbrXFsjBiMnRMp56awm820
        ITkOXkc2sV+5wwkNsNsteOzIHS7MVSWlRemqkuEBFS7DZq/xvYDVX6gPIiXUnIzX
        hqyn6nI7W6ROaE34SMvBXLe/DsFE/Axql9ydM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=rp7T8nM6IinT84atgLEES144WK/aZ69e
        3tP0SWH1JYJ3YAwDeOCDUG5RzkqoAgIipKNp9m5v/agwAZLRGIoOajMMebdO1Ovx
        bGQWFxuiZ1+b6gTj4MBfJVMNBZJ+W6Wi8xJ3zCZbhCVHAoWivXLJ+AMxgHht+JuG
        a4prFq4D7nM=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id AC879A5CF6;
        Mon, 24 Feb 2020 13:01:13 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id CD900A5CF3;
        Mon, 24 Feb 2020 13:01:10 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     <git@vger.kernel.org>
Subject: Re: [PATCH v2 07/24] t6300: abstract away SHA-1-specific constants
References: <20200222201749.937983-1-sandals@crustytoothpaste.net>
        <20200222201749.937983-8-sandals@crustytoothpaste.net>
Date:   Mon, 24 Feb 2020 10:01:08 -0800
In-Reply-To: <20200222201749.937983-8-sandals@crustytoothpaste.net> (brian
        m. carlson's message of "Sat, 22 Feb 2020 20:17:32 +0000")
Message-ID: <xmqqsgizrhjv.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A3A16D6C-572F-11EA-8815-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> Adjust the test so that it computes variables for object IDs instead of
> using hard-coded hashes.
>
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---
>  t/t6300-for-each-ref.sh | 25 ++++++++++++++++---------
>  1 file changed, 16 insertions(+), 9 deletions(-)
>
> diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
> index 9c910ce746..2406b93d35 100755
> --- a/t/t6300-for-each-ref.sh
> +++ b/t/t6300-for-each-ref.sh
> @@ -20,6 +20,10 @@ setdate_and_increment () {
>  }
>  
>  test_expect_success setup '
> +	test_oid_cache <<-EOF &&
> +	disklen sha1:138
> +	disklen sha256:154
> +	EOF
>  	setdate_and_increment &&
>  	echo "Using $datestamp" > one &&
>  	git add one &&
> @@ -50,6 +54,9 @@ test_atom() {
>  	"
>  }
>  
> +hexlen=$(test_oid hexsz)
> +disklen=$(test_oid disklen)
> +
>  test_atom head refname refs/heads/master
>  test_atom head refname: refs/heads/master
>  test_atom head refname:short master
> @@ -82,9 +89,9 @@ test_atom head push:rstrip=-1 refs
>  test_atom head push:strip=1 remotes/myfork/master
>  test_atom head push:strip=-1 master
>  test_atom head objecttype commit
> -test_atom head objectsize 171
> -test_atom head objectsize:disk 138
> -test_atom head deltabase 0000000000000000000000000000000000000000
> +test_atom head objectsize $((131 + hexlen))

171 == 131 + 40 and that is because we are looking at the initial
commit, whose contents has a single object name (i.e. its tree).

Makes sense.

> +test_atom head objectsize:disk $disklen
> +test_atom head deltabase $ZERO_OID
>  test_atom head objectname $(git rev-parse refs/heads/master)
>  test_atom head objectname:short $(git rev-parse --short refs/heads/master)
>  test_atom head objectname:short=1 $(git rev-parse --short=1 refs/heads/master)
> @@ -125,11 +132,11 @@ test_atom tag refname:short testtag
>  test_atom tag upstream ''
>  test_atom tag push ''
>  test_atom tag objecttype tag
> -test_atom tag objectsize 154
> -test_atom tag objectsize:disk 138
> -test_atom tag '*objectsize:disk' 138
> -test_atom tag deltabase 0000000000000000000000000000000000000000
> -test_atom tag '*deltabase' 0000000000000000000000000000000000000000
> +test_atom tag objectsize $((114 + hexlen))

Likewise, 154 == 114 + 40 because an annotated tag has an object
pointer to a single object (i.e. its pointee).

Makes sense, too.

> +test_atom tag objectsize:disk $disklen
> +test_atom tag '*objectsize:disk' $disklen
> +test_atom tag deltabase $ZERO_OID
> +test_atom tag '*deltabase' $ZERO_OID
>  test_atom tag objectname $(git rev-parse refs/tags/testtag)
>  test_atom tag objectname:short $(git rev-parse --short refs/tags/testtag)
>  test_atom head objectname:short=1 $(git rev-parse --short=1 refs/heads/master)
> @@ -139,7 +146,7 @@ test_atom tag parent ''
>  test_atom tag numparent ''
>  test_atom tag object $(git rev-parse refs/tags/testtag^0)
>  test_atom tag type 'commit'
> -test_atom tag '*objectname' 'ea122842f48be4afb2d1fc6a4b96c05885ab7463'
> +test_atom tag '*objectname' $(git rev-parse refs/tags/testtag^{})
>  test_atom tag '*objecttype' 'commit'
>  test_atom tag author ''
>  test_atom tag authorname ''
