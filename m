From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 1/2] push: Don't push a repository with unpushed
 submodules
Date: Sat, 20 Aug 2011 23:48:48 -0700
Message-ID: <7vmxf3xnsf.fsf@alter.siamese.dyndns.org>
References: <1313791728-11328-1-git-send-email-iveqy@iveqy.com>
 <1313791728-11328-2-git-send-email-iveqy@iveqy.com>
 <7vwre9yodc.fsf@alter.siamese.dyndns.org>
 <7vippszj70.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, hvoigt@hvoigt.net, jens.lehmann@web.de
To: Fredrik Gustafsson <iveqy@iveqy.com>
X-From: git-owner@vger.kernel.org Sun Aug 21 08:49:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qv1qf-0002Mk-I5
	for gcvg-git-2@lo.gmane.org; Sun, 21 Aug 2011 08:49:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752174Ab1HUGsy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Aug 2011 02:48:54 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39794 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751948Ab1HUGsx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Aug 2011 02:48:53 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DF0961616;
	Sun, 21 Aug 2011 02:48:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=09PsIJta4smGHmE3HbmJ4YBOR1g=; b=yZE6gh
	hhyLHwd8EtbyKeExxpZBE5Q/fCqAOyZk+ZHKrjF0vuqQRkP10w8u42yfEL1bc1OO
	zaRte/GrJ1KKIhxhico+eja9frClr5JdBMzgZrZ25UH+4+GjOkVHdI43VfnEjkvB
	1qyWTlKsUp7cLOLVeo6XvdZ03/URbjvGZMg/Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=nAbApDNn0snXaD+SENWLnw0Xzv/61qVG
	y4EeeplXUVxTUBudhlMyANuXb/9QiNodJa+5vrD4CipPejBPgaqWHjZJCYyAe57H
	IC4UmaVPjrMmDYiICggkTZQ0faehDewBPxcxVOEsyFVBVyYn2TfkRx0pOa6gRtCv
	/gyTpqpfxvA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D550E1615;
	Sun, 21 Aug 2011 02:48:52 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6531F1613; Sun, 21 Aug 2011
 02:48:52 -0400 (EDT)
In-Reply-To: <7vippszj70.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Fri, 19 Aug 2011 23:32:51 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A1C4BB00-CBC1-11E0-B6BA-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179796>

Junio C Hamano <gitster@pobox.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> What I meant was more along the lines of the following, but I think we
>> would need a new kind of callback that can take N-way parents (which is
>> not depicted here).
>>
>> Let me cook up something and get back to you later tonight.
>
> And here is a two-patch series to do just that.
>
> The first one is meant for you to use, and the second one is a sample
> application of the new machinery.
>
> -- >8 --
> Subject: [PATCH 1/2] combine-diff: support format_callback
>
> This teaches combine-diff machinery to feed a combined merge to a callback
> function when DIFF_FORMAT_CALLBACK is specified.

After removing the change to combine-diff.c from your two-patch series, I
applied them on top of this one, and queued the result in 'pu'.

While I tried to be careful while doing this callback-for-combine-diff
patch so that a callback function written for two-way diff can be used
without any change as long as it does not care about the LHS (i.e. "one")
of the filepair, please double check. I didn't read your change to
submodule.c very carefully (and I didn't have to change it).

The result seems to pass your new tests ;-).
