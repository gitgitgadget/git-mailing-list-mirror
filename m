From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH v2 1/1] cygwin: Add fast_lstat() and fast_fstat() functions
Date: Mon, 15 Jul 2013 12:49:34 -0700
Message-ID: <7vppuja9ip.fsf@alter.siamese.dyndns.org>
References: <51DDC2AF.9010504@ramsay1.demon.co.uk>
	<51E2CE97.2040900@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramsay Jones <ramsay@ramsay1.demon.co.uk>, mhagger@alum.mit.edu,
	Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
	"Shawn O. Pearce" <spearce@spearce.org>, tboegi@web.de,
	dpotapov@gmail.com, GIT Mailing-list <git@vger.kernel.org>
To: Mark Levedahl <mlevedahl@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 15 21:49:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UyomF-0002re-50
	for gcvg-git-2@plane.gmane.org; Mon, 15 Jul 2013 21:49:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755422Ab3GOTti (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Jul 2013 15:49:38 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55803 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754740Ab3GOTth (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jul 2013 15:49:37 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0A2D93002B;
	Mon, 15 Jul 2013 19:49:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=z9wErBGj4k3h7MJykIseme4tWIA=; b=PHa8ds
	WNzk4DAFPkIw3HRGAvTnGOz5eu+dVKPukk+4xi0iinKzj6GcHK2wTHA1/3Nhsr1S
	MUQ+lAXdJZdqavfKgIe5CoRzxxEIy4/gbiGOFtXcf2U3L84vPC6VRc6yNF/yOuL7
	N0g6/d9QJZDJMbNtaZLc4JS6evbuZXzFNhn0o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DX13odyIzJn1Hb+rNkAulS6uycL7WBWH
	425EThEsntlHmxdHc1MgYld1ut6lK4j445JRts871ztOz0POc6qi3qT9EkmRsDpa
	ojf+rJBuD3bWahraLIyknC1UYSBJW+TsOB0Mnis1N2aBMDHr0M7o5pwYWR+VFuXi
	OAk0Un4tbCw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F1B6D3002A;
	Mon, 15 Jul 2013 19:49:36 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 44D2030028;
	Mon, 15 Jul 2013 19:49:36 +0000 (UTC)
In-Reply-To: <51E2CE97.2040900@gmail.com> (Mark Levedahl's message of "Sun, 14
	Jul 2013 12:15:19 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: AD9E14D2-ED87-11E2-BC95-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230519>

Mark Levedahl <mlevedahl@gmail.com> writes:

>> In order to limit the adverse effects caused by this implementation,
>> we provide a new "fast stat" interface, which allows us to use this
>> only for interactions with the index (i.e. the cached stat data).
>>
>> Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
>> ---
>
> I've tested this on Cygwin 1.7 on WIndows 7 , comparing to the results
> using your prior patch (removing the Cygwin specific lstat entirely)
> and get the same results with both, so this seems ok from me.
>
> My comparison point was created by reverting your current patch from
> pu, then reapplying your earlier patch on top, so the only difference
> was which approach was used to address the stat functions.
>
> Caveats:
> 1) I don't find any speed improvement of the current patch over the
> previous one (the tests actually ran faster with the earlier patch,
> though the difference was less than 1%).
> 2) I still question this whole approach, especially having this
> non-POSIX compliant mode be the default. Running in this mode breaks
> interoperability with Linux, but providing a Linux environment is the
> *primary* goal of Cygwin.

Sounds like we are better off without this patch, and instead remove
the "schizophrenic stat"?  I do not have a strong opinion either
way, except that I tend to agree with your point 2) above.
