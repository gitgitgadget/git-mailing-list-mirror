From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] Add revision range support on "-" and "@{-1}"
Date: Wed, 25 Mar 2015 15:24:26 -0700
Message-ID: <xmqqa8z01zs5.fsf@gitster.dls.corp.google.com>
References: <1426518703-15785-1-git-send-email-kenny.lee28@gmail.com>
	<1426518703-15785-3-git-send-email-kenny.lee28@gmail.com>
	<xmqqlhiwredj.fsf@gitster.dls.corp.google.com>
	<xmqq8uewp183.fsf@gitster.dls.corp.google.com>
	<87egons4du.fsf@gmail.com>
	<xmqqpp87mfqx.fsf@gitster.dls.corp.google.com>
	<87r3sfz25t.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Kenny Lee Sin Cheong <kenny.lee28@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 25 23:24:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yatj1-0007xz-93
	for gcvg-git-2@plane.gmane.org; Wed, 25 Mar 2015 23:24:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751916AbbCYWYb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Mar 2015 18:24:31 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:57093 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751633AbbCYWY3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Mar 2015 18:24:29 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 242C544B20;
	Wed, 25 Mar 2015 18:24:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=qAZ6pBf/1YICkIq3QddwuqqbEX0=; b=AQ96mN
	VOoyE2rgTu5vLfkrvjcO8qO4fduzKEGYrLC0/xrOMtxCJjMa7XLSydnQ5J6b/8Ej
	VaJsqSijPXw61OxGTDuwbNs6i1QG1vMisKf3YK98FN+xTkZfQDN4jF0wjvUuoszB
	IEbfZXRIxcCJQoAmiPgpZ3uSHcXqxIho4seeo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=QqYiipi6wyqv4gUCA0pUQupG8L+gGFGb
	YZeaFHtOkiUEc+qVm3ZInSBfrwuN3UIfsrah0IdB4FqPJkUpzxETHKsWy1ryOqMa
	JIca5dqz2qTMVa/4DmVDBln5dNt3uxdcfpB2onynSTh7Dm57u8LHIEEDoKbdTPt5
	O/axFgf0Tps=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 1D78244B1F;
	Wed, 25 Mar 2015 18:24:28 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 928A544B1E;
	Wed, 25 Mar 2015 18:24:27 -0400 (EDT)
In-Reply-To: <87r3sfz25t.fsf@gmail.com> (Kenny Lee Sin Cheong's message of
	"Mon, 23 Mar 2015 20:09:50 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: B2EA6D6C-D33D-11E4-BD48-11859F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266307>

Kenny Lee Sin Cheong <kenny.lee28@gmail.com> writes:

> If I'm understanding correctly, the problem of checking revisions before
> arg is that an option fed to handle_revision_arg() might die() before getting
> checked as an option in cases where a file with the same name exists?
>
> But doesn't verify_non_filename() already return silently if arg begins
> with "-"? It die() only after making that check.
>
> If an option with ".." in it such as -$opt..ion is really given to
> handle_revision_arg() then verify_non_filename should not be a problem.

Yes, but should we be relying on that behaviour?  The special casing
to assume that no sane person would name a file starting with a dash
is what I find somewhat disturbing.
