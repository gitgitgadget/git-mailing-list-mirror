From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] help.c: make term_columns() cached and export it
Date: Sun, 12 Feb 2012 01:40:08 -0800
Message-ID: <7vsjigl79j.fsf@alter.siamese.dyndns.org>
References: <CACsJy8AQdz=uwDm+FOgcUB5JOi5U7w-W4w7yUPL6wd2FO-bArg@mail.gmail.com>
 <1328891972-23695-1-git-send-email-zbyszek@in.waw.pl>
 <1328891972-23695-3-git-send-email-zbyszek@in.waw.pl>
 <CACsJy8AjqqEpJr64DJUqVumw1sB2g3pvuz-g4DxhmS-ZbGhY3w@mail.gmail.com>
 <4F3647B4.8090803@in.waw.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>, git@vger.kernel.org,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>
To: Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
X-From: git-owner@vger.kernel.org Sun Feb 12 10:40:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RwVvH-0002qa-Ga
	for gcvg-git-2@plane.gmane.org; Sun, 12 Feb 2012 10:40:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751476Ab2BLJkO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 12 Feb 2012 04:40:14 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45639 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751451Ab2BLJkN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 12 Feb 2012 04:40:13 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 019D84FF9;
	Sun, 12 Feb 2012 04:40:12 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=qwHE03VlGBfA
	0VQe7RLDCdDHGhw=; b=jQfjvJEoimqvp7g9aj7mDojKMRUHuesOfpAWuEy8XuF3
	iad9aGhzBI5TykJWFoMS7Qrk1YQ6nqx5PkPrOoPor3IKZFU3XsW4KZ5+ry2WAn8W
	y+y9oWdhVAgEMX3/6xM1aQz6tdwLmFF1fME1ANQZ5s+23CxjAQP8y2sUSBE7vrg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=lmyqwC
	8yXTfx4ntTk+zFpu4aq7KMebKAVE5NvZ30JHiGI7ozltWaZ/PYwQDkGV4GKz7PDJ
	kR8l4F1SFzIBOH0v1Ap+YG+vZUy1ih1KApeRiKlHlC8oGA2kWn0sitBAC+Hpaabw
	O/H3Wf86Kgj7hYBn+Lzph2gmAYgfoQkQ3OlC0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EC5394FF8;
	Sun, 12 Feb 2012 04:40:11 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B5CF84FF7; Sun, 12 Feb 2012
 04:40:10 -0500 (EST)
In-Reply-To: <4F3647B4.8090803@in.waw.pl> ("Zbigniew =?utf-8?Q?J=C4=99drze?=
 =?utf-8?Q?jewski-Szmek=22's?= message of "Sat, 11 Feb 2012 11:49:24 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8E6BA8B8-555D-11E1-8357-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190563>

Zbigniew J=C4=99drzejewski-Szmek <zbyszek@in.waw.pl> writes:

> Junio suggested that "a new file, term.c or something, be a lot more
> suitable home for the function you will be reusing from diff and othe=
r
> parts of the system". Nevertheless, I think that adding two files (.c
> and .h) to hold one function isn't worth it. It can live in pager.c.
> Terminal size is logically connected to paging after all.

I do not have any objection to the above reasoning.

Given that Nguyen's columns topic hasn't been merged to 'next' and I
expect it will be re-rolled anyway, I would prefer a patch that does th=
e
move from help.c to pager.c that is based directly on v1.7.9, on top of
which your work and the columns topic can both be built independently.

Thanks.
