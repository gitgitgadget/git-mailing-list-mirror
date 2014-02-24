From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 0/3] Easier access to index-v4
Date: Mon, 24 Feb 2014 11:35:33 -0800
Message-ID: <xmqqwqgk8fsq.fsf@gitster.dls.corp.google.com>
References: <1393188599-5391-1-git-send-email-t.gummerer@gmail.com>
	<xmqqios49yyq.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, pclouds@gmail.com, sunshine@sunshineco.com
To: Thomas Gummerer <t.gummerer@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 24 20:35:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WI1JV-0002Al-In
	for gcvg-git-2@plane.gmane.org; Mon, 24 Feb 2014 20:35:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753149AbaBXTfh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Feb 2014 14:35:37 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46669 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753053AbaBXTfg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Feb 2014 14:35:36 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DD7D36EA24;
	Mon, 24 Feb 2014 14:35:35 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=xGTMHjGRb9LVxmAfkTO1vSmW2/w=; b=Co0qf3
	q/fTCMHAnOwlFg5s6kgKNM1lZfDEZX8tO3jw/BrevD7MS9G8vvSxgrAO6avheErm
	f0FrWAYLv15ZTs5tW77uBA+rat1KPHOZUqidyIK23uGgs0ivKE95S9PEzt8vM70H
	8g16muq/zwZGokkahs3/qci8HzO1qyJdkkrpk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Z61sIpCOegqks51JM9MgUjZfinzClr+W
	ekW1dgEp5J2SQnXJKbSkLyRBHhaZFmbKVzl9JNWlDyzQO8mTf8TZ/SymTvn8kzzF
	hU2yf3kwPDaJKRMpUgwlH4Yywg4MhxUfchc60GQIM0dGen7rxq9QwzxXY5ekdoq4
	UIPNTGacqRg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B66B16EA23;
	Mon, 24 Feb 2014 14:35:35 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E16EF6EA20;
	Mon, 24 Feb 2014 14:35:34 -0500 (EST)
In-Reply-To: <xmqqios49yyq.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Mon, 24 Feb 2014 09:56:13 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: D4A76A8E-9D8A-11E3-9822-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242632>

Junio C Hamano <gitster@pobox.com> writes:

> Thomas Gummerer <t.gummerer@gmail.com> writes:
>
>> previous round was at $gmane/242198.
>>
>> Since then I've squashed the fixes suggested by Junio, added a test
>> showing what should happen if an index file is present and
>> GIT_INDEX_VERSION is set and fixed the typo found by Eric.
>
> Looks good; thanks.

Tests, seem to leak these unnecessary diag (not limited to t0010).

    sh t0010-racy-git.sh 
    warning: GIT_INDEX_VERSION set, but the value is invalid.
    Using version 3
    ok 1 - Racy GIT trial #0 part A
    ok 2 - Racy GIT trial #0 part B
    warning: GIT_INDEX_VERSION set, but the value is invalid.
    Using version 3
    ...
    # passed all 10 test(s)
    1..10


The same thing under prove.

    *** prove ***
    t0010-racy-git.sh .. warning: GIT_INDEX_VERSION set, but the value is invalid.
    Using version 3
    t0010-racy-git.sh .. 2/? warning: GIT_INDEX_VERSION set, but the value is invalid.
    Using version 3
    t0010-racy-git.sh .. 4/? warning: GIT_INDEX_VERSION set, but the value is invalid.
    Using version 3
    t0010-racy-git.sh .. 6/? warning: GIT_INDEX_VERSION set, but the value is invalid.
    Using version 3
    t0010-racy-git.sh .. 8/? warning: GIT_INDEX_VERSION set, but the value is invalid.
    Using version 3
    t0010-racy-git.sh .. ok    
    All tests successful.


I suspect the real culprit is the early part in test-lib.sh that
sets GIT_INDEX_VERSION explicitly from TEST_GIT_INDEX_VERSION when
the latter is not even specified.

Something along this line, perhaps?

 t/test-lib.sh | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 492f81f..01a98cb 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -108,8 +108,11 @@ export GIT_AUTHOR_EMAIL GIT_AUTHOR_NAME
 export GIT_COMMITTER_EMAIL GIT_COMMITTER_NAME
 export EDITOR
 
-GIT_INDEX_VERSION="$TEST_GIT_INDEX_VERSION"
-export GIT_INDEX_VERSION
+if test -n "${TEST_GIT_INDEX_VERSION+isset}"
+then
+	GIT_INDEX_VERSION="$TEST_GIT_INDEX_VERSION"
+	export GIT_INDEX_VERSION
+fi
 
 # Add libc MALLOC and MALLOC_PERTURB test
 # only if we are not executing the test with valgrind
