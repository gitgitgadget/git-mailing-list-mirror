Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16308C47082
	for <git@archiver.kernel.org>; Sat,  5 Jun 2021 18:11:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F0819611C2
	for <git@archiver.kernel.org>; Sat,  5 Jun 2021 18:11:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230010AbhFESNU (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 5 Jun 2021 14:13:20 -0400
Received: from mout.web.de ([217.72.192.78]:43345 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229994AbhFESNU (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Jun 2021 14:13:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1622916685;
        bh=OJMQChTKvnU8rCAkOpK7f52nri5PnNrBi7CQLKOmbBA=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:References:Date:In-Reply-To;
        b=J9tj5OGclq5QfiVhKYjzaDKel/WkCj5mjEHmP7LDe+0ocZAR084Jx1HAPeP8zDC8U
         +/v6JBF92e9R8Jta+5mbctq+0kLJwU7e8BQuugCQX32belcy0kDRzpH5uKuOrPtq0s
         P65+cXTfENhglmDfPsTAxuNHROKWldKgZItF0bVc=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from Mini-von-Rene.fritz.box ([79.203.31.60]) by smtp.web.de
 (mrweb101 [213.165.67.124]) with ESMTPSA (Nemesis) id
 0MA5if-1leHAa03s9-00BLyN; Sat, 05 Jun 2021 20:11:25 +0200
Subject: [PATCH v2] parallel-checkout: avoid dash local bug in tests
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
To:     Git List <git@vger.kernel.org>
Cc:     Matheus Tavares <matheus.bernardino@usp.br>,
        Junio C Hamano <gitster@pobox.com>
References: <eb4bcd4c-e6d2-cbeb-8951-cf22b9d3d5fe@web.de>
Message-ID: <472c1411-fcf8-862b-cef9-52c2c994914b@web.de>
Date:   Sat, 5 Jun 2021 20:11:24 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <eb4bcd4c-e6d2-cbeb-8951-cf22b9d3d5fe@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:KFu5ZVq87qEjW/zWhqI3ybYArrjSAIIY7IjFNmtK5BNsho/pCeB
 mmCVEQxjilkKHhSGIPPnvcM9xKUAZea2Wf53mYHOG4Y/PEGk5W6dGXdZEjObqSWuXenYSX2
 +hPwEWtiZKCD9mYQLBJ68eqd/Hn+iDDEaps5vHOHdXFjrINhLUeA2I4bb/FAxzt/lsIYvVt
 PKq1XU2eFA2wY8DxLFJjQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:YFXCndqeR/M=:xq/cZwOcNqz1gSrdORO1nz
 W2UJ0S25t1zyhbzNidA6TlOw7ZmULcGnBEVHdmuQWG1Dqk1eQ72qbjQv2yk288rKw2RKajVE4
 7FeHLvOBxu3LS/6Aw8PR5pMAJ7VC1pDgCiVT3EZQm9jaKZOd0enEtafVCSaCUx+KLp24RJilD
 R3tE085fJF91VlI5TL5GSYKtafojjkQdtj2Y62wuaIW8MEsQ27NcSB0FZuNcWUfAaSyu/V9f9
 9+H6XwclZfU7SgQfLFWNLfneLkKoRB/6smIlyW9lOluwNf1w7Hsx8WwYeGhKm0qlwQcYgDAbg
 8DZU2Umg6T0uUp/2GW44x5CSr7p8UcVzn0cczGmWLe3F6qffvUHOSaMGVZxEfxuy3WZY2StSm
 1aXsXs/TtdW/A37026tFOshgWfpERK1KnDFGKnCwTyXDKnGGAstfym9IhxMMPhiZN7nK8HQ3s
 NUTs/AdwYCZHKD47Lw+YtCAzeyzMW9mxvx8QdBtvudObGzY4yubaauKaFVTOL98nbDluMxgbA
 ML8gi9DsrqZ2nXHfFDgB6J7HYupxbmoXZlU+R0FTwrL/vDZ2Iggn0+w4Q836PRDygLGHyzLB9
 tL1vjCP6wfm+sL1cvek2hgravGQynzbDp0Nn2TGUc9xQ5UAOmk7iAva7OvmTnMrA+Rvrg3W0n
 aVErMIUt4O1i0LyyTiv1ct6NUvLHdCyo+eSVMixwwKntxiI5xZuu4I5w8nqUYG9kKAAcwNF2q
 +LlipdnSNL0vpAC9RKe7yxxXph8w56/O4B1VBvgTH7fDuqDQ/p826m6NVQidpmZlcQmKoeJQD
 HiQ1/iYYwX5xKNS2AbmMlXwFbIzQUR0DaMK+rOUySEN7MkrtR/tE5rQ3bC3wiqggJpOrSu9v7
 5i0QIrn14uDgjnD/9o6CXFx9jFt49cak5IIg7LFuAgBlpm0ouFcE+P4+kOyZxjUy/1Rvf8Vt1
 YBz2ZGDWVAAJJuePNlhTf1dMzfK9JQ9XoQoSoHnGe+7l08WbdDjY89ycQoaWXxznCWF/rtHMh
 lUSPQMc9LKF3LTNsI5jZBUkxdIfEfZl2wokE1nSzVYCPdTlXwzqiBgdecSl+0FoJ8XEdI2VA0
 wOa6pfc9yTXElFpXoux9ZjENBcD9Z2q2u+n
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The parallel checkout tests fail when run with /bin/dash on MacOS 11.4,
reporting the following error:

   ./t2080-parallel-checkout-basics.sh: 33: local: 0: bad variable name

That's because wc's output contains leading spaces and this version of
dash erroneously expands the variable declaration as "local workers=3D 0",
i.e. it tries to set the "workers" variable to the empty string and also
declare a variable named "0", which not a valid name.  This is a known
dash bug (https://bugs.launchpad.net/ubuntu/+source/dash/+bug/139097).

Work around it by passing the command output directly to test instead of
storing it in a variable first.  While at it, let grep count the number
of lines instead of piping its output to wc, which is a bit shorter and
more efficient.

Helped-by: Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
Changes since v1:
- Explain the root cause.
- Get rid of the local variable "workers".
- Adjust title accordingly.
- Still use grep -c, though.
- Remove input redirection.

 t/lib-parallel-checkout.sh | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/t/lib-parallel-checkout.sh b/t/lib-parallel-checkout.sh
index 21f5759732..66350d5207 100644
=2D-- a/t/lib-parallel-checkout.sh
+++ b/t/lib-parallel-checkout.sh
@@ -27,8 +27,7 @@ test_checkout_workers () {
 	rm -f "$trace_file" &&
 	GIT_TRACE2=3D"$(pwd)/$trace_file" "$@" 2>&8 &&

-	local workers=3D$(grep "child_start\[..*\] git checkout--worker" "$trace=
_file" | wc -l) &&
-	test $workers -eq $expected_workers &&
+	test $(grep -c "child_start\[..*\] git checkout--worker" "$trace_file") =
-eq $expected_workers &&
 	rm "$trace_file"
 } 8>&2 2>&4

=2D-
2.31.1

