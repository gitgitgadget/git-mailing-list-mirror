From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH di/fast-import-deltified-tree] Windows: define S_ISUID
 properly
Date: Wed, 21 Sep 2011 05:07:59 -0700
Message-ID: <7v39fq3xpc.fsf@alter.siamese.dyndns.org>
References: <4E798538.7070106@viscovery.net>
 <loom.20110921T092135-714@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Johannes Sixt <j.sixt@viscovery.net>
To: Dmitry Ivankov <divanorama@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 21 14:08:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R6Lb1-0006fn-Sq
	for gcvg-git-2@lo.gmane.org; Wed, 21 Sep 2011 14:08:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753384Ab1IUMIG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Sep 2011 08:08:06 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51146 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752778Ab1IUMIF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Sep 2011 08:08:05 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 733164096;
	Wed, 21 Sep 2011 08:08:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=fHVENhjLwcJReHQAAwWsoGUSe2Y=; b=dM4bRK
	DiH85cPTMhgjmofI47u7jNa2sYaiI8dPfEIiZ/snPvN5iZgWQ/LV1tedEzsR3/0l
	xETdtEvKMY4VdtbDmdz1Ro7LNGjg8nCy6VZzvLpoU2cq9Uv7F35IWGONpNBXkLGK
	0wFzFwTjRgAuFh3CBaoz5zzbWPu6X8Vi8kGw4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=W8+q3JAHg8Axs7IvaeyNJjh9gTPl7ugJ
	LPnJXSKP84faqpL+6JExZ1HjJA2sYpPiB5cKAYOEuIiFRy1RzUIcS++D75ow+dma
	8om+KbE8nMmFn3WQ+VuFBkXZesFF3rPi9RanjSN9nPbLK7PnNaz+V5cGN+WFWmKk
	kbPNpcUj7fo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6A6914095;
	Wed, 21 Sep 2011 08:08:02 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 774134094; Wed, 21 Sep 2011
 08:08:01 -0400 (EDT)
In-Reply-To: <loom.20110921T092135-714@post.gmane.org> (Dmitry Ivankov's
 message of "Wed, 21 Sep 2011 07:38:18 +0000 (UTC)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5A4F9D52-E44A-11E0-B1D4-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181837>

Dmitry Ivankov <divanorama@gmail.com> writes:

> Johannes Sixt <j.sixt <at> viscovery.net> writes:
>> 
>> From: Johannes Sixt <j6t <at> kdbg.org>
>> 
>> 8fb3ad76 (fast-import: prevent producing bad delta) introduced the first
>> use of S_ISUID. Since before this commit the value was irrelevant, we had
>> only a dummy definition in mingw.h. But beginning with this commit the
>> macro must expand to a reasonable value. Make it so.
>>  #define S_ISVTX 0
>> ...
> Ow, it's awkward that the issue was discussed in [1] but slipped and nobody 
> noticed, especially me being a patch sender.
>
> If we choose patch from [1] I'd also change a comment to smth like
> /* 
>  * We abuse the 04000 bit on directories to mean "do not delta".
>  * It is a S_ISUID bit on setuid platforms and an unused bit on
>  * non-setuid platforms supported in git. In either case git ignores
>  * the bit, so it's safe to abuse it locally.
>  */
>
> [1] http://thread.gmane.org/gmane.comp.version-control.git/179223/focus=179762

I think that the fix from Jonathan to stop abusing S_ISUID is much more
preferrable; the Windows platform shouldn't have to worry about this.

And it would be even better to use a value that does not overlap with the
usual bits for do-not-delta bit if possible.
