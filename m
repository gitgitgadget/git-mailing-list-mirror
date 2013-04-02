From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 07/13] remote-hg: redirect buggy mercurial output
Date: Tue, 02 Apr 2013 13:36:44 -0700
Message-ID: <7v8v50brfn.fsf@alter.siamese.dyndns.org>
References: <1364929382-1399-1-git-send-email-felipe.contreras@gmail.com>
 <1364929382-1399-8-git-send-email-felipe.contreras@gmail.com>
 <7vehesd7rl.fsf@alter.siamese.dyndns.org>
 <CAMP44s1C37+drw3HhysO4aRgxUt=knAKnT+Bk0JCqLr=CL5yjQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Max Horn <max@quendi.de>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 02 22:37:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UN7xH-0001Lg-CT
	for gcvg-git-2@plane.gmane.org; Tue, 02 Apr 2013 22:37:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762297Ab3DBUgs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Apr 2013 16:36:48 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42072 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761463Ab3DBUgr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Apr 2013 16:36:47 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 676CD12DA5;
	Tue,  2 Apr 2013 20:36:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ryz5RnMQofQHGqa3XPB59uiPCkI=; b=szjki6
	nJHABOnLpNdLJC6rH4K9bXvAYiiXFMpzZhzInTdcgKg4dRMM9dl8keNdRtqoXrQs
	/3xNnodcB9r84WC7SJO/AJKYGotnQn73bdLva7RQpGRSaIqukfvKVo4Dgv+VfQ8N
	xK0UbaTwYWxSeBhxW9bIBxWNgfQxpwSmQmqVQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=fLb46FME+zdNo7G9fz1/bV1aC/m6/D7b
	rt95sEjYazG/vbgwYnfHy/3XFeIRtq2zLIcsFxF/r2Gm0mwmBiNvWl43i9ihd122
	z9JROS2tQamxg5Kw/VFbvAXHL2ESHstBEAXD9sCRAF7W+n31nqz8k4HOqEHIyobE
	zMdvtJnxAUA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5C1B212DA3;
	Tue,  2 Apr 2013 20:36:46 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D685412DA2; Tue,  2 Apr
 2013 20:36:45 +0000 (UTC)
In-Reply-To: <CAMP44s1C37+drw3HhysO4aRgxUt=knAKnT+Bk0JCqLr=CL5yjQ@mail.gmail.com> (Felipe
 Contreras's message of "Tue, 2 Apr 2013 14:22:44 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 092E01CC-9BD5-11E2-8E29-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219882>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> On Tue, Apr 2, 2013 at 1:58 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Felipe Contreras <felipe.contreras@gmail.com> writes:
>>
>>> We can't use stdout for that in remote helpers.
>>>
>>> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
>>> ---
>>
>> You may want to clarify "buggy output" a bit.  Will mercurial
>> forever be broken?  Some versions of Hg emit [[[it is unclear for
>> Junio to tell what it is to fill this blank]]] to its output that
>> we want to ignore?
>
> The problem is that mercurial's code is kind of hardcoded to run under
> mercurial's UI, so it throws messages around willynillingly, like:
>
> searching for changes
> no changes found
>
> And they can't be turned off. Theoretically we could override
> mercurial's UI class, but I think that has the potential to create
> more problems, it's not worth at this point in time.

Oh, I totally agree with you _after_ reading that explanation.

You just shouldn't let me waste your time to explain that to me in
this exchange, and you could have done so by writing a clearer log
message.  That's all.

>
> Cheers.
