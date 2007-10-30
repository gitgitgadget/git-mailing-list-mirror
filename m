From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH 0/4] Build in some more things
Date: Tue, 30 Oct 2007 12:37:19 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0710301147310.7357@iabervon.org>
References: <Pine.LNX.4.64.0710292049450.7357@iabervon.org>
 <7vzly1nhmn.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 30 17:37:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Imu5x-0005Df-2r
	for gcvg-git-2@gmane.org; Tue, 30 Oct 2007 17:37:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752117AbXJ3QhX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Oct 2007 12:37:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752275AbXJ3QhW
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Oct 2007 12:37:22 -0400
Received: from iabervon.org ([66.92.72.58]:47185 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750894AbXJ3QhV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Oct 2007 12:37:21 -0400
Received: (qmail 28535 invoked by uid 1000); 30 Oct 2007 16:37:19 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 30 Oct 2007 16:37:19 -0000
In-Reply-To: <7vzly1nhmn.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62667>

On Tue, 30 Oct 2007, Junio C Hamano wrote:

> I've merged this to 'pu', but honestly speaking, the conflicts
> are geting a bit more "interesting" than I care to keep
> repeating even with help from rerere, with four people
> simultaneously touching the neighbouring code in their topics.

I mostly actually care about [PATCH 1/4] which is also probably the 
easiest to validate (since it really shouldn't change anything that 
matters except to make things work in more cases). If I could get that in 
early, I'd be fine with pushing the rest off until other people are out of 
that code. The reason I care about 1/4 is that it also sets up an 
extensive patch to make the fetch side of transport use the same git 
connection for getting the initial list of remote refs and for fetching 
their content (still with a second connection for auto-following tags, 
since I couldn't figure out how to request more content after examining 
some fetched content); this patch miraculously doesn't seem to 
significantly conflict with anything currently in pu, and actually 
provides a user-visible benefit (ssh transport with no special 
infrastructure doesn't require typing the password multiple times for a 
single logical operation most of the time).

On the other hand, [PATCH 2/4] might be worth floating earlier in pu, 
since its conflicts are to simply remove all of the code that the other 
patches update (since that code duplicates code in transport.c that can be 
used instead).

For the builtin-send-pack stuff, I might as well redo the same logical 
changes to the code once it settles down, since the edit sequence for 3/4 
is really not all that well represented by diff, being very nearly "rename 
a bunch of static globals; mark a bunch of things const; move a 
function call down; split a function in half", and I can just redo that 
after all the other changes.

> Topics involved are:
> 
> ** db/remote-builtin (Mon Oct 29 22:03:42 2007 -0400) 4 commits
>  . Use built-in send-pack.
>  . Build-in send-pack, with an API for other programs to call.
>  . Build-in peek-remote, using transport infrastructure.
>  . Miscellaneous const changes and utilities
> 
> *  jk/send-pack (Thu Oct 18 02:17:46 2007 -0400) 2 commits
>  + t5516: test update of local refs on push
>  + send-pack: don't update tracking refs on error
> 
> *  js/forkexec (Fri Oct 19 21:48:06 2007 +0200)
>  + Use start_command() in git_connect() instead of explicit
>    fork/exec.
>  + Change git_connect() to return a struct child_process instead of a
>    pid_t.
> 
> ** sp/push-refspec (Sun Oct 28 18:46:21 2007 +0100)
>  . push: teach push to pass --verbose option to transport layer
>  . push: use same rules as git-rev-parse to resolve refspecs
>  . add ref_abbrev_matches_full_with_rev_parse_rules() comparing
>    abbrev with full ref name
>  . rename ref_matches_abbrev() to
>    ref_abbrev_matches_full_with_fetch_rules()
> 
> Could you please check the result after I push it out?

I agree with all of the conflict resolutions, although I didn't make sure 
that parts that didn't get conflicts merged correctly (but, if it builds, 
it's almost certainly right).

	-Daniel
*This .sig left intentionally blank*
