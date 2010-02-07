From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: Using =?utf-8?q?=E2=80=98git_replace=E2=80=99_to_replace?= blobs
Date: Sun, 7 Feb 2010 07:45:59 +0100
Message-ID: <201002070746.00200.chriscool@tuxfamily.org>
References: <20100207011056.GA15307@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Nick Edelen <sirnot@gmail.com>,
	Sam Vilain <sam@vilain.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 07 07:44:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ne0sy-0004ZL-GS
	for gcvg-git-2@lo.gmane.org; Sun, 07 Feb 2010 07:44:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751426Ab0BGGmu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 7 Feb 2010 01:42:50 -0500
Received: from smtp3-g21.free.fr ([212.27.42.3]:43312 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751337Ab0BGGmu convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 7 Feb 2010 01:42:50 -0500
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 4251281805F;
	Sun,  7 Feb 2010 07:42:42 +0100 (CET)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 1CF69818045;
	Sun,  7 Feb 2010 07:42:40 +0100 (CET)
User-Agent: KMail/1.9.9
In-Reply-To: <20100207011056.GA15307@progeny.tock>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139222>

On dimanche 07 f=C3=A9vrier 2010, Jonathan Nieder wrote:
> I think it is a known problem that =E2=80=98git replace=E2=80=99 cann=
ot be used safely
> to replace blobs used in the currently checked out commit.  The man
> page says:
>
> 	Comparing blobs or trees that have been replaced with
> 	those that replace them will not work properly.
>
> Indeed, in practice it produces problems. [1]
>
> I would like to start to fix this. =20

One way to fix it may be to use a bit in "struct object" that could tel=
l if=20
any object was replaced or not. I think that in the "Add caching suppor=
t to=20
git-daemon" GSoc patches, Nick Edelen did something like that for graft=
s.=20
(See http://thread.gmane.org/gmane.comp.version-control.git/127932/)

> But the correct semantics are not=20
> obvious to me:
>
>  - When writing a tree from an index that includes replaced blobs,
>    should the result use the original blobs or the replaced ones?

It may depend on why the original blob was replaced in the first place.
I did not think much about this though.

>  - When reading a tree that includes replaced blobs, should the
>    resulting cache entries use the original blobs or the replaced
>    ones?

I think it should depend on whether the global variable read_replace_re=
fs is=20
set or not.

> My hunch is to say both should use the replaced blobs.  This way,
> replacing a blob in a checked-out index would behave in a more
> intuitive way, and git filter-branch would make permanent any
> substitutions requested through replaced blob entries.

It might not always be a good idea to make any substitution permanent.
=46or example if you use git replace to improve the bisectability of yo=
ur=20
commit history you may want to keep the original commits.

I know you are talking about blobs, not commits, but perhaps there are =
some=20
similar use cases of replaced blobs.

Thanks for looking at that,
Christian.
