From: Jeff King <peff@peff.net>
Subject: [PATCH 0/2] improve "git branch --contains=<commit> <pattern>"
Date: Thu, 31 Jan 2013 01:43:57 -0500
Message-ID: <20130131064357.GA24660@sigill.intra.peff.net>
References: <679787987.uZRbjA7AMj@al>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Peter Wu <lekensteyn@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 31 07:44:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U0nsl-0006Hx-IS
	for gcvg-git-2@plane.gmane.org; Thu, 31 Jan 2013 07:44:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754215Ab3AaGoB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jan 2013 01:44:01 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:54442 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750917Ab3AaGoA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jan 2013 01:44:00 -0500
Received: (qmail 3693 invoked by uid 107); 31 Jan 2013 06:45:23 -0000
Received: from c-71-206-173-132.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.206.173.132)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 31 Jan 2013 01:45:23 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 31 Jan 2013 01:43:57 -0500
Content-Disposition: inline
In-Reply-To: <679787987.uZRbjA7AMj@al>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215097>

On Wed, Jan 30, 2013 at 07:57:03PM +0100, Peter Wu wrote:

> Hi,
> 
> I was trying to check whether a certain branch contained a commit and ran:
> 
>      git branch --contains ddc150f7a33ae0c9cb16eaac3641abc00f56316f master
> 
> This resulted in:
> 
>     fatal: A branch named 'master' already exists.
> When "name" does not exist, this command creates a branch. I expect this 
> command to search the mentioned branch, not trying to create it. The manual 
> page of git-branch(1) does not mention such special behavior either.

Yeah, it's sort-of a bug. It is a syntactic ambiguity that an argument
to git-branch could be a listing pattern or a new branch name. When
using a listing pattern, you need to explicitly specify that you want
list mode with `--list`. This is documented in git-branch under --list,
but it should be more prominent, in the section that covers the various
invocation modes. The first patch below fixes that.

That being said, we could be much more helpful. It seems like --contains
should imply listing mode, since it is nonsensical in other modes. The
second patch below adjusts that, and makes the command above do what you
expect.

  [1/2]: docs: clarify git-branch --list behavior
  [2/2]: branch: let branch filters imply --list

-Peff
