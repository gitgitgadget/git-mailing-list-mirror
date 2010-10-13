From: Jeff King <peff@peff.net>
Subject: Re: [RFC] Hidden refs
Date: Wed, 13 Oct 2010 13:35:55 -0400
Message-ID: <20101013173555.GA13188@sigill.intra.peff.net>
References: <4CB5CEA3.8020702@xiplink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Marc Branchaud <marcnarc@xiplink.com>
X-From: git-owner@vger.kernel.org Wed Oct 13 19:35:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P65Es-0002MI-5q
	for gcvg-git-2@lo.gmane.org; Wed, 13 Oct 2010 19:35:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752212Ab0JMRfe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Oct 2010 13:35:34 -0400
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:47023 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752156Ab0JMRfd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Oct 2010 13:35:33 -0400
Received: (qmail 301 invoked by uid 111); 13 Oct 2010 17:35:33 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (129.79.255.167)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Wed, 13 Oct 2010 17:35:33 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 13 Oct 2010 13:35:55 -0400
Content-Disposition: inline
In-Reply-To: <4CB5CEA3.8020702@xiplink.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158947>

On Wed, Oct 13, 2010 at 11:22:11AM -0400, Marc Branchaud wrote:

> We want to have our build system record, in our repo, which commits
> correspond to which builds.
> 
> Nominally, this is a job for tags.  But we don't want to have to look at
> these tags all the time.  We particularly just want to tag the repo when we
> make an actual release -- tags are a Big Deal for us.
> 
> Notes are an option, though they feel a bit heavy for this application.  And
> although we can store the build notes in their own refspace, it would (I
> believe) be a little clunky to make commands like checkout and log work with
> the commits that were noted by the build system.

Keep in mind that notes and tags are basically inverses as far as
efficient lookup goes. If you want to map a build name or number to a
commit, you would use a ref which points to a commit. But if you want to
map a commit sha1 to a build number, you would use notes.

> It struck me that it would be neat to have hidden refs in the refs/
> directory.  I experimented a bit with a "refs/.builds" directory:
> 
> * "git update-ref refs/.builds/One" fails with "Cannot lock the
>   ref 'refs/.builds/One'."  So I created a ref the regular way
>   (refs/blah/One) and copied the "One" file into refs/.builds/.

Yeah, I believe "." at the front of a directory component is explicitly
forbidden by check_ref_format. I don't recall whether there was a
specific rationale, or whether it was simply a can of worms we didn't
want to explore.

...

Look like it blames to 03feddd (git-check-ref-format: reject funny ref
names., 2005-10-13).  This looks like the relevant thread:

  http://article.gmane.org/gmane.comp.version-control.git/9874

but I didn't read through it carefully.

-Peff
