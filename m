From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv6 16/16] Introduce portable_unset and use it to ensure
 proper && chaining
Date: Mon, 04 Oct 2010 00:52:57 -0700
Message-ID: <7vy6ae8kdi.fsf@alter.siamese.dyndns.org>
References: <1286136014-7728-1-git-send-email-newren@gmail.com>
 <1286136014-7728-17-git-send-email-newren@gmail.com>
 <AANLkTinU_fv7pJqw_ghM4RoF6dsiV8PFM3GgCqD-hh7L@mail.gmail.com>
 <20101004044402.GF24884@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Elijah Newren <newren@gmail.com>, git@vger.kernel.org,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 04 09:53:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2frK-0001TY-V0
	for gcvg-git-2@lo.gmane.org; Mon, 04 Oct 2010 09:53:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752803Ab0JDHxM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 4 Oct 2010 03:53:12 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:64053 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752185Ab0JDHxM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 4 Oct 2010 03:53:12 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 91032DBDFB;
	Mon,  4 Oct 2010 03:53:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=kz+L/kR1YNKP
	/R1ON1h45U6ivog=; b=pqALl/Y1B/ZLbQMftgV17rnOHLm8lmzuW3r6Vwz3ZPwf
	sXAAm30cgbtuiPLhIDna1RtrI65mOCZVo6RDMl/2NbT4itxkPaSqLBTGRc0xUGyS
	4qHVDgDb5vnWPUhYvdYvC8NmwVhlDLKQ+rfzHSnoIsMpJBPDZMvJnyZoDVRlkCQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=PQnRcq
	V0mM9ithkkzaL3XqBzMMCrx9kdgpJ2QE8sDUBn+yCbyoNuBtRdNuCvF0jQ4t+En5
	vfDbQI0yZv2eKwpApp2jQr5iO3KGa0/H1YNJXnyZnlHEx/+YeMh72pIzlBNMm5q2
	tKONcWY5jAFs1+p1B7UKJkPucliB5aqkiF/vw=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 3C09ADBDF9;
	Mon,  4 Oct 2010 03:53:05 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DC840DBDF7; Mon,  4 Oct
 2010 03:52:58 -0400 (EDT)
In-Reply-To: <20101004044402.GF24884@burratino> (Jonathan Nieder's message of
 "Sun\, 3 Oct 2010 23\:44\:02 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 6B9C68E8-CF8C-11DF-8AD6-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158004>

Jonathan Nieder <jrnieder@gmail.com> writes:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>
>>                         I don't know if we came to an agreement on
>> using test_might_fail for non-builtins
>
> Non-builtins: okay.
> Non-git commands: no.
>
> That's just my take, though; if the project consensus is different,
> who am I to resist it?

Hmm, the pros and cons between allowing test_might_fail on normal comma=
nds
vs introducing cmd_might_fail are questionable, though.  I cannot think=
 of
a case where we would want to tolerate death by signal or segv on non g=
it
commands by using cmd_might_fail.  At least I do not think that is a
common thing we would want to ignore, and in a rare case, it probably i=
s a
good idea to say that explicitly with something like...

	{
        	frotz
                : the above might randomly segfault but we do not care
	}
