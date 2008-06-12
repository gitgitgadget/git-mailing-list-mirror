From: Stephan Beyer <s-beyer@gmx.net>
Subject: Re: [RFCv2/FYI] git-sequencer.txt
Date: Thu, 12 Jun 2008 17:29:28 +0200
Message-ID: <20080612152928.GB6848@leksak.fem-net>
References: <20080612002258.GC7200@leksak.fem-net> <48507C70.8010402@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jakub Narebski <jnareb@gmail.com>,
	Pierre Habouzit <madcoder@debian.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Christian Couder <chriscool@tuxfamily.org>
To: Paolo Bonzini <bonzini@gnu.org>
X-From: git-owner@vger.kernel.org Thu Jun 12 17:31:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K6ol8-0003RV-En
	for gcvg-git-2@gmane.org; Thu, 12 Jun 2008 17:30:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752512AbYFLP3f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Jun 2008 11:29:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751447AbYFLP3f
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jun 2008 11:29:35 -0400
Received: from mail.gmx.net ([213.165.64.20]:33888 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752512AbYFLP3e (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jun 2008 11:29:34 -0400
Received: (qmail invoked by alias); 12 Jun 2008 15:29:32 -0000
Received: from q137.fem.tu-ilmenau.de (EHLO leksak.fem-net) [141.24.46.137]
  by mail.gmx.net (mp004) with SMTP; 12 Jun 2008 17:29:32 +0200
X-Authenticated: #1499303
X-Provags-ID: V01U2FsdGVkX1+EszUoa5OEHyI8HfbzTQCZZybFia3IDE10NFFiN2
	wxCVSJOo8h5rBO
Received: from sbeyer by leksak.fem-net with local (Exim 4.69)
	(envelope-from <s-beyer@gmx.net>)
	id 1K6ojw-0008Ep-Lh; Thu, 12 Jun 2008 17:29:28 +0200
Content-Disposition: inline
In-Reply-To: <48507C70.8010402@gnu.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84760>

Hi,

On Wed, Jun 11, 2008 at 06:31:28PM -0700,
Paolo Bonzini <bonzini@gnu.org> wrote to git@vger.kernel.org:
>> 	--collect-signoffs;;
>> 		Collect the Signed-by-off: lines of each commit and
>> 		add them to the squashed commit message.
>
> I think this makes sense only if -m/-F/-C/-c (see later) is used,  
> because otherwise the default behavior would be to concatenate all  
> messages and call the editor, right?  Would it be a no-op if those  
> options are not given?

No, because the default behavior is cat it all together and call the
editor, the user sees in the editor:

	Message of commit 1

	Signed-off-by: A

	Message of commit 2

	Signed-off-by: B

	Message of commit 3

	Signed-off-by: A
	Signed-off-by: C

And with --collect-signoffs this could be like:

	Message of commit 1

	Message of commit 2

	Message of commit 3

	Signed-off-by: A
	Signed-off-by: B
	Signed-off-by: C

>> tag <tag>::
>> 	Set tag `<tag>` to the current HEAD,
>> 	see also linkgit:git-tag[1].
>> 	If another commit is tagged `<tag>`, it will lose this tag,
>> 	i.e. the tag will be reset to HEAD.
>
> Is this a lightweight or a heavyweight tag?  I guess lightweight -- the  
> tag command should probably support -a, -s and -u like git-tag does.  
> Unless -c/-C/-F/-m is given, the sequencer will then run the editor.

It is a lightweight tag currently.
Well, I've taken it because it was in rebase-i of "next" and currently
I use it because it makes one merge test case really simple by tagging
the parents of the planned merge.

I don't know if it is really useful to sequencer users and I don't know
if its better to drop from the documentation but keep it for my test 
case ;-)

Because I'm pretty unsure about it, I didn't change anything on "tag" 
after Junio's complaints about it.

>> -C <commit-ish>::
>> --reuse-commit=<commit-ish>::
>> --reference=<commit-ish>::
>> 	Reuse message and authorship data from specified commit.
>
> Why --reference?

I know that it's inconsistent to git-commit and I hoped nobody would
notice. ;-)

The reason why I didn't want `-C' to be `--reuse-message' is:
 1. it is a misleading long option name, and
 2. some days ago the long option was not really documented,
    so everyone and everything is using -C.
    (See
	git show bc47c29
     and/or
	git grep -e reuse-message
     in git.git)

I think that --reuse-commit is much less misleading, since 
--reuse-message-and-authorship is too long ;-)
And Joerg Sommer's patchset which migrated to next introduced the
term "reference merge" (see "git show d9711a80", the first "die" in the
first hunk), and I thought the term "reference" is nicer than
"reuse message and authorship". But, of course, I also see the
disadvantage that it can be mixed up with refs.

I still vote for "-C/--reuse-commit" and because nobody and
nothing uses --reuse-message in git-commit I even dare propose
to change it to --reuse-commit there.

>> -M <commit-ish>
>> --reuse-message=<commit-ish>::
>> 	Reuse message from specified commit.
>> 	Note, that only the commit message is reused
>> 	and not the authorship information.

This is something I'd like to keep.

> For consistency with git-commit I would think it's better to have
>
>   -c <commit-ish>::
>   -C <commit-ish>::
>   --reedit-message=<commit-ish>::
>   --reuse-message=<commit-ish>::
> 	Take existing commit object, and reuse the log message and the
>         authorship information (including the timestamp) when creating
>         the commit. With -C (or --reuse-message), the editor is not
> 	invoked; with -c (or --reedit-message) the user can further edit
> 	the commit message.
>
> (I know it's confusing that it's reusing the message too, but...)

Later you speak of using the -e option to force edit of the message.
I think that "-c" is not needed if you can use "-C f00babe -e".

> and then a separate option:
>
>   -A
>   --author-override::
> 	Force authorship information for commits created by the command
> 	to be the data in git's configuration files.
>
> ... if it is not too complicated to implement.

Currently you can pass --author as a general option.
Perhaps this is not as easy to handle for the user, but if we
really really really want the -A/--author-override, we can add it later.

> To satisfy Pierre's comment, you might also add a "-e" general option,  
> which forces an invocation of the editor -- even if -C/-m/-F are given,  
> and even if the command is pick/patch/merge.  I guess that in order to  
> support -C/-m/-F you already have to use git-cherry-pick and git-merge's  
> --no-commit options, so it should not be hard to implement.

I hoped someone will come up with -e ;-)
So "reinvent" a general option -e/--edit that just goes sure to invoke
an editor should be fine.

Regards,
  Stephan

-- 
Stephan Beyer <s-beyer@gmx.net>, PGP 0x6EDDD207FCC5040F
