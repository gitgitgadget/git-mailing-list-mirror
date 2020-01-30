Return-Path: <SRS0=gonI=3T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43B23C2D0DB
	for <git@archiver.kernel.org>; Thu, 30 Jan 2020 19:16:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B483206D3
	for <git@archiver.kernel.org>; Thu, 30 Jan 2020 19:16:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="KaJQPcr1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727639AbgA3TQU (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jan 2020 14:16:20 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56050 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726267AbgA3TQT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jan 2020 14:16:19 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BC84C534F9;
        Thu, 30 Jan 2020 14:16:14 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=/2TmEo166oRKVmdgI4atm0poTz0=; b=KaJQPc
        r15e7SqOEuJehmYPnns0ia4r/9IRIJRPERaMqdLZhytvH3Q2GvdPVUbkVrMhN3Mf
        pwffFIbcoPDumatEgTgSE00/cOaPAJOXh9iW6CEStl6NoSnwAmJyL5a8N0sDMjVZ
        dNMlhjFjdlyp/T++YgcYvt2nF+Yq7W3mjCMxY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=EBZD0kwKrw20O5GR+IwFw06vH0ZwojF9
        Bg3iQjCy1HlBaL/u7AFelx9ez4fAaIlVP4/s47m1lX3KnZDmipI7uUyz6zYxMpse
        7yZ9be2zYgt1oYUEl/8QfKWUdxrOJ56OUIBn4NlraeU7TU2AS9kL56masbicZOZM
        atUoo1CbqVY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B535F534F8;
        Thu, 30 Jan 2020 14:16:14 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 23A8E534F7;
        Thu, 30 Jan 2020 14:16:14 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     David =?utf-8?Q?Burstr=C3=B6m?= <davidburstrom@spotify.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 3/3] sha1-name: mark get_oid() error messages for translation
References: <20200125000542.GA566779@coredump.intra.peff.net>
        <20200125001301.GC567109@coredump.intra.peff.net>
        <xmqqpnf2dk6m.fsf@gitster-ct.c.googlers.com>
        <xmqqimkudjmt.fsf@gitster-ct.c.googlers.com>
        <20200130071700.GB2189233@coredump.intra.peff.net>
Date:   Thu, 30 Jan 2020 11:16:13 -0800
In-Reply-To: <20200130071700.GB2189233@coredump.intra.peff.net> (Jeff King's
        message of "Thu, 30 Jan 2020 02:17:00 -0500")
Message-ID: <xmqqeevgdabm.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FB7BDB52-4394-11EA-BEA7-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I think we can do this much more simply, by just using i18ncmp:
>
> diff --git a/t/t1506-rev-parse-diagnosis.sh b/t/t1506-rev-parse-diagnosis.sh
> index c2b5125c12..62085a89e3 100755
> --- a/t/t1506-rev-parse-diagnosis.sh
> +++ b/t/t1506-rev-parse-diagnosis.sh
> @@ -12,7 +12,7 @@ test_did_you_mean ()
>  	fatal: path '$2$3' $4, but not ${5:-$SQ$3$SQ}
>  	hint: Did you mean '$1:$2$3'${2:+ aka $SQ$1:./$3$SQ}?
>  	EOF
> -	test_cmp expected error
> +	test_i18ncmp expected error
>  }

Yeah, "what die(_(...)) under POISON says matches /^fatal:/"
probably is not worth checking and more importantly not something we
would want to rely on.

>  HASH_file=
>
> (we'd still need the s/grep/test_i18ngrep/ in your second hunk).

Yes.  The final amend to 3/3 has become like this.

$ git range-diff bc3f657f71..83252ba6f1 HEAD^..HEAD
1:  83252ba6f1 ! 1:  b0418303b1 sha1-name: mark get_oid() error messages for translation
    @@ t/t1506-rev-parse-diagnosis.sh: exec </dev/null
     +	fatal: path '$2$3' $4, but not ${5:-$SQ$3$SQ}
     +	hint: Did you mean '$1:$2$3'${2:+ aka $SQ$1:./$3$SQ}?
      	EOF
    - 	test_cmp expected error
    +-	test_cmp expected error
    ++	test_i18ncmp expected error
      }
    + 
    + HASH_file=
     @@ t/t1506-rev-parse-diagnosis.sh: test_expect_success 'correct relative file objects (6)' '
      
      test_expect_success 'incorrect revision id' '
    @@ t/t1506-rev-parse-diagnosis.sh: test_expect_success 'incorrect file in :path and
      '
      
      test_expect_success 'relative path not found' '
    + 	(
    + 		cd subdir &&
    + 		test_must_fail git rev-parse HEAD:./nonexistent.txt 2>error &&
    +-		grep subdir/nonexistent.txt error
    ++		test_i18ngrep subdir/nonexistent.txt error
    + 	)
    + '
    + 
     @@ t/t1506-rev-parse-diagnosis.sh: test_expect_success 'relative path outside worktree' '
      test_expect_success 'relative path when cwd is outside worktree' '
      	test_must_fail git --git-dir=.git --work-tree=subdir rev-parse HEAD:./file.txt >output 2>error &&

