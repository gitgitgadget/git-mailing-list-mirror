From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Test script style (Re: [PATCH 08/18] git notes merge: Initial
 implementation handling trivial merges only)
Date: Wed, 06 Oct 2010 21:57:25 -0700
Message-ID: <7vk4luy4zu.fsf@alter.siamese.dyndns.org>
References: <1285719811-10871-1-git-send-email-johan@herland.net>
 <1285719811-10871-9-git-send-email-johan@herland.net>
 <20101007043721.GD2285@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johan Herland <johan@herland.net>, git@vger.kernel.org,
	bebarino@gmail.com, avarab@gmail.com
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 07 07:02:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P3icY-0000kB-AR
	for gcvg-git-2@lo.gmane.org; Thu, 07 Oct 2010 07:02:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752267Ab0JGE5l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Oct 2010 00:57:41 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:46202 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752132Ab0JGE5k (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Oct 2010 00:57:40 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 336ABDCA73;
	Thu,  7 Oct 2010 00:57:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=TCEgUxkBbVU3d3PC/N70p4YBNj4=; b=ANXJQO
	YFSXFp+yPuqtCMOv2SZztg3Jq3fd0hWK9bmrAH6KHF8WpH18NQC3sFcKFnAM9GZk
	Lq+XHtf1apld4f5YflkbeAP/T52TrAmMX7xMQdJ6pDWM5C043c6vl7YQDveG6CDm
	KxvE6QUMRzUs3SlkaTSEQFJHqol6l8G9xHxcY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=bsnLoRrz0AP3fh7IEbxi7mC4oHa9PTrI
	Cv6GBPXtl2122T8hz9qxoEn6+14zff3nwpmGKrupLj7Curuq36q+s+YrLiG4qkDD
	NOTtewcgsyvubN0heLLCYSVhA94UOx8q09xoGwnXKGaWs+f2mD2vLGLXvmOphOPA
	lvCL1Syt45g=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id D0FC2DCA6F;
	Thu,  7 Oct 2010 00:57:33 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C4015DCA6C; Thu,  7 Oct
 2010 00:57:27 -0400 (EDT)
In-Reply-To: <20101007043721.GD2285@burratino> (Jonathan Nieder's message of
 "Wed\, 6 Oct 2010 23\:37\:21 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 65A6B98A-D1CF-11DF-A598-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158370>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Thoughts?  Would it make sense to eventually put something like this
> in t/CodingStyle or nearby?

> Tests:
> 	test_expect_success|failure '... some claim...' '
> 		Commands to test that claim.
> 		Could do all sorts of things, as long as they do not
> 		disturb the invariants established by the
> 		constant_data and setup sections.
> 	'

In practice, I am afraid it would take a lot more discipline than any of
the current test script does to actually preserve the invariants.  But if
we can arrange that, it would be ideal.  For one thing, it would finally
make the subtest skip feature of GIT_SKIP_TESTS usable.

An obvious way to do so would be

 Tests:
 	test_expect_success|failure '... some claim...' '
+ 		Commands to establish a known precondition without
+		depending on the state left by previous steps.
 		Commands to test that claim.
-		Could do all sorts of things, as long as they do not
-		disturb the invariants established by the
-		constant_data and setup sections.
 	'

but if done naively, the time it takes to re-establish a known
precondition for each and every test would add up to substantial
overhead.
