From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t0300-credentials: Word around a solaris /bin/sh bug
Date: Fri, 03 Feb 2012 14:45:25 -0800
Message-ID: <7vipjnmt8a.fsf@alter.siamese.dyndns.org>
References: <1328211135-25217-1-git-send-email-bwalton@artsci.utoronto.ca>
 <20120202200240.GC9246@sigill.intra.peff.net>
 <7vr4ycu3ty.fsf@alter.siamese.dyndns.org>
 <20120203120657.GB31441@sigill.intra.peff.net>
 <7v7h03odyo.fsf@alter.siamese.dyndns.org>
 <20120203212604.GA1890@sigill.intra.peff.net>
 <7vr4ybmvrq.fsf@alter.siamese.dyndns.org>
 <20120203215507.GB3472@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ben Walton <bwalton@artsci.utoronto.ca>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Feb 03 23:45:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RtRsw-0004el-F2
	for gcvg-git-2@plane.gmane.org; Fri, 03 Feb 2012 23:45:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752277Ab2BCWp3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Feb 2012 17:45:29 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33158 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751153Ab2BCWp2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Feb 2012 17:45:28 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5197A6817;
	Fri,  3 Feb 2012 17:45:27 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+P6ZwhHjy0QB2m/VrghQYV/8dTA=; b=Y7ypik
	3HGxUSSDqNWCr50GheANu2V8LwoHSyd0WRfyYv5JixI1ddy2gxBFgfGExhI6WB7A
	Ys8uxM6mgvyLME8KQUZ9LqOE13IdB+XVYoS3DhNB0HwblmwZcaYTeHqtUI+pKgKl
	ToUU6F7VsIbYgdieeJJxWM+/PJ86Ivy3Nz/WM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=OYFcMXr9p2TurTiOrerzv4nyNLnzrmmf
	ykCC82xJv4NOMwAS5Bjrnk5280AtFjQcaIVml6x7hzL3/Quz/EbPaKPctbGnZPBF
	162uYfz54S3hkqYf9RGWG2OWd1YvRsxhR/RD9lCVwDW+mB2R9oKIPovg4scLWAE1
	NqB96PjYIfc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 493EB6816;
	Fri,  3 Feb 2012 17:45:27 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C6CDA6814; Fri,  3 Feb 2012
 17:45:26 -0500 (EST)
In-Reply-To: <20120203215507.GB3472@sigill.intra.peff.net> (Jeff King's
 message of "Fri, 3 Feb 2012 16:55:07 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C41177BE-4EB8-11E1-BDEB-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189817>

Jeff King <peff@peff.net> writes:

>>                 2)	echo "#!$2" ;;
>> 		*)	BUG ;;
>>                 esac >"$1" &&
>>                 cat >>"$1" &&
>>                 chmod +x "$1"
>> 	}
>> 
>
> Nice. I was going to suggest a wrapper like "write_sh_script" so you
> didn't have to spell out $SHELL_PATH, but I think the auto-detection
> makes sense (and falling back to shell makes even more sense, as that
> covers 99% of the cases anyway).

Let's not over-engineer this and stick to the simple-stupid-sufficient.

Something like this?

 t/test-lib.sh |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index bdd9513..1b9c461 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -379,6 +379,15 @@ test_config () {
 	git config "$@"
 }
 
+# Prepare a script to be used in the test
+write_script () {
+	{
+		echo "#!${2-"$SHELL_PATH"}"
+		cat
+	} >"$1" &&
+	chmod +x "$1"
+}
+
 # Use test_set_prereq to tell that a particular prerequisite is available.
 # The prerequisite can later be checked for in two ways:
 #
