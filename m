From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] CodingGuidelines: Fix a typo
Date: Sat, 09 Oct 2010 10:51:32 -0700
Message-ID: <7v39sfuue3.fsf@alter.siamese.dyndns.org>
References: <1286623119-13766-1-git-send-email-stepnem@gmail.com>
 <20101009152758.GA17799@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: stepnem@gmail.com, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Oct 09 19:51:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P4daN-00081A-U9
	for gcvg-git-2@lo.gmane.org; Sat, 09 Oct 2010 19:51:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756263Ab0JIRvo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Oct 2010 13:51:44 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:61272 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756094Ab0JIRvn (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Oct 2010 13:51:43 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id ED255DB848;
	Sat,  9 Oct 2010 13:51:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=JFOsExovDtX6M2PKNhAcFRYIUbQ=; b=weXVBc
	6jqJsRMWGH2Knpj6HTm50LZsLKWQlX9faPs7NVbhs+DVNfVGLZOwujVu3s+ViZAu
	xOEKmUdvPjLprNJAB5moGJWcTrfUHVUXYiYFRFMtpzKTzcvwUDdEoxTDG1S7FX/0
	Q3CvQyft75bKr41wb79pAXdgtR1bSrZUVN+n0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=iub3ixpcBkpzncvdNHOtRMkR3S9E8Uls
	SfTLMkc3i1okNHKxM+Kl3ovusMD5umUWbAg+RFcwVWCFOGOdiXnhFqqtk4hPiVO6
	Zd0exXtwNGhffk90iV1uJY0IwuICOpRPwQan7urKOXZoI77vfmYZAqnNn8OeJJNy
	3eGile1bqp4=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id BC09FDB847;
	Sat,  9 Oct 2010 13:51:38 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C90F4DB846; Sat,  9 Oct
 2010 13:51:34 -0400 (EDT)
In-Reply-To: <20101009152758.GA17799@burratino> (Jonathan Nieder's message of
 "Sat\, 9 Oct 2010 10\:27\:58 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: DDCDF14E-D3CD-11DF-A010-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158595>

Jonathan Nieder <jrnieder@gmail.com> writes:

> stepnem@gmail.com wrote:
>
>> `${parameter/pattern/string}' shell expansion uses glob patterns, so
>> talking about `regexp' is confusing.
>
> Okay.
>
>> - - No regexp ${parameter/pattern/string}.
>> + - No substitution ${parameter/pattern/string}.
>
> A bit confusing, since ${parameter%word} and $parameter are
> substitutions, too.

I had the same reaction.  Perhaps moving other parameter substitions
closer to these two would help?

	Side note: this is totally unrelated, but the below is --patience;
	our output without --patience is almost unreadable in this case.

 Documentation/CodingGuidelines |   27 +++++++++++++++------------
 1 files changed, 15 insertions(+), 12 deletions(-)

diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
index 8346c19..09ffc46 100644
--- a/Documentation/CodingGuidelines
+++ b/Documentation/CodingGuidelines
@@ -35,11 +35,22 @@ For shell scripts specifically (not exhaustive):
    properly nests.  It should have been the way Bourne spelled
    it from day one, but unfortunately isn't.
 
- - We use ${parameter-word} and its [-=?+] siblings, and their
-   colon'ed "unset or null" form.
+ - We use POSIX compliant parameter substitutions and avoid bashisms;
+   namely:
 
- - We use ${parameter#word} and its [#%] siblings, and their
-   doubled "longest matching" form.
+   - We use ${parameter-word} and its [-=?+] siblings, and their
+     colon'ed "unset or null" form.
+
+   - We use ${parameter#word} and its [#%] siblings, and their
+     doubled "longest matching" form.
+
+   - No "Substring Expansion" ${parameter:offset:length}.
+
+   - No shell arrays.
+
+   - No strlen ${#parameter}.
+
+   - No pattern replacement ${parameter/pattern/string}.
 
  - We use Arithmetic Expansion $(( ... )).
 
@@ -47,14 +58,6 @@ For shell scripts specifically (not exhaustive):
    of them, as some shells do not grok $((x)) while accepting $(($x))
    just fine (e.g. dash older than 0.5.4).
 
- - No "Substring Expansion" ${parameter:offset:length}.
-
- - No shell arrays.
-
- - No strlen ${#parameter}.
-
- - No regexp ${parameter/pattern/string}.
-
  - We do not use Process Substitution <(list) or >(list).
 
  - We prefer "test" over "[ ... ]".
