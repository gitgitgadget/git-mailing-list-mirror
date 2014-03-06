From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t3200-branch: test setting branch as own upstream
Date: Thu, 06 Mar 2014 13:53:49 -0800
Message-ID: <xmqqa9d3vvrm.fsf@gitster.dls.corp.google.com>
References: <xmqqmwh5ikl0.fsf@gitster.dls.corp.google.com>
	<1394004715-18776-1-git-send-email-modocache@gmail.com>
	<20140306210025.GD29659@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brian Gesiak <modocache@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Mar 06 22:54:04 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WLgEt-00027e-JB
	for gcvg-git-2@plane.gmane.org; Thu, 06 Mar 2014 22:54:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753386AbaCFVx6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Mar 2014 16:53:58 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34697 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752639AbaCFVxy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Mar 2014 16:53:54 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2863D725FA;
	Thu,  6 Mar 2014 16:53:54 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=R3CaHe80tdPUuO8cwj4dMXOplzU=; b=wc6Fxs
	nhU9UzxgcBPP2qqTqclIshrz7pcP8rcdzb55LRTQJWtCd1X3ribQzVK0qQbO51kY
	Tvh9sR1iJwDeI56KAQbfeiixF61Fn/tAhNBiCnzlHy17dtQdSe4N4JiiuLNVb3g5
	bKQgba+Sa/tXPpisqiNRbqW+wkmzwYcCHNp0Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=tT+QAjDYb+Rmzy9//pRszsiOsE/MN1z8
	VJgN9diqviZB5eZzFQOKAEiCZdfHl7xklyjHqj089MMXTeUIzvTvpU0Dqdqdg6cg
	UkAfcCLBQPk3BFRvjbenaO4rTz3l0rQSoo8ybjBa3SzjhwAjclI9LdztJn+mZ4LW
	WUF7GFXfjGM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1942F725F9;
	Thu,  6 Mar 2014 16:53:54 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 25741725F8;
	Thu,  6 Mar 2014 16:53:53 -0500 (EST)
In-Reply-To: <20140306210025.GD29659@sigill.intra.peff.net> (Jeff King's
	message of "Thu, 6 Mar 2014 16:00:26 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: CEDF689E-A579-11E3-B4E2-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243562>

Jeff King <peff@peff.net> writes:

> On Wed, Mar 05, 2014 at 04:31:55PM +0900, Brian Gesiak wrote:
>
>> No test asserts that "git branch -u refs/heads/my-branch my-branch"
>> emits a warning. Add a test that does so.
>> 
>> Signed-off-by: Brian Gesiak <modocache@gmail.com>
>
> Thanks, this looks good. Two minor points that may or may not be worth
> addressing:
>
>> +test_expect_success '--set-upstream-to shows warning if used to set branch as own upstream' '
>> +	git branch --set-upstream-to refs/heads/my13 my13 2>actual &&
>> +	cat >expected <<EOF &&
>> +warning: Not setting branch my13 as its own upstream.
>> +EOF
>
> If you spell the EOF marker as:
>
>     cat >expect <<-\EOF
>
> then:
>
>   1. The shell does not interpolate the contents (it does not matter
>      here, but it is a good habit to be in, so we typically do it unless
>      there is a need to interpolate).
>
>   2. Using <<- will strip leading tabs, so the content can be indented
>      properly along with the rest of the test.
>
>> +	test_i18ncmp expected actual &&
>> +	test_must_fail git config branch.my13.remote &&
>> +	test_must_fail git config branch.my13.merge
>
> I think we could tighten these to:
>
>   test_expect_code 1 git config branch.my13.remote
>
> to eliminate a false-positive success on other config errors. It's
> highly improbable for it to ever matter, though (and it looks like we
> are not so careful in most other places that call "git config" looking
> for a missing entry, either).

Sounds good.  Here is what I'll re-queue.

-- >8 --
From: Brian Gesiak <modocache@gmail.com>
Date: Wed, 5 Mar 2014 16:31:55 +0900
Subject: [PATCH] t3200-branch: test setting branch as own upstream

No test asserts that "git branch -u refs/heads/my-branch my-branch"
avoids leaving nonsense configuration and emits a warning.

Add a test that does so.

Signed-off-by: Brian Gesiak <modocache@gmail.com>
Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t3200-branch.sh | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index fcdb867..83037b1 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -507,6 +507,16 @@ EOF
 	test_cmp expected actual
 '
 
+test_expect_success '--set-upstream-to notices an error to set branch as own upstream' '
+	git branch --set-upstream-to refs/heads/my13 my13 2>actual &&
+	cat >expected <<-\EOF &&
+	warning: Not setting branch my13 as its own upstream.
+	EOF
+	test_expect_code 1 git config branch.my13.remote &&
+	test_expect_code 1 git config branch.my13.merge &&
+	test_i18ncmp expected actual
+'
+
 # Keep this test last, as it changes the current branch
 cat >expect <<EOF
 $_z40 $HEAD $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1117150200 +0000	branch: Created from master
-- 
1.9.0-192-g8dd89d4
