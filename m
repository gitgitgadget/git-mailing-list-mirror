Return-Path: <SRS0=RoqO=ZW=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52C94C432C3
	for <git@archiver.kernel.org>; Sat, 30 Nov 2019 00:47:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07A86217BC
	for <git@archiver.kernel.org>; Sat, 30 Nov 2019 00:47:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="RdUABpUI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727200AbfK3ArG (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Nov 2019 19:47:06 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:58761 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727130AbfK3ArG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Nov 2019 19:47:06 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id D2D27AC642;
        Fri, 29 Nov 2019 19:46:59 -0500 (EST)
        (envelope-from tmz@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=I7BHZ076UllD
        4GJjnbT2xVhP0ng=; b=RdUABpUIln/9+eHivPy6jHLDbAQ6U1BoF6DZIaYyGvVr
        0dRhtypssWtd+2B+HyWP3vx26ZdKs3e4ILrZpuMrhu3IcUoOqVT5UEgBHHTOcmzU
        LnY6FKrQ1gT17KYwKx4socN9VdjIHWzxIe2VYL7cYpWF95pA6hQ8woRR9SZdWS8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=O1uhJy
        n42EzAEGXemMEEIlWxHgXZ7oAsJbFp4Ytwb6CAz4F83vQcYqCi6st/sZ/NPLbQgZ
        3uM6K7cbDq6VE2TGIikiVpTLeRruyWKKnnu0AaEPMlCwvMJ5QKs4wTAnHKvQJXeA
        lGplFgHn7FAIkNI/RrNn4LbFehoYVuI4Fs2NI=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C99C2AC641;
        Fri, 29 Nov 2019 19:46:59 -0500 (EST)
        (envelope-from tmz@pobox.com)
Received: from morphine.paradise.teonanacatl.net (unknown [47.202.86.139])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 02676AC640;
        Fri, 29 Nov 2019 19:46:55 -0500 (EST)
        (envelope-from tmz@pobox.com)
From:   Todd Zullinger <tmz@pobox.com>
To:     Andreas Schwab <schwab@linux-m68k.org>
Cc:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>, Beat Bolli <dev+git@drbeat.li>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>
Subject: [PATCH] t7812: expect failure for grep -i with invalid UTF-8 data
Date:   Fri, 29 Nov 2019 19:46:53 -0500
Message-Id: <20191130004653.8794-1-tmz@pobox.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <87blsyl32c.fsf_-_@igel.home>
References: 
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Pobox-Relay-ID: E9051598-130A-11EA-9FC6-8D86F504CC47-09356542!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When the 'grep with invalid UTF-8 data' tests were added/adjusted in
8a5999838e (grep: stess test PCRE v2 on invalid UTF-8 data, 2019-07-26)
and 870eea8166 (grep: do not enter PCRE2_UTF mode on fixed matching,
2019-07-26) they lacked a redirect which caused them to falsely succeed
on most architectures.  They failed on big-endian arches where the test
never reached the portion which was missing the redirect.

A recent patch add the missing redirect and exposed the fact that the
'PCRE v2: grep non-ASCII from invalid UTF-8 data with -i' test fails on
all architectures.

Based on the final paragraph in in 870eea8166:

    When grepping a non-ASCII fixed string. This is a more general proble=
m
    that's hard to fix, but we can at least fix the most common case of
    grepping for a fixed string without "-i". I can't think of a reason
    for why we'd turn on PCRE2_UTF when matching byte-for-byte like that.

it seems that we don't expect that the case-insensitive grep will
succeed.  Adjust the test to reflect that expectation.

Signed-off-by: Todd Zullinger <tmz@pobox.com>
---

Hi,

Andreas Schwab wrote:
> Two tests in t7812 were missing redirects, failing to actually test the
> produced output.
>=20
> Fixes: 8a5999838e ("grep: stess test PCRE v2 on invalid UTF-8 data")
> Signed-off-by: Andreas Schwab <schwab@linux-m68k.org>

Nice catch on these missing redirects.  While testing the
2.24.0 rc's this test failed only on big-endian arches (like
s390x in Fedora).  It was briefly mentioned at the time in
<20191020002648.GZ10893@pobox.com>.

After applying the fix to add the missing redirects, the
test now fails on all architectures.  It seems like that is
the intended state and we simply need to adjust the final
test with `grep -i` accordingly.

Of course, it's possible that I've misunderstood =C3=86var's
intentions in 870eea8166 (grep: do not enter PCRE2_UTF mode
on fixed matching, 2019-07-26) or otherwise have poorly
explained the reasoning in my commit message.

We don't appear to test PCRE (neither v1 nor v2) in our CI
builds.  I added libpcre2-dev and set USE_LIBPCRE to test
this in travis.  (Whether we want to enable that by default
is worth discussing.)

Doing so confirms that the tests (incorrectly) pass without
the missing redirects and fail when the redirects are added.
Inverting the expectation of test_cmp in the final `grep -i`
test results in a successful test run.

with PCRE2:
https://travis-ci.org/tmzullinger/git/jobs/618733182

with PCRE2 and 'add missing redirects':
https://travis-ci.org/tmzullinger/git/jobs/618723277

with PCRE2, 'add missing redirects' and this patch:
https://travis-ci.org/tmzullinger/git/jobs/618796963

This still doesn't fix the failure on s390x.  There

    test_might_fail git grep -hi "=C3=86" invalid-0x80 >actual

fails and leaves nothing in 'actual' which causes the test
to fail at the following

    test_cmp expected actual

line.  If we suspect the test might fail, it seems like we
need to account for that and not expect that 'expect' will
match 'actual' as we currently do.

 t/t7812-grep-icase-non-ascii.sh | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/t/t7812-grep-icase-non-ascii.sh b/t/t7812-grep-icase-non-asc=
ii.sh
index c4528432e5..03dba6685a 100755
--- a/t/t7812-grep-icase-non-ascii.sh
+++ b/t/t7812-grep-icase-non-ascii.sh
@@ -76,9 +76,12 @@ test_expect_success GETTEXT_LOCALE,LIBPCRE2 'PCRE v2: =
grep non-ASCII from invali
=20
 test_expect_success GETTEXT_LOCALE,LIBPCRE2 'PCRE v2: grep non-ASCII fro=
m invalid UTF-8 data with -i' '
 	test_might_fail git grep -hi "=C3=86" invalid-0x80 >actual &&
-	test_cmp expected actual &&
+	if test -s actual
+	then
+	    test_cmp expected actual
+	fi &&
 	test_must_fail git grep -hi "(*NO_JIT)=C3=86" invalid-0x80 >actual &&
-	test_cmp expected actual
+	! test_cmp expected actual
 '
=20
 test_done
--=20
2.24.0

