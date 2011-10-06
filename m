From: Jeff King <peff@peff.net>
Subject: Re: [PATCH WIP 0/3] git log --exclude
Date: Thu, 6 Oct 2011 10:34:41 -0400
Message-ID: <20111006143441.GA21558@sigill.intra.peff.net>
References: <1317799088-26626-1-git-send-email-pclouds@gmail.com>
 <7vhb3n8ie9.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 06 16:34:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RBp2A-00046R-Nd
	for gcvg-git-2@lo.gmane.org; Thu, 06 Oct 2011 16:34:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964936Ab1JFOep (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Oct 2011 10:34:45 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:54386
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964930Ab1JFOep (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Oct 2011 10:34:45 -0400
Received: (qmail 8382 invoked by uid 107); 6 Oct 2011 14:34:45 -0000
Received: from 208.177.47.101.ptr.us.xo.net (HELO sigill.intra.peff.net) (208.177.47.101)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 06 Oct 2011 10:34:45 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 06 Oct 2011 10:34:41 -0400
Content-Disposition: inline
In-Reply-To: <7vhb3n8ie9.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182956>

On Wed, Oct 05, 2011 at 10:20:30AM -0700, Junio C Hamano wrote:

> The way I envisioned the narrow cloning would work like this [*1*]:
> 
>  * The narrowed set of paths is an attribute of the local repository. It
>    is not tied to the history nor the current working tree state, so the
>    information does not live in the index or in the history. A new file
>    $GIT_DIR/narrowed-paths specifies a list of pathspecs. We call a
>    repository with such a file "a narrowed repository".
> 
>  * The objects that live in a narrowed repository are subset of the
>    objects in an unnarrowed repository that records the same
>    history. Objects are not modified in any way when transferring into
>    a narrowed repository. E.g. if you clone git.git but limit the tree to
>    Documentation/ and builtin/, you will get _all_ commit objects, even
>    the ones that do _not_ touch these two directories, and the top level
>    tree objects. These top level tree objects _do_ record the object names
>    for paths outside the narrowed area. To facilitate local history
>    traversal, we may add either grafts or replace entries to "gather" away
>    commits that do not touch the narrowed area, but this is not essential.

I'm really just a bystander on this topic, and haven't given it too much
thought. But one stumbling block I see for narrow clone is how narrow
repositories will interact with object transfer from other repositories.

For example, if I have a narrow git.git that omits Documentation, and I
do a "git fetch" from a non-narrow repository, then how do we tell the
non-narrow remote that we don't have blobs in Documentation, and that
they should not be used as delta bases for any objects that are sent?

The current protocol relies on certain repository properties on the
remote end that narrow clone will violate. I don't see a way around that
without a protocol extension to communicate the narrowness. What will
that extension look like?

-Peff
