From: "Alex Bennee" <kernel-hacker@bennee.com>
Subject: Re: parsecvs losing files
Date: Wed, 28 May 2008 17:53:30 +0100
Message-ID: <b2cdc9f30805280953l40ce9e37m1fb558e541ef89c3@mail.gmail.com>
References: <b2cdc9f30805280750v3b92d115yf76f382e5c2fa418@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 28 18:54:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K1Oux-0001Cv-Lq
	for gcvg-git-2@gmane.org; Wed, 28 May 2008 18:54:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751829AbYE1Qxc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 May 2008 12:53:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751762AbYE1Qxc
	(ORCPT <rfc822;git-outgoing>); Wed, 28 May 2008 12:53:32 -0400
Received: from rv-out-0506.google.com ([209.85.198.229]:5653 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751725AbYE1Qxb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 May 2008 12:53:31 -0400
Received: by rv-out-0506.google.com with SMTP id l9so3612278rvb.1
        for <git@vger.kernel.org>; Wed, 28 May 2008 09:53:30 -0700 (PDT)
Received: by 10.141.171.6 with SMTP id y6mr1399004rvo.85.1211993610147;
        Wed, 28 May 2008 09:53:30 -0700 (PDT)
Received: by 10.140.134.12 with HTTP; Wed, 28 May 2008 09:53:30 -0700 (PDT)
In-Reply-To: <b2cdc9f30805280750v3b92d115yf76f382e5c2fa418@mail.gmail.com>
Content-Disposition: inline
X-Google-Sender-Auth: 0c2ec64ff5b23604
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83110>

On Wed, May 28, 2008 at 3:50 PM, Alex Bennee <kernel-hacker@bennee.com> wrote:
> Hi,
> <snip>
> Anyway today I noticed it had failed to import a sub-directory of the
> project (not a bit I usually build). However looking at the import log
> from parsecvs I see that the file was read by parsecvs. It looks as
> though it should have made it into the git repo. The only thing that
> seems different from the other modules is that the files where
> imported once and don't seem to have been touched since. This may of
> caused parsecvs to get confused?

Well in answer to myself parsecvs does get confused. In an example
failed to import file:

Load:                          third-party/libxml/runtest.c,v   8207 of 79070
/export/git/master.cvs/third-party/libxml/runtest.c,v spliced:
	 1.1.1.1
	 1.1
Sorted heads for /export/git/master.cvs/third-party/libxml/runtest.c,v
	master 1.1
	master > BRANCH-3-5-branch 1.1.1.1.0.2
	master > BRANCH-3-5-16-branch 1.1.1.1.0.4
building branches for /export/git/master.cvs/third-party/libxml/runtest.c,v
file sha1: b694d565caf10fedbc7566f2bf15b893c57d5a19
file sha1: b694d565caf10fedbc7566f2bf15b893c57d5a19
file has 2 revisions

An lo, looking at the branches mentioned these missing files are
there. Trouble is the files should be in a number of branches, looking
at the ,v file in question:

head	1.1;
branch	1.1.1;
access;
symbols
	BRANCH-3-5-26-1:1.1.1.1
	BRANCH-3-5-25-1:1.1.1.1
	BRANCH-3-5-24-1:1.1.1.1
	BRANCH-3-5-22-3:1.1.1.1
	BRANCH-3-5-22-1:1.1.1.1
	BRANCH-3-5-21-1:1.1.1.1
	BRANCH-3-5-20-1:1.1.1.1
	BRANCH-3-5-16-7:1.1.1.1
	BRANCH-3-5-19-1:1.1.1.1
	BRANCH-3-5-16-6:1.1.1.1
	BRANCH-3-5-16-5:1.1.1.1
	BRANCH-3-5-18-1:1.1.1.1
	BRANCH-3-5-16-4:1.1.1.1
	BRANCH-3-5-16-branch:1.1.1.1.0.4
	BRANCH-3-5-17-1:1.1.1.1
	BRANCH-3-5-16-3:1.1.1.1
	BRANCH-3-5-16-2:1.1.1.1
	BRANCH-3-5-16-1:1.1.1.1
	post-merge-of-ajz-post-3-5-branch:1.1.1.1
	pre-merge-of-ajz-post-3-5-branch:1.1.1.1
	BRANCH-3-5-15-1:1.1.1.1
	BRANCH-3-5-14-1:1.1.1.1
	BRANCH-3-5-branch:1.1.1.1.0.2
	BRANCH-3-5-13-1:1.1.1.1
	BRANCH-3-5-12-1:1.1.1.1
	BRANCH-3-5-11-1:1.1.1.1
	BRANCH-3-5-10-1:1.1.1.1
	BRANCH-3-5-9-2:1.1.1.1
	BRANCH-3-3-20-red-e1-opt-branch:1.1.1.1
	GNOME_LIBXML2_2_6_29:1.1.1.1
	GNOME:1.1.1;
locks; strict;
comment	@ * @;


1.1
date	2007.08.16.15.59.35;	author jbpn;	state Exp;
branches
	1.1.1.1;
next	;

1.1.1.1
date	2007.08.16.15.59.35;	author jbpn;	state Exp;
branches;
next	;


desc
@@



1.1
log
@Initial revision
<snip rest of file>

I'm not sure why parsecvs got this wrong, I'm digging through it but
I'm a little fuzzy where lex/bison/whatever is involved. I notice
looking at the log for some of the files that did make it that the CVS
revisions for all the branches have a .0.[something] suffix which the
missing branches in this case don't have. However CVS is very sure the
file exists in these other branches.

Could this be something to do with explicit branches and sticky branch
tags? Or just a straight bug in parsecvs?


-- 
Alex, homepage: http://www.bennee.com/~alex/
