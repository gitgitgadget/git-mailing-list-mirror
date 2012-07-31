From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] macos: lazily initialize iconv
Date: Tue, 31 Jul 2012 11:07:04 -0700
Message-ID: <7va9yfkdo7.fsf@alter.siamese.dyndns.org>
References: <7vk3xjked0.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Tue Jul 31 20:07:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SwGqi-0001RM-V8
	for gcvg-git-2@plane.gmane.org; Tue, 31 Jul 2012 20:07:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754905Ab2GaSHJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Jul 2012 14:07:09 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37581 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754629Ab2GaSHH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Jul 2012 14:07:07 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4F04274E4;
	Tue, 31 Jul 2012 14:07:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=KXy36B484wIGBdonAd2VTZI4lZk=; b=uH2K/W
	jkfuRAsmNqfcfT+M9Mo7JeLBQCdkns+8eNREKbQJ0K3lm/XpNftjjBsonKi4km5f
	FdgpfXNuM1ndBE6lorJRMiQBK2VKGemUSMLL2AhXuzbxgqTlvOSHlrEH7NgZhNTa
	BCumlD2ca9sd/G69xPrpNhrL5sHjpebjwy4P8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=JQ3G1DgevglbYIU8SwwaCZ5/8qxSB7t3
	vEmilGdK04TICz0qiwzj5ibk8UvtPOOrZTfaBOHgqQkqabyVB24jYeoz5wobHc1b
	vtTN0+vLNbVvrQg5phl/Po1yuUfZXyNFb01nRrht2RSsMn6MoJh7QVnSotBuhJNU
	U3KCWK8BAno=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3C76A74E3;
	Tue, 31 Jul 2012 14:07:07 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C0E5974E2; Tue, 31 Jul 2012
 14:07:05 -0400 (EDT)
In-Reply-To: <7vk3xjked0.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Tue, 31 Jul 2012 10:52:11 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 896C2EB0-DB3A-11E1-9187-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202664>

Junio C Hamano <gitster@pobox.com> writes:

> In practice, the majority of paths do not have any utf8 character
> that needs the canonicalization.  Lazily call iconv_open() and
> iconv_close() to avoid unnecessary overhead.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>
>  * This is not even compile tested, so it needs testing and
>    benchmarking, as I do not even know how costly the calls to
>    open/close are when we do not have to call iconv() itself.
>
>    This was brought up by Linus (Cc'ed) in http://goo.gl/INWVc

Even though I also think that per-DIR iconv may not be the optimal
way to organize this (I think iconv_t should be a per-thread thing
at most), it would be a more involved change that needs to be done
by somebody who actually works on Mac, so the patch I sent is kept
deliberately minimum.

Just FYI.
