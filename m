X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] reflog: ignore expire-unreachable for "HEAD" reflog
Date: Thu, 15 Apr 2010 09:57:23 -0700
Message-ID: <7vhbnck618.fsf@alter.siamese.dyndns.org>
References: <7vljcppycc.fsf@alter.siamese.dyndns.org>
 <7vfx2xpyam.fsf@alter.siamese.dyndns.org> <4BC6B5FF.6030406@viscovery.net>
 <7vochlkvtg.fsf@alter.siamese.dyndns.org> <4BC6D30F.5020004@viscovery.net>
 <7v4ojclwyu.fsf@alter.siamese.dyndns.org> <4BC70D75.70801@viscovery.net>
 <20100415163607.GA4279@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Thu, 15 Apr 2010 16:57:46 +0000 (UTC)
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=M4H0I4/EBJNCN7Vt5InGkfMMWy8=; b=Ur3FM9
	6iidoMdF/wfvUBANEOBa/WDYzjkdsdKAnDpY6npN4XCVfQYXYz/Bu4ptKzIU2iHv
	3VPXJ/2wgcmXp0afb7UdDkGYYKLJR9b6f7AIrj5PiSkfEYZWxZ/PKzXPZLIqVXxO
	wyEjl3TKpZjioo7qZDKEV3AmR6BLkr0TBEN1k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qtX8km9ts0v1sGbt2EvNKFOmOLG1kzM7
	w+vw99SejdVfLLZCu47F+LFRUGteKm2Mi9VJJEtweas9qdX/5GccJ+gyHVZh8i9u
	tWD2Mg7B6qI0m+3FPph4UbRD50mGPpak4MTrSPD5UWy/yIE8NUi4zdM6hIz8YpjG
	LPV6mirQzQw=
In-Reply-To: <20100415163607.GA4279@coredump.intra.peff.net> (Jeff King's
 message of "Thu\, 15 Apr 2010 12\:36\:07 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: F9A5DB4C-48AF-11DF-A685-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145000>
Received: from vger.kernel.org ([209.132.180.67]) by lo.gmane.org with esmtp
 (Exim 4.69) (envelope-from <git-owner@vger.kernel.org>) id 1O2SNm-00013I-Pz
 for gcvg-git-2@lo.gmane.org; Thu, 15 Apr 2010 18:57:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1754850Ab0DOQ5d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>); Thu, 15 Apr 2010
 12:57:33 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:38092 "EHLO
 sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1754776Ab0DOQ5c (ORCPT <rfc822;git@vger.kernel.org>); Thu, 15 Apr 2010
 12:57:32 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1]) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 2B92EAB786; Thu, 15 Apr
 2010 12:57:32 -0400 (EDT)
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1]) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id E9692AB781; Thu, 15 Apr
 2010 12:57:28 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4E0AFAB780; Thu, 15 Apr
 2010 12:57:25 -0400 (EDT)
Sender: git-owner@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I think another way of addressing the same problem would be to redefine
> "reachable" in this context as "reachable from any current ref".

I tend to agree, but I haven't thought through the case for entries that
point at commits on detached HEAD.  My gut feeling is that unless they are
connected to a real ref by now after all these expireunreachable days,
they are "failed experiments" and deserve to get pruned, so "from any ref"
