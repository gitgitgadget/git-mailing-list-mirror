From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Bug: bad errno report from lock_ref_sha1_basic() when contents
 bad
Date: Mon, 02 Apr 2012 10:30:14 -0700
Message-ID: <7vhax2ghy1.fsf@alter.siamese.dyndns.org>
References: <878viephzm.fsf@thomas.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Mon Apr 02 19:30:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SEl5F-0007OR-Ka
	for gcvg-git-2@plane.gmane.org; Mon, 02 Apr 2012 19:30:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752818Ab2DBRaU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Apr 2012 13:30:20 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48451 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752859Ab2DBRaS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Apr 2012 13:30:18 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BC4836391;
	Mon,  2 Apr 2012 13:30:17 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=N5s7zXQwjK4Kr2PCfq9/axTW0js=; b=LV+iY3
	rbCt+5XmSHMOHoERc5aDbCwRyeVD31p3+n/xm1nx2vz3+0eqBIobt65BUyiN19Hc
	eBd3pAo9EkIvrEKkR+/WFdTNvtxA+4mK5wnnrGfBGsDBW4bcpTqu/cHWJAtH6MAx
	egn1oSPipXbzjeBOEzmzosyTEGcZ5ZwCKmKxo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=lCNJnE1vCEOOgIFoqK36aifOQy/WmmW2
	KNT9e2OeM/YdUROkDrfQGuNAFT11p43BC+qWJtQqgaTIGIb2IIR2q1aGGaZKNTDo
	fvreV18+7l3Y4aGyZV1glyf5q7n9+M6aIqA9vLNopkXsooMgrHFtyz8OolxLzi6w
	Tybcc/kqrp0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B25426390;
	Mon,  2 Apr 2012 13:30:17 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 510AF638F; Mon,  2 Apr 2012
 13:30:16 -0400 (EDT)
In-Reply-To: <878viephzm.fsf@thomas.inf.ethz.ch> (Thomas Rast's message of
 "Mon, 2 Apr 2012 12:04:29 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 82EA07A6-7CE9-11E1-AA80-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194543>

Thomas Rast <trast@inf.ethz.ch> writes:

> As far as I can see lock_ref_sha1_basic() needs a similar check for
> REF_ISBROKEN (and presumably the only fix is to nuke it so maybe it
> should even suggest that to the user).

Probably.

> But in general, the "errno may
> be crucial or worthless" interface of lock_ref_sha1_basic() seems a bit
> broken...

Sorry, but I am not sure what you mean by this.  The function is fairly
careful using errno to base its decision and even saves errno when it
calls helpers that may overwrite it, so the "interface" does not want "may
be crucial or worthless".  The implementation may have been broken over
time by many patches, but that is a different issue.  Which codepaths
clobber errno, and is it something you can easily fix with a patch or two?
