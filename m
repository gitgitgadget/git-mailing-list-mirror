From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH] diff: Fix rename pretty-print when suffix and prefix overlap
Date: Thu, 28 Feb 2013 23:14:47 +0100
Message-ID: <874ngw2ii0.fsf@pctrast.inf.ethz.ch>
References: <CALWbr2yviqF68zF7mBbhaXW7oFar0YRqROBWXwqjo7UNgZNVBQ@mail.gmail.com>
	<1362088540-14564-1-git-send-email-apelisse@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <git@vger.kernel.org>
To: Antoine Pelisse <apelisse@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 28 23:15:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UBBlA-0001RW-Q5
	for gcvg-git-2@plane.gmane.org; Thu, 28 Feb 2013 23:15:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760896Ab3B1WOy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Feb 2013 17:14:54 -0500
Received: from edge10.ethz.ch ([82.130.75.186]:33655 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760893Ab3B1WOw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Feb 2013 17:14:52 -0500
Received: from CAS11.d.ethz.ch (172.31.38.211) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.2.298.4; Thu, 28 Feb
 2013 23:14:45 +0100
Received: from pctrast.inf.ethz.ch.ethz.ch (129.132.208.97) by CAS11.d.ethz.ch
 (172.31.38.211) with Microsoft SMTP Server (TLS) id 14.2.298.4; Thu, 28 Feb
 2013 23:14:47 +0100
In-Reply-To: <1362088540-14564-1-git-send-email-apelisse@gmail.com> (Antoine
	Pelisse's message of "Thu, 28 Feb 2013 22:55:40 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
X-Originating-IP: [129.132.208.97]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217260>

Antoine Pelisse <apelisse@gmail.com> writes:

> diff --git a/diff.c b/diff.c
> index 9038f19..e1d82c9 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -1177,7 +1177,16 @@ static char *pprint_rename(const char *a, const char *b)
> -	while (a <= old && b <= new && *old == *new) {
> +	/*
> +	 * Note:
> +	 * if pfx_length is 0, old/new will never reach a - 1 because it
> +	 * would mean the whole string is common suffix. But then, the
> +	 * whole string would also be a common prefix, and we would not
> +	 * have pfx_length equals 0.
> +	 */
> +	while (a + pfx_length - 1 <= old &&
> +	       b + pfx_length - 1 <= new &&
> +	       *old == *new) {

Umm, you still have the broken version here, and the previous patch is
already in next.  I think you should decide for one thing ;-)

Either: consider this a reroll; Junio would have to revert the version
already in next (which isn't _so_ bad, because next will eventually be
rebuilt) and apply this new version.  But if you do that, you should
squash my change that deals with the underrun issue (I'd be fine with
that).

Or: consider it an incremental improvement on the series, in which case
you should send only the tests with a new commit message.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
