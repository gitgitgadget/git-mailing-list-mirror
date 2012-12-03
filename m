From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] status: respect advice.statusHints for ahead/behind
 advice
Date: Mon, 03 Dec 2012 09:11:32 -0800
Message-ID: <7vr4n7rrgb.fsf@alter.siamese.dyndns.org>
References: <20121203061656.GA20164@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Dec 03 18:11:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TfZYf-0007wB-AT
	for gcvg-git-2@plane.gmane.org; Mon, 03 Dec 2012 18:11:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755515Ab2LCRLh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Dec 2012 12:11:37 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62582 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754670Ab2LCRLf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Dec 2012 12:11:35 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 21403A731;
	Mon,  3 Dec 2012 12:11:35 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=QvBF866RFEV/tQhXX/gVuqy+KqA=; b=USYbm6
	UKcOYZ6jkqaPkvm59Nro8xStDAtkJxlRBzITX98EvO2MrNPI8Smj7rFMY0etw3fs
	1qV8vBT31mUt7JfAgW9vq7zgFT8urJLQjASLJLvudifCvgOdESd/gFJc7zY2jEM0
	TYHZXgFIaYMtxaXuBsJ15mLeAKIPlnfsJW3Gk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=d+qABpWfraqZCq53zlWOcg/37mZ+s1Eo
	fZez4G8o40scK/wxQAkuYj4ayYxOfoz+kAEzaykWO0G5gJXrC8q4wS8ib4rMdC9a
	z8xLBX/El3bND4kgE1aYTrnz9X+gt8sv1I97lWia4j1Sl8i7wZAaWi3QAShQUJRO
	sGiAUnlEfXU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0E98BA730;
	Mon,  3 Dec 2012 12:11:35 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 454F6A72E; Mon,  3 Dec 2012
 12:11:34 -0500 (EST)
In-Reply-To: <20121203061656.GA20164@sigill.intra.peff.net> (Jeff King's
 message of "Mon, 3 Dec 2012 01:16:57 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7D5380F8-3D6C-11E2-98A9-C2612E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211046>

Jeff King <peff@peff.net> writes:

> If the user has unset advice.statusHints, we already
> suppress the "use git reset to..." hints in each stanza. The
> new "use git push to publish..." hint is the same type of
> hint. Let's respect statusHints for it, rather than making
> the user set yet another advice flag.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> On top of mm/status-push-pull-advise.
>
> I left "git checkout" alone, though I'd also like to turn it off there,
> too. Should it get a separate advice option there? Should it simply
> respect statusHints (it seems odd because I know that "status" there
> means "git status", not "hints about the status of your repo")?

I agree that we should have a toggle to turn it off and I think it
is OK to reuse the same "hints about the status" option for this
purpose.  It is not like there is a released version that already
gives the advice (possibly with some other option to turn it off)
and you are changing the behaviour of "checkout" by suddenly making
it honor statusHints advice.

So let's do a lot simpler patch instead.

-- >8 --
From: Jeff King <peff@peff.net>
Date: Mon, 3 Dec 2012 01:16:57 -0500

If the user has unset advice.statusHints, we already
suppress the "use git reset to..." hints in each stanza. The
new "use git push to publish..." hint is the same type of
hint. Let's respect statusHints for it, rather than making
the user set yet another advice flag.

Signed-off-by: Jeff King <peff@peff.net>
Acked-by: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 remote.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/remote.c b/remote.c
index 9c19689..18dc8ec 100644
--- a/remote.c
+++ b/remote.c
@@ -1633,8 +1633,9 @@ int format_tracking_info(struct branch *branch, struct strbuf *sb)
 			   "Your branch is ahead of '%s' by %d commits.\n",
 			   num_ours),
 			base, num_ours);
-		strbuf_addf(sb,
-			_("  (use \"git push\" to publish your local commits)\n"));
+		if (advice_status_hints)
+			strbuf_addf(sb,
+				_("  (use \"git push\" to publish your local commits)\n"));
 	} else if (!num_ours) {
 		strbuf_addf(sb,
 			Q_("Your branch is behind '%s' by %d commit, "
@@ -1643,8 +1644,9 @@ int format_tracking_info(struct branch *branch, struct strbuf *sb)
 			       "and can be fast-forwarded.\n",
 			   num_theirs),
 			base, num_theirs);
-		strbuf_addf(sb,
-			_("  (use \"git pull\" to update your local branch)\n"));
+		if (advice_status_hints)
+			strbuf_addf(sb,
+				_("  (use \"git pull\" to update your local branch)\n"));
 	} else {
 		strbuf_addf(sb,
 			Q_("Your branch and '%s' have diverged,\n"
@@ -1655,8 +1657,9 @@ int format_tracking_info(struct branch *branch, struct strbuf *sb)
 			       "respectively.\n",
 			   num_theirs),
 			base, num_ours, num_theirs);
-		strbuf_addf(sb,
-			_("  (use \"git pull\" to merge the remote branch into yours)\n"));
+		if (advice_status_hints)
+			strbuf_addf(sb,
+				_("  (use \"git pull\" to merge the remote branch into yours)\n"));
 	}
 	return 1;
 }
-- 
1.8.0.1.420.g52a5207
