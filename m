From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] helping smart-http/stateless-rpc fetch race
Date: Mon, 08 Aug 2011 16:42:27 -0700
Message-ID: <7vei0vtqqk.fsf@alter.siamese.dyndns.org>
References: <7vbow337gx.fsf@alter.siamese.dyndns.org>
 <CAJo=hJvdMCyU-5wzy0p1r+QJxXU=DJTE+Mu5G6pk9iAwAD51mA@mail.gmail.com>
 <7vbow01ols.fsf@alter.siamese.dyndns.org>
 <7vsjpbzv07.fsf@alter.siamese.dyndns.org>
 <CAGdFq_i=8p4jvKo1C=UFpmQyPtUd9JOtr9VW8vn7viC0dQkQmg@mail.gmail.com>
 <20110808230812.GA16974@LK-Perkele-VI.localdomain>
 <7vty9rtrk4.fsf@alter.siamese.dyndns.org>
 <7vpqkftrhg.fsf@alter.siamese.dyndns.org>
 <CAJo=hJu=nuy8Ws8PP16F=ay-Wp9vAdW_U113WLVCFs4hPQOeQA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Sverre Rabbelier <srabbelier@gmail.com>, git@vger.kernel.org
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Aug 09 01:42:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QqZSs-00087x-TN
	for gcvg-git-2@lo.gmane.org; Tue, 09 Aug 2011 01:42:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753652Ab1HHXma (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Aug 2011 19:42:30 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54117 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752879Ab1HHXm3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Aug 2011 19:42:29 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 33A6849A0;
	Mon,  8 Aug 2011 19:42:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=KEzSKb4l8jE0SIHsznOHxiX7gSE=; b=p6Sdii
	5JV+oCGTahyn0Z9BuLbbMkhpuGAuvyIDm+6msx6sf4Zum+n2NqvkbqShdSl+EI6u
	jywE4+3KQ+Cr/foapACNUCcc2hfMwcuYwk7kohd/GNR+ND9YOGVbMt1oN9xfSC+g
	E827UB0OSPy1va4kiJF6AOxs4ugWhn03cSfxY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=iLj7GCm81qZL7Jq+/OMeAiiTJwYW5XEu
	8H21obFVE896lS6SExXphRuLU1KJAZM9Jif4A0o3/wlcmrCcuBAC+SLjsAB+1zRX
	hkbKjHI/iWA2SgE7p6ZLBe5If+P7mkosR2fQhHoVgUN4tsqd0funtMIrXN6QHkVH
	tL6JA/DND/s=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 29AED499F;
	Mon,  8 Aug 2011 19:42:29 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7F878499E; Mon,  8 Aug 2011
 19:42:28 -0400 (EDT)
In-Reply-To: <CAJo=hJu=nuy8Ws8PP16F=ay-Wp9vAdW_U113WLVCFs4hPQOeQA@mail.gmail.com> (Shawn
 Pearce's message of "Mon, 8 Aug 2011 16:33:13 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 13A06520-C218-11E0-9C94-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179012>

Shawn Pearce <spearce@spearce.org> writes:

> On Mon, Aug 8, 2011 at 16:26, Junio C Hamano <gitster@pobox.com> wrote:
>> Junio C Hamano <gitster@pobox.com> writes:
>>
>>> A separate option would allow admins to let their clients ask to fetch
>>> 4bc5fbf (that is v0.99~2) even if that commit is not at the tip of any ref
>>> if they choose to. That is what (1) is about, and people who do not want
>>> a separate option needs to argue that it is an unnecessary "feature".
>>
>> By the way, I personally do not think it is necessary, but as long timers
>> on the list may recall, this has come up on the list for a few times.
>
> My feeling is clients aren't likely to do this, or grow this feature
> anytime soon, so why add a backend option for it now? Lets add the
> feature when the feature is necessary... and right now just fix the
> race in smart HTTP.

Yes, that is what is queued in today's 'pu'.
