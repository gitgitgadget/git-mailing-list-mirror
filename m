Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 93AA01FC96
	for <e@80x24.org>; Tue,  6 Dec 2016 18:18:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932275AbcLFSSB (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Dec 2016 13:18:01 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52112 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752691AbcLFSR5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Dec 2016 13:17:57 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CC36853E54;
        Tue,  6 Dec 2016 13:17:56 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=WaDQ/cQOmItRVrlpgIwR4Hh6xdI=; b=tmahCA
        w/j0B6j+se9UDhBCOCDrIKoP8lxDwh4gzSK64t8F94vL2QHGYqZX3vrVsKdhNREp
        ++0/vc2Xo+bcdf7Y+TnPpQJCeRTZtYPtYLmMeVgqX+dDZaFfwISO17MsDvpCDndp
        IB31C/k2hB8wD+SRF0psXoShnJn9Yg/uB4CFY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=kLLln7WWDM7q/V7prvTrazF79fkzHHdt
        33n3tVT6GaUXx/qlnxQ6ByQo0WwVCEZ7kg1IMDnIohvmCRZP2X5nM7Tw1B3uWqsX
        4Z3tU0OBIDBR8xLwkmA55T9qnNMOv2MAGDyEvz83UWP/OmkhxGIxqilShZXQyTHh
        hNyVoc4YYME=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C2F7953E53;
        Tue,  6 Dec 2016 13:17:56 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4075B53E52;
        Tue,  6 Dec 2016 13:17:56 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Ramsay Jones <ramsay@ramsayjones.plus.com>,
        GIT Mailing-list <git@vger.kernel.org>
Subject: Re: [RFC PATCH] GIT-VERSION-GEN: set --abbrev=9 to match auto-scaling
References: <22e9dfa0-47fb-d6fd-caf4-c2d87f63f707@ramsayjones.plus.com>
        <20161205053258.jtnqq64gp5n7vtni@sigill.intra.peff.net>
        <xmqqbmwq5k7k.fsf@gitster.mtv.corp.google.com>
        <20161206140259.lly76xkvsj7su3om@sigill.intra.peff.net>
Date:   Tue, 06 Dec 2016 10:17:55 -0800
In-Reply-To: <20161206140259.lly76xkvsj7su3om@sigill.intra.peff.net> (Jeff
        King's message of "Tue, 6 Dec 2016 09:03:00 -0500")
Message-ID: <xmqqwpfc2a7g.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4F890DEA-BBE0-11E6-A029-E98412518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Mon, Dec 05, 2016 at 10:01:19AM -0800, Junio C Hamano wrote:
>
>> > That said, I think the right patch may be to just drop --abbrev
>> > entirely.
>> > ...
>> > I think at that point it was a noop, as 7 should have been the default.
>> > And now we probably ought to drop it, so that we can use the
>> > auto-scaling default.
>> 
>> Yeah, I agree.
>> 
>> It does mean that snapshot binaries built out of the same commit in
>> the same repository before and after a repack have higher chances of
>> getting named differently, which may surprise people, but that
>> already is possible with a fixed length if the repacking involves
>> pruning (albeit with lower probabilities), and I do not think it is
>> a problem.
>
> I think that the number is already unstable, even with --abbrev, as it
> just specifies a minimum. So any operation that creates objects has a
> possibility of increasing the length. Or more likely, two people
> describing the same version may end up with different strings because
> they have different objects in their repositories (e.g., I used to
> carry's trast's git-notes archive of the mailing list which added quite
> a few objects).
>
> I agree that having it change over the course of a repack is slightly
> _more_ surprising than those cases, but ultimately the value just isn't
> stable.

Yup, that is what I meant to say with "that is already possible" and
we are on the same page.  As all three of us seem to be happy with
just dropping --abbrev and letting describe do its default thing (as
configured by whoever is doing the build), let's do so.

-- >8 --
From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Date: Sun, 4 Dec 2016 20:45:59 +0000
Subject: [PATCH] GIT-VERSION-GEN: do not force abbreviation length used by 'describe'

The default version name for a Git binary is computed by running
"git describe" on the commit the binary is made out of, basing on a
tag whose name matches "v[0-9]*", e.g. v2.11.0-rc2-2-g7f1dc9.

In the very early days, with 9b88fcef7d ("Makefile: use git-describe
to mark the git version.", 2005-12-27), we used "--abbrev=4" to get
absolute minimum number of abbreviated commit object name.  This was
later changed to match the default minimum of 7 with bf505158d0
("Git 1.7.10.1", 2012-05-01).

These days, the "default minimum" scales automatically depending on
the size of the repository, and there is no point in specifying a
particular abbreviation length; all we wanted since Git 1.7.10.1
days was to get "something reasonable we would use by default".

Just drop "--abbrev=<number>" from the invocation of "git describe"
and let the command pick what it thinks is appropriate, taking the
end user's configuration and the repository contents into account.

Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 GIT-VERSION-GEN | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/GIT-VERSION-GEN b/GIT-VERSION-GEN
index 556fbfc104..f95b04bb36 100755
--- a/GIT-VERSION-GEN
+++ b/GIT-VERSION-GEN
@@ -12,7 +12,7 @@ if test -f version
 then
 	VN=$(cat version) || VN="$DEF_VER"
 elif test -d ${GIT_DIR:-.git} -o -f .git &&
-	VN=$(git describe --match "v[0-9]*" --abbrev=7 HEAD 2>/dev/null) &&
+	VN=$(git describe --match "v[0-9]*" HEAD 2>/dev/null) &&
 	case "$VN" in
 	*$LF*) (exit 1) ;;
 	v[0-9]*)
-- 
2.11.0-263-gd89495280e

