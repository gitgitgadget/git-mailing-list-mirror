From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH] Bisect: add checks at the beginning of "git bisect run".
Date: Wed, 28 Mar 2007 09:52:56 +0200
Message-ID: <200703280952.57058.chriscool@tuxfamily.org>
References: <20070327064957.34dad72a.chriscool@tuxfamily.org> <200703280544.47569.chriscool@tuxfamily.org> <7vk5x1ly2g.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed Mar 28 09:44:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HWSq1-0003jk-H8
	for gcvg-git@gmane.org; Wed, 28 Mar 2007 09:44:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752590AbXC1Hot convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 28 Mar 2007 03:44:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933455AbXC1Hot
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Mar 2007 03:44:49 -0400
Received: from smtp1-g19.free.fr ([212.27.42.27]:36865 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752590AbXC1Hos convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 28 Mar 2007 03:44:48 -0400
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 92AF6B62BA;
	Wed, 28 Mar 2007 09:44:46 +0200 (CEST)
User-Agent: KMail/1.9.5
In-Reply-To: <7vk5x1ly2g.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43356>

Le mercredi 28 mars 2007 07:46, Junio C Hamano a =E9crit :
> >
> > --not
> > mark current revision as bad instead of good and as good instead of=
 bad
>
> Do you mean this is a useful option when the "run-script"
> reports failure with 0 exit and success with non-zero exit?  In
> other words, exit code has reversed meanings from the usual?

Yes, for example to find when a string first appeared in a file one cou=
ld=20
use:

git bisect run --not grep string my_file

instead of something like

git bisect run ! grep string my_file

or

git bisect run 'grep string my_file ; test $? -ne 0'

> > --good <rev1>
> > --bad <rev2>
> > use rev1 as good and rev2 as bad
>
> I am not sure what you mean by these two.

=46or example one could write:

git bisect run --good rev1 --bad rev2 my_script

instead of

git bisect start
git bisect good rev1
git bisect bad rev2
git bisect run my_script

> > --check or --test
> > run the script once and then do nothing if the result is good
>
> How would you use this?=20

=46or example if you know that the last nightly build=20
tagged "nightly_2007_03_27" was ok, you could use:

git bisect start
git bisect good nightly_2007_03_27
git bisect run --check make > /dev/null || {
	# extract commit and author email address from "$GIT_DIR/BISECT_RUN"
	#=A0and send flame to author who broke the build with the commit
}

to automatically check that current source code builds ok.

Or you could use it in some test suites to automatically find the first=
 bad=20
commit (and be able to flame the author :-) in case one test fails.

Christian.
