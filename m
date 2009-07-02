From: Jeff King <peff@peff.net>
Subject: Re: Bug report: .gitattributes: -diff Unset causes files to be
	reported as binaries
Date: Thu, 2 Jul 2009 01:35:34 -0400
Message-ID: <20090702053534.GA13255@sigio.peff.net>
References: <200907011208.35397.fenglich@fastmail.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Frans Englich <fenglich@fastmail.fm>
X-From: git-owner@vger.kernel.org Thu Jul 02 07:35:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MMExU-0002t4-LH
	for gcvg-git-2@gmane.org; Thu, 02 Jul 2009 07:35:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755981AbZGBFdk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Jul 2009 01:33:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755958AbZGBFdk
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Jul 2009 01:33:40 -0400
Received: from peff.net ([208.65.91.99]:56704 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755981AbZGBFdj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Jul 2009 01:33:39 -0400
Received: (qmail 13265 invoked by uid 1000); 2 Jul 2009 05:35:34 -0000
Content-Disposition: inline
In-Reply-To: <200907011208.35397.fenglich@fastmail.fm>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122621>

On Wed, Jul 01, 2009 at 12:08:35PM +0200, Frans Englich wrote:

> Applying -diff Unset to a file using .gittattributes causes "git diff"
> to state that the file is a binary even though it isn't, or have been
> instructed to be treated as one. See attached script for reproducing.

I think you are a little confused by the syntax. Each line of the
gitattributes file has a filename pattern and a set of attributes. Each
attribute is either set, unset, set to a value, or unspecified. For your
example (file.txt and the "diff" attribute), they look like:

  Set:
    file.txt diff
  Unset:
    file.txt -diff
  Set to a value:
    file.txt diff=foo
  Unspecified:
    file.txt

So the word "Unset" is unnecessary in "-diff Unset" (and syntactically
means "set the attribute named "Unset", not any sort of modifier on the
diff attribute). This is described in the first section of "git help
attributes".

All of that being said, your example does end up, in fact, making the
diff attribute "unset" for you (because it uses "-diff"). And the effect
of doing so is to mark the file as binary (i.e., not to be diffed). From
"git help attributes", section "Generating diff text":

  The attribute `diff` affects how 'git' generates diffs for particular
  files. It can tell git whether to generate a textual patch for the
  path or to treat the path as a binary file.
  [...]
  Unset
      A path to which the diff attribute is unset will generate Binary
      files differ.

So as far as I can see, git is behaving exactly as it is supposed to.
Maybe you can be more specific about what effect you were trying to
achieve by setting gitattributes in the first place?

-Peff
