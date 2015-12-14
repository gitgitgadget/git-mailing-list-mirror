From: Junio C Hamano <gitster@pobox.com>
Subject: Re: compile error in Git v2.7.0-rc0
Date: Mon, 14 Dec 2015 12:35:25 -0800
Message-ID: <xmqqvb80ix9u.fsf@gitster.mtv.corp.google.com>
References: <CALibRqFajuBuv9ooaBWL1kUzaVps2WfodqucyHni2ggv6JpwDg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitter.spiros@gmail.com
To: johan defries <johandefries@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 14 21:35:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a8ZqQ-0004cY-9J
	for gcvg-git-2@plane.gmane.org; Mon, 14 Dec 2015 21:35:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932080AbbLNUfi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 14 Dec 2015 15:35:38 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:55422 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752900AbbLNUfh convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Dec 2015 15:35:37 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 2E5D33367C;
	Mon, 14 Dec 2015 15:35:36 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=AWin90QI9E8N
	Lb8xDBKZFw8hFfE=; b=IIxG5c9fU7Z6h+uxEHaM5AIt6XmmCCUU5GoY2uYYybcC
	biUxjsuG4xfuGFxYWpjddSOs/AJLilmmU75rS3Yeob2jjIhaHDkhVmeruZQ22UfV
	TbGrEfOjgOlo0jssqYFzGMddVBV/CNPMFF+2PQUafSqJaZu//caYEZ+4+EaCvFs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=FakjeI
	8CQhS0qMOJ5K8Qr0wpsh9WceRu80kis0XqVBLWsqqKnla0BzFoKT59NcS8QYWHPC
	2ZjL1Q4GQ3TU4+EVAQ3oJtzxZbA+18yXHJRTuDcesbLXoeuSyZF6eJdSOhFofI7a
	7Teo21vnoOimVKu3YRfZ6TL3BXhe1JhiSvv8w=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 263F13367B;
	Mon, 14 Dec 2015 15:35:36 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 940243367A;
	Mon, 14 Dec 2015 15:35:35 -0500 (EST)
In-Reply-To: <CALibRqFajuBuv9ooaBWL1kUzaVps2WfodqucyHni2ggv6JpwDg@mail.gmail.com>
	(johan defries's message of "Mon, 14 Dec 2015 21:28:52 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 3A98F768-A2A2-11E5-9D9F-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282402>

johan defries <johandefries@gmail.com> writes:

> Probably because I have NO_IPV6 defined.
>
> ident.c: In function =E2=80=98canonical_name=E2=80=99:
> ident.c:89:37: error: =E2=80=98buf=E2=80=99 undeclared (first use in =
this function)
>   struct hostent *he =3D gethostbyname(buf);
>                                      ^
> ident.c:89:37: note: each undeclared identifier is reported only once
> for each function it appears in
> make: *** [ident.o] Fout 1

Thanks.  This should perhaps do?

 ident.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/ident.c b/ident.c
index 4e7f99d..2900879 100644
--- a/ident.c
+++ b/ident.c
@@ -86,6 +86,7 @@ static int canonical_name(const char *host, struct st=
rbuf *out)
 		freeaddrinfo(ai);
 	}
 #else
+	char buf[1024];
 	struct hostent *he =3D gethostbyname(buf);
 	if (he && strchr(he->h_name, '.')) {
 		strbuf_addstr(out, he->h_name);
