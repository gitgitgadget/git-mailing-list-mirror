Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EFACA20986
	for <e@80x24.org>; Wed, 19 Oct 2016 22:30:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754069AbcJSWau (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Oct 2016 18:30:50 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57141 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751012AbcJSWat (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Oct 2016 18:30:49 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 87BE74957F;
        Wed, 19 Oct 2016 18:30:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=24Dq0Bbm8H3Zqu1N3rtlW4uDtaY=; b=kWO/Ix
        XCipyUd5SOsiOwHYmrQr+wsDPc1buoCHynFwvKH6Jhn52k/I38KsdEzxnFFiNR5j
        9tEzNcEffgdGij8cIieIpbRNywKkz/WzevdiHBVlFaitQjJz2jjUJHY2hEbKX37h
        j/LjVKLX02jSsj2aizGaO0MgEyM8WuzmwkcR4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=qdhx4OsKZ1iizTL/1nckc7i4ivZJhB6a
        tW0ukwCIbSADIaDrCNnAYZwFpL6GKmA44U8b7zS40MmUcSejheDwK8GE4YqJsaqh
        VwzQNZHFHZrtxON3QCBX+JCXVmMhcqD0bpL0wjBv1v1cUDc/W8bv2ccB/itPIjX2
        r0ien5jCSc0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7EA5F4957E;
        Wed, 19 Oct 2016 18:30:47 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id DEDF14957D;
        Wed, 19 Oct 2016 18:30:46 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Jan Keromnes <janx@linux.com>, git@vger.kernel.org
Subject: Re: [regression] `make profile-install` fails in 2.10.1
References: <CAA6PgK5vtnZSqqZafMVGoy0Rv38=8e__uQvXaf2SyPePHuPjJA@mail.gmail.com>
        <20161019210519.ubk5q54rrvbafch7@sigill.intra.peff.net>
        <xmqqh988j7oo.fsf@gitster.mtv.corp.google.com>
Date:   Wed, 19 Oct 2016 15:30:44 -0700
In-Reply-To: <xmqqh988j7oo.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Wed, 19 Oct 2016 15:27:35 -0700")
Message-ID: <xmqqd1iwj7jf.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AE1DBC44-964B-11E6-9059-987C12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Ouch.  Thanks for a reminder.  How about doing this for now?

And the hack I used to quickly test it looks like this:

    $ cd t
    $ GIT_I_AM_INSANE=Yes sh ./t3700-add.sh

We may want a more general 

    GIT_OVERRIDE_PREREQ='!SANITY,!POSIXPERM,MINGW' make test

or something like that, though.

 t/test-lib.sh | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 0055ebba46..9c5bcd9d1d 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -89,6 +89,7 @@ unset VISUAL EMAIL LANGUAGE COLUMNS $("$PERL_PATH" -e '
 		UNZIP
 		PERF_
 		CURL_VERBOSE
+		I_AM_INSANE
 	));
 	my @vars = grep(/^GIT_/ && !/^GIT_($ok)/o, @env);
 	print join("\n", @vars);
@@ -1081,6 +1082,12 @@ test_lazy_prereq NOT_ROOT '
 # containing directory doesn't have read or execute permissions.
 
 test_lazy_prereq SANITY '
+
+	if test -n "$GIT_I_AM_INSANE"
+	then
+		return 1
+	fi &&
+
 	mkdir SANETESTD.1 SANETESTD.2 &&
 
 	chmod +w SANETESTD.1 SANETESTD.2 &&
