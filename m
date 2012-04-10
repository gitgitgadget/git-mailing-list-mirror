From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] list-objects: perform NULL check before the variable is
 dereferenced
Date: Mon, 09 Apr 2012 17:09:02 -0700
Message-ID: <7vbon0tplt.fsf@alter.siamese.dyndns.org>
References: <1333968311-29889-1-git-send-email-pclouds@gmail.com>
 <7v7gxowxfh.fsf@alter.siamese.dyndns.org>
 <CACsJy8ASo8j+hmJ7Kw2uLcD9cS8SXc6yOoc5GDUcFHYk9W9a_g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 10 02:09:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SHOe0-0004rJ-H3
	for gcvg-git-2@plane.gmane.org; Tue, 10 Apr 2012 02:09:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758160Ab2DJAJH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 9 Apr 2012 20:09:07 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47423 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752984Ab2DJAJF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 9 Apr 2012 20:09:05 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 076CD6153;
	Mon,  9 Apr 2012 20:09:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=GgGi2Q1IahjE
	KQFWBdPJ7hbP+xA=; b=Um+Znb3rmx4HpgSkFYJB7Nn2atOM2Eh7llBK/yx654YT
	Qu4CkJl2WQWBhI5MAFAbTix66zO4dfoq4QJ272pt729VLnxMWx/VJQNrwT+zNWbT
	E04ciBuzbVA+TkEoSmAFlqKscFZ6l1B7acR42u0xiv25rtgJW1W6ND3SURczuDw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=krbjc/
	765Qhx/90WxHI3Cx4OVEPj44l/+hP8+w3aAzbgtW+K+cNvtRXz/0o3rGGhRruokk
	N4lpCtEjJrX+OG3Prr+jE2sTNXmQoPCggEwldrbExkikHvq7YfigoWLYREQfKTbn
	qV1I6epipOqX8WuAhi3DjZ6c2RE9kDNYljl4w=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F28006152;
	Mon,  9 Apr 2012 20:09:03 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 866806150; Mon,  9 Apr 2012
 20:09:03 -0400 (EDT)
In-Reply-To: <CACsJy8ASo8j+hmJ7Kw2uLcD9cS8SXc6yOoc5GDUcFHYk9W9a_g@mail.gmail.com> (Nguyen
 Thai Ngoc Duy's message of "Tue, 10 Apr 2012 06:47:17 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 618A1034-82A1-11E1-B60D-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195047>

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

Please try again when post 1.7.10 cycle opens.

Thanks.
