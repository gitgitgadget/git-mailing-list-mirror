Return-Path: <SRS0=xyTh=BY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80FEDC433DF
	for <git@archiver.kernel.org>; Fri, 14 Aug 2020 17:01:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A7472065C
	for <git@archiver.kernel.org>; Fri, 14 Aug 2020 17:01:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="DScH7Deg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728016AbgHNRA7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Aug 2020 13:00:59 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:53512 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726270AbgHNRA7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Aug 2020 13:00:59 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 7196AE8962;
        Fri, 14 Aug 2020 13:00:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=T58e5F0VICSK
        bGdSle02+CZMMsE=; b=DScH7Deg1t+YH+EP0uDCRfvF4r8XwMi8iolNNAooDwnY
        Q4XjL5okRgmQeWFXj4IUvSMMSxI2wfYdK0vZva06HMCR/ILaUdCp8AzB0JLRpSXG
        ArUpcazG9JbKGaeaf/wFbyiBBqxaZTKvUMZPMiB4JznC1eL9qinshyC/C4quPjs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=p59qB1
        G4uELv6hIMogjfVHXeS8fNT8m/jMV78H5dSfQOVsvxVF4E9UkQ0QMRsM+zC+6whN
        ZtDVvrX02l1xHCaJ0ijnlrv3gv/2NcYo5uBlZ4y6lx7gmTx9CRCVUzCe+mg5EoQC
        6ENCpHds2vA7yYq/Ct59Le8k+OS/k1Pr5pVE4=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 69C57E8961;
        Fri, 14 Aug 2020 13:00:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.231.104.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id A40C9E8960;
        Fri, 14 Aug 2020 13:00:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>, git@vger.kernel.org,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 2/2] diff: index-line: respect --abbrev in object's name
References: <cover.1596887883.git.congdanhqx@gmail.com>
        <cover.1597364493.git.congdanhqx@gmail.com>
        <760df7782dad9e9df7bb284ec57249e697a4cc92.1597364493.git.congdanhqx@gmail.com>
        <20200814151815.GA29528@szeder.dev>
Date:   Fri, 14 Aug 2020 10:00:53 -0700
In-Reply-To: <20200814151815.GA29528@szeder.dev> ("SZEDER =?utf-8?Q?G?=
 =?utf-8?Q?=C3=A1bor=22's?= message of
        "Fri, 14 Aug 2020 17:18:15 +0200")
Message-ID: <xmqqwo21xiuy.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: B7470564-DE4F-11EA-B9B4-F0EA2EB3C613-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER G=C3=A1bor <szeder.dev@gmail.com> writes:

>> +diff --git a/file0 b/file0
>> +new file mode 100644
>> +index 0000000000000000000000000000000000000000..01e79c32a8c99c557f075=
7da7cb6d65b3414466d
>> +--- /dev/null
>> ++++ b/file0
>> +@@ -0,0 +1,3 @@
>> ++1
>> ++2
>> ++3
>> +diff --git a/file2 b/file2
>> +new file mode 100644
>> +index 0000000000000000000000000000000000000000..01e79c32a8c99c557f075=
7da7cb6d65b3414466d
>> +--- /dev/null
>> ++++ b/file2
>> +@@ -0,0 +1,3 @@
>> ++1
>> ++2
>> ++3
>> +$
>
> All these new tests break when run with GIT_TEST_DEFAULT_HASH=3Dsha256
> with something like:
>
>   + test_cmp expect actual
>   --- expect	2020-08-14 15:05:12.209285397 +0000
>   +++ actual	2020-08-14 15:05:12.205285279 +0000
>   @@ -2,7 +2,7 @@
>    0000000000000000000000000000000000000000000000000000000000000000
>    diff --git a/dir/sub b/dir/sub
>    new file mode ffff44
>   -index ffffffffff..fffffffa79
>   +index ffffffffff..fffffff895

Ouch.  These apparently come from

process_diffs () {
	_x04=3D"[0-9a-f][0-9a-f][0-9a-f][0-9a-f]" &&
	_x07=3D"$_x05[0-9a-f][0-9a-f]" &&
	sed -e "s/$OID_REGEX/$ZERO_OID/g" \
	    -e "s/From $_x40 /From $ZERO_OID /" \
	    -e "s/from $_x40)/from $ZERO_OID)/" \
	    -e "s/commit $_x40\$/commit $ZERO_OID/" \
	    -e "s/commit $_x40 (/commit $ZERO_OID (/" \
	    -e "s/$_x40 $_x40 $_x40/$ZERO_OID $ZERO_OID $ZERO_OID/" \
	    -e "s/$_x40 $_x40 /$ZERO_OID $ZERO_OID /" \
	    -e "s/^$_x40 $_x40$/$ZERO_OID $ZERO_OID/" \
	    -e "s/^$_x40 /$ZERO_OID /" \
	    -e "s/^$_x40$/$ZERO_OID/" \
	    -e "s/$_x07\.\.$_x07/fffffff..fffffff/g" \
	    -e "s/$_x07,$_x07\.\.$_x07/fffffff,fffffff..fffffff/g" \
	    -e "s/$_x07 $_x07 $_x07/fffffff fffffff fffffff/g" \
	    -e "s/$_x07 $_x07 /fffffff fffffff /g" \
	    -e "s/Merge: $_x07 $_x07/Merge: fffffff fffffff/g" \
	    -e "s/$_x07\.\.\./fffffff.../g" \
	    -e "s/ $_x04\.\.\./ ffff.../g" \
	    -e "s/ $_x04/ ffff/g" \
	    "$1"
}

Hash-independence may be good, but it should not munge expected mode
bits from 100644 to ffff44, which I think is a bug in the original
introduced in 72f936b1 (t4013: make test hash independent,
2020-02-07).

When we are adjusting the abbrev length of the index line, of course
$_x07 would not be sufficient to match the abbreviated object name
in full, so a79 vs 895 can be explained and is a bug in this patch
that did not update the process_diffs helper.

Another thing that I find somewhat problematic in the original
(brian cc'ed) is that it does not special case all-zero object name
specially.  By turning any and all instances of $_x40 to $ZERO_OID,
we lose the distinction between a random-looking object name which
got turned into $ZERO_OID by the processing, and an object name that
was $ZERO_OID from the beginning, so we won't catch a possible
future bug where new file's preimage object name is not $ZERO_OID
(this is plausible when you try to show an intent-to-add entry; the
diff between the index and the working tree would be "new file"
patch, but the index entry records the object name for an empty
blob, e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 instead of $ZERO_OID
can easily be emitted by a mistaken implementation).
