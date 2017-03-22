Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 24C3E20323
	for <e@80x24.org>; Wed, 22 Mar 2017 22:13:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751355AbdCVWM7 (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Mar 2017 18:12:59 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63315 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751250AbdCVWM5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Mar 2017 18:12:57 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 65E3D8051B;
        Wed, 22 Mar 2017 18:12:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=pTJlDJWitgdfeHvpyFOSwKu+d/I=; b=rpDBQr
        qD+AoSDJuAeSCXc+fqK9XIZBPJj3MFEM6DJ2lOGbdCtBm8JVwMPHqtTi5nQ4d+0V
        sR9sMWOWgkPZhJynqzfpTNc8Nsz7aXV10mP3nGyMpWTJMXR0EvRQj0A9wIyMHMgA
        TpsnTcFi6aLQF1BL7oQgLde3WogSg2v8psOJ0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=hScIBAG7A2Emz3LVvPEdqiWVgPydIu9R
        RXBstWC/yDga/HLHhzLkHlPRW/lTfmMRh/lOTNhOjv3q2ZyeKIscpwCaBDEMoUc+
        yFKw9xFwZgok5BzRy5VnMMejBYLnmvRTXHsHnK8hejInL22JW6xl5MeegViNIh1h
        jXWMqD3y6AU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5EE408051A;
        Wed, 22 Mar 2017 18:12:09 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id BDB7980519;
        Wed, 22 Mar 2017 18:12:08 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Stefan Beller <sbeller@google.com>, git@vger.kernel.org,
        jan.palus@gmail.com
Subject: Re: [PATCH] t7406: correct test case for submodule-update initial population
References: <20170322213953.oddbgw5nfrvmzjgm@sigill.intra.peff.net>
        <20170322214948.12015-1-sbeller@google.com>
        <20170322215951.f4xbxehzvsd64c4y@sigill.intra.peff.net>
Date:   Wed, 22 Mar 2017 15:12:07 -0700
In-Reply-To: <20170322215951.f4xbxehzvsd64c4y@sigill.intra.peff.net> (Jeff
        King's message of "Wed, 22 Mar 2017 17:59:51 -0400")
Message-ID: <xmqq37e5hsg8.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9744E3EC-0F4C-11E7-8DA7-97B1B46B9B0B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Neither of those is true, but I think:
>
>   cat >expect <<-EOF &&
>   Execution of '\''false $submodulesha1'\'' failed in ...
>   EOF
>
> is safer and less surprising. The single-quote handling is unfortunate and
> ugly, but necessary to get them into the shell snippet in the first
> place. I notice the others tests in this script set up the expect file
> outside of a block. You could also do something like:
>
>   sq=\'
>   test_expect_success '...' '
> 	cat >expect <<-EOF
> 	Execution of ${sq}false $submodulesha1${sq} ...
>   '
>
> but I'm not sure if that is any more readable.

Yup, my eyes have long learned to coast over '\'' as an idiomatic
symbol, but I agree that it is harder to see until you get used to
it (and I do not think it is particularly useful skill to be able to
spot '\'' as a logical unit, either).  ${sq} thing may make it easier
to read but I think the one you did in the first quoted part in this
reply is good enough.

-- >8 --
Subject: t7406: correct test case for submodule-update initial population

There are three issues with the test:

* The syntax of the here-doc was wrong, such that the entire test was
  sucked into the here-doc, which is why the test succeeded successfully.

* The variable $submodulesha1 was not expanded as it was inside a quoted
  here text.  We do not want to quote EOF marker for this.

* The redirection from the git command to the output file for comparison
  was wrong as the -C operator from git doesn't apply to the redirect path.
  Also we're interested in stderr of that command.

Noticed-by: Jan Palus <jan.palus@gmail.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 t/t7406-submodule-update.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
index 8c086a429b..a70fe96ad6 100755
--- a/t/t7406-submodule-update.sh
+++ b/t/t7406-submodule-update.sh
@@ -425,11 +425,11 @@ test_expect_success 'submodule update - command in .git/config catches failure -
 '
 
 test_expect_success 'submodule update - command run for initial population of submodule' '
-	cat <<-\ EOF >expect
+	cat >expect <<-EOF &&
 	Execution of '\''false $submodulesha1'\'' failed in submodule path '\''submodule'\''
-	EOF &&
+	EOF
 	rm -rf super/submodule &&
-	test_must_fail git -C super submodule update >../actual &&
+	test_must_fail git -C super submodule update 2>actual &&
 	test_cmp expect actual &&
 	git -C super submodule update --checkout
 '

