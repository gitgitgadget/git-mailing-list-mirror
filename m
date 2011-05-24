From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv4 09/10] pack-objects: Estimate pack size; abort early if
 pack size limit is exceeded
Date: Mon, 23 May 2011 17:18:48 -0700
Message-ID: <7vd3j9rlw7.fsf@alter.siamese.dyndns.org>
References: <1306111923-16859-1-git-send-email-johan@herland.net>
 <1306111923-16859-10-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Shawn Pearce <spearce@spearce.org>, git@vger.kernel.org
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Tue May 24 02:19:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QOfKz-00038q-JK
	for gcvg-git-2@lo.gmane.org; Tue, 24 May 2011 02:19:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757722Ab1EXAS7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 May 2011 20:18:59 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:61976 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756887Ab1EXAS6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 May 2011 20:18:58 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 2A6D8536B;
	Mon, 23 May 2011 20:21:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=nHe/GMgrK8r37KZcFOa5CW4dUIg=; b=obq+ZE
	7dbZGLTHs57dDg9mFle6o3mOs+BpHMOih4cDlGwWc2CftToo1IcMt13XbZ2Uf/lp
	ssPZWzrBD+i1imvZ4KMmZEL8LN88w3GSH2wWOVuOr/6pEpGr5HgaykzFXd7j9FZx
	AE4r/0QDgDsqONI5jUnsiyWlSW/vdH9Ug80DI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Wt4Lt+y2xvF6DQG5G2AgLqaePVU7Ze/b
	XTygSP2N+6rYq2dTYvro/t7IX2QTDWdf8bAQI42dqSiKfdKw2uopfcH3ijrq7ALH
	HljJ+nLA9QpCCl2HLpcJfWM5JMJRWlbUvBReDSq/aupT4Jk5r9swXPBv7k+xlkYM
	q/URPUGe22Q=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id D525C536A;
	Mon, 23 May 2011 20:21:02 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id A83045369; Mon, 23 May 2011
 20:20:58 -0400 (EDT)
In-Reply-To: <1306111923-16859-10-git-send-email-johan@herland.net> (Johan
 Herland's message of "Mon, 23 May 2011 02:52:02 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B5342EA8-859B-11E0-BE50-D6B6226F3D4C-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174301>

Johan Herland <johan@herland.net> writes:

> I'm not really happy with excluding loose objects in the pack size
> estimate. However, the size contributed by loose objects varies wildly
> depending on whether a (good) delta is found. Therefore, any estimate
> done at an early stage is bound to be wildly inaccurate. We could maybe
> use some sort of absolute minimum size per object instead, but I
> thought I should publish this version before spending more time futzing
> with it...

As the initial approximation, I think this implementation is fine.
Continuing my comments on 7/10, "pack_to_stdout && pack_size_limit" part
may need to be replaced with "total_data_limit" or something, though.

After all it isn't fundamentally wrong to say "I don't want to pack more
than 2GB in total" even when you are producing packs on your local disk
without the --stdout option, no?
