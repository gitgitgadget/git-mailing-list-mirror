From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Fix archive format with -- on the command line
Date: Wed, 30 Dec 2009 00:11:52 -0800
Message-ID: <7vhbr8519z.fsf@alter.siamese.dyndns.org>
References: <20091210212636.GA27722@Knoppix>
 <7v1vj2a3ik.fsf@alter.siamese.dyndns.org>
 <20091210222258.GQ4114@genesis.frugalware.org>
 <7vws0u8n99.fsf@alter.siamese.dyndns.org>
 <7vhbry8l54.fsf_-_@alter.siamese.dyndns.org>
 <7vd42m8kyr.fsf@alter.siamese.dyndns.org> <4B23B019.40106@lsrfire.ath.cx>
 <20091230121309.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>,
	Miklos Vajna <vmiklos@frugalware.org>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	git@vger.kernel.org
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Wed Dec 30 09:12:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NPtfC-00005V-Gh
	for gcvg-git-2@lo.gmane.org; Wed, 30 Dec 2009 09:12:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752510AbZL3IMJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Dec 2009 03:12:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752503AbZL3IMJ
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Dec 2009 03:12:09 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:62378 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752498AbZL3IMG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Dec 2009 03:12:06 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id EBA6BABC86;
	Wed, 30 Dec 2009 03:12:05 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=AWMoSJIW0STL5aRSvep5B4YUTeg=; b=mQgif7
	2OdWjZGqwhl1NYIh6ZDmHIh1Njx6KL0AbXg45IMfXtO6bssHOemaHVSJJc9QXxJ+
	TB2E+RjtiAN4At3/Wx222vAXfKIj+eQWSXJ50zBKwKVPOMHPpzy711dxDVtsy1Zy
	7b9RmKstaoAwTQ3kae6363sofYjpHsKktOHlg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=W027StSLNu4kVAmoJEJsu9RvlsNJrHZA
	n0YoPZsgxlsiH/QR9Ufb79wm8IWKNL4jhwgccTODZjk75On/aklj9rFbW6bjkWfA
	M4Ti0do+VJNj9KMQR2uViRstlvS9q0XuYeQjql72Dw3jn+Vy5vozEOwaHMiDlAcT
	liobqSSAvKQ=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id A077CABC85;
	Wed, 30 Dec 2009 03:12:00 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 2477CABC84; Wed, 30 Dec 2009
 03:11:53 -0500 (EST)
In-Reply-To: <20091230121309.6117@nanako3.lavabit.com> (Nanako Shiraishi's
 message of "Wed\, 30 Dec 2009 12\:13\:09 +0900")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 01863AD4-F51B-11DE-830D-465EBBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135870>

Nanako Shiraishi <nanako3@lavabit.com> writes:

> Junio, could you tell us what happened to this thread?
>
> "git archive HEAD non-existing-path" doesn't complain like "git
> add" does, and the patch is to fix it.  No discussion.

It walks the tree twice, once for the checking and then another for doing
its real work.  Doing that way obviously looks stupid and inefficient but
on the other hand it can fail before doing anything, which may be a big
plus.  I couldn't decide the pros-and-cons at the moment.

Probably it is worth queuing the patch as is, and if there are motivated
people who want to, let them "optimize" it by rolling that check into the
main loop.

I dunno.
