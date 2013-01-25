From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [regression] Re: [PATCHv2 10/15] drop length limitations on
 gecos-derived names and emails
Date: Fri, 25 Jan 2013 10:46:48 -0800
Message-ID: <7vtxq53xt3.fsf@alter.siamese.dyndns.org>
References: <20120521230917.GA474@sigill.intra.peff.net>
 <20120521231017.GJ10981@sigill.intra.peff.net>
 <20130124232146.GA17458@google.com>
 <20130125010559.GA27657@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Angus Hammond <angusgh@gmail.com>, git@vger.kernel.org,
	Mihai Rusu <dizzy@google.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jan 25 19:47:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TyoIz-0004o2-MJ
	for gcvg-git-2@plane.gmane.org; Fri, 25 Jan 2013 19:47:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756222Ab3AYSqx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jan 2013 13:46:53 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47768 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756049Ab3AYSqv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jan 2013 13:46:51 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F060EB1B1;
	Fri, 25 Jan 2013 13:46:50 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=cMAjhD78C2IM+KAm5mIf00DSbvk=; b=u13NMn
	cNr9lrttLgpDbD0lEcPkS1JD5fsbcFxl3Utv2GFn/pbyCKzktP0ivywAvUKFL6Py
	c4Hbyb0MAGnv81cyb3dxegGBFZT2PMX8zjUGIVa5A/I6u5jSe4+U7Vf5B3IGcsVv
	KPxx9XdRyRiXVCnEx1wEImWwoRcgYsBIPpy/8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ijLycjDYQefxAKKlukSe5f7GiBm2LZs8
	5yEzkX+36VUYoL4JEA6uKYU5iVxT/69wnAdQ7msAPke+n6g60R32YUDHqIRcrNF6
	ZgoSJVce1S5RGjbX6+o2diU31xoh5bl99skgypLoyIiEMz+D6BfeRbSpv/IQt617
	b3KizL8Tb9I=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E3E1FB1B0;
	Fri, 25 Jan 2013 13:46:50 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 735E7B1AF; Fri, 25 Jan 2013
 13:46:50 -0500 (EST)
In-Reply-To: <20130125010559.GA27657@sigill.intra.peff.net> (Jeff King's
 message of "Thu, 24 Jan 2013 20:05:59 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9455667C-671F-11E2-A6A0-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214567>

Jeff King <peff@peff.net> writes:

> (with a proper commit message, of course).

Will queue this one, to be merged to 'maint' and 'master'.

-- >8 --
From: Jonathan Nieder <jrnieder@gmail.com>
Date: Thu, 24 Jan 2013 15:21:46 -0800
Subject: [PATCH] ident: do not drop username when reading from /etc/mailname

An earlier conversion from fgets() to strbuf_getline() in the
codepath to read from /etc/mailname to learn the default host-part
of the ident e-mail address forgot that strbuf_getline() stores the
line at the beginning of the buffer just like fgets().

The "username@" the caller has prepared in the strbuf, expecting the
function to append the host-part to it, was lost because of this.

Reported-by: Mihai Rusu <dizzy@google.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Acked-by: Jeff King <peff@peff.net>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 ident.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/ident.c b/ident.c
index 484e0a9..fb4cc72 100644
--- a/ident.c
+++ b/ident.c
@@ -41,6 +41,7 @@ static void copy_gecos(const struct passwd *w, struct strbuf *name)
 static int add_mailname_host(struct strbuf *buf)
 {
 	FILE *mailname;
+	struct strbuf mailnamebuf = STRBUF_INIT;
 
 	mailname = fopen("/etc/mailname", "r");
 	if (!mailname) {
@@ -49,14 +50,17 @@ static int add_mailname_host(struct strbuf *buf)
 				strerror(errno));
 		return -1;
 	}
-	if (strbuf_getline(buf, mailname, '\n') == EOF) {
+	if (strbuf_getline(&mailnamebuf, mailname, '\n') == EOF) {
 		if (ferror(mailname))
 			warning("cannot read /etc/mailname: %s",
 				strerror(errno));
+		strbuf_release(&mailnamebuf);
 		fclose(mailname);
 		return -1;
 	}
 	/* success! */
+	strbuf_addbuf(buf, &mailnamebuf);
+	strbuf_release(&mailnamebuf);
 	fclose(mailname);
 	return 0;
 }
-- 
1.8.1.1.525.gdace530
