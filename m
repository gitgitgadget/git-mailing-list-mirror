From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/6] Use floating point for --dirstat percentages
Date: Tue, 26 Apr 2011 21:42:25 -0700
Message-ID: <7vipu0b8zy.fsf@alter.siamese.dyndns.org>
References: <BANLkTim9U4cOnV+5=Mp-2g_M6+JOiM5e7A@mail.gmail.com>
 <1303776102-9085-6-git-send-email-johan@herland.net>
 <7vpqo9ez03.fsf@alter.siamese.dyndns.org>
 <201104270402.29085.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Wed Apr 27 06:42:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QEwaW-00065d-1I
	for gcvg-git-2@lo.gmane.org; Wed, 27 Apr 2011 06:42:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751870Ab1D0Emi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Apr 2011 00:42:38 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:50696 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751099Ab1D0Emh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Apr 2011 00:42:37 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id D945859F0;
	Wed, 27 Apr 2011 00:44:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=d7nj8Iq3+ReHYSjKgljEHUx8X38=; b=ALnRBU
	bBrpjtULQOeFffkqLgMs2dfX5tilzyHGkNJxFLlbz+SgDR+jktgZ7OF1j078KNHL
	2SQuc2HiRAOWwOf+mFD4aFw7krzo2oqjYHjrE0zhEyi+XbkkMPHBaES9AXVK+Msj
	wqapf5Xg07+usRKMlNmoln3+S5z8g0o6AJX0g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Om1XKoXSbOoBjpNS7xrM0N6ttOlAIJQ7
	TnChq0zsrdMBbIET3+S0WDhorEeDgmpBJlm0LlR6dVkLGJo0GSBQu2tXrguW3ArC
	rFVOPK48oSKzewFU0PfX3KPQ+mbw0ly+GSRHo+yxJpzwsCCh+NxQwhGop9FcdoSY
	knVv3bj+sls=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id A388159EB;
	Wed, 27 Apr 2011 00:44:34 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 7E9C659E9; Wed, 27 Apr 2011
 00:44:30 -0400 (EDT)
In-Reply-To: <201104270402.29085.johan@herland.net> (Johan Herland's message
 of "Wed, 27 Apr 2011 04:02:28 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0CA15972-7089-11E0-8E45-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172163>

Johan Herland <johan@herland.net> writes:

> On Tuesday 26 April 2011, Junio C Hamano wrote:
>> Johan Herland <johan@herland.net> writes:
>> > Allow specifying --dirstat cut-off percentage as a floating point
>> > number.
>> > 
>> > When printing the dirstat output, floating point numbers are presented
>> > in rounded form (as opposed to truncated).
>> 
>> Why isn't it sufficient to change
>> 
>> 	permille = this_dir * 1000 / changed
>> 
>> to
>> 
>> 	permille = (this_dir * 2000 + changed) / (changed * 2)
>> 
>> or something?  If rounding is the only issue that bothers you (I admit
>> that it does bother me, now that you brought it up), that is.
>
> Actually, rounding doesn't bother me at all (or rather, I don't really care 
> if we round or truncate, as long as we're consistent).

If that is the case, I would rather not see us use floating point for
this.

I have used "#define MAX_SCORE 60000.0" to sneakily run rename similarity
score in floating point, feeling ashamed of it, and have been meaning to
fix that for quite a long time, but other than that, I do not think we
have anything that uses float.
