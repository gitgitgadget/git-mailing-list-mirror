From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] add: refuse to add paths beyond repository
 boundaries
Date: Tue, 09 Apr 2013 12:10:04 -0700
Message-ID: <7vsj2zr04z.fsf@alter.siamese.dyndns.org>
References: <CALkWK0m_82ThYKxcr=YHGBnOaHr9yBpYFHxx2KrnQkWD_zjp1A@mail.gmail.com>
 <1365499297-8667-1-git-send-email-artagnon@gmail.com>
 <1365499297-8667-3-git-send-email-artagnon@gmail.com>
 <7v4nfftyu3.fsf@alter.siamese.dyndns.org>
 <7vvc7vsj4p.fsf@alter.siamese.dyndns.org> <51645EC6.407@gmail.com>
 <7v61zvsfkj.fsf@alter.siamese.dyndns.org> <516464E4.10503@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Jeff King <peff@peff.net>, Duy Nguyen <pclouds@gmail.com>,
	Git List <git@vger.kernel.org>
To: Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 09 21:10:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPdw4-0002HO-Ip
	for gcvg-git-2@plane.gmane.org; Tue, 09 Apr 2013 21:10:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935677Ab3DITKS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 9 Apr 2013 15:10:18 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48815 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935700Ab3DITKG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 9 Apr 2013 15:10:06 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6E74815B91;
	Tue,  9 Apr 2013 19:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=uDayTIzsDGUF
	w4PnYztU+NhmpSk=; b=Z6mjPZJlbTCR2RDgzL1U51MIcxoPbcI/O7+iDSDvTStK
	tpkn1TEYgqqqkWyXUWcwZft6TTkQ2mPJW7CwO18EWgSsmFwdVkAHRIptto9wAxnq
	/kGsI4bBj7nzP6B7FLtOp7pgMGOUbJxA/mFSwEdSO0KlAl+WEMB6MH+yxQUBJdE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=lIvV42
	vrO4zg6KpMbrYP0Cq4jE24sA4K8agsOVbqTEvExrk9FVzQvJI/J1LaEX6wOIfd8N
	v+wi73VE/MPYK4ikeWHYxEK2BLhrG9AnGOCPULdfDiGg3qMaTA68fHQOE4KkrBDi
	jXq8Y13IYfQ4nYaUiQUQJZ26o47RFVwvkTO4Q=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6569B15B90;
	Tue,  9 Apr 2013 19:10:06 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C1E9515B8E; Tue,  9 Apr
 2013 19:10:05 +0000 (UTC)
In-Reply-To: <516464E4.10503@gmail.com> ("Jakub =?utf-8?Q?Nar=C4=99bski=22?=
 =?utf-8?Q?'s?= message of "Tue, 09 Apr 2013 20:58:44 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 16940BBC-A149-11E2-AE8B-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220618>

Jakub Nar=C4=99bski <jnareb@gmail.com> writes:

> Junio C Hamano wrote:
>> Jakub Nar=C4=99bski <jnareb@gmail.com> writes:
>>=20
>>> W dniu 09.04.2013 19:34, Junio C Hamano pisze:
>>>
>>>> -	if (has_symlink_leading_path(path, len))
>>>> -		return error("'%s' is beyond a symbolic link", path);
>>>> +	if (path_outside_our_project(path, len))
>>>> +		return error("'%s' is outside our working tree", path);
>>>> =20
>>>
>>> Don't we lose important information here?  Or we shouldn't care?
>>=20
>> What important information is it?
>
> That the cause is symbolic link (or other git repository, in the futu=
re).

And in what way is it important?
