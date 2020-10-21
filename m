Return-Path: <SRS0=jwDG=D4=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43FDEC4363A
	for <git@archiver.kernel.org>; Wed, 21 Oct 2020 20:48:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B8ED02415A
	for <git@archiver.kernel.org>; Wed, 21 Oct 2020 20:48:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="lAe+jI+E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439419AbgJUUsy (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Oct 2020 16:48:54 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50326 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405190AbgJUUsx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Oct 2020 16:48:53 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 93E9B7F6C0;
        Wed, 21 Oct 2020 16:48:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=LQdBDN90qGyk/iSDDCgUsiowVfk=; b=lAe+jI
        +EEJmz96fJbbBTvJ5lrhfa+akTwLc1Pd+YOn6WkegtKnEN4X6Tx+huR+QQylYyZz
        BPlwvPcy409uSwy3s7T7u99FwMQt2v8hxW0kxMYfJs5u21GvKpHgyoTCc4X/XWhn
        zKZkiJ7dAApdERE9mdJU6GvB3BmC7w5sqdWUA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=bUlVKadZNVAW+BeZtIzUZ43AE0bDvwXC
        QdEkJ8R+Ia2bw/hJByDPv98gTCn2Ukm1PaKdyeJHw9wPiYl31xDc4HaikH6yMkrj
        +kmD3e7RfZsWiz6SApScfr4TOLkS95EuMkHujEpHSwq2mVF/tj30fCk1njCakKh1
        K4pd1bFdO3U=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8AC5C7F6BF;
        Wed, 21 Oct 2020 16:48:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 131FF7F6BD;
        Wed, 21 Oct 2020 16:48:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Nikos Chantziaras <realnc@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Subject: Re: git svn log: Use of uninitialized value $sha1_short
References: <rmpve5$q2s$1@ciao.gmane.io>
        <20201021202642.GA60606@coredump.intra.peff.net>
Date:   Wed, 21 Oct 2020 13:48:50 -0700
In-Reply-To: <20201021202642.GA60606@coredump.intra.peff.net> (Jeff King's
        message of "Wed, 21 Oct 2020 16:26:42 -0400")
Message-ID: <xmqqwnzj5mq5.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D3247568-13DE-11EB-B992-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> It seems to only get mentioned once and never set:
>
>   $ git grep sha1_short perl
>   perl/Git/SVN/Log.pm:            } elsif (/^${esc_color}:\d{6} \d{6} $::sha1_short/o) {
>
> Looks like it got renamed, and this reference was somehow missed?
>
>   $ git log -1 -Ssha1_short perl
>   commit 9ab33150a0d14089d0496dd8354d4a969e849571
>   Author: brian m. carlson <sandals@crustytoothpaste.net>
>   Date:   Mon Jun 22 18:04:12 2020 +0000
>   
>       perl: create and switch variables for hash constants
>       
>       git-svn has several variables for SHA-1 constants, including short hash
>       values and full length hash values.  Since these are no longer SHA-1
>       specific, let's start them with "oid" instead of "sha1".  Add a
>       constant, oid_length, which is the length of the hash algorithm in use
>       in hex.  We use the hex version because overwhelmingly that's what's
>       used by git-svn.
>   [...]

Looks that way.  '$::' as opposed to plain '$' threw the replacement
off the track?

 perl/Git/SVN/Log.pm | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git i/perl/Git/SVN/Log.pm w/perl/Git/SVN/Log.pm
index 3858fcf27d..9c819188ea 100644
--- i/perl/Git/SVN/Log.pm
+++ w/perl/Git/SVN/Log.pm
@@ -298,7 +298,7 @@ sub cmd_show_log {
 			get_author_info($c, $1, $2, $3);
 		} elsif (/^${esc_color}(?:tree|parent|committer) /o) {
 			# ignore
-		} elsif (/^${esc_color}:\d{6} \d{6} $::sha1_short/o) {
+		} elsif (/^${esc_color}:\d{6} \d{6} $::oid_short/o) {
 			push @{$c->{raw}}, $_;
 		} elsif (/^${esc_color}[ACRMDT]\t/) {
 			# we could add $SVN->{svn_path} here, but that requires
