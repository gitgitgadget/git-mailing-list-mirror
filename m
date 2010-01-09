From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] ls-files: fix overeager pathspec optimization
Date: Sat, 09 Jan 2010 00:07:48 -0800
Message-ID: <7vfx6f3dm3.fsf@alter.siamese.dyndns.org>
References: <4B474C73.8080100@mtu.net>
 <4B4751EA.8060707@drmicha.warpmail.net>
 <20100108162404.GA5799@coredump.intra.peff.net>
 <7vr5q05z74.fsf@alter.siamese.dyndns.org>
 <20100108164132.GA6171@coredump.intra.peff.net>
 <7vskag1r5o.fsf@alter.siamese.dyndns.org>
 <7v8wc8jw3k.fsf@alter.siamese.dyndns.org>
 <7vvdfcfjxo.fsf@alter.siamese.dyndns.org>
 <7veim0w68q.fsf_-_@alter.siamese.dyndns.org>
 <alpine.LFD.2.00.1001081520240.7821@localhost.localdomain>
 <7v3a2gnnv2.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.00.1001081619570.7821@localhost.localdomain>
 <7v8wc8kshh.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.00.1001081701570.7821@localhost.localdomain>
 <7veilzaguf.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Jon Schewe <jpschewe@mtu.net>, spearce@spearce.org,
	git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>,
	Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Jan 09 09:09:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NTWNr-0005Cm-DD
	for gcvg-git-2@lo.gmane.org; Sat, 09 Jan 2010 09:09:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751619Ab0AIIJO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Jan 2010 03:09:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751580Ab0AIIIH
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Jan 2010 03:08:07 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:54938 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751484Ab0AIIIG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Jan 2010 03:08:06 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 77D978FD0E;
	Sat,  9 Jan 2010 03:08:03 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=GWtQ2ps3OkGSWwQZdTCEOifCrHc=; b=V+7Ujl
	r4xUWIZhl1hD0903NpUlVu0HTM5lP2T0PyqBFFWZSlVDKTKHj/YXieRhM2y550ka
	319DkEFsMr0ZLhOflLtTyPQTc807NmZjms/KLXBIEW5sNNJpd3piOdD7XgcN29q/
	cW3A2OLKOJ1Fj5b4LJ9M3DzTmoRgkPhEv2bpg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=fEqk9i9uGMxa4FJOdFbt4fZ3ZJd2wAlX
	SqDq5FbSOhsqFIZRkw3m/X4wLgg+dQjUtcUGGy0Cqbnm/euvrwjd1g/lateiOTlR
	iCrm/1DP8F8rdWqcQFzhV6SiIDbBP9ro2diogv6jqUNFznrWgW9ZtzW908SOl3xU
	syNMS67p95w=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 03D428FD0D;
	Sat,  9 Jan 2010 03:07:56 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C1B548FD0C; Sat,  9 Jan
 2010 03:07:49 -0500 (EST)
In-Reply-To: <7veilzaguf.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Fri\, 08 Jan 2010 23\:16\:08 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 186F8F92-FCF6-11DE-B07B-9D59EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136526>

Junio C Hamano <gitster@pobox.com> writes:

> Linus Torvalds <torvalds@linux-foundation.org> writes:
>
>> I'd have to see both patches to be able to tell. I do admit that while I
>> acked your patch, it sure ain't _pretty_ to do that special odd
>> "has_leading_ignored_dir()" thing.
>
> Revised patch (v4) series is coming shortly.

Having sent these patches, I am wondering if the simplest fix might be this
one-liner.

diff --git a/dir.c b/dir.c
index d0999ba..7fba335 100644
--- a/dir.c
+++ b/dir.c
@@ -788,3 +788,3 @@ int read_directory(struct dir_struct *dir, const char *path, int len, const char
 	simplify = create_simplify(pathspec);
-	read_directory_recursive(dir, path, len, 0, simplify);
+	read_directory_recursive(dir, "", 0, 0, simplify);
 	free_simplify(simplify);

What my series does is to keep all the "depending on dir->flags and what
excluded() says for path, decide to recurse, add it to dir->ignored[],
etc." logic and optimize only the readdir() loop, pretending as if it
returned only the entry on the "common prefix" path and nothing else, as
we know all other paths will be skipped by either simplified away or
filtered by in_pathspec() check.

If the directories we are reading are not humongous, maybe using this much
simpler patch might be preferrable (although it is completely untested).
