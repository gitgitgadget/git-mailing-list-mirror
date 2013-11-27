From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 15/28] fetch: add --update-shallow to get refs that require updating .git/shallow
Date: Wed, 27 Nov 2013 11:04:35 -0800
Message-ID: <xmqqa9gpu0n0.fsf@gitster.dls.corp.google.com>
References: <1385351754-9954-1-git-send-email-pclouds@gmail.com>
	<1385351754-9954-16-git-send-email-pclouds@gmail.com>
	<CAPig+cRMj_RY53--OLDmonZLzhzf0Cu+JrDc8LAicSn5QGKNyQ@mail.gmail.com>
	<CACsJy8CJRzCVzJ7LfEY_2Gxzq=96BB44UQUeMD0R-a6buYNu4A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 27 20:04:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VlkPj-0006n9-NR
	for gcvg-git-2@plane.gmane.org; Wed, 27 Nov 2013 20:04:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754103Ab3K0TEk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 27 Nov 2013 14:04:40 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59145 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753275Ab3K0TEj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Nov 2013 14:04:39 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3D59C558AE;
	Wed, 27 Nov 2013 14:04:39 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=m2//pQ/ja2SF
	t2oa/QuwZ9AMPzQ=; b=rfNbOvWVMjYboo4FCZNONpkZbldhdvl4Bb0Yf7PN94Y2
	N5840TDJrXvE3cr3NEvwNyiaeKT6EErVvQPd4q4ucoDh0ATujmSr8L4FAls8jAfx
	Tqyood3TO3JuXo2KTY+N8xMMofhpTvOCnVr92Md+ScC5tKwEUXtQ7slkDkbiMkc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=dmZvWI
	GzWa5BIc1EjwKoeEyk3cLnOsy+WsNrh2DGMI1DxFrbvF0AXWEYov0QKIG778pyld
	IHN59UC467ejOgu/vlUSK8Kopsz04dUMrf96RkcD7HH0fj/bwhI/PQepAayrTMJU
	SZLvrH9wPu/T1cLLBUw0tgyCfSE/VfjHsg3/U=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2E50D558AD;
	Wed, 27 Nov 2013 14:04:39 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7C5EA558AC;
	Wed, 27 Nov 2013 14:04:38 -0500 (EST)
In-Reply-To: <CACsJy8CJRzCVzJ7LfEY_2Gxzq=96BB44UQUeMD0R-a6buYNu4A@mail.gmail.com>
	(Duy Nguyen's message of "Wed, 27 Nov 2013 19:54:14 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: C35659B4-5796-11E3-A5D6-D331802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238453>

Duy Nguyen <pclouds@gmail.com> writes:

> On Wed, Nov 27, 2013 at 8:53 AM, Eric Sunshine <sunshine@sunshineco.c=
om> wrote:
>> On Sun, Nov 24, 2013 at 10:55 PM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8D=
c Duy
>> <pclouds@gmail.com> wrote:
>>> diff --git a/t/t5536-fetch-shallow.sh b/t/t5536-fetch-shallow.sh
>>> index e011ead..95b6313 100755
>>> --- a/t/t5536-fetch-shallow.sh
>>> +++ b/t/t5536-fetch-shallow.sh
>>> @@ -141,4 +141,26 @@ EOF
>>>         )
>>>  '
>>>
>>> +test_expect_success 'fetch --update-shallow' '
>>> +       (
>>> +       cd notshallow &&
>>> +       git fetch --update-shallow ../shallow/.git refs/heads/*:ref=
s/remotes/shallow/* &&
>>> +       git fsck &&
>>> +       git for-each-ref --format=3D"%(refname)" |sort >actual.refs=
 &&
>>
>> Exit status of git-for-each-ref could be lost down the pipe.
>
> I think it's ok. If for-each-ref is broken or something the final
> output in actual.refs will be different anyway.

You can tell for-each-ref to sort its output in a way you specify,
no?
