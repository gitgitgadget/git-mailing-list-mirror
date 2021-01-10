Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7D75C433E6
	for <git@archiver.kernel.org>; Sun, 10 Jan 2021 01:53:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD65823A01
	for <git@archiver.kernel.org>; Sun, 10 Jan 2021 01:53:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726426AbhAJBxO (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 9 Jan 2021 20:53:14 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:58643 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726329AbhAJBxN (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Jan 2021 20:53:13 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 9EDE111560F;
        Sat,  9 Jan 2021 20:52:31 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=kxsLDElN9tz6bFo5pBGTbPrIXdQ=; b=JqAa7H
        1S44k6uveGqCy/1gVaQtuOuiFTMHVUliYwXjfRe4LJNAHITDsIkCCdyYLUQpzwGv
        2LKSm2J6Vs9BUcTtO6JTxqBentICp3AnrZ1503+Udc6CERw3hUuiY+KD2D7MgVZ6
        KrtkDSCZCsdFwbbQdXGbUykmA9niF68Xv6xj8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=wdVwamYqzetFOgeiSdQr85y1cCMcqwmF
        hDgLbBbr0c9UD1IX37jkElsbfKQURd7ydn4pOXDMBl6zo3O1oUCpkP37fPtX3dV6
        +Ji+Cd1yEFpzofFzY9Ip9PjCPF12Myd/zqbRpB3Tg4V0Zu7KgrDHMTET/6gAH1DS
        vyYW9I+7UKE=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 9702B11560E;
        Sat,  9 Jan 2021 20:52:31 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 0B4BB11560B;
        Sat,  9 Jan 2021 20:52:27 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     David Aguilar <davvid@gmail.com>
Cc:     Seth House <seth@eseth.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Subject: Re: [PATCH v2] fixup! mergetool: add automerge configuration
References: <X/onP6vFAHH8SUBo@camp.crustytoothpaste.net>
        <20210109224236.50363-1-davvid@gmail.com>
        <xmqqbldxem24.fsf@gitster.c.googlers.com>
Date:   Sat, 09 Jan 2021 17:52:26 -0800
In-Reply-To: <xmqqbldxem24.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Sat, 09 Jan 2021 15:18:43 -0800")
Message-ID: <xmqqeeitd0dh.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7E5876C8-52E6-11EB-AFB3-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> I was hoping that we can avoid repetition that can cause bugs with
> something like
> ...

Here is a cleaned-up version that would apply cleanly on top of
yours.

I suspect that it would make it even easier to follow the logic if
the two sed "-e" expressions are swapped for the $LOCAL one.  

It would clarify that we remove $C0 (separator before ours) and
$C1..$C3 (ancestor's and theirs, including the separators) to get
the local version.

The other two are already described in the correct order.

Thanks.

 git-mergetool.sh | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/git-mergetool.sh b/git-mergetool.sh
index 9029a79431..ed152a4187 100755
--- a/git-mergetool.sh
+++ b/git-mergetool.sh
@@ -243,16 +243,14 @@ auto_merge () {
 	git merge-file --diff3 --marker-size=7 -q -p "$LOCAL" "$BASE" "$REMOTE" >"$DIFF3"
 	if test -s "$DIFF3"
 	then
-		cr=$(printf '\r')
-		sed -e '/^<<<<<<< /,/^||||||| /d' \
-			-e "/^=======$cr\{0,1\}$/,/^>>>>>>> /d" \
-			"$DIFF3" >"$BASE"
-		sed -e '/^||||||| /,/^>>>>>>> /d' \
-			-e '/^<<<<<<< /d' \
-			"$DIFF3" >"$LOCAL"
-		sed -e "/^<<<<<<< /,/^=======$cr\{0,1\}$/d" \
-			-e '/^>>>>>>> /d' \
-			"$DIFF3" >"$REMOTE"
+		C0="^<<<<<<< "
+		C1="^||||||| "
+		C2="^=======$(printf '\015')\{0,1\}$"
+		C3="^>>>>>>> "
+
+		sed -e "/$C0/,/$C1/d" -e "/$C2/,/$C3/d" "$DIFF3" >"$BASE"
+		sed -e "/$C1/,/$C3/d" -e "/$C0/d" "$DIFF3" >"$LOCAL"
+		sed -e "/$C0/,/$C2/d" -e "/$C3/d" "$DIFF3" >"$REMOTE"
 	fi
 	rm -- "$DIFF3"
 }
-- 
2.30.0-307-g37795e20d9

