From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] pack-refs: remove all empty directories under
 $GIT_DIR/refs
Date: Sat, 11 Feb 2012 09:59:12 -0800
Message-ID: <7vd39lmetr.fsf@alter.siamese.dyndns.org>
References: <1328891127-17150-1-git-send-email-pclouds@gmail.com>
 <1328946907-31650-1-git-send-email-pclouds@gmail.com>
 <7vhayxn5cg.fsf@alter.siamese.dyndns.org>
 <CACsJy8Bh=FZ6kNN5hERK5_H7XnZ83BZ_EfsZ5XmJbrnn+CfgcQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 11 18:59:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RwHEa-0007N1-MJ
	for gcvg-git-2@plane.gmane.org; Sat, 11 Feb 2012 18:59:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752984Ab2BKR7Q convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 11 Feb 2012 12:59:16 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48338 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751940Ab2BKR7P convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 11 Feb 2012 12:59:15 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D18446B8E;
	Sat, 11 Feb 2012 12:59:14 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=dEXPkjw4+bvg
	MaxIfLGKbu/mh/g=; b=O4fpbyzAX0r21mKLU0ccBFKfkhK23NNaI8mdWSBI1xb8
	9G7OC+79AYHkMFDF8OX7DJcBlHwbh+XJknkmTuO1wvkmPKvPjlWGvHHf3j6kUBA2
	yR26NyfkU6GNl1ZzXBsz5nLxMuTFojo67cSo0a4xYg9yijqqrFC330abpXtJkdY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=UU8sAh
	CD+QKaW9jZtzMnKvheFAjwhDzB8Ybgce1ZC+itMr8HhXPF2bShQo+CDXKnFQCdXs
	XUSDEz2AqmNnD49+E8I5uc2u/KcXXMKX0dKCkAo4bP0WgDbhAfeo/j+CWUn0levF
	p6xT97nWg5Q594yM1B1uvCDz/eo6M7B0qKdQ4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C83D86B8D;
	Sat, 11 Feb 2012 12:59:14 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5E1D56B8B; Sat, 11 Feb 2012
 12:59:14 -0500 (EST)
In-Reply-To: <CACsJy8Bh=FZ6kNN5hERK5_H7XnZ83BZ_EfsZ5XmJbrnn+CfgcQ@mail.gmail.com> (Nguyen
 Thai Ngoc Duy's message of "Sat, 11 Feb 2012 15:55:31 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1BCEBBCA-54DA-11E1-B34B-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190521>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

> 2012/2/11 Junio C Hamano <gitster@pobox.com>:
>> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com> writes=
:
> ...
>> Would it make more sense to note the
>> directory for which rmdir() fails in try_remove_empty_parents(), and
>> revisit only these directories, at least?
>
> That would leave empty directories not sharing the ref's path until
> the failed rmdir() unexamined, I think.

True. Thanks.

>>> +     subpath =3D xmalloc(pathlen + 257);
>>
>> What is this 257 about?
>
> This function is a ripoff from get_ref_dir(). I think 257 is 255 belo=
w
> plus '/' and NIL.

I do not think there is any justification to copy-and-paste from code t=
hat
predates the strbuf infrastructure these days.
