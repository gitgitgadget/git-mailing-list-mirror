X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Sergey Vlasov <vsu@altlinux.ru>
Subject: Re: [PATCH] Make git-clone --use-separate-remote the default
Date: Fri, 24 Nov 2006 14:32:00 +0300
Message-ID: <20061124143200.52aa1901.vsu@altlinux.ru>
References: <20061123225835.30071.99265.stgit@machine.or.cz>
	<7vejrtiwqd.fsf@assigned-by-dhcp.cox.net>
	<20061123234203.GN7201@pasky.or.cz>
	<7vlkm1hf57.fsf@assigned-by-dhcp.cox.net>
	<7vzmahe6qe.fsf@assigned-by-dhcp.cox.net>
	<7vpsbde4fy.fsf@assigned-by-dhcp.cox.net>
	<ek6glc$pn$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Fri__24_Nov_2006_14_32_00_+0300_+5P7Ae3dViLErN8E"
NNTP-Posting-Date: Fri, 24 Nov 2006 11:32:25 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <ek6glc$pn$1@sea.gmane.org>
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.10.2; i586-alt-linux-gnu)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32210>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GnZHx-0000Ov-JB for gcvg-git@gmane.org; Fri, 24 Nov
 2006 12:32:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932502AbWKXLcK (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 24 Nov 2006
 06:32:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933060AbWKXLcK
 (ORCPT <rfc822;git-outgoing>); Fri, 24 Nov 2006 06:32:10 -0500
Received: from mivlgu.ru ([81.18.140.87]:57280 "EHLO mail.mivlgu.ru") by
 vger.kernel.org with ESMTP id S932502AbWKXLcI (ORCPT
 <rfc822;git@vger.kernel.org>); Fri, 24 Nov 2006 06:32:08 -0500
Received: from center4.mivlgu.local (center4.mivlgu.local [192.168.1.4]) by
 mail.mivlgu.ru (Postfix) with SMTP id 539E7804E; Fri, 24 Nov 2006 14:32:05
 +0300 (MSK)
To: Salikh Zakirov <Salikh.Zakirov@Intel.com>
Sender: git-owner@vger.kernel.org

--Signature=_Fri__24_Nov_2006_14_32_00_+0300_+5P7Ae3dViLErN8E
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

On Fri, 24 Nov 2006 13:14:00 +0300 Salikh Zakirov wrote:

> git-push.1 has following description:
>
>     Some short-cut notations are also supported.
>
>               o   tag <tag> means the same as refs/tags/<tag>:refs/tags/<tag>.

BTW, this is broken (and was broken even in 1.4.3.x):

$ mkdir ~/tmp/test_repo
$ ( cd ~/tmp/test_repo; git-init-db )
defaulting to local storage area
$ git push ~/tmp/test_repo tag v1.4.4.1
error: src refspec tag does not match any.
error: dst refspec tag does not match any existing ref on the remote and does not start with refs/.
fatal: unexpected EOF

Omitting the "tag" word works:

$ git push ~/tmp/test_repo v1.4.4.1
updating 'refs/tags/v1.4.4.1'
  from 0000000000000000000000000000000000000000
  to   21dff5f4982333d694d105595a701540d4d0d1db
Generating pack...
Done counting 28130 objects.
Deltifying 28130 objects.
 100% (28130/28130) done
Writing 28130 objects.
 100% (28130/28130) done
Total 28130, written 28130 (delta 19344), reused 27628 (delta 18891)
refs/tags/v1.4.4.1: 0000000000000000000000000000000000000000 -> 21dff5f4982333d694d105595a701540d4d0d1db

Seems that nobody really uses the "tag NAME" syntax...

>               o  A parameter <ref> without a colon is equivalent to
>                  <ref>:<ref>, hence updates <ref>  in
>                  the destination from <ref> in the source.
>
> Maybe this is only my reading of manual page, but I understood
> it like it does not leave the room for ambiguity, because it is using
> _the same_ refspec as the local one.
>
> That's why, when I do
>
>    git-push repo x
>
> and it results in
>
>    git-push repo refs/heads/x:refs/remotes/origin/x
>
> instead of expected
>
>    git-push repo refs/heads/x:refs/heads/x
>
> just because the remote repo did not have refs/heads/x, but happened
> to have refs/remotes/origin/x, would be highly surprising to me.

Such interpretation would indeed be horrible, but I'm afraid this is
exactly the case now:

$ mkdir ~/tmp/test_repo
$ ( cd ~/tmp/test_repo; git-init-db )
defaulting to local storage area
$ git push ~/tmp/test_repo v1.4.0^0:refs/remotes/origin/master
updating 'refs/remotes/origin/master' using 'v1.4.0^0'
  from 0000000000000000000000000000000000000000
  to   41292ddd37202ff6dce34986c87a6000c5d3fbfa
Generating pack...
Done counting 19857 objects.
Deltifying 19857 objects.
 100% (19857/19857) done
Writing 19857 objects.
 100% (19857/19857) done
Total 19857, written 19857 (delta 13472), reused 19038 (delta 12884)
refs/remotes/origin/master: 0000000000000000000000000000000000000000 -> 41292ddd37202ff6dce34986c87a6000c5d3fbfa

$ git push ~/tmp/test_repo master
updating 'refs/remotes/origin/master' using 'refs/heads/master'
  from 41292ddd37202ff6dce34986c87a6000c5d3fbfa
  to   e945f95157c2c515e763ade874931fc1eb671a0b
Generating pack...
Done counting 8667 objects.
Result has 8278 objects.
Deltifying 8278 objects.
 100% (8278/8278) done
Writing 8278 objects.
 100% (8278/8278) done
Total 8278, written 8278 (delta 5924), reused 7396 (delta 5065)
refs/remotes/origin/master: 41292ddd37202ff6dce34986c87a6000c5d3fbfa -> e945f95157c2c515e763ade874931fc1eb671a0b

BTW, I cannot find the description of the matching algorithm used by
connect.c:count_refspec_match() anywhere in the git-push or git-fetch
man page, and I cannot understand why this algorithm is different from
the default search order ($name, refs/$name, refs/tags/$name,
refs/heads/$name, refs/remotes/$name, refs/remotes/$name/HEAD).

> The expected behaviour on 'git-push repo x' in my understanding is
> 1) git finds the exact reference for 'x' (i.e. either refs/heads/x or
> refs/tags/x) according to local lookup rules
> 2) git uses the found reference _unambiguously_ to create or update
> exactly the same reference in the remote repo.
>
> Am I the only one to have this understanding?

The problem is that "$x" and "$x:$x" would be not equivalent anymore,
unless we add a special case for "$x:$y" where $x == $y - hmm, but the
current code seems to have that special case:

			else if (!strcmp(rs[i].src, rs[i].dst) &&
				 matched_src) {
				/* pushing "master:master" when
				 * remote does not have master yet.
				 */

(but that code triggers only in case we did not find any matching ref in
the destination repo).

--Signature=_Fri__24_Nov_2006_14_32_00_+0300_+5P7Ae3dViLErN8E
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFFZtg1W82GfkQfsqIRAq6NAJ4qfD7RJ65P7oUY2K1n2Y22EGKAxgCgk4AR
yLGC7Jbvdblk7jQfhIuy80c=
=r/E4
-----END PGP SIGNATURE-----

