From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH di/fast-import-deltified-tree] Windows: define S_ISUID
 properly
Date: Wed, 21 Sep 2011 05:08:03 -0700
Message-ID: <7vfwjq2hoo.fsf@alter.siamese.dyndns.org>
References: <4E798538.7070106@viscovery.net>
 <loom.20110921T092135-714@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Johannes Sixt <j.sixt@viscovery.net>
To: Dmitry Ivankov <divanorama@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 21 14:39:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R6M5G-0005cw-Dc
	for gcvg-git-2@lo.gmane.org; Wed, 21 Sep 2011 14:39:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753620Ab1IUMjX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Sep 2011 08:39:23 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61779 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752529Ab1IUMjV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Sep 2011 08:39:21 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3A4ED4716;
	Wed, 21 Sep 2011 08:39:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:date:references:message-id:mime-version
	:content-type; s=sasl; bh=fHVENhjLwcJReHQAAwWsoGUSe2Y=; b=F5AiYI
	vcdtQ+apWg10uizowXB52niBlHvNbZulpEQCYtrssG0cfX4+6RtfOib6fEhh7zBu
	Tc66O6skXCUrlUMcC07mOWyBsuUb5256FqZixdryFT97Y2jvBQlas4R7LL9n+izh
	9lgyk53jwrXFGkz6aqwQzXkB5RNpGXCkTaH3I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:date:references:message-id:mime-version
	:content-type; q=dns; s=sasl; b=a8wmAfQc+XYHfAdwEJbc39QqxtUGq2an
	wR+eHKyzZxJ7EHPqOCe72D/aZgMv3NsiWpjHQH/dEbLbauH0NF0yozj/Qas8WLte
	U3QZ9SCoDJJ9fSDkq7MhwslVE8wZvlpjkC5GPLddYeyRvL9QXQ699mAjqEmX+7Ei
	gKE7nJUsysw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 325E44715;
	Wed, 21 Sep 2011 08:39:21 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BDA2C4713; Wed, 21 Sep 2011
 08:39:20 -0400 (EDT)
In-Reply-To: <loom.20110921T092135-714@post.gmane.org> (Dmitry Ivankov's
 message of "Wed, 21 Sep 2011 07:38:18 +0000 (UTC)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: BA743A22-E44E-11E0-AAD8-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181839>

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
