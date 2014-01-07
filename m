From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] sha1_name: don't resolve refs when
 core.warnambiguousrefs is false
Date: Tue, 7 Jan 2014 12:13:08 -0500
Message-ID: <20140107171307.GA19482@sigill.intra.peff.net>
References: <1389065521-46331-1-git-send-email-brodie@sf.io>
 <CAEfQM484kqLSVeyjhYtg7GfXOQkQNjaO1FV2_U3uAqO=Nargdg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: Brodie Rao <brodie@sf.io>
X-From: git-owner@vger.kernel.org Tue Jan 07 18:14:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W0aDP-0002YI-CR
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jan 2014 18:13:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752950AbaAGRNP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jan 2014 12:13:15 -0500
Received: from cloud.peff.net ([50.56.180.127]:56542 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752706AbaAGRNN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jan 2014 12:13:13 -0500
Received: (qmail 10926 invoked by uid 102); 7 Jan 2014 17:13:12 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 07 Jan 2014 11:13:12 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 07 Jan 2014 12:13:08 -0500
Content-Disposition: inline
In-Reply-To: <CAEfQM484kqLSVeyjhYtg7GfXOQkQNjaO1FV2_U3uAqO=Nargdg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240111>

On Mon, Jan 06, 2014 at 07:35:04PM -0800, Brodie Rao wrote:

> On Mon, Jan 6, 2014 at 7:32 PM, Brodie Rao <brodie@sf.io> wrote:
> > This change ensures get_sha1_basic() doesn't try to resolve full hashes
> > as refs when ambiguous ref warnings are disabled.
> >
> > This provides a substantial performance improvement when passing many
> > hashes to a command (like "git rev-list --stdin") when
> > core.warnambiguousrefs is false. The check incurs 6 stat()s for every
> > hash supplied, which can be costly over NFS.
> 
> Forgot to add:
> 
> Signed-off-by: Brodie Rao <brodie@sf.io>

Looks good to me.

I wonder if I should have simply gone this route instead of adding
warn_on_object_refname_ambiguity, and then people who want "cat-file
--batch" to be fast could just turn off core.warnAmbiguousRefs. I wanted
it to happen automatically, though. Alternatively, I guess "cat-file
--batch" could just turn off warn_ambiguous_refs itself.

-Peff
