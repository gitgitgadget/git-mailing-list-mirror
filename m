From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH/RFC] Do not show "diff --git" metainfo with --no-prefix
Date: Tue, 15 Jan 2008 21:04:24 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0801152056030.13593@iabervon.org>
References: <c0f2d4110801150559x155ffabaj6bea52715522a070@mail.gmail.com> <alpine.DEB.1.00.0801151444180.5289@eeepc-johanness> <c0f2d4110801150758t68714570y83e1e74acbb67325@mail.gmail.com> <alpine.LNX.1.00.0801151728120.13593@iabervon.org>
 <7vhched3kw.fsf@gitster.siamese.dyndns.org> <7v4pded1rk.fsf_-_@gitster.siamese.dyndns.org> <alpine.LSU.1.00.0801160133150.17650@racer.site> <7vir1ubl0g.fsf@gitster.siamese.dyndns.org> <alpine.LSU.1.00.0801160152540.17650@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Chris Ortman <chrisortman@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jan 16 03:04:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JExeB-0000yn-B0
	for gcvg-git-2@gmane.org; Wed, 16 Jan 2008 03:04:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751620AbYAPCE1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jan 2008 21:04:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752170AbYAPCE1
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Jan 2008 21:04:27 -0500
Received: from iabervon.org ([66.92.72.58]:40519 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751585AbYAPCE0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jan 2008 21:04:26 -0500
Received: (qmail 12493 invoked by uid 1000); 16 Jan 2008 02:04:24 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 16 Jan 2008 02:04:24 -0000
In-Reply-To: <alpine.LSU.1.00.0801160152540.17650@racer.site>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70602>

On Wed, 16 Jan 2008, Johannes Schindelin wrote:

> Hi,
> 
> On Tue, 15 Jan 2008, Junio C Hamano wrote:
> 
> > Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> > 
> > >> diff --git a/diff.c b/diff.c
> > >> index b18c140..8126a74 100644
> > >> --- a/diff.c
> > >> +++ b/diff.c
> > >> @@ -1246,30 +1258,46 @@ static void builtin_diff(const char *name_a,
> > >>  	char *a_one, *b_two;
> > >>  	const char *set = diff_get_color_opt(o, DIFF_METAINFO);
> > >>  	const char *reset = diff_get_color_opt(o, DIFF_RESET);
> > >> +	int is_git_diff = with_standard_prefix(o);
> > >>  
> > >>  	a_one = quote_two(o->a_prefix, name_a + (*name_a == '/'));
> > >>  	b_two = quote_two(o->b_prefix, name_b + (*name_b == '/'));
> > >>  	lbl[0] = DIFF_FILE_VALID(one) ? a_one : "/dev/null";
> > >>  	lbl[1] = DIFF_FILE_VALID(two) ? b_two : "/dev/null";
> > >> -	printf("%sdiff --git %s %s%s\n", set, a_one, b_two, reset);
> > >> +
> > >> +	if (!is_git_diff)
> > >> +		printf("%sIndex: %s%s\n", set, b_two, reset);
> > >> +	else
> > >> +		printf("%sdiff --git %s %s%s\n", set, a_one, b_two, reset);
> > >> +
> > >
> > > Hmm.  AFAICT plain diff outputs "diff ...", not "Index: ...".  IMHO doing 
> > > half of what SVN does, and half what GNU diff does, but not completely 
> > > what something else does, does not help anybody.
> > >
> > > So I'm mildly negative on this hunk.
> > 
> > You misread the intention of the patch.
> > 
> > This whole point of this RFC patch is about not labelling a non-git 
> > patch that results from --no-prefix with "diff --git". As I said in my 
> > reply to Daniel, I do not like "Index:" myself, and doing printf("diff 
> > %s %s\n", a_one, b_two) instead would be perfectly fine by me.
> 
> Well, I commented on this hunk specifically, and think that the intention 
> of the patch would be better served by just conditionally omitting 
> "--git", and nothing else.

At most, I think, if a_one and b_two are identical, we could use the 
"Index:" form, since "diff -ur something something" is weird (how can 
"something" be different from itself?). If they're different, definitely 
use "diff %s %s".

	-Daniel
*This .sig left intentionally blank*
