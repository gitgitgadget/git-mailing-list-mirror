From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH] Bisect: add checks at the beginning of "git bisect run".
Date: Thu, 29 Mar 2007 07:02:47 +0200
Message-ID: <200703290702.47972.chriscool@tuxfamily.org>
References: <20070327064957.34dad72a.chriscool@tuxfamily.org> <200703280952.57058.chriscool@tuxfamily.org> <7vbqidls13.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu Mar 29 06:54:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HWmer-0001n4-I7
	for gcvg-git@gmane.org; Thu, 29 Mar 2007 06:54:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933986AbXC2Eyj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Thu, 29 Mar 2007 00:54:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933997AbXC2Eyi
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Mar 2007 00:54:38 -0400
Received: from smtp1-g19.free.fr ([212.27.42.27]:39113 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933986AbXC2Eyi convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 29 Mar 2007 00:54:38 -0400
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with ESMTP id F1699B5D7E;
	Thu, 29 Mar 2007 06:54:36 +0200 (CEST)
User-Agent: KMail/1.9.5
In-Reply-To: <7vbqidls13.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43402>

Le mercredi 28 mars 2007 09:57, Junio C Hamano a =C3=A9crit :
>
> In other words, the above would be equilvalent to
>
>   git bisect start
>   git bisect good nightly_2007_03_27
>   make >/dev/null || {
> 	  git bisect bad
>           git bisect run make >/dev/null
>           # extract commit and author email address from
> "$GIT_DIR/BISECT_RUN" #=C2=A0and send flame to author who broke the b=
uild with
> the commit }

Yes, it would be equivalent but a little shorter.

So while we are at it, what about a new subcommand "git bisect test" th=
at=20
could be used like this:

git bisect test good_rev my_script

equivalent to the following :

my_script || {
	git bisect start &&
	git bisect bad &&
	git bisect good good_rev &&
	git bisect run my_script
}

that could be used like this:

git bisect test good_rev my_script || {
	echo >&2 "my_script failed but 'git bisect test' failed too"
	exit 1
}
test -f "$GIT_DIR/BISECT_RUN" && {
	# extract commit and author email address from
	# "$GIT_DIR/BISECT_RUN" and send flames
	git bisect reset
}

Thanks,
Christian.
