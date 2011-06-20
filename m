From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] Add a lot of dummy returns to avoid warnings with
 NO_NORETURN
Date: Mon, 20 Jun 2011 14:17:32 -0700
Message-ID: <7vsjr4b3tf.fsf@alter.siamese.dyndns.org>
References: <1308445625-30667-1-git-send-email-andi@firstfloor.org>
 <1308445625-30667-2-git-send-email-andi@firstfloor.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Andi Kleen <ak@linux.intel.com>
To: Andi Kleen <andi@firstfloor.org>
X-From: git-owner@vger.kernel.org Mon Jun 20 23:17:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QYlqn-0006DR-F3
	for gcvg-git-2@lo.gmane.org; Mon, 20 Jun 2011 23:17:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752645Ab1FTVRg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Jun 2011 17:17:36 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:54992 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751106Ab1FTVRf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Jun 2011 17:17:35 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 67DD061F4;
	Mon, 20 Jun 2011 17:19:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=klkeE4w+8BaAohfhdOzbvSnwkKA=; b=p0mEsw
	gKHMn8v8z4E0fpbIo28exBdyhxJU/qxGdTxq3npQxGhFYZsxNCMcTSQM+qnn2X9k
	WEA0hLJUPrv6hL/7mljoI45B2GEhEpl461s8gCzcLr3a0p+U+i8X8ygobN5yAUVr
	39lwJuH5IXIQtQJ5KAcGo4ymP8vwlD2BGMV7I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=EYwLXF+1MLTsEZZtcwzcDh5jY53AVeGX
	G9YGSa4bd1N5bxMjXNngZufUFZvYqSxvmfYuMuTnuwaZZnCzFd4NyR+FpB9xepMg
	QO9+JVSRQjb1eGxm0Yahssg2KUBpMkk05aiidPGF+O26M8LPilhSHjKWH9TFP+hI
	PclK0ktz+zY=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 618BD61F3;
	Mon, 20 Jun 2011 17:19:45 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id C546E61F2; Mon, 20 Jun 2011
 17:19:44 -0400 (EDT)
In-Reply-To: <1308445625-30667-2-git-send-email-andi@firstfloor.org> (Andi
 Kleen's message of "Sat, 18 Jun 2011 18:07:04 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0502391E-9B83-11E0-8B78-5875C023C68D-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176093>

Andi Kleen <andi@firstfloor.org> writes:

> From: Andi Kleen <ak@linux.intel.com>
>
> Add a lot of dummy returns to silence "control flow reaches
> end of non void function" warnings with disabled noreturn.
>
> If NO_NORETURN is not disabled they will be all optimized away.

I think this is probably a bad move, given that the previous patch is a
temporary workaround until gcc 4.6 is fixed. With -Wunreachable-code on,
these will introduce noise for build without NO_NORETURN (either when
profile feedback is not used, or when profile feedback build is in use and
it no longer requires the NO_NORETURN workaround).
