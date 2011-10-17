From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 2/7] invalidate_ref_cache(): take the submodule as
 parameter
Date: Mon, 17 Oct 2011 11:00:35 -0700
Message-ID: <7vmxczmrb0.fsf@alter.siamese.dyndns.org>
References: <7vty7ggzum.fsf@alter.siamese.dyndns.org>
 <1318445067-19279-1-git-send-email-mhagger@alum.mit.edu>
 <1318445067-19279-3-git-send-email-mhagger@alum.mit.edu>
 <7vwrca81c7.fsf@alter.siamese.dyndns.org> <4E960F91.5020103@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Drew Northup <drew.northup@maine.edu>,
	Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>,
	Julian Phillips <julian@quantumfyre.co.uk>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon Oct 17 20:00:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RFrUU-00047J-3u
	for gcvg-git-2@lo.gmane.org; Mon, 17 Oct 2011 20:00:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751677Ab1JQSAm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Oct 2011 14:00:42 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42680 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751626Ab1JQSAl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Oct 2011 14:00:41 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CDEB2491E;
	Mon, 17 Oct 2011 14:00:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=wSAJHyiFsQQ4Xt89aSri1TrmMfs=; b=jIuBw/
	3sbGOnLgRqT0Z2kkbOqOwolpmWfglLUnn+hEDryvfhECpEMNygoLnhcx3irY3SbQ
	EjworG1hdllB8Cebx9FB2CkC7/wtfr53j2Kq12708+eUaDPyrRJL9f/x4ehhVY99
	C0Dnm1sRR0kxkm1Q7Rk9ILGc5DCuSeS6wR0L0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=c3BAB45fbCabyMFMEkOCjfwY87xTXY3Z
	vLTIVZvHC+ZnHkM0rSy6WGoTvHP26ORt3LrDW8eY9D9jEw4DQsEOJGXJZse4kIoS
	J7xran1T/u9X7z8RGNlj9VMKEwxPw2l/xT7ktXBSjr8Hf3R07pNp7T7izZG7Ev/m
	5RVpzmNxuUo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B32F9491C;
	Mon, 17 Oct 2011 14:00:39 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 50E1D4919; Mon, 17 Oct 2011
 14:00:39 -0400 (EDT)
In-Reply-To: <4E960F91.5020103@alum.mit.edu> (Michael Haggerty's message of
 "Thu, 13 Oct 2011 00:07:13 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: EC2000E2-F8E9-11E0-90B5-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183801>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> On 10/12/2011 09:19 PM, Junio C Hamano wrote:
>> Michael Haggerty <mhagger@alum.mit.edu> writes:
>>  ...
>> Probably that is what all the existing callers want, but I would have
>> expected that an existing feature would be kept, perhaps like this
>> instead:
>> 
>> 	if (!submodule) {
>> 		struct ref_cache *c;
>>                 for (c = ref_cache; c; c = c->next)
>>                 	clear_ref_cache(c);
>> 	} else {
>> 		clear_ref_cache(get_ref_cache(submodule);
>> 	}
> ...
> Your specific suggestion would not work because currently
> submodule==NULL signifies the main module.  However, it would be easy to
> add the few-line function when/if it is needed.

I think "submodule==NULL" is probably a mistake; "" would make more sense
given that you are storing the string in name[FLEX_ARRAY] field.
