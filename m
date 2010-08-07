From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH maint] imap-send: Fix sprintf usage
Date: Sat, 7 Aug 2010 18:09:45 -0500
Message-ID: <20100807230945.GA3427@burratino>
References: <1281183136-10352-1-git-send-email-avarab@gmail.com>
 <20100807210429.GA2216@burratino>
 <AANLkTim4CHdVLinkw1EjXB74OJ+YW-ri4GzHMNhRd+Cy@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Mike McCormack <mikem@ring3k.org>,
	Benjamin Kramer <benny.kra@googlemail.com>,
	Junio C Hamano <gitster@pobox.com>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 08 01:11:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OhsXy-0005Wt-Uq
	for gcvg-git-2@lo.gmane.org; Sun, 08 Aug 2010 01:11:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753956Ab0HGXLM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 7 Aug 2010 19:11:12 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:53551 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753605Ab0HGXLL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Aug 2010 19:11:11 -0400
Received: by gyg10 with SMTP id 10so3163567gyg.19
        for <git@vger.kernel.org>; Sat, 07 Aug 2010 16:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=ynVbnhHqtlnTOoWCv4McoVVCRqUCyauUYfPeQ3YB2r8=;
        b=JeDA60CcZcsZPYjJ968EwvUNTAzPAxlJFLsXuiVH8yQAxabaKP6EnrjwzXHeYVRbEl
         rk5yNNl+0CWiLsl9YKQ0O/Qa2FXsfhcJp4hiCDrJBxxzuiFm8vQZxEmWA4Rc0nUE8JEC
         jrInLknpwddSydN6MzaEClW59yBCM6fkjyA9s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=NHDPdhpL6edzoPLmzU/5usiJ6zVQWMZ5cS3CYgjB6Y+ZQHql5EJNbA/7OO4xqsXH8a
         Smxc7vLptJOpG7clapppi/r/jeW3ucCuDYMLSE6UWsUuyGB5cOqMXxQ7SGYHppSIi/3y
         QN8sDGIjMgfcukWlBvUyODYt10xmVh/1i+3yc=
Received: by 10.101.139.6 with SMTP id r6mr15898965ann.74.1281222670347;
        Sat, 07 Aug 2010 16:11:10 -0700 (PDT)
Received: from burratino (ip-64-32-208-34.chi.megapath.net [64.32.208.34])
        by mx.google.com with ESMTPS id u14sm5068961ann.20.2010.08.07.16.11.08
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 07 Aug 2010 16:11:09 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTim4CHdVLinkw1EjXB74OJ+YW-ri4GzHMNhRd+Cy@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152872>

=46rom: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>

When composing a command for the imap server, imap-send uses a single
nfsnprintf() invocation for brevity instead of dealing separately with
the case when there is a message to be sent and the case when there
isn=E2=80=99t.  The unused argument in the second case, while valid, is
confusing for static analyzers and human readers.

v1.6.4-rc0~117 (imap-send: add support for IPv6, 2009-05-25)
mistakenly used %hu as the format for an int =E2=80=9Cport=E2=80=9D, by=
 analogy with
existing usage for the unsigned short =E2=80=9Caddr.sin_port=E2=80=9D. =
=C2=A0Use %d
instead.

Noticed with clang.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> I wasn't sure whether it needed to be %hu for the purposes of the
> snprintf() call. I.e. that the resulting contents of portstr might be
> different on some systems.
>=20
> Maybe they won't be, then we could just use %d.

It=E2=80=99s just a nonnegative integer. :)

Here=E2=80=99s the updated patch.  Untested.

 imap-send.c |   12 ++++++++----
 1 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/imap-send.c b/imap-send.c
index 1a577a0..3a02e89 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -543,9 +543,13 @@ static struct imap_cmd *v_issue_imap_cmd(struct im=
ap_store *ctx,
 	while (imap->literal_pending)
 		get_cmd_result(ctx, NULL);
=20
-	bufl =3D nfsnprintf(buf, sizeof(buf), cmd->cb.data ? CAP(LITERALPLUS)=
 ?
-			   "%d %s{%d+}\r\n" : "%d %s{%d}\r\n" : "%d %s\r\n",
-			   cmd->tag, cmd->cmd, cmd->cb.dlen);
+	if (!cmd->cb.data)
+		bufl =3D nfsnprintf(buf, sizeof(buf), "%d %s\r\n", cmd->tag, cmd->cm=
d);
+	else
+		bufl =3D nfsnprintf(buf, sizeof(buf), "%d %s{%d%s}\r\n",
+		                  cmd->tag, cmd->cmd, cmd->cb.dlen,
+		                  CAP(LITERALPLUS) ? "+" : "");
+
 	if (Verbose) {
 		if (imap->num_in_progress)
 			printf("(%d in progress) ", imap->num_in_progress);
@@ -1086,7 +1090,7 @@ static struct store *imap_open_store(struct imap_=
server_conf *srvc)
 		int gai;
 		char portstr[6];
=20
-		snprintf(portstr, sizeof(portstr), "%hu", srvc->port);
+		snprintf(portstr, sizeof(portstr), "%d", srvc->port);
=20
 		memset(&hints, 0, sizeof(hints));
 		hints.ai_socktype =3D SOCK_STREAM;
--=20
1.7.2.1.544.ga752d.dirty
