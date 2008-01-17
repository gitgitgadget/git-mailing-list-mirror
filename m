From: Wincent Colaiuta <win@wincent.com>
Subject: Re: git on MacOSX and files with decomposed utf-8 file names
Date: Thu, 17 Jan 2008 11:28:52 +0100
Message-ID: <32DB7E53-1062-4F7C-A42D-6EC5945A70A3@wincent.com>
References: <478E1FED.5010801@web.de> <76718490801162043w3884435ex435f38b9de837540@mail.gmail.com> <76718490801162059i2472cd82va34010caa3130b7e@mail.gmail.com> <7vejchkp6o.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v915)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Jay Soffian" <jaysoffian+git@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 17 11:29:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFS0H-0008V8-3Y
	for gcvg-git-2@gmane.org; Thu, 17 Jan 2008 11:29:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754286AbYAQK3O convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 17 Jan 2008 05:29:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754477AbYAQK3O
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Jan 2008 05:29:14 -0500
Received: from wincent.com ([72.3.236.74]:35456 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754031AbYAQK3N convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 17 Jan 2008 05:29:13 -0500
Received: from cuzco.lan (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id m0HASrjI018415;
	Thu, 17 Jan 2008 04:28:55 -0600
In-Reply-To: <7vejchkp6o.fsf@gitster.siamese.dyndns.org>
X-Mailer: Apple Mail (2.915)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70842>

El 17/1/2008, a las 6:15, Junio C Hamano escribi=F3:

> "Jay Soffian" <jaysoffian+git@gmail.com> writes:
>
>> So here's what I can see as being useful additions to git:
>> ...
>> Thoughts (besides "patches welcomed")?
>
> I think we already discussed a plan to store normalization
> mapping in the index extension section and use it to avoid
> getting confused by readdir(3) that lies to us.  Is there any
> more thing that need to be discussed?
>
> I would presume that we would still add _new_ paths using the
> pathname we receive from the user (there is no need for us to be
> similarly insane as broken "normalizing" filesystems), but when
> deciding if a path is new or we already have it in the index
> would be done by seeing if an entry already exists in the index
> whose "normalized" form is the same as the "normalized" form of
> the given path --- that way we would not add two paths to the
> index that would "normalize" to the same string.

And what do we do when asked to check out a tree which has two =20
different files in it whose normalized forms are the same (ie. a clone =
=20
of a repo created on a non-HFS+ filesystem)?

We either have to fail catastrophically, preventing the user from =20
working with that tree on HFS+, or arbitrarily pick one of the files =20
as the "winner" which gets written out into the work tree. None of the =
=20
options is particularly attractive, although luckily this exact =20
situation is unlikely to come up in practice.

Cheers,
Wincent
