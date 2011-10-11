From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] Teach merge the '[-e|--edit]' option
Date: Mon, 10 Oct 2011 17:00:57 -0700
Message-ID: <7v1uukieh2.fsf@alter.siamese.dyndns.org>
References: <1318099192-60860-1-git-send-email-jaysoffian@gmail.com>
 <7vd3e4k162.fsf@alter.siamese.dyndns.org>
 <CAG+J_Dz37etot0nNkq+1gTUy8R0vVJpsRQuvwrTSczXRWy7mkA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	"Todd A. Jacobs" <nospam+listmail@codegnome.org>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 11 02:01:07 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RDPmL-00055d-B3
	for gcvg-git-2@lo.gmane.org; Tue, 11 Oct 2011 02:01:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753593Ab1JKABA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Oct 2011 20:01:00 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59661 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751570Ab1JKAA7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Oct 2011 20:00:59 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7CE43560E;
	Mon, 10 Oct 2011 20:00:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=kXMekbIlmJT8NLp/LbrakfDHgw8=; b=p7geoP571F7Hs8+uiuNs
	x/Q4fOK6jBMR0aK+49K/K3M1RocJ9L3kdE8t+AHfQYV+gqX9JhNh/joL47IBqi8d
	yITsqmLBqXy6vRuEo6o+rBYx4ZluE0AK1CsZjhst5S2ibL9RVTrStfEfVhLZK5vp
	TF2fEEhUwxeICsO7K9UN/hM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=jLAMO2w0BNCPE2M7bc3htMy+/FyzQxjoS4r0icsNy8ZYZL
	7ucpu/WJdm4C3QDMRieJCCm/Sd6UiwzpQAh4pgHWR7X90cAA1z/cHt0/kJfVi+AP
	rHxIBK0Pas8oNBu6KF5FKrGS4Y0dhs/YNXx83fZEWKRHhC4q1ozzn/xoyuV7U=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 72A29560C;
	Mon, 10 Oct 2011 20:00:59 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 01584560B; Mon, 10 Oct 2011
 20:00:58 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 198BF6A6-F39C-11E0-AC06-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183275>

Jay Soffian <jaysoffian@gmail.com> writes:

>> I am not sure about the '\n' you unconditionally added at the end of the
>> existing message.
>
> Right, the old code does that when the merge fails, counting on (I
> think) git-commit to then take care of any extra newlines.

Ahh, that explains it. I was originally about to suggest running the
stripspace() only when we run the editor, and saw a failure from an
unrelated test and realized that running stripspace() on the result of
prepare-commit-msg is the right thing to do after all, because that is
what is done by "git commit". Yes, the current code does rely on the
stripspace to remove it, so there is no need to make it conditional.

So if we drop the "conditionally add '\n'" part in builtin/merge.c from my
"how about this on top" patch and we should be ready to go, right?

Thanks.
