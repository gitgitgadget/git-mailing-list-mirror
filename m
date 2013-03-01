From: Junio C Hamano <gitster@pobox.com>
Subject: Re: two-way merge corner case bug
Date: Fri, 01 Mar 2013 15:06:57 -0800
Message-ID: <7vppzien3i.fsf@alter.siamese.dyndns.org>
References: <7v7glun8kt.fsf@alter.siamese.dyndns.org>
 <20130226201820.GD13830@sigill.intra.peff.net>
 <7vwqtulplp.fsf@alter.siamese.dyndns.org>
 <20130301092201.GA17254@sigill.intra.peff.net>
 <7va9qngisg.fsf@alter.siamese.dyndns.org>
 <20130301223612.GA862@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Mar 02 00:07:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UBZ35-0003ax-Fm
	for gcvg-git-2@plane.gmane.org; Sat, 02 Mar 2013 00:07:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751962Ab3CAXHD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Mar 2013 18:07:03 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56879 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751436Ab3CAXHC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Mar 2013 18:07:02 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 46D55BA06;
	Fri,  1 Mar 2013 18:07:01 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Q5++Igj3N+MTj49/6ApOi9jjZhc=; b=AUPKia
	P3skTuC8aLJNJ2tp9gO5B7g9OOPDKofE8SPDg7LUri/0GzwRUIQoMTKRvqJt885/
	s9DUz7D6jQOt6UqrhYduuiW2rNpXpsSbz8roSf1UD2DpBJHyP0Alf1rvh7SYltqy
	mr8PAY3uiU0kgsjQJnhM4e/G+EYEMxmHtkWnY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=nMbI+3hzkQ4hQVcnLrmxvVCXWoutePOG
	/r54JtCCSyxLszfx2uzYeqdaitBfgePmBIw+EFFGNvVeQaAND9uhAhlE4diyVlye
	JJxWQHYWdwXnO5zIOXBKG4PnGVuCwSO4YxdarVv9gmGrLWe2dW5BM2he/V7Rv0J0
	Lnw8lNpKK2k=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3ABD7BA02;
	Fri,  1 Mar 2013 18:07:01 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AD60ABA00; Fri,  1 Mar 2013
 18:07:00 -0500 (EST)
In-Reply-To: <20130301223612.GA862@sigill.intra.peff.net> (Jeff King's
 message of "Fri, 1 Mar 2013 17:36:12 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B937D374-82C4-11E2-97E4-7FA22E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217303>

Jeff King <peff@peff.net> writes:

> On Fri, Mar 01, 2013 at 08:57:03AM -0800, Junio C Hamano wrote:
>> 
>> Nobody seems to use that combination, either from scripts or from C
>> (i.e. when opts.update==1 and opts.merge==1, opts.reset is not set)
>> with a twoway merge, other than "git am --abort/--skip".
>
> I can believe it. So do we want to do that fix, then? Did you want to
> roll up the two halves of it with a test and write a commit message? I
> feel like you could write a much more coherent one than I could on this
> subject.

I actually was wondering if we can remove that sole uses of two-way
merge with --reset -u from "git am" and replace them with something
else.  But we do want to keep local change that existed before "am"
started, so we cannot avoid use of two-way merge, I guess...
