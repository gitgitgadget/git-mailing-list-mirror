From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 3/8] status: Added missing calls to
 diff_unmodified_pair() in format_callbacks.
Date: Sat, 10 Apr 2010 15:32:09 -0700
Message-ID: <7v39z3uefq.fsf@alter.siamese.dyndns.org>
References: <cover.1270554878.git.grubba@grubba.org>
 <5962221bef558d15183c9937863b38bc7ca41339.1270554878.git.grubba@grubba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?Q?Henrik_Grubbstr=C3=B6m_=28Grubba=29?= <grubba@grubba.org>
X-From: git-owner@vger.kernel.org Sun Apr 11 00:32:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O0jDx-0004S7-Cq
	for gcvg-git-2@lo.gmane.org; Sun, 11 Apr 2010 00:32:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752341Ab0DJWcQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 10 Apr 2010 18:32:16 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:42785 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752334Ab0DJWcP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 10 Apr 2010 18:32:15 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id CE1FCA96F4;
	Sat, 10 Apr 2010 18:32:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=G6Vz9tzi7b1LPMG0T4hC1NG4S
	mI=; b=MUsj8vgukTqX1D1iTKEpv7e+p2nGaH2RA/dkD6KWH2na8hOBwDE54EQ8G
	RNSeagr/KjMNAMXjYLFYohLMJox3mWb4tWyzykuqdJfd5PsCgikdbVcTpkNCIFKa
	Mu5lPX1pn/Q+RVOYemkazWZLfpLs9D0/iWCCGDc7txmEBs3bww=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=uGNfa8OCzr89j81kAvq
	QWATf1ldegc9OjhH93PWBL4FFh8jxXxDGzZl0zAnN8oH3DA+eZHIbCEMcbVvZ07o
	1yRlBptm4mMLIc6Qi3YkRIQNJ7RVQCV/9oVMOvLufdgelImLVoQMcQ5u9qvOQgBJ
	8ubx9sK66Vq+afa/W5okoRyQ=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id AC686A96F2;
	Sat, 10 Apr 2010 18:32:12 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 23C6BA96F0; Sat, 10 Apr
 2010 18:32:10 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: E86E18F2-44F0-11DF-BB0E-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144607>

"Henrik Grubbstr=C3=B6m (Grubba)"  <grubba@grubba.org> writes:

> The diff_queue_struct provided by diff_flush() is raw, and needs to b=
e
> filtered through diff_unmodified_pair() before being used.
> This is already done by most of the other functions operating on
> diff_queue_struct called by diff_flush().

That is true but only if you are letting the diff front-end to feed
unmodified pairs to begin with, e.g. --find-copies-harder.  I don't thi=
nk
the internal caller in wt-status does that.

I don't think the patch is wrong nor it would hurt, but I am puzzled wh=
y
you needed this patch.

>  wt-status.c |    4 ++++
>  1 files changed, 4 insertions(+), 0 deletions(-)
