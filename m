From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv4 3/4] Support ref namespaces for remote repositories via
 upload-pack and receive-pack
Date: Fri, 03 Jun 2011 09:33:28 -0700
Message-ID: <7vy61ian8n.fsf@alter.siamese.dyndns.org>
References: <1306887870-3875-1-git-send-email-jamey@minilop.net>
 <1306887870-3875-3-git-send-email-jamey@minilop.net>
 <7v8vtjdebw.fsf@alter.siamese.dyndns.org> <20110603000612.GB30975@cloud>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jamey Sharp <jamey@minilop.net>, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <johannes.sixt@telecom.at>,
	Jeff King <peff@peff.net>
To: josh@joshtriplett.org
X-From: git-owner@vger.kernel.org Fri Jun 03 18:33:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QSXJo-0006Xh-64
	for gcvg-git-2@lo.gmane.org; Fri, 03 Jun 2011 18:33:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752097Ab1FCQds (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jun 2011 12:33:48 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:55783 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751951Ab1FCQdr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Jun 2011 12:33:47 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id E06A458EE;
	Fri,  3 Jun 2011 12:35:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=wG+hQXfQ3yDfQLfncolqc9fIlAc=; b=qn/AeK
	wPqq+efd7HH2VP8ENo0s1V//jfLGhZQlElJl4arsHL07BhVKS4u7/jGeIbiHXtZE
	RP6+drZWZYD/B58hZmnOphphWG8LYwn6a9nNRK2R/38H9J81IzjAfaulTbI8dP8b
	1lTY02/gG5ircycoqQzTMksX8efgaNyP6Y+P8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BKXjy1LKT3sFMAFKJbRJ57cOMceiGfrV
	bdRH+ANM1Zoj2vFSvTMKm80Xu0Z/k5/QI6NFTuQLM9WyY5dw7gn0xP07kwYnaBm4
	Q1uD1mWHdCe8vFoMXJKlQAWYuTyH7UTL/GawVzHCvhSXAlPFuFwj+Gs6BvPIfn2Z
	nQsNLrTTcoQ=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 6C71958ED;
	Fri,  3 Jun 2011 12:35:47 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 7E03458EC; Fri,  3 Jun 2011
 12:35:38 -0400 (EDT)
In-Reply-To: <20110603000612.GB30975@cloud> (josh@joshtriplett.org's message
 of "Thu, 2 Jun 2011 17:06:12 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 88DF6F40-8DFF-11E0-8849-EA23C7C1A288-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175017>

josh@joshtriplett.org writes:

> Fair enough.  We'd thought of NULL as a fairly logical representation
> for a null ref sent as a dummy ref just to send capabilities,...

I am not objecting to that part. NULL may be a logical thing to throw at
when the interface is to take only strings that begin with refs/... and
you have to occasionally send something different.

But that is a line of thought that is only valid while there is only one
"something different" (i.e. "capabilities^{}") and the current code
happens to have only one such different thing to send, but the approach
closes the door to allow us sending things other than that single
exception in the future without redoing your patch. That was what I found
objectionable.
