From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 01/19] check_bindir: convert test -a/-o to && and ||
Date: Tue, 20 May 2014 11:54:30 -0700
Message-ID: <xmqq38g4z3fd.fsf@gitster.dls.corp.google.com>
References: <1400593832-6510-1-git-send-email-gitter.spiros@gmail.com>
	<1400593832-6510-2-git-send-email-gitter.spiros@gmail.com>
	<xmqqsio4z5e5.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, jrnieder@gmail.com
To: Elia Pinto <gitter.spiros@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 20 20:54:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WmpBP-0002XA-PQ
	for gcvg-git-2@plane.gmane.org; Tue, 20 May 2014 20:54:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751018AbaETSyg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 May 2014 14:54:36 -0400
Received: from smtp.pobox.com ([208.72.237.35]:59886 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750758AbaETSyf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 May 2014 14:54:35 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 1E30718557;
	Tue, 20 May 2014 14:54:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=NkQhoNbRm+6GBlvjgMTCJMlgpzQ=; b=IyZ+u/
	lATgPX4KKmOk9Ji9rCr2ua1rgBZS7YPEu/Ch3jD3myplHsdaxKU9bUs9z7SonyZh
	AAMigicr4Hy/jLDiYsx3Ci4AT3SNM8G2TOfGEASlps3iIn9F0opwD3wzH/6TcNbI
	zG4KrBIZed7vCE5d8ozZPwrO8m1612dZeKm5Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qJKGNblUVlKKf6xdrHRRUEaSLqUCsE/A
	HFQvNsX4osSlhx30czSBgkhd311RhSbNo8LcLP8Na8VeUFqi/3ByxwaKmLANKD8r
	CSyb6reMhtBaxWt9EIoK+Spk+SnEm/vmoG1k01d59HoB6lbCVD6gclgz4DfG5NGD
	UqPs4ZE8Jzk=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 1517618555;
	Tue, 20 May 2014 14:54:35 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id CB8A41854C;
	Tue, 20 May 2014 14:54:31 -0400 (EDT)
In-Reply-To: <xmqqsio4z5e5.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Tue, 20 May 2014 11:12:02 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 2D9BB6F6-E050-11E3-8524-B784E8FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249727>

Junio C Hamano <gitster@pobox.com> writes:

> As I already said, I think "better known" is much less of an issue
> than that "-a/-o" is "more error prone", and that is the reason why
> we may want to do this rewrite.
>
> I do not know offhand how busy the tree would be when we can apply
> these patches post-release without them getting rebased, but the
> zero-th step before this series may want to be a patch like this.

... and this time with a proposed log message.

-- >8 --
Subject: [PATCH] CodingGuidelines: avoid "test <cond> -a/-o <cond>"

The construct is error-prone; "test" being built-in in most modern
shells, the reason to avoid "test <cond> && test <cond>" spawning
one extra process by using a single "test <cond> -a <cond>" no
longer exists.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/CodingGuidelines | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
index 3d08671..4d90c77 100644
--- a/Documentation/CodingGuidelines
+++ b/Documentation/CodingGuidelines
@@ -151,6 +151,19 @@ For shell scripts specifically (not exhaustive):
    interface translatable. See "Marking strings for translation" in
    po/README.
 
+ - We do not write our "test" command with "-a" and "-o" and use "&&"
+   or "||" to concatenate multiple "test" commands instead, because
+   the use of "-a/-o" is often error-prone.  E.g.
+
+     test -n "$x" -a "$a" = "$b"
+
+   is buggy and breaks when $x is "=", but
+
+     test -n "$x" && test "$a" = "$b"
+
+   does not have such a problem.
+
+
 For C programs:
 
  - We use tabs to indent, and interpret tabs as taking up to
-- 
2.0.0-rc3-438-g36dae77
