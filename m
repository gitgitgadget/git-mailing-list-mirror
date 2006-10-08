From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: Does GIT require property like Subversion?
Date: Sun, 8 Oct 2006 17:52:10 +0200
Organization: Dewire
Message-ID: <200610081752.10940.robin.rosenberg.lists@dewire.com>
References: <4528C09B.3030004@gmail.com> <20061008091900.GG30283@lug-owl.de> <egaj49$424$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 08 17:51:44 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GWawG-0007YE-MI
	for gcvg-git@gmane.org; Sun, 08 Oct 2006 17:51:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751237AbWJHPvi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 8 Oct 2006 11:51:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751239AbWJHPvi
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Oct 2006 11:51:38 -0400
Received: from [83.140.172.130] ([83.140.172.130]:17464 "EHLO
	torino.dewire.com") by vger.kernel.org with ESMTP id S1751237AbWJHPvh convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Sun, 8 Oct 2006 11:51:37 -0400
Received: from localhost (localhost [127.0.0.1])
	by torino.dewire.com (Postfix) with ESMTP id 987E380286A;
	Sun,  8 Oct 2006 17:48:38 +0200 (CEST)
Received: from torino.dewire.com ([127.0.0.1])
 by localhost (torino [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 12730-07; Sun,  8 Oct 2006 17:48:38 +0200 (CEST)
Received: from [10.9.0.3] (unknown [10.9.0.3])
	by torino.dewire.com (Postfix) with ESMTP id 27621800199;
	Sun,  8 Oct 2006 17:48:36 +0200 (CEST)
To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KMail/1.9.4
In-Reply-To: <egaj49$424$1@sea.gmane.org>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new at dewire.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28540>

s=F6ndag 08 oktober 2006 12:16 skrev Jakub Narebski:
> File content encoding is something (if it is outside US-ASCII of cour=
se)
> that you would want either to have some default convention, or have i=
t
> embedded in the file itself (like XML, HTML, or Emacs' file variables=
)
> to be able to read file _outside_ SCM.
Except for CR/LF, this is best solved outside of the SCM. There aren't =
that
may tools/users to warrant the complexity or performance hit I imagine =
to=20
solve it.

> Path name encoding is something that is global property of a reposito=
ry,
> I think. We have i18n.commitEncoding configuration variable; we could
> add i18n.pathnameEncoding quite easily I think (and some way for Git =
to
> detect current filesystem pathname encoding, if possible). Although
> BTW I think that i18n.commitEncoding information should be made persi=
stent,
> and copied when cloning repository.

*I* think git should use UTF-8 internally. Always. Clients could then h=
ave
the option to convert to local conventions.

Same for pathname. Internally all paths should be UTF-8 encoded. Encodi=
ng=20
commit info that way would make the i18n option obsolete also.

I have a patch for both these, but it's very ugly and probably has some=
 memory=20
management problems, so I'll refrain from submitting for now. Knowing t=
hat it=20
exists may perhaps serve as starting point for discussion. It encodes=20
filenames in UTF-8 using LC_CTYPE as the local encoding, as well as com=
mit=20
messages. An exception is when something looks like UTF-8, in which cas=
e it=20
will not convert input to git. When UTF-8 cannot be converted to the lo=
cal=20
encoding on it's way out of git, the data remains in UTF-8 format. Bran=
ch and=20
tags names are not managed (yet, at least).

> But in fact the philosophy of Git _prohibits_ I think property bits.
I don't think so, but they aren't needed for the original purpose. Git =
already
does manage file permissions.

> Unless we add ability (which can be done fairly easy even now, but wi=
ll
> not be automatic) to save some metainfo (ACL, extended attributes,
> Subversion-like properties) along with the file (blob) and/or tree
> (directory).

A problem with adding too much metadata is that there is a cost to this=
=2E We=20
like GIT much thanks to it's perforrmance. Git simply gets out of the w=
ay=20
thanks to this. ACL's aren't content at all. Extended attributes howeve=
r are,=20
but who uses them?


-- robin
