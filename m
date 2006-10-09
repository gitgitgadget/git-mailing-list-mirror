From: Liu Yubao <yubao.liu@gmail.com>
Subject: Re: Does GIT require property like Subversion?
Date: Mon, 09 Oct 2006 10:53:59 +0800
Message-ID: <4529B9C7.7000000@gmail.com>
References: <4528C09B.3030004@gmail.com> <20061008091900.GG30283@lug-owl.de> <egaj49$424$1@sea.gmane.org> <200610081752.10940.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 09 04:54:59 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GWlI4-00046N-NW
	for gcvg-git@gmane.org; Mon, 09 Oct 2006 04:54:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751627AbWJICyt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 8 Oct 2006 22:54:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751638AbWJICyt
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Oct 2006 22:54:49 -0400
Received: from py-out-1112.google.com ([64.233.166.177]:7999 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751627AbWJICyt (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Oct 2006 22:54:49 -0400
Received: by py-out-1112.google.com with SMTP id n25so2137130pyg
        for <git@vger.kernel.org>; Sun, 08 Oct 2006 19:54:45 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=pRFf2kTytFa6AFfQBwRruEluKX2ok5x68B+n5BiW+90/tpmkiFBXLDaIMni6XNztbd1hLOznmVDy67wXTYGXQk4AXk6lLiby+wDKmHt5H4DRD0/dM8tAURzap6EcaKgQrz4jMHLFM7WbbKQa9jwxW5OpEYz7UpT+syV9SRPYqa0=
Received: by 10.35.60.15 with SMTP id n15mr4653346pyk;
        Sun, 08 Oct 2006 19:54:45 -0700 (PDT)
Received: from ?192.168.88.85? ( [221.122.47.70])
        by mx.google.com with ESMTP id x47sm2991839pyc.2006.10.08.19.54.43;
        Sun, 08 Oct 2006 19:54:45 -0700 (PDT)
User-Agent: Thunderbird 1.5.0.7 (Windows/20060909)
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <200610081752.10940.robin.rosenberg.lists@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28559>

Sorry, I forgot to reply all.

Robin Rosenberg wrote:
> s=F6ndag 08 oktober 2006 12:16 skrev Jakub Narebski:
>> File content encoding is something (if it is outside US-ASCII of cou=
rse)
>> that you would want either to have some default convention, or have =
it
>> embedded in the file itself (like XML, HTML, or Emacs' file variable=
s)
>> to be able to read file _outside_ SCM.
> Except for CR/LF, this is best solved outside of the SCM. There aren'=
t that
> may tools/users to warrant the complexity or performance hit I imagin=
e to=20
> solve it.
>=20
>> Path name encoding is something that is global property of a reposit=
ory,
>> I think. We have i18n.commitEncoding configuration variable; we coul=
d
>> add i18n.pathnameEncoding quite easily I think (and some way for Git=
 to
>> detect current filesystem pathname encoding, if possible). Although
>> BTW I think that i18n.commitEncoding information should be made pers=
istent,
>> and copied when cloning repository.
>=20
> *I* think git should use UTF-8 internally. Always. Clients could then=
 have
> the option to convert to local conventions.
>=20
> Same for pathname. Internally all paths should be UTF-8 encoded. Enco=
ding=20
> commit info that way would make the i18n option obsolete also.
>=20
I am afraid it's not a good idea to convert file content to UTF-8 encod=
ing
as GIT can manage non-text file, it's not safe to modify file content=20
stealthily by a VCS.

But I agree to use UTF-8 for path name in tree object, or add an encodi=
ng
property(not a user defined property) to the head of tree object, so GI=
T
won't do useless enc -> UTF-8 -> same_enc conversion. The second way ha=
s
a fault: two tree objects with same content in different encoding have=20
different SHA1 digests.

> I have a patch for both these, but it's very ugly and probably has so=
me memory=20
> management problems, so I'll refrain from submitting for now. Knowing=
 that it=20
> exists may perhaps serve as starting point for discussion. It encodes=
=20
> filenames in UTF-8 using LC_CTYPE as the local encoding, as well as c=
ommit=20
> messages. An exception is when something looks like UTF-8, in which c=
ase it=20
> will not convert input to git. When UTF-8 cannot be converted to the =
local=20
> encoding on it's way out of git, the data remains in UTF-8 format. Br=
anch and=20
> tags names are not managed (yet, at least).
>=20
 >
Good, hope GIT can deal with path names that are not in 8859_1 or UTF-8=
 encoding.
