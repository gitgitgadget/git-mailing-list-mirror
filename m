From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/6] modernize t1500
Date: Tue, 10 May 2016 11:10:33 -0700
Message-ID: <xmqqmvnxpyw6.fsf@gitster.mtv.corp.google.com>
References: <20160510052055.32924-1-sunshine@sunshineco.com>
	<xmqqfutqsaxn.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Michael Rappazzo <rappazzo@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>,
	SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>,
	Johannes Sixt <j.sixt@viscovery.net>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Tue May 10 20:10:44 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0C7F-00076A-8I
	for gcvg-git-2@plane.gmane.org; Tue, 10 May 2016 20:10:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751410AbcEJSKh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 May 2016 14:10:37 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57137 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750983AbcEJSKg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 May 2016 14:10:36 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 764F11A46D;
	Tue, 10 May 2016 14:10:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=iWp8bvjJt1GaQuTpk02sjecGr/0=; b=ePy5G/
	SATJVcsm/X0+G+LUfR7wZvK0B4uanTtLAvG0F7whtYK1YKw2let1PZ3LhQrzVlIx
	xevTML4dg0bYdCqIrpYIvOFA29sivZjXdD63zDVfwL61JskZUEmX3nSvl49uo0Hi
	rs3IMqeaptJZyaABKSgnJoiaoKsprx6MbaGQ8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=sKRj+Y/nYrnaUS8LpQyuskBr7fZOAhZE
	SEt0R0rFxNvGKqOL/EMLI5e3rVdkZW3BB/x+uC/5MmUYr1IdKALLT2A+EO6qp9Rp
	jwoLap/MUIAOgUUdStxtBjISpFah8PltPIlycqX/bSAJeymVvSMH7dzKuJAxZLH4
	l+vh/fqdlLU=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 66F9E1A46C;
	Tue, 10 May 2016 14:10:35 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id DA4B31A46B;
	Tue, 10 May 2016 14:10:34 -0400 (EDT)
In-Reply-To: <xmqqfutqsaxn.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Mon, 09 May 2016 23:07:32 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 7DBF4E64-16DA-11E6-970E-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294168>

Junio C Hamano <gitster@pobox.com> writes:

> Eric Sunshine <sunshine@sunshineco.com> writes:
>
>> This series modernizes t1500; it takes an entirely different approach
>> than [1][2] and is intended to replace that series.
>
> Turns out that it wasn't so painful after all.
>
> The only small niggle I have is on 6/6; my preference would be,
> because once we set up .git we do not add objects and refs to it, to
> make a copy a lot earlier before the tests start.

-- >8 --
Subject: [PATCH 7/6] t1500: finish preparation upfront

The earlier tests do not attempt to modify the contents of .git (by
creating objects or refs, for example), which means that even if
some earlier tests before "cp -R" fail, the tests in repo.git will
run in an environment that we can expect them to succeed in.

Make it clear that tests in repo.git will be independent from the
results of earlier tests done in .git by moving its initialization
"cp -R .git repo.git" much higher in the test sequence.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t1500-rev-parse.sh | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/t/t1500-rev-parse.sh b/t/t1500-rev-parse.sh
index 811c70f2..cb08677 100755
--- a/t/t1500-rev-parse.sh
+++ b/t/t1500-rev-parse.sh
@@ -51,6 +51,7 @@ test_rev_parse () {
 }
 
 ROOT=$(pwd)
+test_expect_success 'setup non-local database ../repo.git' 'cp -R .git repo.git'
 
 test_rev_parse toplevel false false true '' .git
 
@@ -72,8 +73,6 @@ test_rev_parse -C work -g ../.git -b t 'GIT_DIR=../.git, core.bare = true' true
 
 test_rev_parse -C work -g ../.git -b u 'GIT_DIR=../.git, core.bare undefined' false false true ''
 
-test_expect_success 'setup non-local database ../repo.git' 'cp -R .git repo.git'
-
 test_rev_parse -C work -g ../repo.git -b f 'GIT_DIR=../repo.git, core.bare = false' false false true ''
 
 test_rev_parse -C work -g ../repo.git -b t 'GIT_DIR=../repo.git, core.bare = true' true false false ''
-- 
2.8.2-623-gacdd3f1
