Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2E3462036D
	for <e@80x24.org>; Thu,  5 Oct 2017 01:49:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751266AbdJEBtJ (ORCPT <rfc822;e@80x24.org>);
        Wed, 4 Oct 2017 21:49:09 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58960 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751223AbdJEBtI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Oct 2017 21:49:08 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A674DB2716;
        Wed,  4 Oct 2017 21:49:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=pdvHYdAUJ9c6yQ0ywtBIAc8jC54=; b=sfPUPz
        TgQ9ZUlMafZa7hMCXacLOyTQYM57pAG9FLMp+KowBMcIRaPEn+7oPBLaUtaws2E7
        F99EHV7Vix7Oui+CrqL8wGGRZsOYaHxODCpNU32WsBhYx7Qwyq+22aVeRe4xrr2q
        YQH0xKy7UZNnzcinFV42rkb4qCfOhQXQgJJws=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=PyjPhQDrfnmEwNMgKMueMoCGY2//WDAD
        GJeKjbqLRZ+t8jtkSoaq56NFt5FWdsfqjuy9UdljrKrKZYxTqg0RUWGHW7zqdYxX
        hDFYgNqafKBvu30F1WJWhu8Usd8tFYx9obvvD25B8O4w0kid4sPvJQgvn6ne8n9r
        DVDQm9dftNQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9DBCEB2715;
        Wed,  4 Oct 2017 21:49:02 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 12D8AB2714;
        Wed,  4 Oct 2017 21:49:02 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
        peff@peff.net
Subject: Re: [PATCH v2] ref-filter.c: pass empty-string as NULL to atom parsers
References: <20171002055052.GB10729@D-10-157-251-166.dhcp4.washington.edu>
        <20171002161034.44867-1-me@ttaylorr.com>
        <20171002224052.GR19555@aiede.mtv.corp.google.com>
        <xmqqmv59m7fu.fsf@gitster.mtv.corp.google.com>
        <20171003033726.GA84817@D-10-157-251-166.dhcp4.washington.edu>
Date:   Thu, 05 Oct 2017 10:49:00 +0900
In-Reply-To: <20171003033726.GA84817@D-10-157-251-166.dhcp4.washington.edu>
        (Taylor Blau's message of "Mon, 2 Oct 2017 20:37:26 -0700")
Message-ID: <xmqq376y9xf7.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5CC48CFA-A96F-11E7-874D-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> On Tue, Oct 03, 2017 at 08:55:01AM +0900, Junio C Hamano wrote:
>> Jonathan Nieder <jrnieder@gmail.com> writes:
>>
>> > The above does a nice job of explaining
>> >
>> >  - what this change is going to do
>> >  - how it's good for the internal code structure / maintainability
>> >
>> > What it doesn't tell me about is why the user-facing effect won't
>> > cause problems.  Is there no atom where %(atom:) was previously
>> > accepted and did something meaningful that this may break?

This loose end needs to be tied.  

I replaced "let's assume that doing this change is OK" from the
original log message with something a bit stronger, as with this
change, we are saying that it is forbidden to treat %(atom) and
%(atom:) differently.  I also recorded the result of due-diligence
survey of the current code to suggest that the change would be OK
for current users.

-- >8 --
From: Taylor Blau <me@ttaylorr.com>
Date: Mon, 2 Oct 2017 09:10:34 -0700
Subject: [PATCH] ref-filter.c: pass empty-string as NULL to atom parsers

Peff points out that different atom parsers handle the empty
"sub-argument" list differently. An example of this is the format
"%(refname:)".

Since callers often use `string_list_split` (which splits the empty
string with any delimiter as a 1-ary string_list containing the empty
string), this makes handling empty sub-argument strings non-ergonomic.

Let's fix this by declaring that atom parser implementations must
not care about distinguishing between the empty string "%(refname:)"
and no sub-arguments "%(refname)".  Current code aborts, either with
"unrecognised arg" (e.g. "refname:") or "does not take args"
(e.g. "body:") as an error message.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
Reviewed-by: Jeff King <peff@peff.net>
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 ref-filter.c            | 10 +++++++++-
 t/t6300-for-each-ref.sh |  1 +
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/ref-filter.c b/ref-filter.c
index bc591f4f3d..f3e53d4448 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -415,8 +415,16 @@ static int parse_ref_filter_atom(const struct ref_format *format,
 	REALLOC_ARRAY(used_atom, used_atom_cnt);
 	used_atom[at].name = xmemdupz(atom, ep - atom);
 	used_atom[at].type = valid_atom[i].cmp_type;
-	if (arg)
+	if (arg) {
 		arg = used_atom[at].name + (arg - atom) + 1;
+		if (!*arg) {
+			/*
+			 * Treat empty sub-arguments list as NULL (i.e.,
+			 * "%(atom:)" is equivalent to "%(atom)").
+			 */
+			arg = NULL;
+		}
+	}
 	memset(&used_atom[at].u, 0, sizeof(used_atom[at].u));
 	if (valid_atom[i].parser)
 		valid_atom[i].parser(format, &used_atom[at], arg);
diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
index 2274a4b733..edc1bd8eab 100755
--- a/t/t6300-for-each-ref.sh
+++ b/t/t6300-for-each-ref.sh
@@ -51,6 +51,7 @@ test_atom() {
 }
 
 test_atom head refname refs/heads/master
+test_atom head refname: refs/heads/master
 test_atom head refname:short master
 test_atom head refname:lstrip=1 heads/master
 test_atom head refname:lstrip=2 master
-- 
2.14.2-921-g20a440a8ba

