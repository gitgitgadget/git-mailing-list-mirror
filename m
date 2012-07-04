From: Jeff King <peff@peff.net>
Subject: Re: [BUG] serious inflate inconsistency on master
Date: Wed, 4 Jul 2012 03:24:12 -0400
Message-ID: <20120704072412.GC24807@sigill.intra.peff.net>
References: <20120703221900.GA28897@sigill.intra.peff.net>
 <7vipe4tqns.fsf@alter.siamese.dyndns.org>
 <CACsJy8AFs6PV8XCAUar9KadE8g-WSaZofKQAGPB6VjbhVpSRig@mail.gmail.com>
 <7vy5n0rq9c.fsf@alter.siamese.dyndns.org>
 <CACsJy8AH6HHxE-P4j4O_VtVzz6-pe2VWk5ZayOfbZomfX2z7sg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 04 09:24:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SmJwj-0001nM-Ch
	for gcvg-git-2@plane.gmane.org; Wed, 04 Jul 2012 09:24:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932986Ab2GDHYQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 4 Jul 2012 03:24:16 -0400
Received: from 99-108-225-23.lightspeed.iplsin.sbcglobal.net ([99.108.225.23]:52841
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755946Ab2GDHYQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Jul 2012 03:24:16 -0400
Received: (qmail 31082 invoked by uid 107); 4 Jul 2012 07:24:23 -0000
Received: from c-71-206-173-132.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.206.173.132)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 04 Jul 2012 03:24:23 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 04 Jul 2012 03:24:12 -0400
Content-Disposition: inline
In-Reply-To: <CACsJy8AH6HHxE-P4j4O_VtVzz6-pe2VWk5ZayOfbZomfX2z7sg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200991>

On Wed, Jul 04, 2012 at 02:01:06PM +0700, Nguyen Thai Ngoc Duy wrote:

> On Wed, Jul 4, 2012 at 1:31 PM, Junio C Hamano <gitster@pobox.com> wr=
ote:
> > Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:
> >
> >> By the way I searched the commit that introduces that check with "=
git
> >> log --follow -p builtin/index-pack.c" but I could not find it. Wha=
t
> >> did I do wrong?
> >
> > Your commit 8a2e163cc shows changes to the file at ll.535-540; thes=
e
> > come from 776ea370 builtin-index-pack.c ll.383-388.
> >
> > =C2=A0 $ git show 776ea370:builtin-index-pack.c
>=20
> git newbie's hat's on. How do you find 776ea370, git-blame? Another
> question is why doesn't git-log show that commit?

I used git-blame to find it. As to your second question, I believe it i=
s
one of the side-effects of the way --follow is bolted onto the revision
traversal. Look at:

  gitk -- builtin/index-pack.c builtin-index-pack.c

and you will see that the commit in question happened on a simultaneous
branch with the big builtin rename commit. Since we process 776ea370
before we hit the rename commit, we do not yet realize that
builtin-index-pack.c is of interest to us.

-Peff
