From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gettext: setlocale(LC_CTYPE, "") breaks Git's C function assumptions
Date: Fri, 13 Aug 2010 02:39:49 -0700 (PDT)
Message-ID: <m3pqxm3l7k.fsf@localhost.localdomain>
References: <1281650895-7449-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?iso-8859-15?q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 13 11:40:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ojqk3-0008Sh-Uc
	for gcvg-git-2@lo.gmane.org; Fri, 13 Aug 2010 11:40:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934146Ab0HMJjw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 13 Aug 2010 05:39:52 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:38137 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934113Ab0HMJjv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 13 Aug 2010 05:39:51 -0400
Received: by wwj40 with SMTP id 40so2710720wwj.1
        for <git@vger.kernel.org>; Fri, 13 Aug 2010 02:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=MO5i7GNCNEWB2NO/CMMZtwcH9m3HZgwe4mQ6wcKbpAg=;
        b=a4ehzRlxsHs4WlivZ5cAYvQiCUrz/x/DZqdEUqwYI6I5EkYVK3MlA5yT6bxsKMJI/U
         0iUNNLiPVI7Bs6QiQ+2pILgmmC9pZI55ZtJONJqYPcEeraWQrBEldcWHXhj/G7kWWU0X
         URgSyab1BIt1ulgu9NcJL+UX0ns9ANGEg0q9U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        b=CHt7rIzO6oYw8DHPimBNgJhmefaspujUGwdGRm9Utykq+3j6WR8RGFlvB1BPAMfvix
         1OrvQ2eUMIQcGKP2slB6o2X3xSZkGjSNfP3+ocCif7l6QSIeVtSNubIN0OvePRM+E6rQ
         s4le9xUWXp0qjA7RytuN5/ehMh3hiCJPb7GsQ=
Received: by 10.227.72.200 with SMTP id n8mr1049630wbj.223.1281692390492;
        Fri, 13 Aug 2010 02:39:50 -0700 (PDT)
Received: from localhost.localdomain (abwf88.neoplus.adsl.tpnet.pl [83.8.229.88])
        by mx.google.com with ESMTPS id e8sm1417471wej.22.2010.08.13.02.39.47
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 13 Aug 2010 02:39:49 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o7D9e08c014925;
	Fri, 13 Aug 2010 11:40:11 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id o7D9diMT014919;
	Fri, 13 Aug 2010 11:39:44 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <1281650895-7449-1-git-send-email-avarab@gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153467>

=C6var Arnfj=F6r=F0 Bjarmason  <avarab@gmail.com> writes:

> Remove the setlocale/LC_CTYPE call from gettext.c, we only need
> setlocale/LC_MESSAGES to use the message catalog, and setting LC_CTYP=
E
> from the environment breaks Git's assumptions about C library
> functions.
>=20
> Under a non-C locale functions like vsnprintf become locale sensitive=
,
> so that they'll e.g. refuse to process ISO-8895-1 data under a UTF-8
> locale.
>=20
> This triggered a "your vsnprintf is broken" error on Git's own
> repository when inspecting v0.99.6~1 under a UTF-8 locale.
>=20
> That commit contains a ISO-8859-1 encoded author name, which the
> locale aware vsnprintf(3) won't interpolate in the format argument,
> due to mismatch between the data encoding and the locale.

Sidenote: This commit was done probably before invention of 'encoding'
header, but it should be displayable anyway.

--=20
Jakub Narebski
Poland
ShadeHawk on #git
