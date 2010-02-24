From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Feb 2010, #06; Tue, 23)
Date: Wed, 24 Feb 2010 15:42:28 -0800
Message-ID: <7v635m6w0r.fsf@alter.siamese.dyndns.org>
References: <7v635nsa37.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.00.1002241004010.1946@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nelson Elhage <nelhage@MIT.EDU>, git@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Thu Feb 25 00:42:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NkQsO-0006h1-97
	for gcvg-git-2@lo.gmane.org; Thu, 25 Feb 2010 00:42:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758598Ab0BXXmj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Feb 2010 18:42:39 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:58709 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758546Ab0BXXmi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Feb 2010 18:42:38 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 24D9D9C38D;
	Wed, 24 Feb 2010 18:42:37 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Nf7JhYqjqdqZq14FFcLwCoic+wg=; b=F9dGvu
	Eg9XpkBextQofHwJibWKap/2p8Iig7m0pbqB7aLaVjER/BJQOnHHMBxLfyu7ykUA
	1Rtu+IqrmE+A7IzxGTltR93xVPTl26U356PlxV7hlsPQKegDLeKgPQOxxkqS6yex
	lbFy9H0GO8pS3KUxoDPFSS4jPna1Pt4aFc7R8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rq+Coxi6k0p0t6dYT4sdzIQ0jBkz6ihU
	OrZCmQdQepvuBcOXUT3LdUc8c/g+egub3ADlRLZOjwUA503QjQfmygZY3eV3x+SU
	L2As1eZv6iAHjJUNLazHEPqn2GDg/W3IxohVzBY4xc2yElyfM8WRlkg7azsrzYMG
	9b7PvXxLgI8=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id DF4AC9C388;
	Wed, 24 Feb 2010 18:42:33 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 147729C385; Wed, 24 Feb
 2010 18:42:29 -0500 (EST)
In-Reply-To: <alpine.LFD.2.00.1002241004010.1946@xanadu.home> (Nicolas
 Pitre's message of "Wed\, 24 Feb 2010 10\:09\:53 -0500 \(EST\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 47E0A758-219E-11DF-89EF-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141009>

Nicolas Pitre <nico@fluxnic.net> writes:

> On Tue, 23 Feb 2010, Junio C Hamano wrote:
>
>> * ne/pack-local-doc (2010-02-18) 1 commit
>>  - Documentation: pack-objects: Clarify --local's semantics.
>> 
>> Comments from pack experts?
>
> The patch is fine in the sense that what it modifies was indeed wrong.
>
> However the "even if it appears in the standard input" formulation 
> should also be fixed as the object list may be specified with a rev spec 
> on the command line, and not necessarily only via standard input.

Ah, true.  Perhaps something like this.

-- >8 --
Subject: pack-objects documentation: reword "objects that appear in the standard input"

These were written back when we always read objects from the standard
input.  These days --revs and its friends can feed only the start and
end points and have the command internally enumerate the objects.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-pack-objects.txt |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-pack-objects.txt b/Documentation/git-pack-objects.txt
index 769f1de..1deaa65 100644
--- a/Documentation/git-pack-objects.txt
+++ b/Documentation/git-pack-objects.txt
@@ -120,12 +120,12 @@ base-name::
 
 --incremental::
 	This flag causes an object already in a pack to be ignored
-	even if it appears in the standard input.
+	even if it would have otherwise been packed.
 
 --local::
 	This flag causes an object that is borrowed from an alternate
-	object store to be ignored even if it appears in the standard
-	input.
+	object store to be ignored even if it would have otherwise been
+	packed.
 
 --non-empty::
         Only create a packed archive if it would contain at
