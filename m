From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] list-objects: perform NULL check before the variable is
 dereferenced
Date: Mon, 09 Apr 2012 17:09:12 -0700
Message-ID: <7vaa2ktplj.fsf@alter.siamese.dyndns.org>
References: <1333968311-29889-1-git-send-email-pclouds@gmail.com>
 <7v7gxowxfh.fsf@alter.siamese.dyndns.org>
 <CACsJy8ASo8j+hmJ7Kw2uLcD9cS8SXc6yOoc5GDUcFHYk9W9a_g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 10 02:09:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SHOeA-0004uZ-KM
	for gcvg-git-2@plane.gmane.org; Tue, 10 Apr 2012 02:09:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758222Ab2DJAJR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 9 Apr 2012 20:09:17 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47477 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752984Ab2DJAJQ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 9 Apr 2012 20:09:16 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3288E615C;
	Mon,  9 Apr 2012 20:09:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=wD3+JC9s+t/s
	TtV/DeRZwOQ579o=; b=jR5ZSSHcMOMPTpiVJ2QKzSIk0MaSeGeVMvjQ3uS0ixrL
	dn/qh9cbE49sriMvZu5G3ylAeDn9MDkbFyBI4V3HuM8Nd9NA9U4ogUB4mPiZbNsp
	sI4y18jlDpHJBj3A6iJKfUVCTN80FSu0ppdA2/u6/+AO3NQoXKzUIT0ZSFU4RZw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=AbolIT
	JvZwLOXPRKC1NQEgDf8znoPv9yUYS4RBvtwBX29pRyw5ugVVCqeHLDJyjV7GjSJn
	VUOTrZbbrss+QJKgLZ5lDfKy9PuPIVT7DiaTb3AgFFNNjczsy9lWk/nrt6/Qugxc
	+ydY6c4fOowpTOdWN7kdlH6hZXlKRTlMUkt+k=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2986A615B;
	Mon,  9 Apr 2012 20:09:16 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A3F836159; Mon,  9 Apr 2012
 20:09:14 -0400 (EDT)
In-Reply-To: <CACsJy8ASo8j+hmJ7Kw2uLcD9cS8SXc6yOoc5GDUcFHYk9W9a_g@mail.gmail.com> (Nguyen
 Thai Ngoc Duy's message of "Tue, 10 Apr 2012 06:47:17 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 682ACF00-82A1-11E1-9FB1-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195048>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

> 2012/4/10 Junio C Hamano <gitster@pobox.com>:
>> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy =C2=A0<pclouds@gmail.com> =
writes:
>>
>>> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@g=
mail.com>
>>> ---
>>> =C2=A0list-objects.c | =C2=A0 10 ++++++----
>>> =C2=A01 files changed, 6 insertions(+), 4 deletions(-)
>>
>> Please explain why this is needed?
>>
>> I can see that process_blob() is called from process_tree() which pa=
sses
>> the return value from lookup_blob(entry.sha1) directly without looki=
ng at
>> it. =C2=A0lookup_blob() can issue an error message and return NULL i=
f there is
>> a SHA-1 collision with an object that is not a blob.
>
> to avoid segmentation fault in that case, if "blob" is NULL, it dies
> at blob->object anyway and the check "if (!obj)" is useless.

Well, I didn't mean that you should explain whatever to _me_ as a
response; I meant that the log message should explain that to future
readers. I thought you have been here long enough to know that ;-)

Also "check NULL before dereferencing" means "avoid segmentation fault"=
,
so that is not the primary thing that needs to be explained.  The point=
 is
to explain why and how a NULL could come into the codepath in the first
place.

Please try again when the post-1.7.10 cycle opens.

Thanks.
