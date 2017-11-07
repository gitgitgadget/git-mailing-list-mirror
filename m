Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6F9F520281
	for <e@80x24.org>; Tue,  7 Nov 2017 06:40:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754804AbdKGGkO (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Nov 2017 01:40:14 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62551 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754796AbdKGGkN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Nov 2017 01:40:13 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 21809A91DA;
        Tue,  7 Nov 2017 01:40:13 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:in-reply-to:references; s=sasl; bh=Vbgi
        J0M722KOvQyfVkI5zI2r3uc=; b=neurJX5Y1vDz/0ESBy9KSVkw3uKh5GVYHAZC
        KdKm8IpUgou/0KZoRTpA8spui74YVxnmc2nlkvrLFBcDlku13sRevWxQvyucXEUU
        a5EisvddfBBhBCNn4IutXLgLNpKAV6hPIDnfIuJ6Ayw3zgYsp6rXK1XL/Ri/+fcg
        8xzyrvw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
        :date:message-id:in-reply-to:references; q=dns; s=sasl; b=yB3SlU
        JlSvs46IVJ3n0k6NODMWT19lC8tkiN5hmHGDypWsU26C5G00totTAZyCOMwpzASC
        C7nf2rwKxKpKnhOKBWPwhhJ4LWglKw/aV+p3AA0C4bmtgy9CVCI6NIsXnsH9vpWL
        nSjmSQGfpJYw7o4t/FA/F+p4mAx11jJSANAiU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 183B4A91D9;
        Tue,  7 Nov 2017 01:40:13 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 7FA3DA91D7;
        Tue,  7 Nov 2017 01:40:12 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [PATCH v2 0/2] Teach "diff" to ignore only CR at EOL
Date:   Tue,  7 Nov 2017 15:40:09 +0900
Message-Id: <20171107064011.18399-1-gitster@pobox.com>
X-Mailer: git-send-email 2.15.0-263-g47cc852023
In-Reply-To: <xmqqshe7j0af.fsf@gitster.mtv.corp.google.com>
References: <xmqqshe7j0af.fsf@gitster.mtv.corp.google.com>
X-Pobox-Relay-ID: 81983316-C386-11E7-93D4-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This time with doc updates and tests.  The previous one is at 

https://public-inbox.org/git/xmqqshe7j0af.fsf@gitster.mtv.corp.google.com

A change that is supposed to only change the end-of-line convention
between LF <-> CRLF and nothing else can be verified with "diff -b"
or "diff --ignore-space-at-eol" in practice, but these hide changes
in whitespaces other than the carriage return at the end of the lines.

These two patches introduce a new --ignore-cr-at-eol option so that
only CR at eol and no other whitespace changes are ignored while
making a comparison, to allow a stricter validation.

I am not sure how much practical value the new option has.  The
preliminary clean-up patch to shuffle the bis assignment for flags
does have values, though ;-).

Junio C Hamano (2):
  xdiff: reassign xpparm_t.flags bits
  diff: --ignore-cr-at-eol

 Documentation/diff-options.txt     |  3 +++
 Documentation/merge-strategies.txt |  5 +++--
 diff.c                             |  6 +++---
 merge-recursive.c                  |  2 ++
 t/t4015-diff-whitespace.sh         | 28 ++++++++++++++++++++++++++++
 xdiff/xdiff.h                      | 26 ++++++++++++++++----------
 xdiff/xutils.c                     | 38 ++++++++++++++++++++++++++++++++++++--
 7 files changed, 91 insertions(+), 17 deletions(-)

-- 
2.15.0-263-g47cc852023

