From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: use correct mime type even if filename has multiple dots.
Date: Sun, 17 Sep 2006 10:56:10 +0200
Organization: At home
Message-ID: <eej2i1$97c$1@sea.gmane.org>
References: <20060916210933.GX17042@admingilde.org> <eehr7e$5i0$1@sea.gmane.org> <20060917075157.GY17042@admingilde.org> <7vejua7um3.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Sun Sep 17 10:56:12 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GOsRU-0004TE-E0
	for gcvg-git@gmane.org; Sun, 17 Sep 2006 10:56:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932321AbWIQIz6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 17 Sep 2006 04:55:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932328AbWIQIz5
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Sep 2006 04:55:57 -0400
Received: from main.gmane.org ([80.91.229.2]:29097 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932321AbWIQIz5 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 17 Sep 2006 04:55:57 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GOsRH-0004PK-Os
	for git@vger.kernel.org; Sun, 17 Sep 2006 10:55:47 +0200
Received: from 193.0.122.19 ([193.0.122.19])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 17 Sep 2006 10:55:47 +0200
Received: from jnareb by 193.0.122.19 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 17 Sep 2006 10:55:47 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 193.0.122.19
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27169>

Junio C Hamano wrote:

>> Looking at /etc/mime.types, it only contains pcf.Z but perhaps
>> it should also contain tar.gz or similiar.
>=20
> Probably. =A0But that makes me think it might be better to:
>=20
> =A0- read in mime.types, sort the entries with length of the
> =A0 =A0suffixes (longer first);
>=20
> =A0- try matching the suffixes from longer to shorter and pick the
> =A0 =A0first match.
>=20
> Without that, you would not be able to cope with a /etc/mime.types
> that looks like this, no?
>=20
> =A0 =A0 =A0 =A0 application/a=A0=A0=A0a
> =A0 =A0 =A0 =A0 application/b=A0=A0=A0b.a
>=20
> Perhaps something like the attached.

Is it really useful? Usually the suffix in mime.types doesn't contain d=
ot
itself. Besides, to be said we need correct mimetype only for files whi=
ch
can be displayed in browser (HTML, XHTML, images: png, gif, jpeg, perha=
ps
XML). All other can get generic mimetype, i.e. application/octet-stream=
 for
binary files (to be saved) and text/plain for text file (to be displaye=
r
as-is in browser).

Besides, performance will suffer for "blob_plain" view. One hash lookup=
=20
vs. nested loops.
--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
