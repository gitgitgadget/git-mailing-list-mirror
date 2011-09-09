From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] fetch: skip on-demand checking when no submodules are
 configured
Date: Fri, 09 Sep 2011 14:00:29 -0700
Message-ID: <7vaaadtor6.fsf@alter.siamese.dyndns.org>
References: <4E6A594B.9030108@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Martin Fick <mfick@codeaurora.org>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Fri Sep 09 23:00:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R28Bj-0003M9-5r
	for gcvg-git-2@lo.gmane.org; Fri, 09 Sep 2011 23:00:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933377Ab1IIVAe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Sep 2011 17:00:34 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34521 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933345Ab1IIVAd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Sep 2011 17:00:33 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A3B204205;
	Fri,  9 Sep 2011 17:00:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=GTcC/DGwvQ/47Y8L2Zoj9JgVtRY=; b=uScGDJ
	/zClOAIFuumw+OHVZHoKNRrDrP00rKU0pl5X6nztr5+1gzSck4RbPTSPPZ63QDcw
	mH741m/FoyoNIF/dg8XqyAxLaoDJ99999hH0d5vYpi0eKqpgN02fr+bxMvU93GIh
	gMatZkUYWyph2zKNj0QlwftxnXHxW8EOT5Vss=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=RAf3TkCgQbs/E0jb6sPuck5/WQecpHID
	3ejJI3pqmUd/y+jAFsSWqVXke5NTRjzvlstdXe8E6WvTvjZigXJpn0+DtfLCwZ7z
	NoCf3Z3TH5s97Z/JTwyLwX72Mf7gNAif/oZtbyr7OqVsR8hLQg/ydmXAE4/F1/pu
	R8RlpZbfaiQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9B7964204;
	Fri,  9 Sep 2011 17:00:31 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3184441F8; Fri,  9 Sep 2011
 17:00:31 -0400 (EDT)
In-Reply-To: <4E6A594B.9030108@web.de> (Jens Lehmann's message of "Fri, 09
 Sep 2011 20:22:03 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C0DE4B9A-DB26-11E0-952E-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181125>

Jens Lehmann <Jens.Lehmann@web.de> writes:

> It makes no sense to do the - possibly very expensive - call to "rev-list
> <new-ref-sha1> --not --all" in check_for_new_submodule_commits() when
> there aren't any submodules configured.
>
> Leave check_for_new_submodule_commits() early when no name <-> path
> mappings for submodules are found in the configuration. To make that work
> reading the configuration had to be moved further up in cmd_fetch(), as
> doing that after the actual fetch of the superproject was too late.
>
> Reported-by: Martin Fick <mfick@codeaurora.org>
> Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
> ---
>
> This achieves the first goal: Don't let people pay a performance penalty
> when they don't even use submodules. On Michael's test repo from [1] the
> time for a full fetch went down from 142 seconds (current master) to one
> second which is - not surprisingly - the same as using current master
> with the --no-recurse-submodules option.
>
> Now back to the drawing board to fix the performance regression for those
> people who are using submodules ...
>
> [1] http://comments.gmane.org/gmane.comp.version-control.git/177103

Thanks.
