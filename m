From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Borrowing objects from nearby repositories
Date: Tue, 25 Mar 2014 15:17:07 -0700
Message-ID: <xmqqvbv1kjoc.fsf@gitster.dls.corp.google.com>
References: <BFF5FBC7-8F53-4958-8D56-90EADD3AD626@kellerfarm.com>
	<CACBZZX5teZuqtNkPT4PdXJn=g34cOhRH2oNehROT8kJ_M2cgfg@mail.gmail.com>
	<xmqqtxammctc.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Andrew Keller <andrew@kellerfarm.com>,
	Git List <git@vger.kernel.org>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 25 23:17:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WSZeq-0000Mp-Im
	for gcvg-git-2@plane.gmane.org; Tue, 25 Mar 2014 23:17:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755046AbaCYWRN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 25 Mar 2014 18:17:13 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34417 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755002AbaCYWRL convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 25 Mar 2014 18:17:11 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 68E9777686;
	Tue, 25 Mar 2014 18:17:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=mgoqY5LaiJOk
	FG9oDy0YNaGDEgU=; b=k42Q9KBrYjnP8ucGdTyWPGF6r1jFcVOsmQ+3ukhXgYu2
	7ta8uNHqg2Irh0xF0Ny4DtTNN8JpwzV3FdmTH/7m7soUp87hP038/PgP7IIn03ZJ
	vntyZkAH6z/FsMIMu+n7fDntniPVDG9mQGaaarKfj/kDwI705mV0BiCHWzy0YPQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=JbSJAe
	tkn9aQNKAE23S+adIyin/PLhbdyorcKQ3oj2elrAIbnj2+qhLr8bwKGbAZpJ8T+5
	rMU4VHcIGWudGPmfU27VQFDeelWkIE1TtzOZ9zbpQi09ituOaNVMjoxlrIinOqSg
	SB8xfPSmuAZdsllqrgGaqU4u4Mc0NqEV6ER7A=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 53B1677684;
	Tue, 25 Mar 2014 18:17:10 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7C81477682;
	Tue, 25 Mar 2014 18:17:09 -0400 (EDT)
In-Reply-To: <xmqqtxammctc.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Tue, 25 Mar 2014 10:02:23 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 35041534-B46B-11E3-A276-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245156>

Junio C Hamano <gitster@pobox.com> writes:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>>> 1) Introduce '--borrow' to `git-fetch`.  This would behave similarl=
y
>> to '--reference', except that it operates on a temporary basis, and
>> does not assume that the reference repository will exist after the
>> operation completes, so any used objects are copied into the local
>> objects database.  In theory, this mechanism would be distinct from
>> --reference', so if both are used, some objects would be copied, and
>> some objects would be accessible via a reference repository referenc=
ed
>> by the alternates file.
>>
>> Isn't this the same as git clone --reference <path> --no-hardlinks
>> <url> ?
>>
>> Also without --no-hardlinks we're not assuming that the other repo
>> doesn't go away (you could rm-rf it), just that the files won't be
>> *modified*, which Git won't do, but you could manually do with other
>> tools, so the default is to hardlink.
>
> I think that the standard practice with the existing toolset is to
> clone with reference and then repack.  That is:
>
>     $ git clone --reference <borrowee> git://over/there mine
>     $ cd mine
>     $ git repack -a -d
>
> And then you can try this:
>
>     $ mv .git/objects/info/alternates .git/objects/info/alternates.di=
sabled
>     $ git fsck
>
> to make sure that you are no longer borrowing anything from the
> borrowee.  Once you are satisfied, you can remove the saved-away
> alternates.disabled file.

Oh, I forgot to say that I am not opposed if somebody wants to teach
"git clone" a new option to copy its objects from two places,
(hopefully) the majority from near-by reference repository and the
remainder over the network, without permanently relying on the
former via the alternates mechanism.  The implementation of such a
feature could even literally be "clone with reference first and then
repack" at least initially but even in the final version.
