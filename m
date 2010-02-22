From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] submodules: ensure clean environment when operating in a
  submodule
Date: Mon, 22 Feb 2010 15:16:50 -0800
Message-ID: <7vsk8s274t.fsf@alter.siamese.dyndns.org>
References: <20100218203726.GD12660@book.hvoigt.net>
 <1266877015-7943-1-git-send-email-giuseppe.bilotta@gmail.com>
 <7vljek51t1.fsf@alter.siamese.dyndns.org>
 <cb7bb73a1002221456q6c113675i7453e0115814c99c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	msysGit Mailinglist <msysgit@googlegroups.com>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 23 00:17:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NjhWc-0007aY-QO
	for gcvg-git-2@lo.gmane.org; Tue, 23 Feb 2010 00:17:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754890Ab0BVXRJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Feb 2010 18:17:09 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:42587 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754858Ab0BVXRF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Feb 2010 18:17:05 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 75BD59C3D5;
	Mon, 22 Feb 2010 18:17:03 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=3Bv+m1ZcMWmSBvFMbI8az+eSjLc=; b=ksnEoA
	cX53vU8y2cetptyDTlzdySxPoH8FLub7lX4Cykg3Lr2picd7FsaTOl9a/jWBzgYq
	LeFlQ6nlj56PBiJqV9g4L+2iWOeSvT8CgMK5jDQ/iJTcspCQ6kcsvm9uLBD2cZpK
	VX6WTCl/O2mlgheXV60lmS4JHa8ZTkjnM+840=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ixU+EiHsTBJ2RRRA+YkAD4AKtYUu1YwY
	WD3dHx7mJJrmbbnGHySba0W2oj0C6vJ7GLi/RZyieYk1JfEqJuBcR05H7mrHSq2l
	ia27wp38u8QFDLygXQfDuhxQ510CyMxtAcr9i6CXuJxp/fMlr0+M/Wy6FQ4igBhk
	xb1/NeHDaR8=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 213CE9C3D4;
	Mon, 22 Feb 2010 18:16:58 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 12B839C3D2; Mon, 22 Feb
 2010 18:16:51 -0500 (EST)
In-Reply-To: <cb7bb73a1002221456q6c113675i7453e0115814c99c@mail.gmail.com>
 (Giuseppe Bilotta's message of "Mon\, 22 Feb 2010 23\:56\:39 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 5FA64A06-2008-11DF-A857-D83AEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140736>

Giuseppe Bilotta <giuseppe.bilotta@gmail.com> writes:

> Good point. All GIT_* env variables should be resent when descending
> into a submodule. Is there a way to loop over them, or do I have to do
> something horrible like env | grep ^GIT_ | cut -f1 -d=  to get the
> list?

I would suggest to enumerate only what you care about explicitly, without
consulting the user's environment.  The user may have variables you do not
know about and not related to git at all.

IOW, don't try to be too clever for your own good ;-)
