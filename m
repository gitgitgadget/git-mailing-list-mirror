From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] gitk: refresh the index before running diff-files
Date: Fri, 28 Sep 2012 16:02:32 -0700
Message-ID: <7vipaxkayf.fsf@alter.siamese.dyndns.org>
References: <CAEkqydxRy3ukSWyQ53Tiosq+DMWWLG=AVuZk+Jm79Y5SaRmeDw@mail.gmail.com>
 <20120928202330.GA5770@sigill.intra.peff.net>
 <20120928205054.GA5985@sigill.intra.peff.net> <m24nmh4x1t.fsf@igel.home>
 <20120928223152.GA7906@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andreas Schwab <schwab@linux-m68k.org>,
	Scott Batchelor <scott.batchelor@gmail.com>,
	Paul Mackerras <paulus@samba.org>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Sep 29 01:02:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1THja7-0006Iu-Qd
	for gcvg-git-2@plane.gmane.org; Sat, 29 Sep 2012 01:02:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932189Ab2I1XCg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Sep 2012 19:02:36 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:65008 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932133Ab2I1XCf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Sep 2012 19:02:35 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6ED6E92C5;
	Fri, 28 Sep 2012 19:02:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Hf+fVCkvNLF/ctZzEMUn2JZ+v0I=; b=nv2mhF
	YJHwuZSzITjujspxSVb+/NIKKYsoifH/JtdSdBCFpzl7Ny4x9+ziGp8fniobu3C1
	NWdPofkeIHg1Oe2q4i/q4KxifxKuTXaDl88q5c8idx/Rux6r4M4O7/28MTe0DTbU
	ZzG321CJTpiF1sJBbvP2P80p+UgSw46GZkkTM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=TY/2D8dhaLFMS8IOK+tEX795gZpaKBPB
	aBDgc7cdEcPkmB85B9YGK8dY86cSyinG+GH0ApHUFp3JqO713PMQ1bwzjRbLppF2
	GYm5XseX1xNZbt3H8NeqfdFnS8S+cOhoQQVZe4vIecnVs8c21E8pXt4uiiqSijrU
	+JRIm6SLn2A=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5BF6E92C4;
	Fri, 28 Sep 2012 19:02:34 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C53B992C3; Fri, 28 Sep 2012
 19:02:33 -0400 (EDT)
In-Reply-To: <20120928223152.GA7906@sigill.intra.peff.net> (Jeff King's
 message of "Fri, 28 Sep 2012 18:31:52 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 96845168-09C0-11E2-A86D-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206615>

Jeff King <peff@peff.net> writes:

> On Sat, Sep 29, 2012 at 12:11:58AM +0200, Andreas Schwab wrote:
>
>> Jeff King <peff@peff.net> writes:
>> 
>> > +proc refresh_index {} {
>> > +    global need_index_refresh
>> > +    if { $need_index_refresh } {
>> > +	exec sh -c "git update-index --refresh >/dev/null 2>&1 || true"
>> 
>> I think the usual idiom for ignoring errors is to use catch around exec,
>> avoiding the extra shell wrapper:
>> 
>>         catch { exec git update-index --refresh }
>
> Thanks. I don't speak tcl at all, but your version makes much more
> sense.

But isn't the redirection still needed?  Otherwise the "Needs
update" messages will go to the terminal, no?
