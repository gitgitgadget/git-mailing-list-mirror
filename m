From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 04/12] refs: implement simple transactions for the packed-refs file
Date: Thu, 20 Jun 2013 10:11:02 -0700
Message-ID: <7vd2rgwvvd.fsf@alter.siamese.dyndns.org>
References: <1371628293-28824-1-git-send-email-mhagger@alum.mit.edu>
	<1371628293-28824-5-git-send-email-mhagger@alum.mit.edu>
	<7vfvwdzz6k.fsf@alter.siamese.dyndns.org>
	<51C2B41F.2050708@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Johan Herland <johan@herland.net>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Thu Jun 20 19:11:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UpiOC-0003LS-Fq
	for gcvg-git-2@plane.gmane.org; Thu, 20 Jun 2013 19:11:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161242Ab3FTRLM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Jun 2013 13:11:12 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36463 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161212Ab3FTRLL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Jun 2013 13:11:11 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4B6FE296E7;
	Thu, 20 Jun 2013 17:11:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Dmoo1/e1htNAYXSJePlI/pD4/PE=; b=ZCZLhj
	x4ySDGJEGXNhMipy7I3uau7FXDt5uZ33eaTcYO1aSsveNcjVt694nrwISFcFtU2J
	9/m1hbeBjW4yybgxxaSAIx4goYX1l3oLCIJB8ob9feZFVXmfEUfr+qIDz+wTEnXy
	6CNMaCdGFx0U79xCF1fPdkNjeALXQ6GK+h/Cs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=S7hKYVVZs85EQJPzxxiNeQSLk/Guq6VR
	xSBhW/JemPOAULMxIXJiPn9qr/t9X5xZ66HBo++xryy2t3GMb/SESG++yNTKTNSg
	W32xn96uUU1htMEDXNoRJcOnFIatxkaU24x6e8/A/DYjtRe8U9dqIETHK3b0X/Lc
	VHxMZCNs0Ug=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3F995296E5;
	Thu, 20 Jun 2013 17:11:10 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A8919296E0;
	Thu, 20 Jun 2013 17:11:09 +0000 (UTC)
In-Reply-To: <51C2B41F.2050708@alum.mit.edu> (Michael Haggerty's message of
	"Thu, 20 Jun 2013 09:49:51 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 66DF5A48-D9CC-11E2-A36C-80EC6777888E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228513>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> But currently only the main packed ref cache can be locked, so it would
> be possible for lock_packed_refs() to use the static packlock instance
> for locking.

Perhaps I am missing something from the previous discussions, but I
am having trouble understanding the "main packed ref cache" part of
the above.  "main" as opposed to...?  Is it envisioned that later
somebody can lock one subpart while another can lock a different and
non-overlapping subpart, to make changes independently, and somehow
their non-overlapping changes will be consolidated into a single
consistent result?
