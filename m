From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] fix overslow :/no-such-string-ever-existed diagnostics
Date: Tue, 10 May 2011 16:11:22 -0700
Message-ID: <7v4o52i21x.fsf@alter.siamese.dyndns.org>
References: <7vhb92jujt.fsf@alter.siamese.dyndns.org>
 <7vzkmuidk1.fsf@alter.siamese.dyndns.org> <vpqfwomffuy.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed May 11 01:11:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QJw5W-0005OG-N0
	for gcvg-git-2@lo.gmane.org; Wed, 11 May 2011 01:11:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753264Ab1EJXL3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 May 2011 19:11:29 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:47059 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753234Ab1EJXL3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 May 2011 19:11:29 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 3B9004BF5;
	Tue, 10 May 2011 19:13:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=DSkzOMuZ2kJFGGLJPEcD1yY9A8w=; b=t8aZcd
	L+ue/3bRtoZ+88eeKPa+4DCQv5VR2x1reElMyhj9mHjLELnJLRL4YXUt/7/cFVLP
	cGRNaxM6HxeSi50s5xr5xDU7/hHcJkvGq/+2obpQ3ZWQmygOhS3C3i7ns+DAX+RC
	HAIoRRYFwVBY3De1rBqkjz+CWc2vHeEWfrZGY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=k1zgkjvxWAHsmIoervZAPxvzYTxhn7eV
	rAovoKDDz7MNljsiDYzddd5THWuMaCprDLM3RRANxZBbg1dKiT8pWhzgJ6+fAaxt
	L80kGs8te7Hz50goZY4cKgBduwYZwcjdX6oLeLtpFfFTOLw+8zq4ug9cqzkI3hbX
	xBqwPdHd7oQ=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 17EB74BF4;
	Tue, 10 May 2011 19:13:32 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 40A164BF1; Tue, 10 May 2011
 19:13:28 -0400 (EDT)
In-Reply-To: <vpqfwomffuy.fsf@bauges.imag.fr> (Matthieu Moy's message of
 "Tue, 10 May 2011 22:41:25 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1F664C84-7B5B-11E0-9D7F-B44DF9BAD297-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173381>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Is this a complement or an alternative? It seems to me that your other
> patch makes this first one useless (in the sense that the second call is
> always cheap), and avoids complexifying the code of get_sha1_with_mode_1
> for the first call.

I think that the get_sha1_with_mode_1() that is sprinkled with the
"gently" conditional everywhere _is_ the primary source of complexity.

I suspect that if 009fee4 did a proper refactoring, get_sha1_with_mode()
wouldn't have that "gently" option at all, and the die_verify_filename()
wouldn't call get_sha1_with_mode().  Instead, they would share same set of
helper functions and the latter would make a few calls to them, only to
deal with :<path> and <tree>:<path> cases.
