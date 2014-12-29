From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-log: added --invert-grep option
Date: Mon, 29 Dec 2014 09:56:07 -0800
Message-ID: <xmqqy4pqz6fc.fsf@gitster.dls.corp.google.com>
References: <xmqqwq5o5e1j.fsf@gitster.dls.corp.google.com>
	<1419390196-17222-1-git-send-email-ottxor@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Christoph Junghans <ottxor@gentoo.org>
X-From: git-owner@vger.kernel.org Mon Dec 29 18:56:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y5eYB-0005KB-PU
	for gcvg-git-2@plane.gmane.org; Mon, 29 Dec 2014 18:56:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751560AbaL2R4L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Dec 2014 12:56:11 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:55608 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751315AbaL2R4K (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Dec 2014 12:56:10 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A6CFB286B1;
	Mon, 29 Dec 2014 12:56:09 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=6NwO9I2S2B7In/Zyl2a1grCeE+M=; b=PLdgUV
	HrI/GXSNcL5V0ibz7UiyEAPOhffoYB3TbzcJT/Sn60b8cUaM5rvMR1sg4btJP29m
	BXHm/QQXGRcRVGhwiMaTYNcI9lVN6seDGnExWRqjCNF2ijP+dU33D60L23TRM4gE
	k6zAyD2ONW5B0duQTDnUabf9nKN5fuCvN6Wvw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=FrCv9uBdutYvuVtVBwuupaOOX5i/nuqP
	sKWyvNegXtYDHMkJBX7m+gML2U8UOE1y0lDr2+QXTOEtE1DYCihw/sXM+uPkyz9I
	JXBr68VGRrw7YMxqq6rDrZ/yA0kPSKSAnLGnDKkJ7tNhDJP4dzHSpVXpPjtNOBDH
	144k5ETQApU=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 96B9A286AF;
	Mon, 29 Dec 2014 12:56:09 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0BA9F286AE;
	Mon, 29 Dec 2014 12:56:08 -0500 (EST)
In-Reply-To: <1419390196-17222-1-git-send-email-ottxor@gentoo.org> (Christoph
	Junghans's message of "Tue, 23 Dec 2014 20:03:15 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: F7E7383A-8F83-11E4-AD86-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261869>

Christoph Junghans <ottxor@gentoo.org> writes:

> Ok, I drafted a first version of the suggest --grep-begin ...
> --grep-end syntax.

I am somewhat surprised that it was doable that cleanly.

The syntax, as I already said, is a bit too ugly to live in that
form I suggested, though ;-).

> However, I could not find a good ways to invert the match on a commit
> basis instead of the normal line-wise version.

Good point.

The only interface to tweak the way the individual matches are
turned into file-level match (by default, we say "any one of the
clauses match, we find the file to be interesting") is "--all-match"
("all of the clauses have to trigger at least once for us to find
the file interesting"), which, compared to the richer set of boolean
operations at the line level, is a kludge.

Offhand, short of overhauling that kludge to allow us to express
"The file has to have either 'atomic' or 'all-or-none' appear
somewhere, and also cannot have 'wip' anywhere", I do not think of a
good way, other than adding yet another kludge on top of the
"--all-match" that says "none of the clauses must trigger" to
express what you want to see happen in "git log" to exclude ones
that are marked with "wip", perhaps naming it "--none-match" or
something.

Thanks.
