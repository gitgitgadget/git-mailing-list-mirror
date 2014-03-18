From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] test-lib.sh: do not "echo" externally supplied strings
Date: Tue, 18 Mar 2014 11:47:48 -0700
Message-ID: <xmqqvbvb8ht7.fsf@gitster.dls.corp.google.com>
References: <20140314235735.GA6959@ibr.ch> <20140318001410.GA4813@ibr.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Uwe Storbeck <uwe@ibr.ch>
X-From: git-owner@vger.kernel.org Tue Mar 18 19:47:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WPz3N-0006A5-0r
	for gcvg-git-2@plane.gmane.org; Tue, 18 Mar 2014 19:47:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757758AbaCRSrw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Mar 2014 14:47:52 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:65467 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757755AbaCRSru (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Mar 2014 14:47:50 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 63F0B72DAC;
	Tue, 18 Mar 2014 14:47:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Irs4R6ahVgkZhCopGAFfWU1jgZ4=; b=sBriMs
	TaOSHmRswyyOzGPkd4K4romkCbuwM3QaMK/Sp5i+0m2H1NXWEnGKLJ8cKsBh2TDt
	9uoCqNa3HyyYRM7rwAWfMgcqRMQyRsKz0B3z/f/u8fdvzDu//S/cRYnQFYJcV1GY
	rhdiLTlStjWG6G+F1/YzOxDrpZ1V43wjyGxmo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=T1fBHjfQsGYVPnpG6Nq0C76G+m3XIpPv
	sZZ1HdUbmu9G0GSHgrju10prwKDrxGQMn+jKZPmQ7G/flIA75OgqaaKcEGIdbP/9
	I+IilQ2Ij8LtBp+nJKLql6dUlYC7ARmXB1VWnlj/RUJ1MdQpm4U9rsOye6b7maxN
	sdibKEPj730=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 53FCE72DAB;
	Tue, 18 Mar 2014 14:47:50 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AB55072DA8;
	Tue, 18 Mar 2014 14:47:49 -0400 (EDT)
In-Reply-To: <20140318001410.GA4813@ibr.ch> (Uwe Storbeck's message of "Tue,
	18 Mar 2014 01:14:11 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: CDE5181E-AECD-11E3-AB48-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244367>

Uwe Storbeck <uwe@ibr.ch> writes:

> In some places we "echo" a string that is supplied by the calling
> test script and may contain backslash sequences. The echo command
> of some shells, most notably "dash", interprets these backslash
> sequences (POSIX.1 allows this) which may scramble the test
> output.
>
> Signed-off-by: Uwe Storbeck <uwe@ibr.ch>
> ---
>
> Commit message rewritten to avoid title continuation in the body.
> Thanks Junio C Hamano for the hint.

Here is what I queued yesterday.  I was wrong to say "control
characters"; a backslash sequence is not necessarily a control
character (e.g. \c at the end that suppresses the final LF), so I'll
replace it with your version.

The test titles are not externally supplied but under our control,
so it is less problematic than the "rebase -i" case where we do get
bitten by user supplied commit title string.  Still it is a good
idea to apply this change to protect ourselves.

Thanks.  

commit 215cd588caebe86fe77115bdda97930b4659aecd
Author: Uwe Storbeck <uwe@ibr.ch>
Date:   Sat Mar 15 00:57:36 2014 +0100

    test-lib.sh: do not "echo" test titles
    
    The test title could be a string with backslash in it, and can be
    interpreted as control characters by the echo command of some shells
    (e.g. dash).
    
    Signed-off-by: Uwe Storbeck <uwe@ibr.ch>
    Signed-off-by: Junio C Hamano <gitster@pobox.com>

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 1531c24..3c7cb1d 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -277,7 +277,7 @@ error "Test script did not set test_description."
 
 if test "$help" = "t"
 then
-	echo "$test_description"
+	printf '%s\n' "$test_description"
 	exit 0
 fi
 
@@ -328,7 +328,7 @@ test_failure_ () {
 	test_failure=$(($test_failure + 1))
 	say_color error "not ok $test_count - $1"
 	shift
-	echo "$@" | sed -e 's/^/#	/'
+	printf '%s\n' "$*" | sed -e 's/^/#	/'
 	test "$immediate" = "" || { GIT_EXIT_OK=t; exit 1; }
 }
