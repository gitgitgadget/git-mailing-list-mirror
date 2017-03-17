Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 915B720955
	for <e@80x24.org>; Fri, 17 Mar 2017 00:18:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752952AbdCQASV (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Mar 2017 20:18:21 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51715 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752193AbdCQASU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Mar 2017 20:18:20 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 44C906A76E;
        Thu, 16 Mar 2017 20:18:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=sawToJC1IfwyDDvqAwJTsmEU8y8=; b=pP29zm
        ogB2MIPzix0Na/wsnB8UqBcG9gS4RLN18AgKTMpPtKl89zxF41cZ0/t41OjIMEN9
        hmdPmicbliSWpVsNsiZbHAkkJbz2luNsj0N44GY+idlWCHtM5XQ01wOR54XA+4Hh
        JP5X3MN7RjS6Mk5KwLQFAfNbiwS0Lasp4jWAU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
        :references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=go5iEM5ESmUjYITF2gN0aKDMaZc+esyT
        DgW6B+XcvhnKkrq86D+Fg6y4cJlz2zK9wRqjkX4YagOZND9Si/hNTIPWcLG4iAS+
        cZo0K/RgArFVMAZB/qc7LMzcker9F7s0NoAQGWUGYGr9dQJRKpqzBC5Rb9jJ2lN2
        8oqkGx+fXSg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3D1226A76D;
        Thu, 16 Mar 2017 20:18:18 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B09406A76C;
        Thu, 16 Mar 2017 20:18:17 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: Getting ready for 2.12.1
References: <xmqq4lyvh1nw.fsf@gitster.mtv.corp.google.com>
Date:   Thu, 16 Mar 2017 17:18:16 -0700
In-Reply-To: <xmqq4lyvh1nw.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Tue, 14 Mar 2017 16:35:47 -0700")
Message-ID: <xmqqpohgah87.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 383C0A1E-0AA7-11E7-8D97-FC50AE2156B6-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

So far I've merged the following topics to 'maint' in preparation
for the first maintenance update for 2.12:

 * Reduce authentication round-trip over HTTP when the server supports
   just a single authentication method.  This also improves the
   behaviour when Git is misconfigured to enable http.emptyAuth
   against a server that does not authenticate without a username
   (i.e. not using Kerberos etc., which makes http.emptyAuth
   pointless).

 * Windows port wants to use OpenSSL's implementation of SHA-1
   routines, so let them.

 * Add 32-bit Linux variant to the set of platforms to be tested with
   Travis CI.

 * When a redirected http transport gets an error during the
   redirected request, we ignored the error we got from the server,
   and ended up giving a not-so-useful error message.

 * The patch subcommand of "git add -i" was meant to have paths
   selection prompt just like other subcommand, unlike "git add -p"
   directly jumps to hunk selection.  Recently, this was broken and
   "add -i" lost the paths selection dialog, but it now has been
   fixed.

 * Git v2.12 was shipped with an embarrassing breakage where various
   operations that verify paths given from the user stopped dying when
   seeing an issue, and instead later triggering segfault.

 * The code to parse "git log -L..." command line was buggy when there
   are many ranges specified with -L; overrun of the allocated buffer
   has been fixed.

 * The command-line parsing of "git log -L" copied internal data
   structures using incorrect size on ILP32 systems.

I think travis will try to build it tonight on our usual suspect
platforms; it would be appreciated if those who are testing for
their favourite platform to also give it a whirl and report if there
are any breakages.

There are other "fix" topics that have been merged to 'master' that
eventually could go to 'maint'; as I am inclined to keep the first
one to the minimum, they will be merged and shipped in 2.12.2 or
later.

Thanks.
