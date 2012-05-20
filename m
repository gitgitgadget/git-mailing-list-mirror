From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] grep: support newline separated pattern list
Date: Sun, 20 May 2012 15:29:44 -0700
Message-ID: <7vobpia3l3.fsf@alter.siamese.dyndns.org>
References: <CAEV-rjc0PtuQZei95_24=Ou=mZZxA0Lsr6boXGrGy3z40otkNQ@mail.gmail.com>
 <4FB6426C.7040202@lsrfire.ath.cx>
 <CAEV-rjd=WjLu8e+UCnAHVxg7DTLWe+YrEO_Gs2rh5Oy1=KA5sw@mail.gmail.com>
 <4FB900A3.9050309@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Torne \(Richard Coles\)" <torne@google.com>, git@vger.kernel.org
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Mon May 21 00:29:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SWEdO-0000wP-41
	for gcvg-git-2@plane.gmane.org; Mon, 21 May 2012 00:29:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756851Ab2ETW3t convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 20 May 2012 18:29:49 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41476 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755099Ab2ETW3s convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 20 May 2012 18:29:48 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AB9FD8BE4;
	Sun, 20 May 2012 18:29:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=9qg26Skx0xBS
	mSOw3X6/6dfWeFI=; b=pVi11B1CQjofmw3orKHreNc3snWOU4NrJm1yNPbav0lr
	9PRCiTEfD1pO3Neo9GvSI4JLKWepTvhMlE5TfsqQ+IfYVg+wMEFnwkEYm0UZ9E1O
	QPcmvTVRedzJoEY081RqkwpWDD/5lmoAaSqrL35do/mRWXkdvLomVQjcW6cmLCo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=WCHRMS
	aL6z3Ir51vPKlmmjvI7xHeyIGNDAJjTgUUumti5mQNPXYwtnDkJCv4KoRH0Iinkn
	VeLXVmECihLaRyCzax2c2pjzZhibrqweARvFE0z/wdCdTHGsiNyruc1dyBGIV8la
	+DiFXwLYQsVwOvxagbNA+FZ0RopSytwAXvoCw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A38528BE3;
	Sun, 20 May 2012 18:29:46 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 385CB8BE2; Sun, 20 May 2012
 18:29:46 -0400 (EDT)
In-Reply-To: <4FB900A3.9050309@lsrfire.ath.cx> (=?utf-8?Q?=22Ren=C3=A9?=
 Scharfe"'s message of "Sun, 20 May 2012 16:33:07 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4DA2F7C6-A2CB-11E1-8E83-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198072>

Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx> writes:

> Currently, patterns that contain newline characters don't match anyth=
ing
> when given to git grep.  Regular grep(1) interprets patterns as lists=
 of
> newline separated search strings instead.
>
> Implement this functionality by creating and inserting extra grep_pat
> structures for patterns consisting of multiple lines when appending t=
o
> the pattern lists.  For simplicity, all pattern strings are duplicate=
d.
> The original pattern is truncated in place to make it contain only th=
e
> first line.

Thanks for a fix; I am assuming that the duplication for simplicity is =
not
for simplified allocation but primarily for a simpler freeing?
