From: Yann Dirson <dirson@bertin.fr>
Subject: Re: [BUG] Cannot push some grafted branches
Date: Tue, 18 Dec 2012 14:41:57 +0100
Organization: Bertin Technologies
Message-ID: <20121218144157.00ccd915@chalon.bertin.fr>
References: <20121211153903.7522d6b0@chalon.bertin.fr>
 <7vd2yg8ngk.fsf@alter.siamese.dyndns.org>
 <20121212094432.6e1e48c8@chalon.bertin.fr>
 <7v38zb3ux0.fsf@alter.siamese.dyndns.org> <877goht6eu.fsf@pctrast.inf.ethz.ch>
 <20121217114058.449cbc3c@chalon.bertin.fr>
 <CAP8UFD2pkotNy=t5wTxDH-pMivQsTz-kw2y8Y7rWY42YKabp7g@mail.gmail.com>
 <m21ueo78f8.fsf@igel.home> <7vwqwgjs8f.fsf@alter.siamese.dyndns.org>
 <20121218120058.0c558ba5@chalon.bertin.fr> <50D05BAF.4000200@viscovery.net>
 <871uentthz.fsf@pctrast.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Junio C Hamano <gitster@pobox.com>,
	Andreas Schwab <schwab@linux-m68k.org>,
	Christian Couder <christian.couder@gmail.com>,
	Thomas Rast <trast@student.ethz.ch>,
	git list <git@vger.kernel.org>
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Tue Dec 18 14:42:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TkxR4-0000Nn-Fm
	for gcvg-git-2@plane.gmane.org; Tue, 18 Dec 2012 14:42:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754873Ab2LRNmA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Dec 2012 08:42:00 -0500
Received: from cabourg.bertin.fr ([195.68.26.10]:38303 "EHLO cabourg.bertin.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754830Ab2LRNl7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Dec 2012 08:41:59 -0500
Received: from cabourg.bertin.fr (localhost [127.0.0.1])
	by postfix.imss70 (Postfix) with ESMTP id 43DD8A0F61
	for <git@vger.kernel.org>; Tue, 18 Dec 2012 14:41:57 +0100 (CET)
Received: from yport1.innovation.bertin.fr (yport1.bertin.fr [192.168.1.13])
	by cabourg.bertin.fr (Postfix) with ESMTP id A5CDBA0F84
	for <git@vger.kernel.org>; Tue, 18 Dec 2012 14:41:56 +0100 (CET)
Received: from chalon.bertin.fr ([172.16.1.1]) by yport1.innovation.bertin.fr
 (Sun Java System Messaging Server 6.2-8.04 (built Feb 28 2007))
 with ESMTPPA id <0MF8006PIBDV0FC0@yport1.innovation.bertin.fr> for
 git@vger.kernel.org; Tue, 18 Dec 2012 14:41:55 +0100 (CET)
In-reply-to: <871uentthz.fsf@pctrast.inf.ethz.ch>
X-Mailer: Claws Mail 3.8.1 (GTK+ 2.24.10; i486-pc-linux-gnu)
X-TM-AS-Product-Ver: IMSS-7.0.0.8220-6.8.0.1017-19458.007
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211747>

On Tue, 18 Dec 2012 13:49:44 +0100
Thomas Rast <trast@inf.ethz.ch> wrote:

> Johannes Sixt <j.sixt@viscovery.net> writes:
> 
> > Am 12/18/2012 12:00, schrieb Yann Dirson:
> >> On Mon, 17 Dec 2012 13:14:56 -0800
> >> Junio C Hamano <gitster@pobox.com> wrote:
> >> 
> >>> Andreas Schwab <schwab@linux-m68k.org> writes:
> >>>
> >>>> Christian Couder <christian.couder@gmail.com> writes:
> >>>>
> >>>>> Yeah, at one point I wanted to have a command that created to craft a
> >>>>> new commit based on an existing one.
> >>>>
> >>>> This isn't hard to do, you only have to resort to plumbing:
> >>>>
> >>>> $ git cat-file commit fef11965da875c105c40f1a9550af1f5e34a6e62 |
> >>>> sed
> >>>> s/bfae342c973b0be3c9e99d3d86ed2e6b152b4a6b/790c83cda92f95f1b4b91e2ddc056a52a99a055d/
> >>>> | git hash-object -t commit --stdin -w
> >>>> bb45cc6356eac6c7fa432965090045306dab7026
> >>>
> >>> Good.  I do not think an extra special-purpose command is welcome
> >>> here.
> >> 
> >> Well, I'm not sure this is intuitive enough to be useful to the average user :)
> >
> > When I played with git-replace in the past, I imagined that it could be
> >
> >    git replace <object> --commit ...commit options...
> >
> > that would do the trick.
> >
> > We could implement it with a git-replace--commit helper script that
> > generates the replacement commit using the ...commit options... (to be
> > defined what this should be), and git-replace would just pick its output
> > (the SHA1 of the generated commit) as a substitute for the <replacement>
> > argument that would have to be given without the --commit option.
> 
> I wouldn't even want a script -- we'd end up inventing a complicated
> command-line editor for what can simply be done by judicious use of an
> actual text editor.  How about something like the following?

Well, while it does the job, it is still hardly as straightforward as the
old "vi .git/info/grafts", or as a single easily-remembered commandline.

I was again thinking the only commandline stuff that does not exist currently in
git-commit is specifying parents.  One possiblity would be to add such an
option to git-commit, together with a --replace flag that would cause the
new commit to attached a replace ref (not completely unlike --append, in that
we're doing some non-default action instead of just adding the changes to a
new commit).

But well, I don't think we would want to add to git-commit the ability of playing
with something else than what's in the index/worktree.  Abstracting the commit
commandline to make it reusable by a git-replace--commit and possibly other tools
that may want to rw-manipulate arbitrary commits could make sense ?


> 
>  Documentation/git-replace.txt | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git i/Documentation/git-replace.txt w/Documentation/git-replace.txt
> index 51131d0..2502118 100644
> --- i/Documentation/git-replace.txt
> +++ w/Documentation/git-replace.txt
> @@ -61,6 +61,27 @@ OPTIONS
>  	Typing "git replace" without arguments, also lists all replace
>  	refs.
>  
> +
> +EXAMPLE
> +-------
> +
> +Replacements (and before them, grafts) are often used to replace the
> +parent list of a commit.  Since commits are stored in a human-readable
> +format, you can in fact change any property using the following
> +recipe:
> +
> +------------------------------------------------
> +$ git cat-file commit original_commit >tmp
> +$ vi tmp
> +------------------------------------------------
> +In the editor, adjust the commit as needed.  For example, you can edit
> +the parent lists by adding/removing lines starting with "parent".
> +When done, replace the original commit with the edited one:
> +------------------------------------------------
> +$ git replace original_commit $(git hash-object -w tmp)

You probably meant "-t commit" - a sign that it's not so trivial to forge ?

> +------------------------------------------------
> +
> +
>  BUGS
>  ----
>  Comparing blobs or trees that have been replaced with those that
> 
> 


-- 
Yann Dirson - Bertin Technologies
