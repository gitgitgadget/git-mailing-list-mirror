From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] push: Correctly initialize nonfastforward in do_push.
Date: Wed, 16 Sep 2009 11:15:27 -0700
Message-ID: <7vvdjizrgg.fsf@alter.siamese.dyndns.org>
References: <1253119020-26547-1-git-send-email-Matthieu.Moy@imag.fr>
 <7vpr9q24oa.fsf@alter.siamese.dyndns.org> <vpqfxamby33.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Sep 16 20:15:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mnz2e-0002l7-Q0
	for gcvg-git-2@lo.gmane.org; Wed, 16 Sep 2009 20:15:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756534AbZIPSPf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Sep 2009 14:15:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755954AbZIPSPe
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Sep 2009 14:15:34 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:55512 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755741AbZIPSPe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Sep 2009 14:15:34 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 1F0535354D;
	Wed, 16 Sep 2009 14:15:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=VUmLaW8ORCx1tkLTukfDH1r4y3U=; b=S9coGB
	/XiFTRFTfbEmAzAeGHHikodgOOx5sqF+upkk1TFbHbFoDIisZKHBAWs+5R0Ibaob
	/82KQRs0fx2DGUZixEoHPGEkLlXy0Yd8uNorzd4V//bBpU3/HYs6Cmhp6kleae+6
	JP6+GXOzCKArBnpp5Ld/mbk2DjchJUiKfLspw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=EcvcHYogzkxz4z5KNv407xhGOVyU3JKB
	lDRJrbXrgs8c2xEUGZQo8URwHUVmYkmvbnDzshxDS0jNwaNpuwsuamhRjcg2a4RI
	HigBzgwj+AGm2InAtveVERWZK6A5koy+xnQoqJG1ZUW2+L6Vl7okO677K2qITRau
	7WyKFaXjvyo=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 010975354C;
	Wed, 16 Sep 2009 14:15:34 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id AD96F53544; Wed, 16 Sep 2009
 14:15:28 -0400 (EDT)
In-Reply-To: <vpqfxamby33.fsf@bauges.imag.fr> (Matthieu Moy's message of
 "Wed\, 16 Sep 2009 19\:26\:08 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: ED93DFAC-A2EC-11DE-A30B-8B19076EA04E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128669>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Short answer: trust me, without the patch, you get the non-fast
> forward (and valgrind tells you about conditional jump on
> uninitialized value), with, you don't ;-).

I understand valgrind one; I can trace the codepath with eyeballs without
it, and that is why I said it looks correct to begin with.

My puzzlement was that the following in the log message did not seem to
reproduce for me:

    ... where "git push ... nonexisting-branch" was complaining about
    non-fast forward.

I would be eventually writing an entry in the Release Notes about this
fix, and I do not want to say:

    "git push $there no-such-ref" incorrectly said no-such-ref does not
    fast forward; fixed.

when I know that command line would produce something entirely different
error.
