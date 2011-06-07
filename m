From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] verify_path: consider dos drive prefix
Date: Tue, 07 Jun 2011 12:22:37 -0700
Message-ID: <7vhb815tvm.fsf@alter.siamese.dyndns.org>
References: <1306512040-1468-1-git-send-email-kusmabite@gmail.com>
 <1306512040-1468-4-git-send-email-kusmabite@gmail.com>
 <4DDFF473.7030104@kdbg.org>
 <BANLkTikdeq7cuhi0uo7Q6wqDJK3nxjmP-g@mail.gmail.com>
 <C8718F35FD1A4C3C84A4D353D27621E0@martinic.local>
 <BANLkTi=o6p=E4bM+CG77yKrFFvQ8sBS07g@mail.gmail.com>
 <7v39jm8fs0.fsf@alter.siamese.dyndns.org>
 <BANLkTi=eC37opWnN4nmC5AP66M+m5nZ86Q@mail.gmail.com>
 <BANLkTik3ywV91UtLSR_Dydjqg=pva+b0qg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Theo Niessink <theo@taletn.com>, Johannes Sixt <j6t@kdbg.org>,
	git@vger.kernel.org, johannes.schindelin@gmx.de
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Tue Jun 07 21:23:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QU1rd-0006Dj-UA
	for gcvg-git-2@lo.gmane.org; Tue, 07 Jun 2011 21:22:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756495Ab1FGTWx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jun 2011 15:22:53 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:63794 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754212Ab1FGTWw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jun 2011 15:22:52 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 665E3573F;
	Tue,  7 Jun 2011 15:25:01 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=gYIUPvca02lmhndXhOwZ6l2Rf74=; b=K2LDVd
	BuG0FJzk4F/q3kjItzZbS9LprtnTlx8r4i7p1N7DQejDGN7XKOvxHv266UAIiBXb
	tyEu4gmfttXw/lDh+pd3UZKar4vEuuYGrTU0Ek6Mp8NHccwyAjjakL1ij5TKq92Y
	9PoPIpM5XMMPhDFYVjtrTicBRYFPvUk7NyRWQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CyJoZLwzj2J8RPzNmqo9cKwYDYGUg0Rw
	l6nl7KtfMd6wJGtKf/JbLufpAmHMI4rapUmCqgv0RtBNF4TNorWXI5d5RAlWqZ06
	fiy7n1VAHS+X166jdchBLktQMXV9aSkE3hSmxAzrabA3YRg70A/hz8qSt1SXXBV6
	Z5SEP0+idmA=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 78E7B573C;
	Tue,  7 Jun 2011 15:24:55 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id CE8EF5737; Tue,  7 Jun 2011
 15:24:48 -0400 (EDT)
In-Reply-To: <BANLkTik3ywV91UtLSR_Dydjqg=pva+b0qg@mail.gmail.com> (Erik
 Faye-Lund's message of "Tue, 7 Jun 2011 21:09:38 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D33BDA30-913B-11E0-BABB-EA23C7C1A288-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175255>

Erik Faye-Lund <kusmabite@gmail.com> writes:

> I forgot to ask; do you want me to resend? I would imagine the commit
> message should be updated to reflect this change as well...

Here is what I queued last night. If it looks Ok then I'll merge it down
to 'next'.

-- >8 --
Subject: [PATCH] verify_path(): simplify check at the directory boundary

We simply want to say "At a directory boundary, be careful with a name
that begins with a dot, forbid a name that ends with the boundary
character or has duplicated bounadry characters".

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 read-cache.c |   13 +++----------
 1 files changed, 3 insertions(+), 10 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index 31cf0b5..3593291 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -784,16 +784,9 @@ int verify_path(const char *path)
 		if (is_dir_sep(c)) {
 inside:
 			c = *path++;
-			switch (c) {
-			default:
-				continue;
-			case '/': case '\0':
-				break;
-			case '.':
-				if (verify_dotfile(path))
-					continue;
-			}
-			return 0;
+			if ((c == '.' && !verify_dotfile(path)) ||
+			    is_dir_sep(c) || c == '\0')
+				return 0;
 		}
 		c = *path++;
 	}
-- 
1.7.6.rc0.129.gbe6ef
