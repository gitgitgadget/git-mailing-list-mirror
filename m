X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: How to view an old revision?
Date: Wed, 01 Nov 2006 08:00:13 -0800
Message-ID: <7vzmbb2m42.fsf@assigned-by-dhcp.cox.net>
References: <3bbc18d20611010620m11e40402v44334a8c486a4932@mail.gmail.com>
	<4548AFA2.1040606@shadowen.org>
	<3bbc18d20611010637s6d05aecbt98322b62cf7235e8@mail.gmail.com>
	<4548B32A.5030803@shadowen.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Wed, 1 Nov 2006 16:01:05 +0000 (UTC)
Cc: Matt McCutchen <hashproduct+git@gmail.com>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <4548B32A.5030803@shadowen.org> (Andy Whitcroft's message of
	"Wed, 01 Nov 2006 14:46:02 +0000")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30645>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GfIW1-0003gt-3d for gcvg-git@gmane.org; Wed, 01 Nov
 2006 17:00:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1946794AbWKAQAR (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 1 Nov 2006
 11:00:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946823AbWKAQAR
 (ORCPT <rfc822;git-outgoing>); Wed, 1 Nov 2006 11:00:17 -0500
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:47582 "EHLO
 fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP id S1946794AbWKAQAO
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 1 Nov 2006 11:00:14 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao12.cox.net
 (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP id
 <20061101160014.RPFR18180.fed1rmmtao12.cox.net@fed1rmimpo02.cox.net>; Wed, 1
 Nov 2006 11:00:14 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id hU0J1V00M1kojtg0000000 Wed, 01 Nov 2006
 11:00:19 -0500
To: Andy Whitcroft <apw@shadowen.org>
Sender: git-owner@vger.kernel.org

Andy Whitcroft <apw@shadowen.org> writes:

> Junio, I wonder if we should be changing the usage for this command
> slightly.  Currently, it mearly says <object> as the identifier for the
> blob.  Really this is <object-ish> as it supports symbolic naming in
> addition to raw sha1's.  I also feel it would be very helpful if
> <commit-ish> and family were documented as a glossary section in main
> git manpage.
>
> Something like this:
>
> <commit-ish>:: is an sha1 for a commit, or any symbolic name for a
> commit (see SPECIFYING REVISIONS in git-rev-parse)
>
> What do people think.  I can do the munging about if its seems like a
> sane plan.

When we really want an object of type <x>, we accept an object
that is not of type <x> if there is a natural and unique
dereferencing of that object to the type <x>.  We use word
<x-ish> to describe such an object that dereferences to <x>.
For example, ls-tree is about listing tree contents (so we want
a tree), but we accept a commit because the natural and unique
dereferencing of a commit to a tree is to take its (toplevel)
tree.  We also accept a tag pointing at a commit because we can
dereference it to the commit and then to its tree.  Hence a tag
that points at either commit or a tree, and a commit are
tree-ish.

<object> is an object which can be <commit>, <tree>, <tag> or
<blob>.  There is nothing -ish about it.

I was actually reviewing the documentation of git-rev-parse and
noticed that it talks about naming objects in the section called
"SPECIFYING REVISIONS".  The title implies that it is about
committish (because we think of "revisions" as something that is
used in walking commit ancestry chains), but it actually talks
about naming objects of any type.

It is a good and comprehensive list when viewed as "list of ways
you can name an object", but both the title and the page the
list appears in put unfair emphasis of commits for that purpose,
and it is hard to realize that what you learned there applies to
naming any type of objects.  It is even harder to guess the list
appears on that page, unless you are the one who is actively involved
in the git list, when you want to know which manual page to look
at in order to find out how you name an arbitrary object.

We could either

 (1) retitle the list and move it to git.txt (Symbolic
     Identifiers), and refer to it from pages that describe
     commands that take object names;

 (2) retitle the list and make it an includable snippet, similar
     to the way Documentation/diff-format.txt is used from pages
     that describe diff commands, and include it everywhere.

I am slightly in favor of the latter.  Although it has a bloat
factor in the generated documentation, docs are not novels and
not meant to be read from cover to cover, and duplicating
relevant information on each page is more useful than refering
the reader to jump around in the documentation set.
