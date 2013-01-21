From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] Update :/abc ambiguity check
Date: Mon, 21 Jan 2013 11:27:45 -0800
Message-ID: <7vsj5ufia6.fsf@alter.siamese.dyndns.org>
References: <1358773249-24384-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 21 20:28:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TxN2U-0000ui-3Y
	for gcvg-git-2@plane.gmane.org; Mon, 21 Jan 2013 20:28:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756257Ab3AUT1w convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 21 Jan 2013 14:27:52 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33301 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756113Ab3AUT1v convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 21 Jan 2013 14:27:51 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 47B09BA06;
	Mon, 21 Jan 2013 14:27:51 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=73G0rNauNE4p
	dpjH5I6NBjbTGy4=; b=L4fqTOE7EjeVLGp78Ul7aBkHEIAZ/UkqnYYh9zzR6hUz
	WrtmjBuB1e/nFfJWXHm5kWiOHl90FpxQKtxRL0F8jGwqBoHrty75ASIazV2ysk+F
	oLpEKOs5PULrs9fe/CiWak3sk8BczGXgG8BGaAuuw7xnlk3gdpJdiRr8PDz5RGs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=imjMUL
	jyQG7wK+l4ZZq++oat8/k6YWFt2UmRo0DZLQeR1WUAAAcLYnoD3wfTyLRaKjH5Gx
	oKY6+iOBn6mPs1sDkyXNindC+1tdj7s9ex2cw9vgmbRmeL4cHY0yKLJnzkQwbRrp
	AJOAQj+N5wDPeKyphBGXnUXdD/2XwIBOCRzaA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3AFB6BA05;
	Mon, 21 Jan 2013 14:27:51 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 06FFFB9FF; Mon, 21 Jan 2013
 14:27:46 -0500 (EST)
In-Reply-To: <1358773249-24384-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Mon, 21 Jan
 2013 20:00:48 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A2E7008C-6400-11E2-A019-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214153>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> :/abc may mean two things:
>
> - as a revision, it means the revision that has "abc" in commit
>   message.
>
> - as a pathpec, it means "abc" from root.
>
> Currently we see ":/abc" as a rev (most of the time), but never see i=
t
> as a pathspec even if "abc" exists and "git log :/abc" will gladly
> take ":/abc" as rev even it's ambiguous. This patch makes it:
>
> - ambiguous when "abc" exists on worktree
> - a rev if abc does not exist on worktree
> - a path if abc is not found in any commits (although better use

The "any commits" above sounds very scary. Are you really going to
check against all the commits?

>   "--" to avoid ambiguation because searching through commit DAG is
>   expensive)
>
> A plus from this patch is, because ":/" never matches anything as a
> rev, it is never considered a valid rev and because root directory
> always exists, ":/" is always unambiguously seen as a pathspec.

That is the primary plus in practice, I think, and it is a big one.

When naming a directory that belongs to a different subdirectory
hierarchy, typing ":/that/directory/name" is not any easier than
having your shell help you complete "../../that/directory/name"; I
suspect nobody uses the relative-to-root notation to name anything
but the root in real life.
