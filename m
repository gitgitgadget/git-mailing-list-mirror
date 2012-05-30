From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv4 1/3] wt-status.*: better advices for git status added
Date: Wed, 30 May 2012 12:06:16 -0700
Message-ID: <7vehq1zdxz.fsf@alter.siamese.dyndns.org>
References: <1338226598-16056-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
 <1338384216-18782-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
 <7vmx4pzfse.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Matthieu.Moy@grenoble-inp.fr,
	Duperray Valentin <Valentin.Duperray@ensimag.imag.fr>,
	Jonas Franck <Franck.Jonas@ensimag.imag.fr>,
	Nguy Thomas <Thomas.Nguy@ensimag.imag.fr>,
	Nguyen Huynh Khoi Nguyen Lucien 
	<Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>
To: Kong Lucien <Lucien.Kong@ensimag.imag.fr>
X-From: git-owner@vger.kernel.org Wed May 30 21:06:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SZoDw-0005hG-N0
	for gcvg-git-2@plane.gmane.org; Wed, 30 May 2012 21:06:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751490Ab2E3TGU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 May 2012 15:06:20 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46455 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750903Ab2E3TGT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 May 2012 15:06:19 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 76F5088D9;
	Wed, 30 May 2012 15:06:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=odQs4Sm8msaeRt7HVO5vcsQHbnk=; b=fR2Diz
	Hq/eY1e4TzcLZzxo+3VPEti0PQ/TDDGgN01uyFDNEMlZX2z/eyThOkpXfhxMDiJA
	U/7QmAe/VEqXc8knNhDZpXz2BvIkLN7mq2XkVwrZSGEN7pByQG/x5o9ArcqzzdCy
	u1xouuIyEzvFoOj5f5BqvMN05hH6TgcgAfqbQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=npSg/9DeIq247fhl3vaYvuMiKf40sI4K
	2FlSUlmUImS6IWbzRMyn3b22NOz5rTWuZUGRv0u9N0AvPIZo2kQ9LP8LRI30F4st
	JZ+AgDB78EnoRK1CBLEQEUAuLAef21n71EDcmwEmEEIE0yM/z7jL1/a2jEJjqj0c
	C7DouF5wV2M=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6CF2588D8;
	Wed, 30 May 2012 15:06:18 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id F2A8688D6; Wed, 30 May 2012
 15:06:17 -0400 (EDT)
In-Reply-To: <7vmx4pzfse.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Wed, 30 May 2012 11:26:25 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8917AF38-AA8A-11E1-8097-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198831>

Junio C Hamano <gitster@pobox.com> writes:

> And instead, hide the above new lines behind advice.statusHints,
> without introducing advice.statusHelp.  As to the global code
> structure, it probably would make more sense to:
>
>   - rename wt_status_evaluate_state() to wt_status_print_state();
>
>   - rename the various "print help information for this state" functions
>     that are called in the above if/else/... cascade to merge_in_progress_show()
>     etc.
>
>   - move the above if/else/... cascade to the end of
>     wt_status_print_state(), which would make the above part more
>     like:
>
> 	 wt_status_print()
>          {
> 		if (s->branch) {
>                 	...
> 		}
> 	+	wt_status_print_state(s);
> 		if (s->is_initial) {
> 			...
>
>   - at the beginning of wt_status_print_state(), check advice.statusHints
>     and return without doing anything if the user does not want hints.
>
> Otherwise, overall the patch is getting better looking.
>
> Thanks for a pleasant read.

After reading the current code, I changed my mind slightly.

The way the new code tries to separate the state information
(i.e. statement of the fact it found) and the advice messages
(i.e. what could be done next) is indeed in line with what the
advice.statusHints configuration is used in the existing code.  We
unconditionally show what we find to the user, and we give help by
default but let the user decline.

So an updated suggestion would be to still move the whole thing to
wt_status_print_state(), but not check advice.statusHints at the
beginning of the function (as we will show what we find even when
the user declines help text) and do the discovery, and hide the help
messages (i.e. "do this to proceed") behind advice.statusHints,
without introducing advice.statusHelp.

As I pointed out in my review, there were some places in the patch
that gave help text unconditionally, which needs to be corrected.
