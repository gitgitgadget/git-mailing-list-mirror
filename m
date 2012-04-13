From: Jeff King <peff@peff.net>
Subject: Re: git bug: moved file with local unstaged changes are lost during
 merge
Date: Fri, 13 Apr 2012 02:49:41 -0400
Message-ID: <20120413064941.GC27214@sigill.intra.peff.net>
References: <CAAZnV3Einocd4TJ0iqcxPJNsr44j3RwhczS9OhyURX0faGWgBQ@mail.gmail.com>
 <CAAZnV3EwZ6kminW7D3ssn_Rtj2SsMHd++VCx7w14K5rQKba4_g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Elijah Newren <newren@gmail.com>, git@vger.kernel.org
To: Joe Angell <joe.d.angell@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 13 08:50:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SIaKk-0005VD-EV
	for gcvg-git-2@plane.gmane.org; Fri, 13 Apr 2012 08:50:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755313Ab2DMGuI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 13 Apr 2012 02:50:08 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:33013
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752044Ab2DMGuG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Apr 2012 02:50:06 -0400
Received: (qmail 5034 invoked by uid 107); 13 Apr 2012 06:49:50 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 13 Apr 2012 02:49:50 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 13 Apr 2012 02:49:41 -0400
Content-Disposition: inline
In-Reply-To: <CAAZnV3EwZ6kminW7D3ssn_Rtj2SsMHd++VCx7w14K5rQKba4_g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195403>

On Thu, Apr 12, 2012 at 10:13:04AM -0600, Joe Angell wrote:

> Is this the right place to post bug reports?

It is. Thanks for including a concise test case with your bug report.

Unfortunately, the merge-recursive code is a mess, and has several know=
n
buggy corner cases with renames. Elijah (cc'd) spent a lot of time
trying to sort these out a while ago, but there still some known
failures. t6042 and t6036 detect some of them. But I thought we managed
to clean up all of the overwriting bugs.

Original bug report is below.

-Peff

> On Wed, Apr 11, 2012 at 12:20 PM, Joe Angell <joe.d.angell@gmail.com>=
 wrote:
> > What steps will reproduce the problem?
> > git init
> > echo "initial checkin" >> readme
> > git add readme
> > git commit -m "inital checkin"
> > git branch b1
> > git checkout b1
> > echo "b1" >> readme
> > git add readme
> > git commit -m "b1 readme"
> > git checkout master
> > git mv readme readme_master
> > git ci -m "moved readme"
> > echo "master" >> readme_master
> > git merge b1
> >
> > What is the expected output? What do you see instead?
> > I expect to have git prevent the merge due to local changes to the
> > file. =C2=A0Instead it overwrites the file (erasing the local modif=
ication
> > "master") and you end up with:
> > cat readme_master
> > initial readme
> > b1
> >
> > What version of the product are you using? On what operating system=
?
> > Reproduced on 1.7.9.6 and from the git-core repo 1.7.10.128.g7945c.
> > This is on ubuntu 10.04.
> >
> > Please provide any additional information below.
> >
> > This problem only seems to occur after you check in the move, then
> > make local modifications, then do the merge.
> >
> > --
> > ---------------
> > Joe Angell
> > cell: (720) 260-2190
