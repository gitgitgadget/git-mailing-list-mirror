From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 6/6] t3001: note about expected "**" behavior
Date: Thu, 04 Oct 2012 11:04:06 -0700
Message-ID: <7vobkiyuzt.fsf@alter.siamese.dyndns.org>
References: <7v626q3hen.fsf@alter.siamese.dyndns.org>
 <1349336392-1772-1-git-send-email-pclouds@gmail.com>
 <1349336392-1772-7-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 05 01:12:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TJtey-00033L-IS
	for gcvg-git-2@plane.gmane.org; Fri, 05 Oct 2012 00:12:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751154Ab2JDSEK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 4 Oct 2012 14:04:10 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33502 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750811Ab2JDSEI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 4 Oct 2012 14:04:08 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7DEC78516;
	Thu,  4 Oct 2012 14:04:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=XFJKyTVop+ab
	yYhrd/vvDVfWCBY=; b=AiJ5VtJ8SgdsDe8sMueIQO1CFZWmas5+N65u4rlJAceM
	yCF0COrjy9zBYb0kQtf0SIhqGEwof/cCJXVvwbuLYsPO6S++YvBEccH4EsgQNNWE
	Kob97Q2mqPiFt+H1nzGQyWlTHJTJUZr1ydZvaf+2w1L24pequ6dQXxtrHM2PaDg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=R4sOqp
	Mj9ADRO6excoy3lG87KlxNN2j620saqjxyYoNIcfBDl9/bcf27Gxb1r9zW8UxALu
	yshanrwV+iKJn/Php2LFk1ObnudtD0zMfv95DCB/U9FIH8IJ2mzuOOT70P82FZ6G
	rrWRTY/ChoO2rAte9QBon49m+PhWkKhHvd5u0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6B4C38514;
	Thu,  4 Oct 2012 14:04:08 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DBC5F8512; Thu,  4 Oct 2012
 14:04:07 -0400 (EDT)
In-Reply-To: <1349336392-1772-7-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Thu, 4 Oct
 2012 14:39:52 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E43E136C-0E4D-11E2-A366-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207048>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com> writes:

> "**" currently matches any characters including slashes. It's probabl=
y
> too powerful. A more sensible definition may be match any characters
> that the but the whole match must be wrapped by slashes. So "**" can
> match none, "/", "/aaa/", "/aa/bb/" and so on but not "aa/bb".

I do not think this is something we want to retroactively change
after releasing it to the public, especially when we _know_ it is a
problem from the get-go (unlike the case we did not notice it had a
problem, release it to the public and then realize it and have to
scramble to devise a fix to bring more sanity in a backward
compatible way).

We must either declare that "**" that matches any characters is the
sane semantics and promise we will never change it, or have "**"
that matches \(/[^/]*\)*/ (sorry for a line noise^W^W^Wregexp) from
the beginning.
