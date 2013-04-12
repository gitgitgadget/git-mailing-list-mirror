From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 3/7] completion: add new __gitcompadd helper
Date: Fri, 12 Apr 2013 11:51:30 -0700
Message-ID: <7v7gk7eg5p.fsf@alter.siamese.dyndns.org>
References: <1365577077-12648-1-git-send-email-felipe.contreras@gmail.com>
 <1365577077-12648-4-git-send-email-felipe.contreras@gmail.com>
 <7vli8neiqi.fsf@alter.siamese.dyndns.org>
 <CAMP44s2rE2nniJhC_ZpsdNbp5uZ=tCo+wV6ygth2R5xiVTN=ng@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	SZEDER =?utf-8?Q?G?= =?utf-8?Q?=C3=A1bor?= <szeder@ira.uka.de>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 12 20:51:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQj4W-0000g0-65
	for gcvg-git-2@plane.gmane.org; Fri, 12 Apr 2013 20:51:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752832Ab3DLSvg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Apr 2013 14:51:36 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55077 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752491Ab3DLSvf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Apr 2013 14:51:35 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C3E35160D8;
	Fri, 12 Apr 2013 18:51:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=H9lTlJabybRCYq15G4QhD4MYyYg=; b=WQitAc
	eEqoGdgp4WWtb2vBoLer0L8P7dnSiUOW99jVEBaLzCV6YXSSe9baOh1++LD1KfWX
	UtbZsH32bRNjiybqrvqnFwnnZOdxlzy9FU6PvZrkRFgdssyBAqgrDOQp5uj5Q6Xq
	RdYC21te4XLc2CQDKmPyalPCokwAl7WZbDsoI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=AP31BNpcihF0GhSeHKjXW8u1qfnmaVN8
	wFVAak/0I5OlhvE8zeKxCDwTcspN2UPk0xQ9NaoKRpiCbTknrUulIlY1KwP11ZyS
	pvwMEX4SpmdyE+OBN52xnIwJyLiCPAUi5XutFM1/fnlOth6tNNho8XAT1S2PmFxn
	Y39Fv+q1sUw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BB148160D7;
	Fri, 12 Apr 2013 18:51:32 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3D520160D5; Fri, 12 Apr
 2013 18:51:32 +0000 (UTC)
In-Reply-To: <CAMP44s2rE2nniJhC_ZpsdNbp5uZ=tCo+wV6ygth2R5xiVTN=ng@mail.gmail.com> (Felipe
 Contreras's message of "Fri, 12 Apr 2013 13:47:15 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FE188F3A-A3A1-11E2-A88F-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221012>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> On Fri, Apr 12, 2013 at 12:55 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>>>  }
>>>
>>>  # Generates completion reply with compgen from newline-separated possible
>>> @@ -1820,7 +1823,7 @@ _git_config ()
>>>               local remote="${prev#remote.}"
>>>               remote="${remote%.fetch}"
>>>               if [ -z "$cur" ]; then
>>> -                     COMPREPLY=("refs/heads/")
>>> +                     __gitcompadd "refs/heads/"
>>
>> I am not sure about this one, though.
>>
>> Other callers took pains to protet against triggering unset variable
>> references by using ${1-} instead of ${1}.  Shouldn't this caller be
>> passing three empty strings?
>
> Perhaps, or perhaps we were being too careful before: 'compgen -W foo'
> is the same as 'compgen -W foo -S "" -P "" -- ""'.

Yes, they are the same (otherwise this patch would not be valid),
but that is not what i was wondering about.
