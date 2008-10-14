From: Matt McCutchen <matt@mattmccutchen.net>
Subject: Re: [PATCH try 2] t1301-shared-repo.sh: don't let a default ACL
	interfere with the test
Date: Tue, 14 Oct 2008 19:00:27 -0400
Message-ID: <1224025227.2699.13.camel@mattlaptop2.local>
References: <1224022020.2699.4.camel@mattlaptop2.local>
	 <1224022216.2699.5.camel@mattlaptop2.local>
	 <7vzll66c5u.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 15 01:02:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KpsuQ-0003vG-N4
	for gcvg-git-2@gmane.org; Wed, 15 Oct 2008 01:02:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755035AbYJNXBT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Oct 2008 19:01:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755018AbYJNXBT
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Oct 2008 19:01:19 -0400
Received: from sd-green-bigip-83.dreamhost.com ([208.97.132.83]:43398 "EHLO
	jankymail-a4.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754947AbYJNXBS (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 14 Oct 2008 19:01:18 -0400
X-Greylist: delayed 3206 seconds by postgrey-1.27 at vger.kernel.org; Tue, 14 Oct 2008 19:01:18 EDT
Received: from [129.2.207.232] (ml2.student.umd.edu [129.2.207.232])
	by jankymail-a4.g.dreamhost.com (Postfix) with ESMTP id 2FB1618112B;
	Tue, 14 Oct 2008 16:01:17 -0700 (PDT)
In-Reply-To: <7vzll66c5u.fsf@gitster.siamese.dyndns.org>
X-Mailer: Evolution 2.22.3.1 (2.22.3.1-1.fc9) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98222>

On Tue, 2008-10-14 at 15:32 -0700, Junio C Hamano wrote:
> Matt McCutchen <matt@mattmccutchen.net> writes:
> > This test creates files with several different umasks and expects the files to
> > be permissioned according to the umasks, so a default ACL on the test dir causes
> 
> Is "to permission" a verb?

I thought it could be, but I'll reword that sentence.

> > the test to fail.  To avoid that, remove the default ACL if possible with
> > setfacl(1).  (Will work on many systems.)
> 
> It is not clear in the comment in parentheses what provision you have made
> not to harm people on systems without setfacl.
> 
> I think "if possible" which you already have is a good enough description
> (i.e. "if setfacl fails we do not barf and if you do not have the command
> you probably are not running with a funky default ACL to see this issue
> anyway"), so I'd rather drop the comment in parentheses.

Sure.

> > Signed-off-by: Matt McCutchen <matt@mattmccutchen.net>
> > ---
> > This time with a signoff.
> >
> >  t/t1301-shared-repo.sh |    3 +++
> >  1 files changed, 3 insertions(+), 0 deletions(-)
> >
> > diff --git a/t/t1301-shared-repo.sh b/t/t1301-shared-repo.sh
> > index dc85e8b..2275caa 100755
> > --- a/t/t1301-shared-repo.sh
> > +++ b/t/t1301-shared-repo.sh
> > @@ -7,6 +7,9 @@ test_description='Test shared repository initialization'
> >  
> >  . ./test-lib.sh
> >  
> > +# Remove a default ACL from the test dir if possible.
> > +setfacl -k . 2>/dev/null
> > +
> 
> Makes me wonder why this is _not_ inside test-lib.sh where it creates the
> test (trash) directory.  That way, you would cover future tests that wants
> to see a saner/simpler POSIX permission behaviour, wouldn't you?

Yes.  However, I don't anticipate there being any tests specifically
about file permissions other than t1301-shared-repo.sh, and if the user
has set a default ACL on the git source tree, we might want to let trash
directories obey that setting except in the one case where it breaks the
test.  What do you think?

Matt
