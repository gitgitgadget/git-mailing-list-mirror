From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 44/47] Remove all logic from get_git_work_tree()
Date: Wed, 22 Dec 2010 07:17:46 -0800
Message-ID: <7vd3ot6dlx.fsf@alter.siamese.dyndns.org>
References: <1290785563-15339-1-git-send-email-pclouds@gmail.com>
 <1290785563-15339-45-git-send-email-pclouds@gmail.com>
 <7vpqsu6059.fsf@alter.siamese.dyndns.org>
 <AANLkTikOOaKSf333UzawEgAf_=t-WBrWLu7tmiOrqO8V@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 22 16:18:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PVQS0-0005zO-KM
	for gcvg-git-2@lo.gmane.org; Wed, 22 Dec 2010 16:18:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753352Ab0LVPR4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 22 Dec 2010 10:17:56 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:40001 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752865Ab0LVPRz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 22 Dec 2010 10:17:55 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 997C72213;
	Wed, 22 Dec 2010 10:18:21 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=yZHo02kFAYl9
	dxI7SBDyqIA9GHA=; b=p5gZt7e68Z3kiTcU31Rp2BaKU8UXwRHRe6fw0FDyCTUp
	9+J55L4GGcWNUaw69cXWibwZsVvEeyNDLusggmIDH1KGp11yytc4LHVOf8ZCeQZ9
	Y3xZ+xLZLHdGyd8WHhHhr4lZZ+tVqDvdnN/t3q/hELRUQJulrbXPMYhQ0PDHrAM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=kXQhUg
	T6eKJqGUFbCSyg11odC4jdSeWK2JPGgoWvTmfwVMU/XzuY+JYehRMX9nHZ+SgtMC
	S+Umf3NojYrDIsPPIVwSkch0LCC6BCAnpbnm5THl4tTMGBBX8LAAMJFy28K0PqzZ
	dR0uZUAehZk60BnLNljV/MsW9OsoXRYw2Ka4Y=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 779C22211;
	Wed, 22 Dec 2010 10:18:19 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 8E0FD220D; Wed, 22 Dec 2010
 10:18:16 -0500 (EST)
In-Reply-To: <AANLkTikOOaKSf333UzawEgAf_=t-WBrWLu7tmiOrqO8V@mail.gmail.com>
 (Nguyen Thai Ngoc Duy's message of "Wed\, 22 Dec 2010 14\:22\:30 +0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: B52A1D4E-0DDE-11E0-B099-C4BE9B774584-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164089>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

> 2010/12/22 Junio C Hamano <gitster@pobox.com>:
>>> =C2=A0const char *get_git_work_tree(void)
>>> =C2=A0{
>>> - =C2=A0 =C2=A0 if (startup_info && !startup_info->setup_explicit) =
{
>>> -...
>>> - =C2=A0 =C2=A0 }
>>> =C2=A0 =C2=A0 =C2=A0 return work_tree;
>>> =C2=A0}
>>
>> Would it be a bug in the new set-up code if this function gets calle=
d and
>> work_tree is still NULL?
>>
>> There are quite a few callers that call get_git_work_tree() and expe=
ct
>> that it will always return a non NULL pointer. =C2=A0Perhaps we woul=
d want an
>> assertion here?
>>
>
> While the assertion sounds good, it does not work well. The old
> function can return NULL in bare repos. is_bare_repository() and
> is_inside_work_tree() expect NULL from get_git_work_tree() sometimes.

Ok, don't bother changing anything in that case---it won't help us much=
=2E
