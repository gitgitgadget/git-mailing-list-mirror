From: =?windows-1252?Q?J=F6rn_Hees?= <dev@joernhees.de>
Subject: Re: [PATCH] [SIGNED-OFF] remotes-hg: bugfix for fetching non local remotes
Date: Wed, 24 Jul 2013 17:28:35 +0200
Message-ID: <665576E7-6083-4535-9CE0-773236A0E9ED@joernhees.de>
References: <1374615616-4730-1-git-send-email-dev@joernhees.de> <CALWbr2zRsCk1N5xUUDQeWX6CbvLHYWnxiYpea+etoWvXHNhPEA@mail.gmail.com> <F0461ED2-7B5F-4657-B0D4-3CBBE15FDD48@joernhees.de> <CALWbr2wDqo29kRJ2eHsozRCN_fT3tumYz23pQa5P-9dm27OL6A@mail.gmail.com> <7v7ggg6l2o.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0 (Mac OS X Mail 6.5 \(1508\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Antoine Pelisse <apelisse@gmail.com>, git <git@vger.kernel.org>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 24 17:28:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V20zk-0007Zg-4T
	for gcvg-git-2@plane.gmane.org; Wed, 24 Jul 2013 17:28:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752040Ab3GXP2s convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 24 Jul 2013 11:28:48 -0400
Received: from srv1.joernhees.de ([81.20.133.80]:49656 "EHLO mail.joernhees.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750909Ab3GXP2r convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 24 Jul 2013 11:28:47 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.joernhees.de (Postfix) with ESMTP id 7DC92E8C2B4;
	Wed, 24 Jul 2013 17:28:41 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at joernhees.de
Received: from mail.joernhees.de ([127.0.0.1])
	by localhost (srv1.joernhees.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id t-3cGNQ9MxHK; Wed, 24 Jul 2013 17:28:39 +0200 (CEST)
Received: from [192.168.83.24] (dfki-098.dfki.uni-kl.de [131.246.194.98])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mail.joernhees.de (Postfix) with ESMTPSA id 85709E8C2B3;
	Wed, 24 Jul 2013 17:28:39 +0200 (CEST)
In-Reply-To: <7v7ggg6l2o.fsf@alter.siamese.dyndns.org>
X-Mailer: Apple Mail (2.1508)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231104>


On 24 Jul 2013, at 17:20, Junio C Hamano <gitster@pobox.com> wrote:

> Antoine Pelisse <apelisse@gmail.com> writes:
>=20
>> On Wed, Jul 24, 2013 at 11:59 AM, J=F6rn Hees <dev@joernhees.de> wro=
te:
>>> On 24.07.2013, at 10:52, Antoine Pelisse <apelisse@gmail.com> wrote=
:
>>>> I think the best way would be to create the shared repository in
>>>> .git/hg/$share, with $share being a path that can't be a remote na=
me
>>>> (so that it doesn't conflict with remote directories),
>>>=20
>>> Maybe ".git/hg/.share"?
>>=20
>> According to Documentation/git-check-ref-format.txt, I'm not sure if
>> we should start with a dot, or end with it.
>=20
> What are in these directories under .git/hg?  Surely they cannot be
> refs in Git's sense, as that hierarchy is not known to anything and
> will not be protected from "git gc".
>=20
> Puzzled...
>=20
> 	Goes and looks...
>=20
> OK, the tracking branches for these are created under refs/hg/*
> using the same name.
>=20
> A refname shouldn't begin or end with a dot, because the range
>=20
> 	master...share
>=20
> will become ambiguous if you allowed ".share" as a refname
> shorthand.  It could mean either one of these:
>=20
> 	master..refs/heads/.share
>        master...refs/heads/share
>=20
> The same for the trailing dot "share."; the range "share...master"
> becomes ambiguous.


I think there is a slight misunderstanding here:
=2Egit/hg/<remote_name> will be the actual directory for a hg:: remote,=
 which will then use mercurial internal magic to refer to the shared re=
po .git/hg/.shared in case the remote is not somewhere on the local fil=
esystem, otherwise that path is used.

What will appear in the refs is something like: hg/<remote_name>/{branc=
hes,bookmarks}/{master,default,=85}.
So the .shared will correctly never appear in a git ref, which is what =
we want. It can also not clash with a remote as ".shared" is not a vali=
d name=85 also what we want ;)

Cheers,
J=F6rn
