Return-Path: <SRS0=xyTh=BY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2BB3C433DF
	for <git@archiver.kernel.org>; Fri, 14 Aug 2020 18:59:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6060F20771
	for <git@archiver.kernel.org>; Fri, 14 Aug 2020 18:59:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ay9kK9X2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727879AbgHNS75 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Aug 2020 14:59:57 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61722 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726285AbgHNS74 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Aug 2020 14:59:56 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 89EF26B80F;
        Fri, 14 Aug 2020 14:59:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=jC++RBhvWv0ZQ4VdesWaZiKs89w=; b=ay9kK9
        X281LHUwieIMiRGr3x2Q0LBOSBVwgE0KYtjnF6GX8c9gtBAOgSHJ8mh5anyKvqh+
        O06kRCPLrFaJ3p1sKQpv+uXNdyLCvFwdwLmP67kO2KryK3CeeRAfgq8vk5vmQ9bR
        903GXwitecHlI8A3g1fCjolGT9xe0wEoDSqTA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=fmQyO9m1ApT4+sMjWW/m/faS1FgehM6n
        ZnvkubtO718reYGPmlZOPxqyHC9Ylgs4HFPPob8G766Ri4uAOgHFmIE7zPuKCyLa
        6zOhjmh8imS0xGc27sP4UYuwYn9Fl05YGjqaYzqUP9Zr4WjTrALGA3Qt5KoYHx3F
        aHveAvceNw4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7FDFE6B80D;
        Fri, 14 Aug 2020 14:59:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.231.104.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 0A1906B80C;
        Fri, 14 Aug 2020 14:59:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?utf-8?B?xJBvw6Bu?= =?utf-8?B?IFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>, git@vger.kernel.org,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 2/2] diff: index-line: respect --abbrev in object's name
References: <cover.1596887883.git.congdanhqx@gmail.com>
        <cover.1597364493.git.congdanhqx@gmail.com>
        <760df7782dad9e9df7bb284ec57249e697a4cc92.1597364493.git.congdanhqx@gmail.com>
        <20200814151815.GA29528@szeder.dev>
        <xmqqwo21xiuy.fsf@gitster.c.googlers.com>
Date:   Fri, 14 Aug 2020 11:59:53 -0700
In-Reply-To: <xmqqwo21xiuy.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Fri, 14 Aug 2020 10:00:53 -0700")
Message-ID: <xmqqy2mhvys6.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 56AC3B46-DE60-11EA-9546-2F5D23BA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Ouch.  These apparently come from
>
> process_diffs () {
> ...
> }
>
> Hash-independence may be good, but it should not munge expected mode
> bits from 100644 to ffff44, which I think is a bug in the original
> introduced in 72f936b1 (t4013: make test hash independent,
> 2020-02-07).
>
> When we are adjusting the abbrev length of the index line, of course
> $_x07 would not be sufficient to match the abbreviated object name
> in full, so a79 vs 895 can be explained and is a bug in this patch
> that did not update the process_diffs helper.
>
> Another thing that I find somewhat problematic in the original
> (brian cc'ed) is that it does not special case all-zero object name
> specially.  By turning any and all instances of $_x40 to $ZERO_OID,
> we lose the distinction between a random-looking object name which
> got turned into $ZERO_OID by the processing, and an object name that
> was $ZERO_OID from the beginning, so we won't catch a possible
> future bug where new file's preimage object name is not $ZERO_OID
> (this is plausible when you try to show an intent-to-add entry; the
> diff between the index and the working tree would be "new file"
> patch, but the index entry records the object name for an empty
> blob, e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 instead of $ZERO_OID
> can easily be emitted by a mistaken implementation).

So here is what I came up with as a possible starting point.  The
idea is to grab hexadecimal strings at locations the original tried
to isolate with various contexts, and

 - if the input happens to be all zero, use '0', otherwise use 'f'

 - if the input is 40-bytes (i.e. unabbreviated object name in the
   SHA-1 world), repeat the character chosen in the first step as
   many times as there are chars in $ZERO_OID

 - otherwise, repeat the character chosen in the first step as many
   times as there are chars in the input.

 - regardless of all of the above, special case possible in-tree
   blob modes (100644, 100755 and 120000) and don't munge them.

I haven't tried it with the patch that started this discussion
thread, nor with SHA-256 build, though.


 t/t4013-diff-various.sh | 58 +++++++++++++++++++++++++++++++------------------
 1 file changed, 37 insertions(+), 21 deletions(-)

diff --git a/t/t4013-diff-various.sh b/t/t4013-diff-various.sh
index 43267d6024..b33e60ab9d 100755
--- a/t/t4013-diff-various.sh
+++ b/t/t4013-diff-various.sh
@@ -130,27 +130,43 @@ test_expect_success setup '
 EOF
 
 process_diffs () {
-	_x04="[0-9a-f][0-9a-f][0-9a-f][0-9a-f]" &&
-	_x07="$_x05[0-9a-f][0-9a-f]" &&
-	sed -e "s/$OID_REGEX/$ZERO_OID/g" \
-	    -e "s/From $_x40 /From $ZERO_OID /" \
-	    -e "s/from $_x40)/from $ZERO_OID)/" \
-	    -e "s/commit $_x40\$/commit $ZERO_OID/" \
-	    -e "s/commit $_x40 (/commit $ZERO_OID (/" \
-	    -e "s/$_x40 $_x40 $_x40/$ZERO_OID $ZERO_OID $ZERO_OID/" \
-	    -e "s/$_x40 $_x40 /$ZERO_OID $ZERO_OID /" \
-	    -e "s/^$_x40 $_x40$/$ZERO_OID $ZERO_OID/" \
-	    -e "s/^$_x40 /$ZERO_OID /" \
-	    -e "s/^$_x40$/$ZERO_OID/" \
-	    -e "s/$_x07\.\.$_x07/fffffff..fffffff/g" \
-	    -e "s/$_x07,$_x07\.\.$_x07/fffffff,fffffff..fffffff/g" \
-	    -e "s/$_x07 $_x07 $_x07/fffffff fffffff fffffff/g" \
-	    -e "s/$_x07 $_x07 /fffffff fffffff /g" \
-	    -e "s/Merge: $_x07 $_x07/Merge: fffffff fffffff/g" \
-	    -e "s/$_x07\.\.\./fffffff.../g" \
-	    -e "s/ $_x04\.\.\./ ffff.../g" \
-	    -e "s/ $_x04/ ffff/g" \
-	    "$1"
+	perl -e '
+		my $oid_length = length($ARGV[0]);
+		my $x40 = "[0-9a-f]{40}";
+		my $xab = "[0-9a-f]{4,16}";
+		my $orx = "[0-9a-f]" x $oid_length;
+
+		sub munge_oid {
+			my ($oid) = @_;
+			my $x;
+
+			if ($oid =~ /^(100644|100755|120000)$/) {
+				return $oid;
+			}
+
+			if ($oid =~ /^0*$/) {
+				$x = "0";
+			} else {
+				$x = "f";
+			}
+
+			if (length($oid) == 40) {
+				return $x x $oid_length;
+			} else {
+				return $x x length($oid);
+			}
+		}
+
+		while (<STDIN>) {
+			s/($orx)/munge_oid($1)/ge;
+			s/From ($x40)( |\))/"From " . munge_oid($1) . $2/ge;
+			s/commit ($x40)($| \()/"commit " . munge_oid($1) . $2/ge;
+			s/($x40) /munge_oid($1) . " "/ge;
+			s/^($x40)($| )/munge_oid($1) . $2/e;
+			s/($xab)(\.\.|,| |\.\.\.|$)/munge_oid($1) . $2/ge;
+			print;
+		}
+	' "$ZERO_OID" <"$1"
 }
 
 V=$(git version | sed -e 's/^git version //' -e 's/\./\\./g')
