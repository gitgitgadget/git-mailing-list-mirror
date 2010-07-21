From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: Avery Pennarun's git-subtree?
Date: Wed, 21 Jul 2010 20:36:04 +0000
Message-ID: <AANLkTikl2zKcie3YGhBHrGbYbX3yB9QCtuJTKjsAfK07@mail.gmail.com>
References: <4C472B48.8050101@gmail.com>
	<AANLkTilivtS4TccZXHz2N_n_2RpY6q_5sw7zwdWKdnYE@mail.gmail.com>
	<AANLkTinl1SB1x1bEObLIo-LWjvxM-Yf1PfdUp4DNJda3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Bryan Larsen <bryan.larsen@gmail.com>, git <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 21 22:36:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Obg1X-0001S3-4h
	for gcvg-git-2@lo.gmane.org; Wed, 21 Jul 2010 22:36:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752540Ab0GUUgJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 21 Jul 2010 16:36:09 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:64178 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750803Ab0GUUgG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 21 Jul 2010 16:36:06 -0400
Received: by fxm14 with SMTP id 14so3896558fxm.19
        for <git@vger.kernel.org>; Wed, 21 Jul 2010 13:36:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=xgKT90wlyQJQBtKilN4y9WCOLr1k0GCVuxlMxPUTtUI=;
        b=Y/72QEfBQJ97xgMk2g+Brei8cet7TCnakOZjRIl3tX9kXMXfEw7PvRYIwtxEiDoBNg
         539zEToccTiNiejefU5JDLtyuVSVwIqfPDV9sZczlLnU4WbllbCazP9TPRcxRiO1PYK1
         4BTKyLSomMSgWtX4GqXuGNck4G3JhRBMUjPqs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=EcHbpwWjEdU4GDtcC2wXVyFha6z+KGiTjOa3QMKIwxWR1C/V3WR/kHRyIlvZORZb6B
         A+6CnkSaxwhIZgM4hti36r3hkWWD+UPNxxy8AvtNmeTiYoyNZDh3BvJOinr/+jC2L7Ec
         1saN/7SWB4MKu8BkEWqvJGhJqnqxIH6Wd4dNc=
Received: by 10.223.107.140 with SMTP id b12mr990852fap.18.1279744564221; Wed, 
	21 Jul 2010 13:36:04 -0700 (PDT)
Received: by 10.223.119.17 with HTTP; Wed, 21 Jul 2010 13:36:04 -0700 (PDT)
In-Reply-To: <AANLkTinl1SB1x1bEObLIo-LWjvxM-Yf1PfdUp4DNJda3@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151417>

On Wed, Jul 21, 2010 at 19:56, Avery Pennarun <apenwarr@gmail.com> wrot=
e:

> No amount of bugfixing in git submodule can fix this workflow, becaus=
e
> it's not a result of bugs. =C2=A0(The bugs, particularly the
> disconnected-by-default HEADs on submodule checkouts, do make it a bi=
t
> worse :( ) =C2=A0It would require a fundamental redesign to make this=
 work
> nicely with submodules.

I think most of those can be fixed, actually. The only requirement
that the git plumbing imposes on git-submodules is that a "commit"
entry exist in your tree, the rest is just (ugly plumbing).

Thus, we could:

   * Hack git-submodule (or its replacement) to check import the tree
     that contains that "commit" into one central .git

   * Fix git status / git commit so that you could commit into
     submodules, i.e.:

     for each submodule in this-commit:
         chdir $submodule && commit
     done && cd $root && commit -m"bumping sumbodules"

   * Make git-push push the submodule contents and the
     superprojects. You'd just need to have commit access to the url
     listed in .gitmodules.

What's missing from that (which would be nice) is the ability to check
out a subdirectory from another repository. That could (I think) be
done by just adding a normal "tree" entry, and then specifying that
that tree can be found in git://... instead of the main tree.

> If we can get some kind of consensus in principle that git-subtree is
> a good idea to merge into git core, I can prepare some patches and we
> can talk about the details.

=46rom having looked at it briefly it looks very nice. But it looks to
me as if the main differences between git-submodule and git-subtree
are in the porcelain, not the plumbing.

It would be a lot less confusing to users of Git in the long term if
we would at least try to unify these two approaches instead of having
two mutually incompatible ways of doing essentially the same thing.
