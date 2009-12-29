From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH] Add --path-prefix option to git-fast-import
Date: Tue, 29 Dec 2009 08:06:16 -0600
Message-ID: <fabb9a1e0912290606ib1f2e46y1ddbae9aa68e5194@mail.gmail.com>
References: <1262091083-25401-1-git-send-email-gisle.aas@it.uib.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com, Gisle Aas <gisle@aas.no>
To: Gisle Aas <gisle.aas@it.uib.no>
X-From: git-owner@vger.kernel.org Tue Dec 29 15:06:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NPcii-0001ct-A4
	for gcvg-git-2@lo.gmane.org; Tue, 29 Dec 2009 15:06:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751473AbZL2OGj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 29 Dec 2009 09:06:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751377AbZL2OGj
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Dec 2009 09:06:39 -0500
Received: from mail-pw0-f42.google.com ([209.85.160.42]:43617 "EHLO
	mail-pw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751007AbZL2OGi convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 29 Dec 2009 09:06:38 -0500
Received: by pwj9 with SMTP id 9so6810918pwj.21
        for <git@vger.kernel.org>; Tue, 29 Dec 2009 06:06:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=cFf0+y1kfG4tJs+3pYe7BMUUbC6s8SyTE+wpRCY7BD8=;
        b=lRycZyM2OobJHP9RqkXgMLwwnSD0LECKcC3ZTCga5E/fPAk/rd4s6wqYDY/4TDBcN2
         55Q0a9FE1fsjDj+S8w5l162eRtMUHVzLiZqetLyhu0AZc2lrhQOsz5pkP7aB9tdyw/WR
         /WSda954K7Ic7t/s13LDAgvAT6a4+jB3zPdSc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=AEE7gMXNydqk10PHLhGt6DJoKIVtISqsCQXxJXwFPf16XbeUYcQXKEWPZY/FadTCiO
         AnEqgz2YA70IQ6rW3Qb8uRx51fkwUvXqcUXlbHPhJ+EsLyFCpkZqPk8vO2n5zI0n7CB/
         ouvTKRGo/dHw51HNAiwDPLHM8vEd9C/eWaBN4=
Received: by 10.142.1.29 with SMTP id 29mr7178799wfa.11.1262095596051; Tue, 29 
	Dec 2009 06:06:36 -0800 (PST)
In-Reply-To: <1262091083-25401-1-git-send-email-gisle.aas@it.uib.no>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135797>

Heya,

On Tue, Dec 29, 2009 at 06:51, Gisle Aas <gisle.aas@it.uib.no> wrote:
> +static const char *path_prefix_prepend(struct strbuf *sb, const char=
 *p)
> +{
> + =A0 =A0 =A0 if (p !=3D sb->buf) {
> + =A0 =A0 =A0 =A0 =A0 strbuf_reset(sb);
> + =A0 =A0 =A0 =A0 =A0 strbuf_addstr(sb, p);
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 strbuf_insert(sb, 0, path_prefix, path_prefix_len);
> + =A0 =A0 =A0 return sb->buf;
> +}
> +
> =A0static void file_change_m(struct branch *b)
> =A0{
> =A0 =A0 =A0 =A0const char *p =3D command_buf.buf + 2;
> @@ -1909,6 +1921,8 @@ static void file_change_m(struct branch *b)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0die("Garbage after pat=
h in: %s", command_buf.buf);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0p =3D uq.buf;
> =A0 =A0 =A0 =A0}
> + =A0 =A0 =A0 if (path_prefix)
> + =A0 =A0 =A0 =A0 =A0 p =3D path_prefix_prepend(&uq, p);

You could reduce the size of this change by having path_prefix_prepend
check for path_prefix and just do nothing if it is not set.

--=20
Cheers,

Sverre Rabbelier
