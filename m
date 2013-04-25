From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t5801: properly test the test shell
Date: Thu, 25 Apr 2013 10:12:23 -0700
Message-ID: <7vfvye4jrc.fsf@alter.siamese.dyndns.org>
References: <ff7ccf22012f069ceca054d90aa0f72666cc11c2.1366884583.git.git@drmicha.warpmail.net>
	<7vppxi60pj.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Felipe Contreras <felipe.contreras@gmail.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu Apr 25 19:12:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UVPio-0001FI-3i
	for gcvg-git-2@plane.gmane.org; Thu, 25 Apr 2013 19:12:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758200Ab3DYRMe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Apr 2013 13:12:34 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35203 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757789Ab3DYRMd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Apr 2013 13:12:33 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 09B5917548;
	Thu, 25 Apr 2013 17:12:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=OCXYnu0RKJAjuD1sEX+zo6sYbV8=; b=Sf/xtR
	Ulx547SPk1+ldq1zYTVpFybIarUL+1D9aDR6f8xrJKyd4sWupwEgL7EEnwRtnW5n
	CScOpW7DVPXdxUejY2D1p2et4+CYLgVPxz84P7xxJeA4QM2BLGb5qRZDT6JRB1zC
	pDLSZA2+s0romm2vNOoCfLq0QZLx7h2ymDqv0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=VuGIMvPa6TjbZkLxhhim7efxonmWejQ0
	+xLk1aCWSP1f0wdx1pf5+F+OQiphlHWxL8H3icgns4TxjAbjgoaX9Axjm4a7EN40
	HlTFKyYzCEvXhzYY+ijKNx+v6TuVrebpf+dBF08En8g6ntawfjqQfVfreC7d2jTb
	rxXRyiKV7Wk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F3E3817546;
	Thu, 25 Apr 2013 17:12:32 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 499031753E;
	Thu, 25 Apr 2013 17:12:32 +0000 (UTC)
In-Reply-To: <7vppxi60pj.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Thu, 25 Apr 2013 09:20:56 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 50FA5804-ADCB-11E2-A1F6-BCFF4146488D-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222398>

Junio C Hamano <gitster@pobox.com> writes:

> Michael J Gruber <git@drmicha.warpmail.net> writes:
>
>> fc407f9 (Add new simplified git-remote-testgit, 2012-11-28) introduced a
>> test which was meant to skip the test unless the test shell is bash.
>> Unfortunately, it tests for the availability of bash only.
>
> True.
>
>> But users can
>> opt to use a different shell (using SHELL_PATH) for the tests even though
>> bash is available.
>>
>> At least for dash,
>> 21610d8 (transport-helper: clarify pushing without refspecs, 2013-04-17)
>> is the commit which actually introduces a test (pushing without refspec)
>> which fails to fail even though it is supposed to. It uses the
>> construct:
>>
>> VAR=value function arguments
>
> The right fix for that is to fix that line, so that the test itself
> can run under any sane POSIX shell, isn't it?  The test in turn may
> need to run git-remote-testgit, which, without J6t's updates, only
> is usable under bash, but to make sure the test will choke on
> absence of bash, the existing check should be sufficient, no?

Curiously enough, there were a few instances of the correct "set and
export environment explicitly during the life of subshell" construct
already in the script.  I found only this one as problematic.

Does it fix your issue without your change?

It is a separate issue to port git-remote-testgit to POSIX (J6t
already has a two part draft), move it to git-remote-testgit.sh, and
get its shebang line preprocessed like all other shell scripts.  I
think it is worth doing.

Takers?

 t/t5801-remote-helpers.sh | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/t/t5801-remote-helpers.sh b/t/t5801-remote-helpers.sh
index 4dcf744..c956abd 100755
--- a/t/t5801-remote-helpers.sh
+++ b/t/t5801-remote-helpers.sh
@@ -118,7 +118,9 @@ test_expect_success 'pushing without refspecs' '
 	(cd local2 &&
 	echo content >>file &&
 	git commit -a -m ten &&
-	GIT_REMOTE_TESTGIT_REFSPEC="" test_must_fail git push 2>../error) &&
+	GIT_REMOTE_TESTGIT_REFSPEC="" &&
+	export GIT_REMOTE_TESTGIT_REFSPEC &&
+	test_must_fail git push 2>../error) &&
 	grep "remote-helper doesn.t support push; refspec needed" error
 '
 
