From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: t5403.1 and adding a file that belongs to a submodule
Date: Wed, 20 Jul 2011 07:17:09 +0700
Message-ID: <CACsJy8AgboAj86PHi6jiSyRFsJJ7hn=mkbt+2UdBva6LmKk4ZQ@mail.gmail.com>
References: <CACsJy8AKMQa2u6Y5qQHGujbjqq0qnM5D1+aEvcfk7POxQBqsVg@mail.gmail.com>
 <7vk4be9qqm.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Josh England <jjengla@sandia.gov>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 20 02:17:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QjKTy-0001R6-M9
	for gcvg-git-2@lo.gmane.org; Wed, 20 Jul 2011 02:17:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752550Ab1GTARl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 19 Jul 2011 20:17:41 -0400
Received: from mail-fx0-f52.google.com ([209.85.161.52]:51393 "EHLO
	mail-fx0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752377Ab1GTARk convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 19 Jul 2011 20:17:40 -0400
Received: by fxd18 with SMTP id 18so704573fxd.11
        for <git@vger.kernel.org>; Tue, 19 Jul 2011 17:17:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=gQ/qxaJAdEt+Rq9kJ0bsRShuHvBTJUxNHO8o/m57PkI=;
        b=xjpmuxq+aI+ncfvaSNSlyhzjF0ORUcBU2hnnd2ntTZrE4uBHtMFrzLuZbbuTeScDzo
         zKY5A52Hgi6n1dJ+ZTM6Gst3vk0BTUiJ9eYf471OosEAyKQqH6jMokkzeiH7NYihVjD9
         U6fUvqEc81gBvPhACOPlJFPZFoMrTnWOqdFV0=
Received: by 10.204.49.6 with SMTP id t6mr990320bkf.135.1311121059177; Tue, 19
 Jul 2011 17:17:39 -0700 (PDT)
Received: by 10.204.123.199 with HTTP; Tue, 19 Jul 2011 17:17:09 -0700 (PDT)
In-Reply-To: <7vk4be9qqm.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177515>

On Tue, Jul 19, 2011 at 11:31 PM, Junio C Hamano <gitster@pobox.com> wr=
ote:
> Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:
>
>> touch a b; git commit -am1
>> git clone ./. clone2
>> GIT_DIR=3Dclone2/.git git add clone2/b
>
> The last one has _always_ meant:
>
> =C2=A0 =C2=A0I am telling with GIT_DIR the directory that contains th=
e repository
> =C2=A0 =C2=A0metadata, which is at clone2/.git directory. =C2=A0I am =
not saying where
> =C2=A0 =C2=A0the working tree is (i.e. no GIT_WORK_TREE and no core.w=
orktree in
> =C2=A0 =C2=A0clone2/.git/config) so take my $(pwd) as the root of the=
 working tree,
> =C2=A0 =C2=A0and add the contents of clone2/b to the index at the sam=
e path,
> =C2=A0 =C2=A0i.e. "clone2/b".
>
> It should not add contents of the said file at "b", as there is _noth=
ing_
> on the command line that tells us "clone2" is the root of the working
> tree.

I see you're distracted by GIT_DIR. Let's take another example without =
GIT_DIR

git init
mkdir foo
(cd foo; git init; touch abc; git add abc; git ci -m1)
git add foo/abc
git ls-files --stage
# 100644 e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 0       foo/abc

Because foo is a repository, should we not allow "git add foo/abc"
("git add foo" is ok)? Otherwise "abc" may be managed in two
repositories.

Note that doing "touch abc; git add abc foo/abc" instead will only add =
"abc".

> If the test means to do that, it should be more explicit and do somet=
hing
> like:
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0( cd clone2 && git add b )
>
> instead.

I suspect that's what it wants. CC the author, hopefully he still remem=
bers.
--=20
Duy
