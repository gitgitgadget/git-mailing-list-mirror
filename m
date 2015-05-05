From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG] deamon.c does not compile when NO_IPV6 is used
Date: Tue, 05 May 2015 10:55:47 -0700
Message-ID: <xmqqioc6ewnw.fsf@gitster.dls.corp.google.com>
References: <CAK4aQQJ9yT8+Q9jPQ78cauhyPj3j5WmpgrQJ5=cA-ECjaWn8BQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Eduardo Espejo <eduardo.espejo@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 05 19:56:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yph4m-0000LQ-5m
	for gcvg-git-2@plane.gmane.org; Tue, 05 May 2015 19:56:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762301AbbEER4F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 May 2015 13:56:05 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:57273 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1762283AbbEERzt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 May 2015 13:55:49 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 39CE44D7B0;
	Tue,  5 May 2015 13:55:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=LIF23Xdl2nod5rM9/gfYa5Z9kLI=; b=vt2S1N
	g2lQjF4ZYblUFNx2RntxRr4JCcLHtBb556SgiI/T0jnLg1IBIU37bGqN553SxMEW
	4VWRZw0bdiZGSqSo4T6fcy9NfbdjYXLhceERDSz52flWfwfChsUhbDYb6h7rR14r
	Fu5dlcGmtsFLs4y+SvMJto8hESK2zHtI0r8tY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ScLZW+u7V9Z7+qiXdNGhvXU4nWFf0THf
	tQoFkvPjcZFeZaFXBCw/9Nhlada6apTrZ7OI/xT6kXLPNe1luKCjsMowskM2adyy
	2xu1ZvjMRquadZJhc7xQBOjqqXmZ5P62rtoKq7tmnbk8KcUketG9MmoPKjwhYKlJ
	oogWg4IjPAA=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 30DA34D7AF;
	Tue,  5 May 2015 13:55:49 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8E4794D7AE;
	Tue,  5 May 2015 13:55:48 -0400 (EDT)
In-Reply-To: <CAK4aQQJ9yT8+Q9jPQ78cauhyPj3j5WmpgrQJ5=cA-ECjaWn8BQ@mail.gmail.com>
	(Eduardo Espejo's message of "Tue, 5 May 2015 09:20:15 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: F62BD67E-F34F-11E4-B9DE-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268408>

Eduardo Espejo <eduardo.espejo@gmail.com> writes:

> Tested in 2.4 commit 3d4a3ffe64:
>
> daemon.c:636:24: error: use of undeclared identifier 'hostname'
>                 hent = gethostbyname(hostname.buf);

Thanks.  It seems nobody actively interested in developing Git
builds with NO_IPV6 these days?

Does this help?

 daemon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/daemon.c b/daemon.c
index ac2bc85..d3d3e43 100644
--- a/daemon.c
+++ b/daemon.c
@@ -633,7 +633,7 @@ static void lookup_hostname(struct hostinfo *hi)
 		char **ap;
 		static char addrbuf[HOST_NAME_MAX + 1];
 
-		hent = gethostbyname(hostname.buf);
+		hent = gethostbyname(hi->hostname.buf);
 		if (hent) {
 			ap = hent->h_addr_list;
 			memset(&sa, 0, sizeof sa);
