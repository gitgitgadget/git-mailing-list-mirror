From: Jeff King <peff@peff.net>
Subject: Re: Large number of object files
Date: Wed, 24 Oct 2012 03:11:09 -0400
Message-ID: <20121024071109.GB29403@sigill.intra.peff.net>
References: <CAMJd5AS1=Cf--0=1Xynxf1J-22fxBq05XjNGMcUep+ndAOO7ig@mail.gmail.com>
 <CACsJy8CcMBJLV=urVoWOQABQzQkC6y35spPF+_3fW6dtJjHtvg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Uri Moszkowicz <uri@4refs.com>, git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 24 09:11:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TQv7d-0007BV-UF
	for gcvg-git-2@plane.gmane.org; Wed, 24 Oct 2012 09:11:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934340Ab2JXHLO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Oct 2012 03:11:14 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:53739 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933861Ab2JXHLN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Oct 2012 03:11:13 -0400
Received: (qmail 27165 invoked by uid 107); 24 Oct 2012 07:11:52 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 24 Oct 2012 03:11:52 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 24 Oct 2012 03:11:09 -0400
Content-Disposition: inline
In-Reply-To: <CACsJy8CcMBJLV=urVoWOQABQzQkC6y35spPF+_3fW6dtJjHtvg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208294>

On Wed, Oct 24, 2012 at 01:59:16PM +0700, Nguyen Thai Ngoc Duy wrote:

> On Wed, Oct 24, 2012 at 12:21 PM, Uri Moszkowicz <uri@4refs.com> wrote:
> > Continuing to work on improving clone times, using "git gc
> > --aggressive" has resulted in a large number of tags combining into a
> > single file but now I have a large number of files in the objects
> > directory - 131k for a ~2.7GB repository.
> 
> Can you paste "git count-objects -v"? I'm curious why gc keeps so many
> loose objects around.

Presumably ejected from the pack because they are now unreachable.
That's a rather large number, but if there was recent ref maintenance
(e.g., deleting branches or tags), it is not impossible.

> > Any way to reduce the number of these files to speed up clones?
> 
> An easy way to get rid of them is to clone the non-local way.
> Everything will be sent over a pack, the result would be a single pack
> in new repo. Try "git clone file:///path/to/source/repo new-repo".

If you have git v1.7.12 or greater, you can also use the "--no-local"
option to clone. But as you mentioned, pruning is probably the most
sensible thing (and for a non-local clone, those objects should not
impact performance at all, as we will never even look at unreferenced
objects).

-Peff
