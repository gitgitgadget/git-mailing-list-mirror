From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Do not fetch tags on new shallow clones
Date: Wed, 04 Jan 2012 15:59:04 -0800
Message-ID: <7vwr97nho7.fsf@alter.siamese.dyndns.org>
References: <1325676922-6995-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 05 00:59:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Riaji-0003RJ-54
	for gcvg-git-2@lo.gmane.org; Thu, 05 Jan 2012 00:59:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757407Ab2ADX7J convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 4 Jan 2012 18:59:09 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35485 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757298Ab2ADX7I convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 4 Jan 2012 18:59:08 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 58EE466B4;
	Wed,  4 Jan 2012 18:59:07 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=ysjgvgW4BgnW
	VC+EN2spn7m8r6U=; b=OKybmRyE1Y2uoYAIWYlM1mmh6ymGYs5vw83RrL0Z7Xnz
	v+jJ8/a3ma7R7PjpsC0yZKw3nHANDgD6PS60NirliWhewjHjJTfWd41k3ZC9RNJa
	9T254v/ETp4QQScTYg5mTm3FpBd/wBIq6jTNseui4Uyc/BWWF0peV6No+qGQ3ok=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=B/2n/b
	Pd9dNsziWAMMFM5f+2homuGxldn3QHPxPoVgRx4Joke0AbJMYa4yrgb4a0i3mm33
	w71d8Y0fMm23Ok6LC5mFPhXmdYosszegZqnQys79d4f6wIdGBh3uycmboAOVpu+I
	EBVoOjAbgF9rHth1IqfAMtF705kvVHI98zUy8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4FEFF66B2;
	Wed,  4 Jan 2012 18:59:07 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5FE3D66B1; Wed,  4 Jan 2012
 18:59:06 -0500 (EST)
In-Reply-To: <1325676922-6995-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Wed, 4 Jan
 2012 18:35:22 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 15F3028C-3730-11E1-B794-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187954>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

>  This could also be applied for normal clones. But I don't think
>  there are many use cases for it, enough to deserve new --no-tags
>  option.

Correct.

>  We should also fetch a single branch, but because branches are
>  usually less crowded and stay close the tip, they do not produce too
>  many extra objects. Let's leave it until somebody yells up.

Probably this is needed.

>  We should also fetch tags that reference to downloaded objects.

I do not think this has much merit. The usual tag-following rules AFAIK
assumes that if you have the commit C then you ought to have all the
ancestors of C, which does not apply at all for the shallow hack to beg=
in
with, and if you make the rule apply for the shallow hack, you would en=
d
up slurping the objects that are needed only for ancient versions, whic=
h
would defeat the objective of this patch, no?

It also is my understanding that the shallow hack is almost always used
with a depth of one, not a range, like "git archive | tar xf -", so if
anything, I would say a single-branch cloning has much higher priority
than following tags.

Will queue on 'pu'. Thanks.
