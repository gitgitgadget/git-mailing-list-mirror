From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC 1/4] contrib: add git-contacts helper
Date: Mon, 01 Jul 2013 12:17:23 -0700
Message-ID: <7vy59qf5to.fsf@alter.siamese.dyndns.org>
References: <1372590512-21341-1-git-send-email-sunshine@sunshineco.com>
	<1372590512-21341-2-git-send-email-sunshine@sunshineco.com>
	<7vbo6mgm5e.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Mon Jul 01 21:17:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UtjbP-0005C6-BY
	for gcvg-git-2@plane.gmane.org; Mon, 01 Jul 2013 21:17:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754615Ab3GATR1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Jul 2013 15:17:27 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53110 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752681Ab3GATR0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Jul 2013 15:17:26 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 044C32C789;
	Mon,  1 Jul 2013 19:17:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=qr6QUT86ZsXDeV7lM02Kt/5xQgc=; b=qCwps6
	9yLZ1JvGIW+/Jh7EytQIpnZwka51aK1Z3u5NOuHcMw0v2pG6UUMYZycd7rwS4dd3
	XvlLTyCjaNoqwGth6zkgqPhIdBUZE9Us/KLngKjUzWZPtz+2i/l0KQyb9nIHRR5A
	Zb2h16woSoxQm9YJniop+NfAPK0VyvArDdTUw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=tT7TnUK1tv5XKjt+DjWYHGVioWCmXxWM
	ijeMCbrc10lJoTTXg5L47hgaEt8A1ZDd2tDAbMdizXIbEbW1LOfWdgLfuI4VbtIN
	8XLJGagc49iV+ybISIpE/pTaV8GMWikdKNfH1kX2AayaTs8Zc1HYNKigJqPsHEk/
	CJ8ungX3+Ew=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id ED7322C788;
	Mon,  1 Jul 2013 19:17:25 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6C3192C786;
	Mon,  1 Jul 2013 19:17:25 +0000 (UTC)
In-Reply-To: <7vbo6mgm5e.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Mon, 01 Jul 2013 11:39:25 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: DCEAB08E-E282-11E2-B3A1-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229323>

Junio C Hamano <gitster@pobox.com> writes:

>  - If the patch were prepared with a non-standard src/dst-prefix,
>    unconditional substr($1, 2) would call blame on a wrong (and
>    likely to be nonexistent) path without a useful diagnosis (the
>    invocation of "git blame" will likely die with "no such path
>    'tailofpathname' in $id").
>
>    One way to make it more robust may be to do something like this:
>
> 	if (/^--- /) {
> 		if (m{^--- (?:a/(.*)|/dev/null)$}) {
> 			$source = ($1 eq '/dev/null') ? undef : $1;

Typo/thinko.  I did that (?:(foo)|bar) thing so that I do not have
to do the conditional.  The above can just be

 		if (m{^--- (?:a/(.*)|/dev/null)$}) {
 			$source = $1;
