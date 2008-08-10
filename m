From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [PATCH 2/3 v2] Teach git diff-tree --stdin to diff trees
Date: Sun, 10 Aug 2008 17:38:48 +0200
Message-ID: <20080810153848.GA28032@diana.vm.bytemark.co.uk>
References: <20080809095605.GA10804@diana.vm.bytemark.co.uk> <20080809120816.11085.66578.stgit@yoghurt> <7vwsip53bg.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Aug 10 17:17:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KSCg3-0004ug-DB
	for gcvg-git-2@gmane.org; Sun, 10 Aug 2008 17:17:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753414AbYHJPQs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 10 Aug 2008 11:16:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753424AbYHJPQs
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Aug 2008 11:16:48 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:4751 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753056AbYHJPQs (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Aug 2008 11:16:48 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1KSD0K-00087Z-00; Sun, 10 Aug 2008 16:38:48 +0100
Content-Disposition: inline
In-Reply-To: <7vwsip53bg.fsf@gitster.siamese.dyndns.org>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91843>

On 2008-08-09 13:41:23 -0700, Junio C Hamano wrote:

> Karl Hasselstr=F6m <kha@treskal.com> writes:
>
> > When diffing trees (either specified on the command line or from
> > the standard input), the -m, -s, -v, --pretty, --abbrev-commit,
> > --encoding, --no-commit-id, -c, --cc, and --always options are
> > ignored, since they do not apply to trees.
>
> I've commented on this part already; -m, -c, --cc are excluded
> because they make sense only when you are dealing with three or more
> trees.

=46ixed.

> > +	if (len !=3D 82 || !isspace(line[40]) || get_sha1_hex(line + 41, =
sha1)) {
> > +		error("Need precisely two trees, separated by one space");
> > +		return -1;
> > +	}
>
> error() returns -1, so:
>
> 	if (len !=3D 82 || !isspace(line[40]) || get_sha1_hex(line + 41, sha=
1))
> 		return error("Need two trees, separated by one space");

=46ixed.

> > +	tree2 =3D lookup_tree(sha1);
> > +	if (!tree2 || parse_tree(tree2))
> > +		return -1;
>
> Don't you want to make error() say something here as well?

Looking at lookup_tree() and parse_tree(), I got the impression that
they take care of that themselves. Do they miss some case that I need
to cover?

> > +	printf("%s %s\n", sha1_to_hex(tree1->object.sha1),
> > +			  sha1_to_hex(tree2->object.sha1));
>
> Since this is strictly for Porcelain's use, you may want to document
> this output format.

Yes. Fixed.

> Two-tree form from the command line does not have anything like
> this, and two-commit form from --stdin have either a single object
> name, the log message under -v or --pretty options. I notice that
> these are not documented but we may want to document it while at it.

I'll whip something up and send it out as a separate patch.

> Other than that, the patch looks good. Thanks.

Thanks for the feedback.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
