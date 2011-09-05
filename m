From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] push: old receive-pack does not understand --quiet
Date: Mon, 05 Sep 2011 01:35:07 -0700
Message-ID: <7v62l7crpg.fsf@alter.siamese.dyndns.org>
References: <20110903105723.GA16304@tin.tmux.org>
 <1315067656-2846-1-git-send-email-drizzd@aon.at>
 <1315067656-2846-4-git-send-email-drizzd@aon.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, tobiasu@tmux.org,
	Michael J Gruber <git@drmicha.warpmail.net>
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Mon Sep 05 10:35:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R0UeC-0004s8-Rq
	for gcvg-git-2@lo.gmane.org; Mon, 05 Sep 2011 10:35:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751574Ab1IEIfM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Sep 2011 04:35:12 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37686 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751457Ab1IEIfK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Sep 2011 04:35:10 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9E9D517DF;
	Mon,  5 Sep 2011 04:35:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=F6G77ZY4YkK+zOzfe9QQkC5FSwM=; b=DH6kcO
	ORfS5sJ/IZKIMS9d7p0Dft+K+4Vi1NLJ/eQr/tafA6P5q0j9DhohxMGGlzNjG4ly
	Tp0wvWd+Gf/Cgdzo//l/RWq83WNU27xuQ2wvuAbvd0YY6jOgdCcALUsZAR0edmr7
	aw0AGbX6NMljHZX3R+S8MZAKa3oUFvjG2ydWo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=vCna8lEXoeW9jhb1Vn9j9ghJdWKkHB4v
	AsMraqYNXl8DIymSo2ExKiGmONDygC2r1QOKO1cah6O3ybnkPuzUGZZ9rsd0IfWR
	Boj5C093Fmp+tMdFaffZeZQdZOOQIiWy2TzyhB1bPUPQDxl7roWZLepq2OJxDP1W
	87efbUCyNmI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9619B17DE;
	Mon,  5 Sep 2011 04:35:09 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1EAE717DD; Mon,  5 Sep 2011
 04:35:09 -0400 (EDT)
In-Reply-To: <1315067656-2846-4-git-send-email-drizzd@aon.at> (Clemens
 Buchacher's message of "Sat, 3 Sep 2011 18:34:16 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F6C7C5F0-D799-11E0-88A0-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180731>

Hmm, with this whole series merged to 'pu', I somehow am getting this
error:

$ make -j8 \
    DEFAULT_TEST_TARGET=prove \
    GIT_PROVE_OPTS=-j8 \
    T=t5541-http-push.sh test
*** prove ***
t5541-http-push.sh .. All 1 subtests passed 

Test Summary Report
-------------------
t5541-http-push.sh (Wstat: 0 Tests: 1 Failed: 0)
  Parse errors: No plan found in TAP output
Files=1, Tests=1,  0 wallclock secs ( 0.02 usr  0.00 sys +  0.06 cusr  0.01 csys =  0.09 CPU)
Result: FAIL
make[1]: *** [prove] Error 1
make[1]: Leaving directory `/srv/project/git/git.git/t'
make: *** [test] Error 2

Without prove (drop "DEFAULT_TEST_TARGET=prove" from the command line),
I do not see the breakage.

*** t5541-http-push.sh ***
ok 1 - set up terminal for tests
# passed all 1 test(s)
1..1 # SKIP Network testing disabled (define GIT_TEST_HTTPD to enable)
make aggregate-results
make[3]: Entering directory `/srv/project/git/git.git/t'
for f in test-results/t*-*.counts; do \
                echo "$f"; \
        done | '/bin/sh' ./aggregate-results.sh
fixed   0
success 1
failed  0
broken  0
total   1
