From: Jeff King <peff@peff.net>
Subject: Re: check-attr doesn't respect recursive definitions
Date: Tue, 2 Apr 2013 10:31:30 -0400
Message-ID: <20130402143130.GC23828@sigill.intra.peff.net>
References: <slrnkldd3g.1l4.jan@majutsushi.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Jan Larres <jan@majutsushi.net>
X-From: git-owner@vger.kernel.org Tue Apr 02 16:32:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UN2Fn-0005hF-Bf
	for gcvg-git-2@plane.gmane.org; Tue, 02 Apr 2013 16:32:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932238Ab3DBObf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Apr 2013 10:31:35 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:52163 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761133Ab3DBObe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Apr 2013 10:31:34 -0400
Received: (qmail 9869 invoked by uid 107); 2 Apr 2013 14:33:23 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 02 Apr 2013 10:33:23 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 02 Apr 2013 10:31:30 -0400
Content-Disposition: inline
In-Reply-To: <slrnkldd3g.1l4.jan@majutsushi.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219774>

On Sat, Mar 30, 2013 at 09:45:51AM +0000, Jan Larres wrote:

> I am trying to write a custom archiving script that checks the
> export-ignore attribute to know which files from an ls-files output it
> should skip. Through this I noticed that for files in directories for
> which the export-ignore (or any other) attribute is set, check-attr
> still reports 'unspecified'. More precisely:
> 
> $ git init test
> Initialized empty Git repository in /home/jan/test/.git/
> $ cd test
> $ mkdir foo
> $ touch foo/bar
> $ echo "foo export-ignore" > .gitattributes
> $ git check-attr export-ignore foo
> foo: export-ignore: set
> $ git check-attr export-ignore foo/bar
> foo/bar: export-ignore: unspecified
> 
> I would expect the last command to also report 'set'. I've also tried
> other patterns like 'foo/' and 'foo*', but it didn't make any
> difference. Is this expected behaviour? It does make checking the
> attributes of single files somewhat more difficult.

Yes, it is the expected behavior, though I cannot offhand think of
anything that would break if we did apply it recursively.

> git-archive ignores the directory as expected, but unfortunately it
> doesn't have an option to just list the files it would archive instead
> of actually archiving them.

Yes, git-archive feeds the directories into the attribute machinery as
it traverses the tree, so it actually checks for attributes of "foo"
before recursing. You can do the same, but I agree it is quite a bit
more annoying than just piping "ls-files -z" into "check-attr --stdin
-z".

-Peff
