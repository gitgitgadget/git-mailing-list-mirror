From: Eli Barzilay <eli@barzilay.org>
Subject: `git check-attr' problems & questions
Date: Thu, 25 Mar 2010 23:57:00 -0400
Message-ID: <m3iq8jn3ar.fsf@winooski.ccs.neu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 26 04:57:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nv0fl-00069k-D4
	for gcvg-git-2@lo.gmane.org; Fri, 26 Mar 2010 04:57:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754234Ab0CZD5T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Mar 2010 23:57:19 -0400
Received: from lo.gmane.org ([80.91.229.12]:57870 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754083Ab0CZD5S (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Mar 2010 23:57:18 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1Nv0fc-000661-Rn
	for git@vger.kernel.org; Fri, 26 Mar 2010 04:57:16 +0100
Received: from winooski.ccs.neu.edu ([129.10.115.117])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 26 Mar 2010 04:57:16 +0100
Received: from eli by winooski.ccs.neu.edu with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 26 Mar 2010 04:57:16 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: winooski.ccs.neu.edu
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1 (gnu/linux)
Cancel-Lock: sha1:tslTeOMGs2rsL6JLeNN8BJw3rnY=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143207>

I'm trying to use .gitattributes to use some custom properties that we
have in an svn repository which is migrating to git, and there are
some two big problems with it that I'm running into:

1. Looks like the path should always be the full path from the root,
   even if I'm currently in a subdirectory, so:

     cd $repo/foo/bar
     git check-attr foo -- some-file # doesn't work
     git check-attr foo -- foo/bar/some-file # works

   Worse, if I happen to have an attribute for a toplevel `foo' file,
   the first command produces that attribute.

2. I'm also trying to use an attribute on a hook script on the server
   (with the idea that email notifications are sent according to the
   set of modified files) -- but it looks like `git check-attr'
   doesn't work on a bare repository.  There's a "worse" part here
   too: instead of showing an error, it actually succeeds after
   showing that the attribute is "unspecified".

So my first question is -- am I missing something obvious?  It almost
looks like `check-attr' is intended only for low-level use...

Fixing the first problem seems like it would be easy with a quick
shell script (maybe even with just an alias), but the second one is
more troubling.  Is there any way to do this on a bare repository
without checking it out?

And the last question -- is there anything that does something like
this customized email notifications that I'm trying to do?  (That is:
an attribute that determines recipients, then a `post-receive' hook
that builds a list of modified files, grabs all the corresponding
values of this attributes, and that's makes up the recipient list to
notify.)

-- 
          ((lambda (x) (x x)) (lambda (x) (x x)))          Eli Barzilay:
                    http://barzilay.org/                   Maze is Life!
