From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] [RFC] Making use of bitmaps for thin objects
Date: Mon, 06 Jan 2014 08:37:49 -0800
Message-ID: <xmqq38l1kqw2.fsf@gitster.dls.corp.google.com>
References: <1387741654-14890-1-git-send-email-bmaurer@fb.com>
	<5CDDBDF2D36D9F43B9F5E99003F6A0D43B67C0DA@PRN-MBX02-1.TheFacebook.com>
	<20140106151052.GB15489@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ben Maurer <bmaurer@fb.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jan 06 17:38:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W0DBr-0004V8-2Y
	for gcvg-git-2@plane.gmane.org; Mon, 06 Jan 2014 17:38:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755777AbaAFQiD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jan 2014 11:38:03 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59224 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755771AbaAFQiA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jan 2014 11:38:00 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 81D535F9A6;
	Mon,  6 Jan 2014 11:37:59 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=3YuIdraW9ZHVsPciPzUkW3onaJ0=; b=Vt2sLK
	pPlR8u9gzgNjiQmE+J+XnOwYgdcuu4lI2OFF+S1tBWfXeZkaY7RIrsunLW20O2Uq
	gwT4G4waI5yFOOJPXDB32nZtTcqMJEZXds2yNaVFd1PCGSOmCkaFUqEQSQpAy1qK
	KZzDWushPwI+ureNXZ41rpd8FTd5kECg7yulE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=vp4p9IIvfAOMAq0UGNtNsUYNHU1BVviM
	U3wKaRXVhlihfSIhMu3BC4qrnx1BqyMftTac8+ZBmj1HP8i2LIoQiiYjPLWWf+Kc
	/5r1JQK38WA+Btji0EXGtmfrmtrXEbYYHyCBaH+9QvpDkp31R72O8tsnhzJzPKF2
	moVvM0ST16w=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A54685F999;
	Mon,  6 Jan 2014 11:37:53 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9C39D5F994;
	Mon,  6 Jan 2014 11:37:51 -0500 (EST)
In-Reply-To: <20140106151052.GB15489@sigill.intra.peff.net> (Jeff King's
	message of "Mon, 6 Jan 2014 10:10:52 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: E28EC00E-76F0-11E3-9A5E-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240025>

Jeff King <peff@peff.net> writes:

> We could probably teach index-pack an "--assume-refs-are-thin"
> option to optimize for this case, and have fetch-pack/receive-pack pass
> it whenever they know that delta-base-offset was negotiated.

I thought the existing negotiation merely means "I understand offset
encoded bases, so you are allowed to use that encoding", not "I will
not accept encoding other than the offset format, so you must use
that encoding for everything".
