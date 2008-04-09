From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: git bisect on multiple cores
Date: Wed, 9 Apr 2008 06:29:28 +0200
Message-ID: <200804090629.29122.chriscool@tuxfamily.org>
References: <dbbf25900804080358o6b1ada20pfb94f68f06a23f83@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "A B" <gentosaker@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 09 06:24:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JjRrl-0001Me-Dc
	for gcvg-git-2@gmane.org; Wed, 09 Apr 2008 06:24:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750882AbYDIEYL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 9 Apr 2008 00:24:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750926AbYDIEYK
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Apr 2008 00:24:10 -0400
Received: from smtp1-g19.free.fr ([212.27.42.27]:52249 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750877AbYDIEYK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 9 Apr 2008 00:24:10 -0400
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id B56021AB2B1;
	Wed,  9 Apr 2008 06:24:07 +0200 (CEST)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 9591F1AB2BF;
	Wed,  9 Apr 2008 06:24:07 +0200 (CEST)
User-Agent: KMail/1.9.7
In-Reply-To: <dbbf25900804080358o6b1ada20pfb94f68f06a23f83@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79069>

Le mardi 8 avril 2008, A B a =E9crit :
> git bisect is really cool. I use it for the first time.
> Just a thought, if you have a multiple core computer, can't you make
> git build new versions in the background while testing the previuos
> version? Alright, if you build 2 versions, one of them will never be
> tested, but you will perhaps save some time by letting it build in th=
e
> background?

Yes, you can do that.

If you have cloned your repository twice (or more), then you can bisect=
=20
compile and test at the same time in your 3 repositories (or more if yo=
u=20
really want).

=46or example if bisecting in one repo asks you to test revision X, the=
n you=20
can bisect and then build (and even maybe start testing) in another rep=
o=20
assuming revision X is good, and in yet in another one assuming revisio=
n X=20
is bad.

(In the repo where you assume X is good you use:

"git bisect start CURRENT-BAD X"

and in the third one, where you assume X is bad, you use:

"git bisect start X CURRENT-GOOD")

When you know that X was good then you can kill the build or test proce=
sses=20
and "git bisect reset" in the repository where you assumed wrongly X wa=
s=20
bad. You can then assume something else with "git bisect start B G" and=
=20
build and test in this repo again.

In the repo that told you X was good, then you need only to use "git bi=
sect=20
good" or "git bisect bad" without building and testing to assume someth=
ing=20
about the revision that should be built and tested.

Regards,
Christian.
