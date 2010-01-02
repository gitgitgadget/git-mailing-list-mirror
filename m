From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v6 3/4] reset: add a few tests for "git reset --merge"
Date: Sat, 2 Jan 2010 06:58:11 +0100
Message-ID: <201001020658.12179.chriscool@tuxfamily.org>
References: <20091230055008.4475.95755.chriscool@tuxfamily.org> <20091230055448.4475.42383.chriscool@tuxfamily.org> <7v7hs2o16j.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jakub Narebski <jnareb@gmail.com>,
	Paolo Bonzini <bonzini@gnu.org>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Stephen Boyd <bebarino@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 02 06:55:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NQwxc-0004WK-Iv
	for gcvg-git-2@lo.gmane.org; Sat, 02 Jan 2010 06:55:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752502Ab0ABFzc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Jan 2010 00:55:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752476Ab0ABFzc
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Jan 2010 00:55:32 -0500
Received: from smtp3-g21.free.fr ([212.27.42.3]:48999 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752458Ab0ABFzb (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Jan 2010 00:55:31 -0500
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 0907D818075;
	Sat,  2 Jan 2010 06:55:21 +0100 (CET)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 19FB681804B;
	Sat,  2 Jan 2010 06:55:19 +0100 (CET)
User-Agent: KMail/1.9.9
In-Reply-To: <7v7hs2o16j.fsf@alter.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136023>

On vendredi 01 janvier 2010, Junio C Hamano wrote:
> Christian Couder <chriscool@tuxfamily.org> writes:
> > Commit 9e8eceab ("Add 'merge' mode to 'git reset'", 2008-12-01),
> > added the --merge option to git reset, but there were no test cases
> > for it.
> >
> > This was not a big problem because "git reset" was just forking and
> > execing "git read-tree", but this will change in a following patch.
> >
> > So let's add a few test cases to make sure that there will be no
> > regression.
> >
> > Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
>
> Looks good.

Thanks again.

> > +# The next test will test the following:
> > +#
> > +#           working index HEAD target         working index HEAD
> > +#           ----------------------------------------------------
> > +# file1:     C       C     C    D     --merge  D       D     D
> > +# file2:     C       D     D    D     --merge  C       D     D
> > +test_expect_success 'reset --merge is ok with changes in file it does
> > not touch' ' +    git reset --merge HEAD^ &&
> > +    ! grep 4 file1 &&
> > +    grep 4 file2 &&
> > +    test "$(git rev-parse HEAD)" = "$(git rev-parse initial)" &&
> > +    test -z "$(git diff --cached)"
> > +'
> > ...
> > +# The next test will test the following:
> > +#
> > +#           working index HEAD target         working index HEAD
> > +#           ----------------------------------------------------
> > +# file1:     C       C     C    D     --merge  D       D     D
> > +# file2:     C       C     D    D     --merge  D       D     D
> > +test_expect_success 'reset --merge discards changes added to index
> > (2)' ' +    git reset --hard second &&
> > +    echo "line 4" >> file2 &&
> > +    git add file2 &&
> > +    git reset --merge HEAD^ &&
> > +    ! grep 4 file2 &&
> > +    test "$(git rev-parse HEAD)" = "$(git rev-parse initial)" &&
> > +    test -z "$(git diff)" &&
> > +    test -z "$(git diff --cached)"
> > +'
>
> These two seem to duplicate the same case for file1; is it necessary?

No. I think I just copied the previous test and added the "git add file2" 
line.

> I am not pointing it out as something that needs to be removed; I am just
> puzzled and wondering if there is some interaction between the ways two
> paths are handled and the test is trying to check that (which I do not
> think is the case).

Best regards,
Christian.
