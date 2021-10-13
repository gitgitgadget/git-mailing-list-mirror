Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A4E1C433EF
	for <git@archiver.kernel.org>; Wed, 13 Oct 2021 02:06:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E4E660C49
	for <git@archiver.kernel.org>; Wed, 13 Oct 2021 02:06:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232245AbhJMCIO (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Oct 2021 22:08:14 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52822 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230398AbhJMCIO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Oct 2021 22:08:14 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A697A103208;
        Tue, 12 Oct 2021 22:06:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=IVt2DXfpjt0NjseHQ3CX+qb1eMiYiC4Iw00/GK
        epzhY=; b=yLjnDTOvs6yi9iKwm1+ETcBmZh0uy7MUvz80utv1ss/4HNzrxFyOCc
        t7lZc/ovM844ZWct6dV0LWyQip/jUbeCWktQ+RzWquPDWRxr4LG2dvcEb2pskobP
        K5pqr1wae3uSkOpUSDHjmrGd5n+pU0LFGKLWTtMeV7vtViMjOS/KI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9D6E1103207;
        Tue, 12 Oct 2021 22:06:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 0BB12103206;
        Tue, 12 Oct 2021 22:06:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Rob Browning <rlb@defaultvalue.org>, Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: [PATCH] signature-format.txt: explain and illustrate multi-line
 headers
References: <20211009163338.2175170-1-rlb@defaultvalue.org>
        <YWRpPw4eTwTmgVvC@coredump.intra.peff.net>
        <xmqq4k9ncopr.fsf@gitster.g>
        <YWTuAOjqK6fy9ZRT@coredump.intra.peff.net>
        <xmqqzgre5glb.fsf@gitster.g>
Date:   Tue, 12 Oct 2021 19:06:01 -0700
In-Reply-To: <xmqqzgre5glb.fsf@gitster.g> (Junio C. Hamano's message of "Tue,
        12 Oct 2021 09:54:24 -0700")
Message-ID: <xmqqtuhlisqe.fsf_-_@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1E233C26-2BCA-11EC-BF87-CD991BBA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A signature attached to a signed commit, and the contents of the
commit that merged a signed tag, are both recorded as a value of an
object header field as a multi-line value, and are subject to the
formatting convention for multi-line values in the headers, with a
leading SP signaling that the rest of the line is a continuation of
the previous line.  Most notably, an empty line in such a multi-line
value would result in a line with a sole SP on it.

Examples in the signature-format technical documentation include a
few of these cases but we did not show these otherwise invisible SPs
in the example.  These trailing spaces cannot be seen on display or
on paper, and forces the readers to look for them in their editors
or pagers, even if we added them to the document.

Extend the overview section to explain the multi-line value
formatting and highlight these otherwise invisible SPs by inventing
the "a dollar-sign at the end of line that appears after SP merely
signals that there is a SP there, and the dollar-sign itself does
not appear in the real file" notation, inspired by "cat -e" output,
to help readers to learn exactly where such "a single SP that is
originally an empty line" appears in the examples.

Reported-by: Rob Browning <rlb@defaultvalue.org>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

    It turns out that the document has another block of text that
    needed the same treatment, so here is an attempt to follow
    through with the "$"-notation approach.

 Documentation/technical/signature-format.txt | 25 ++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/Documentation/technical/signature-format.txt b/Documentation/technical/signature-format.txt
index 2c9406a56a..45448fba24 100644
--- a/Documentation/technical/signature-format.txt
+++ b/Documentation/technical/signature-format.txt
@@ -13,9 +13,25 @@ Signatures always begin with `-----BEGIN PGP SIGNATURE-----`
 and end with `-----END PGP SIGNATURE-----`, unless gpg is told to
 produce RFC1991 signatures which use `MESSAGE` instead of `SIGNATURE`.
 
+Signatures sometimes appear as a part of the normal payload
+(e.g. a signed tag has the signature block appended after the payload
+that the signature applies to), and sometimes appear in the value of
+an object header (e.g. a merge commit that merged a signed tag would
+have the entire tag contents on its "mergetag" header).  In the case
+of the latter, the usual multi-line formatting rule for object
+headers applies.  I.e. the second and subsequent lines are prefixed
+with a SP to signal that the line is continued from the previous
+line.
+
+This is even true for an originally empty line.  In the following
+examples, the end of line that ends with a whitespace letter is
+highlighted with a `$` sign; if you are trying to recreate these
+example by hand, do not cut and paste them---they are there
+primarily to highlight extra whitespace at the end of some lines.
+
 The signed payload and the way the signature is embedded depends
 on the type of the object resp. transaction.
 
 == Tag signatures
 
 - created by: `git tag -s`
@@ -78,7 +95,7 @@ author A U Thor <author@example.com> 1465981137 +0000
 committer C O Mitter <committer@example.com> 1465981137 +0000
 gpgsig -----BEGIN PGP SIGNATURE-----
  Version: GnuPG v1
-
+ $
  iQEcBAABAgAGBQJXYRjRAAoJEGEJLoW3InGJ3IwIAIY4SA6GxY3BjL60YyvsJPh/
  HRCJwH+w7wt3Yc/9/bW2F+gF72kdHOOs2jfv+OZhq0q4OAN6fvVSczISY/82LpS7
  DVdMQj2/YcHDT4xrDNBnXnviDO9G7am/9OE77kEbXrp7QPxvhjkicHNwy2rEflAA
@@ -128,13 +145,13 @@ mergetag object 04b871796dc0420f8e7561a895b52484b701d51a
  type commit
  tag signedtag
  tagger C O Mitter <committer@example.com> 1465981006 +0000
-
+ $
  signed tag
-
+ $
  signed tag message body
  -----BEGIN PGP SIGNATURE-----
  Version: GnuPG v1
-
+ $
  iQEcBAABAgAGBQJXYRhOAAoJEGEJLoW3InGJklkIAIcnhL7RwEb/+QeX9enkXhxn
  rxfdqrvWd1K80sl2TOt8Bg/NYwrUBw/RWJ+sg/hhHp4WtvE1HDGHlkEz3y11Lkuh
  8tSxS3qKTxXUGozyPGuE90sJfExhZlW4knIQ1wt/yWqM+33E9pN4hzPqLwyrdods
-- 
2.33.1-816-gd427230396

