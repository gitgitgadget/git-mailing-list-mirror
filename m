Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6CDC9207BD
	for <e@80x24.org>; Mon, 24 Apr 2017 04:04:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932465AbdDXED5 (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Apr 2017 00:03:57 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60650 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1756897AbdDXECo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Apr 2017 00:02:44 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 20A0B7DFA6;
        Mon, 24 Apr 2017 00:02:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=sQlUyikVuD+jPKV7kIwHjHGP17Y=; b=PU0EDb
        XbyCKrVn+OOpE0Qua7MbQKzEWvloiv9j0/s5G8f+UAI0xU0pk8BWZ/fIbdI1u28O
        79A6yXi18wEvjoPPFHjTQMYAamoXawo+zd5o9ZY2bZBb9EG4uHQoNH4BrtGuOSif
        hOmreq/uSohXHQJTSTJul7TFSpWIWvhEjcPPw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ssGnY05qnP9k9sDPnVxB5cCNYYEURlXu
        /9DCCgxaCYOmGejeGCFStoBMCBm6lEd8w1pZc0qvhq4IIPUyneARVuNvTsdNZTqf
        /aykFODNwZf8B2fByCXJ0ONJDcVb7NOjwrdMz8PqSPb9aEH/QDHEaJQasu9TpZCd
        Umc+yBTLrFA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 186587DFA5;
        Mon, 24 Apr 2017 00:02:43 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6E9187DFA4;
        Mon, 24 Apr 2017 00:02:42 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Johannes Sixt <j6t@kdbg.org>,
        David Turner <dturner@twosigma.com>, git@vger.kernel.org
Subject: Re: [PATCH] test-lib: abort when can't remove trash directory
References: <CAM0VKjm1m4v9vTpwFEejBuD3NuGm+kAdEV-_rzCXCz2G4m5NGw@mail.gmail.com>
        <20170420165230.5951-1-szeder.dev@gmail.com>
        <20170421201527.wdtxhox3p4g35gex@sigill.intra.peff.net>
        <xmqqk26a4q69.fsf@gitster.mtv.corp.google.com>
        <20170424014339.nuh7ixlqudfnftzp@sigill.intra.peff.net>
        <xmqqwpaa1pgb.fsf@gitster.mtv.corp.google.com>
Date:   Sun, 23 Apr 2017 21:02:41 -0700
In-Reply-To: <xmqqwpaa1pgb.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Sun, 23 Apr 2017 19:58:44 -0700")
Message-ID: <xmqq60hu1mhq.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DD937C9A-28A2-11E7-B411-E680B56B9B0B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>> That looks fine, assuming the answer to the "is the cwd important"
>> question is "no".
>
> And I do think the answer would be "yes", unfortunately.  There are
> systems that do not even allow a file to be removed while it is
> open, so...

In addition to "some platforms may not want cwd removed", this
directory would be where test_at_end_hook_ will be running in, so
we'd better be consistent with the current behaviour.

Second try that hopefully is much less damaging

 t/test-lib.sh | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index cb0766b9ee..4e8f511870 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -760,12 +760,15 @@ test_done () {
 			say "1..$test_count$skip_all"
 		fi
 
-		test -d "$remove_trash" ||
-		error "Tests passed but trash directory already removed before test cleanup; aborting"
+		if test -z "$debug"
+		then
+			test -d "$TRASH_DIRECTORY" ||
+			error "Tests passed but trash directory already removed before test cleanup; aborting"
 
-		cd "$(dirname "$remove_trash")" &&
-		rm -rf "$(basename "$remove_trash")" ||
-		error "Tests passed but test cleanup failed; aborting"
+			cd "$(dirname "$TRASH_DIRECTORY")" &&
+			rm -fr "$TRASH_DIRECTORY" ||
+			error "Tests passed but test cleanup failed; aborting"
+		fi
 
 		test_at_end_hook_
 



