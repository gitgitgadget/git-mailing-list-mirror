From: Yann Dirson <dirson@bertin.fr>
Subject: Re: [BUG] Cannot push some grafted branches
Date: Mon, 17 Dec 2012 15:02:30 +0100
Organization: Bertin Technologies
Message-ID: <20121217150230.545a3938@chalon.bertin.fr>
References: <20121211153903.7522d6b0@chalon.bertin.fr>
 <7vd2yg8ngk.fsf@alter.siamese.dyndns.org>
 <20121212094432.6e1e48c8@chalon.bertin.fr>
 <7v38zb3ux0.fsf@alter.siamese.dyndns.org> <877goht6eu.fsf@pctrast.inf.ethz.ch>
 <20121217114058.449cbc3c@chalon.bertin.fr>
 <CAP8UFD2pkotNy=t5wTxDH-pMivQsTz-kw2y8Y7rWY42YKabp7g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Thomas Rast <trast@student.ethz.ch>,
	Junio C Hamano <gitster@pobox.com>,
	git list <git@vger.kernel.org>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 17 15:03:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TkbHf-00068h-P6
	for gcvg-git-2@plane.gmane.org; Mon, 17 Dec 2012 15:03:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752896Ab2LQOCr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Dec 2012 09:02:47 -0500
Received: from cabourg.bertin.fr ([195.68.26.10]:57385 "EHLO cabourg.bertin.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752687Ab2LQOCp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Dec 2012 09:02:45 -0500
Received: from cabourg.bertin.fr (localhost [127.0.0.1])
	by postfix.imss70 (Postfix) with ESMTP id 8083FA0F61
	for <git@vger.kernel.org>; Mon, 17 Dec 2012 15:02:44 +0100 (CET)
Received: from yport1.innovation.bertin.fr (yport1.bertin.fr [192.168.1.13])
	by cabourg.bertin.fr (Postfix) with ESMTP id 686A2A0F6D
	for <git@vger.kernel.org>; Mon, 17 Dec 2012 15:02:43 +0100 (CET)
Received: from chalon.bertin.fr ([172.16.1.1]) by yport1.innovation.bertin.fr
 (Sun Java System Messaging Server 6.2-8.04 (built Feb 28 2007))
 with ESMTPPA id <0MF600F9KHOITVA0@yport1.innovation.bertin.fr> for
 git@vger.kernel.org; Mon, 17 Dec 2012 15:02:43 +0100 (CET)
In-reply-to: <CAP8UFD2pkotNy=t5wTxDH-pMivQsTz-kw2y8Y7rWY42YKabp7g@mail.gmail.com>
X-Mailer: Claws Mail 3.8.1 (GTK+ 2.24.10; i486-pc-linux-gnu)
X-TM-AS-Product-Ver: IMSS-7.0.0.8220-6.8.0.1017-19456.007
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211685>

On Mon, 17 Dec 2012 14:43:59 +0100
Christian Couder <christian.couder@gmail.com> wrote:

> Hi Yann,
> 
> On Mon, Dec 17, 2012 at 11:40 AM, Yann Dirson <dirson@bertin.fr> wrote:
> > On Mon, 17 Dec 2012 09:43:53 +0100
> > Thomas Rast <trast@student.ethz.ch> wrote:
> >
> >> Junio C Hamano <gitster@pobox.com> writes:
> >>
> >>
> >> I suppose there's the additional issue that grafts are much easier to
> >> use than replacements if you really only want to replace some parent
> >> lists.  With replace you need to handcraft the replacement commits, and
> >> git-replace(1) unhelpfully does not say this, much less gives an example
> >> how to do it.
> >>
> >
> > Right, replace refs can surely be made easier to use.  The requirement to craft a
> > new commit manually is a major step back in ease of use.
> 
> Yeah, at one point I wanted to have a command that created to craft a
> new commit based on an existing one.
> Perhaps it could be useful when using filter-branch or perhaps it
> could reuse some filter-branch code.
> 
> > Maybe something like "git replace -p <orig-commit> <parent>..." to just provide a simple
> > API to the exact graft functionnality would be good.  But it would be commit-specific, whereas
> > replace refs are indeed more generic, and, one could want to rewrite any other part of the commit,
> > so we could prefer a more general mechanism.
> 
> Yeah I wondered at one point if something like the following would do:
> 
> git replace --parent <parent1> --parent <parent2> --author <author>
> --commiter <commiter> ... <orig-commit>

Yes, modification flags, that would only be allowed when the objects are commits, 
and would cause creation of a replace commit that's <orig-commit> plus modifications.
We could then reuse the relevant options from git-commit, and add the missing --parent.

But wouldn't it stretch git-replace too much, to add commit-specific behaviour there ?

> > Something that could be useful in this respect, would be an --amend like option to git-commit, like
> > "git commit --replace".  But unfortunately it does not allow to change parents, and it has the
> > drawback of requiring that HEAD points to the commit to be replaced.
> >
> > So maybe, if there are no other idea, a simple "git graft" command that would wrap "git replace",
> > would fill the gap.
> 
> It would not be straightforward to call it "graft" if it uses git replace.

Well, "git replace" would just be the "implementation detail".  The idea would be to keep
the concept of a "graft", and just change its implementation.  If we care (and we surely
do not, it's just a thought experiment ;), we could even provide, for pre-replace gits, a
"git graft" implementation that would manipulate info/grafts, together with a docpatch
saying that direct manipulation of info/grafts is deprecated.

-- 
Yann Dirson - Bertin Technologies
