From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH 00/12] Support columinized output in tag/branch/ls-files/grep
Date: Thu, 11 Mar 2010 22:13:48 +0100
Message-ID: <4B995D0C.2090000@lsrfire.ath.cx>
References: <1267963785-473-1-git-send-email-pclouds@gmail.com>	 <4B9504C9.5000703@lsrfire.ath.cx>	 <fcaeb9bf1003080632o622c8c79x85b816edcf893bc3@mail.gmail.com>	 <4B967C36.90309@lsrfire.ath.cx> <fcaeb9bf1003091627p65ad6e60u4bbae2eb4e859f13@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 11 22:14:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Npphh-0006u3-IX
	for gcvg-git-2@lo.gmane.org; Thu, 11 Mar 2010 22:14:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753337Ab0CKVN4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 11 Mar 2010 16:13:56 -0500
Received: from india601.server4you.de ([85.25.151.105]:51239 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752772Ab0CKVN4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Mar 2010 16:13:56 -0500
Received: from [10.0.1.100] (p57B7CAAE.dip.t-dialin.net [87.183.202.174])
	by india601.server4you.de (Postfix) with ESMTPSA id 6E86F2F8045;
	Thu, 11 Mar 2010 22:13:54 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; de; rv:1.9.1.8) Gecko/20100227 Thunderbird/3.0.3
In-Reply-To: <fcaeb9bf1003091627p65ad6e60u4bbae2eb4e859f13@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141999>

Am 10.03.2010 01:27, schrieb Nguyen Thai Ngoc Duy:
> On 3/9/10, Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx> wrote:
>>  With "more complicated", do you perhaps mean what GNU ls does, name=
ly
>>  having non-uniform column widths?  I never consciously noticed that=
 it
>>  actually goes out of its way to cram as may columns on the screen a=
s
>>  possible, it just feels so natural. :)
>=20
> That. And aligned grep output like this
>=20
> pclouds@do ~/w/git/builtin $ git grep -n 38
> count-objects.c  |  35 |                if (cp - ent->d_name !=3D 38)
> count-objects.c  |  39 |                        memcpy(path + len + 3=
,
> ent->d_name, 38);
> count-objects.c  |  59 |                memcpy(hex+2, ent->d_name, 38=
);
> fsck.c           | 405 |                if (strlen(de->d_name) =3D=3D=
 38) {
> gc.c             | 112 |                if (strspn(ent->d_name,
> "0123456789abcdef") !=3D 38 ||
> gc.c             | 113 |                    ent->d_name[38] !=3D '\0'=
)
> prune-packed.c   |  24 |                if (strlen(de->d_name) !=3D 3=
8)
> prune-packed.c   |  26 |                memcpy(hex+2, de->d_name, 38)=
;
> prune-packed.c   |  31 |                memcpy(pathname + len, de->d_=
name, 38);
> prune.c          |  64 |                if (strlen(de->d_name) =3D=3D=
 38) {
> receive-pack.c   | 588 |        char hdr_arg[38];
> upload-archive.c |  86 |        char buf[16384];

Hmm, I'm not sure that this columnizing is very useful in this instance=
=2E
 You can more easily compare the line numbers and the indent level of
the hits, but both pieces of information are only useful in the context
of the file, so this easier comparison doesn't buy you much.

Another possible use might be the list of untracked files shown by
status and commit, by the way.

>> I don't see any benefit of an environment variable over config optio=
ns.
>=20
> Currently we may pass --column=3D<foo> from a porcelain to "git colum=
n
> --mode=3D<foo>", <foo> could be column first, or row first, or either
> with non-uniform columns (not implemented yet). We can also pass othe=
r
> things to "git column". Putting everything in "<foo>" is OK, although
> looks ugly. In my private tree, I also have "git column
> --min-rows/--max-items" that forces the columnizer to one column mode
> if:
>  - there will be only one or two rows after columnized, too wide
> screen for example (--min-rows)

Well, I can't imagine when I would want to use this option.  If I'm OK
with n + 100 items being displayed in x columns, I'd certainly be OK
with n items being displayed the same way, even if they only take up a
single row.

>  - too many lines and the layout has not been fixed, so nothing gets
> printed (--max-items). Forcing back to one column mode to stop wait
> time.

Interesting idea, but I'm not sure if I'd want to use it, too.  Best
effort pretty-printing combines fast output and optimized display at
first glance.  However, if there are lots of items then the user would
benefit the most from having them columnized.

If it takes too long to show the first line of output (since the
columnizer needs to wait for all items to be generated) then the comman=
d
should only columnize on request.

Ren=C3=A9
