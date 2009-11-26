From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/8] git-merge-recursive-{ours,theirs}
Date: Wed, 25 Nov 2009 22:15:52 -0800
Message-ID: <7vr5rlerqf.fsf@alter.siamese.dyndns.org>
References: <cover.1259201377.git.apenwarr@gmail.com>
 <d243a513ffb8da4272f7a0e13a711f9b65195c25.1259201377.git.apenwarr@gmail.com>
 <905749faf5ccb2c7c54d3318dbc662d69daf8d0e.1259201377.git.apenwarr@gmail.com>
 <cover.1259201377.git.apenwarr@gmail.com>
 <7e1f1179fc5fe2f568e2c75f75366fa40d7bbbfb.1259201377.git.apenwarr@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>, <gitster@pobox.com>
To: "Avery Pennarun" <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 26 07:16:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NDXeD-0007u8-Gg
	for gcvg-git-2@lo.gmane.org; Thu, 26 Nov 2009 07:16:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754078AbZKZGP4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Nov 2009 01:15:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754056AbZKZGP4
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Nov 2009 01:15:56 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:39357 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751286AbZKZGPz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Nov 2009 01:15:55 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 1F60982F3F;
	Thu, 26 Nov 2009 01:16:00 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=JmvGm03K/00rXpAxxd3qcUdeIL8=; b=TbpQsIUSBSkynmD6aZ5Bixi
	uOBOXgZ+jBQ1syV7phdOEjnw/QuJhujw1/bUsqye0K3uMDlmqdQi8ZPkEQj5WEuW
	vQ+cX5E48e7IJ3Rv3H6MQkX401GNY3Opbcl7txvfA0OrEjtEcb5KnRf6Ss3OQHWI
	SFOeotXbY68ybp4Nn6Fs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=bj9Z9QP+ux7Z2OX0YT+vc95txgX8DGZ/nc/N2R6WhbbkKh3bt
	c+1/+tlEFKKRnbB/oRNhkYoDdtuCHGScxoSdF/f34+O+1SwSb2twrZ3JoeyuzeNv
	hMy3mZgz9LD40Qj2zRIonA6YMLQiRwbDi0m2+l9OoX4C1qSOxk8vNJk99M=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id F164882F3E;
	Thu, 26 Nov 2009 01:15:57 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3160482F3D; Thu, 26 Nov
 2009 01:15:54 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 29680B32-DA53-11DE-A5AE-9F3FEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133765>

"Avery Pennarun" <apenwarr@gmail.com> writes:

> This uses the low-level mechanism for "ours" and "theirs" autoresolution
> introduced by the previous commit to introduce two additional merge
> strategies, merge-recursive-ours and merge-recursive-theirs.
>
> (Patch originally by Junio Hamano <gitster@pobox.com>.)
>
> Signed-off-by: Avery Pennarun <apenwarr@gmail.com>

Two comments.

 - The original series was done over a few weeks in 'pu' and this
   intermediate step was done before a better alternative of not using
   these two extra merge strategies were discovered ("...may have been an
   easy way to experiment, but we should bite the bullet", in the next
   patch).

   As the second round to seriously polish the series for inclusion, it
   would make much more sense to squash this with the next patch to erase
   this failed approach that has already been shown as clearly inferiour.

 - I think we should avoid adding the extra argument to ll_merge_fn() by
   combining virtual_ancestor and favor into one "flags" parameter.  If
   you do so, we do not have to change the callsites again next time we
   need to add new optional features that needs only a few bits.

   I vaguely recall that I did the counterpart of this patch that way
   exactly for the above reason, but it is more than a year ago, so maybe
   I didn't do it that way.
