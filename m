From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 00/12] Pulling signed/annotated tags
Date: Mon, 07 Nov 2011 21:37:05 -0800
Message-ID: <7vobwnyy2m.fsf@alter.siamese.dyndns.org>
References: <1320472900-6601-1-git-send-email-gitster@pobox.com>
 <1320721245-13223-1-git-send-email-gitster@pobox.com>
 <CA+55aFxVsgNjGv2zAGR1VK34uG59+euJec_3i9JNyQ0VUdjyeA@mail.gmail.com>
 <7vsjlzyza7.fsf@alter.siamese.dyndns.org>
 <CA+55aFyEuuT25m00uakL66YKSpT-zjoiBreymFSbuHmtARq6yw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Nov 08 06:37:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RNeN0-0000FZ-GS
	for gcvg-git-2@lo.gmane.org; Tue, 08 Nov 2011 06:37:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751478Ab1KHFhJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Nov 2011 00:37:09 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38599 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750957Ab1KHFhI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Nov 2011 00:37:08 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D41BA6B08;
	Tue,  8 Nov 2011 00:37:07 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=NayUm2KzCGqY33ewOGVmi/UdNgU=; b=U644aU
	y94ut9pCZfjF0BhZPXdMTKBEMddjQQLnnj94VGE0b8p7gwzx8b1ZTM5/goaADqH5
	/b5FPh1lERAIsX7yw4z8J+WFrnV/VDmuV/oZTyWcLZmAqkXzuKmERqTyRO4yVMUX
	sHB7OIF4RbUuGVwgpM8hnKm/tzExKDVmWdbLY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=b7JbE1wR0UzUoLBxaE3+ThlUMzDdKZjz
	VXPeSXJcwG0OyxvPMKkRmWkyJZmdb/SaDuM1Pw/xokdwfYzqdwTeyhdsUYsoW2b1
	/Q3IR/siO0aDDmuHbAaIBBZcqgjvXulwJBfhqGDUa5hFOV1YFOqZXklQ2cgEEdIE
	WTTSGB895AA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CC1076B07;
	Tue,  8 Nov 2011 00:37:07 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D7B126B04; Tue,  8 Nov 2011
 00:37:06 -0500 (EST)
In-Reply-To: <CA+55aFyEuuT25m00uakL66YKSpT-zjoiBreymFSbuHmtARq6yw@mail.gmail.com> (Linus
 Torvalds's message of "Mon, 7 Nov 2011 21:31:05 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B21AC452-09CB-11E1-8788-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185070>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> But I don't have any really strong opinions on it. I just think it's a
> good idea to make it easy to parse both mechanically and
> human-visually, and "number of lines" doesn't strike me as being very
> human-friendly.

Here is what I had in mind. An empty line in the tag payload would become
"mergetag \n" and a separate would become "mergetag\n". The consumer of
"cat-file commit" would be able to tell between the two anyway and if a
human _really_ cares, s/he can pipe it to "cat -e" or something.

Honestly, I do not care too much about human readability of "mergetag"
header. We could even store zlib-deflate-and-then-base85 the payload,
which _might_ be a better solution. For one thing, it would protect us
from potential NUL in the tag payload ;-).


 commit.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/commit.c b/commit.c
index 7d471a3..6a5d40e 100644
--- a/commit.c
+++ b/commit.c
@@ -868,6 +868,8 @@ static void handle_signed_tag(struct strbuf *signed_tags, struct commit *parent)
 	 * if (verify_signed_buffer(buf, len, buf + len, size - len, &sig))
 	 *	warn("warning: signed tag unverified.");
 	 */
+	if (signed_tags->len)
+		strbuf_addstr(signed_tags, "mergetag\n");
 	strbuf_add_lines(signed_tags, "mergetag ", buf, size);
 
 free_return:
