From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2 04/10] pkt-line: change error message for oversized
 packet
Date: Mon, 18 Feb 2013 01:40:17 -0800
Message-ID: <7vd2vyarjy.fsf@alter.siamese.dyndns.org>
References: <20130218091203.GB17003@sigill.intra.peff.net>
 <20130218092221.GD5096@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Feb 18 10:40:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U7NDI-0000Sx-7v
	for gcvg-git-2@plane.gmane.org; Mon, 18 Feb 2013 10:40:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757230Ab3BRJkU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Feb 2013 04:40:20 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54484 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752505Ab3BRJkT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Feb 2013 04:40:19 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3E7B39D7D;
	Mon, 18 Feb 2013 04:40:19 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=gHpgz0Y8xu6HpBhpqJkXIDdwyvE=; b=iIENw2
	TE5pP8pchmYlZo504tSXv5aNmSVwPJh7/Ig/tOy19t0iEp+ckQywXCFA0WkifcSv
	9o2Zdv+N1bOs4NWzLkc4OhgmBeEykGaYuJ8JxbEsvyHBcIQYnbvyT5WsIOS4RU4S
	qde5Uef6tQdvIoyVAUZndj5Mpa7vRBNpO+Ozc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=wOu16z85x6WGBugNjlrShkKDXX5oNhKG
	vUc96BA0NTRa30yON/CemgRLjpToKFSXNNJ4q71kzoV7v3QUhWFk078G2/T8moni
	pOsnrfri2hliz3RNsjIHbyMTH50wxVN5BukpoKFUKR08Rw64IWF+ZBR2hd5OckLN
	B3KR6hUku7g=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 340019D74;
	Mon, 18 Feb 2013 04:40:19 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id ADA6A9D73; Mon, 18 Feb 2013
 04:40:18 -0500 (EST)
In-Reply-To: <20130218092221.GD5096@sigill.intra.peff.net> (Jeff King's
 message of "Mon, 18 Feb 2013 04:22:21 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 34D5B592-79AF-11E2-B11C-ACA62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216459>

Jeff King <peff@peff.net> writes:

> I'm really tempted to bump all of our 1000-byte buffers to just use
> LARGE_PACKET_MAX. If we provided a packet_read variant that used a
> static buffer (which is fine for all but one or two callers), then it
> would not take much memory...

I thought that 1000-byte limit was kept when we introduced the 64k
interface to interoperate with other side that does not yet support
the 64k interface. Is your justification that such an old version of
Git no longer matters in the real world (which is true, I think), or
we use 1000-byte limit in some codepaths even when we know that we
are talking with a 64k-capable version of Git on the other side?
