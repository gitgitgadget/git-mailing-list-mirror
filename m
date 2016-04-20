From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] xdiff: implement empty line chunk heuristic
Date: Wed, 20 Apr 2016 12:17:17 -0400
Message-ID: <20160420161716.GA11459@sigill.intra.peff.net>
References: <1461013950-12503-1-git-send-email-sbeller@google.com>
 <1461013950-12503-3-git-send-email-sbeller@google.com>
 <20160419050342.GA19439@sigill.intra.peff.net>
 <CAGZ79kbzg7SmJHFpxeJNKmLaEEw+irCxUedo45jGx8G8fmPtKg@mail.gmail.com>
 <20160419170624.GA3999@sigill.intra.peff.net>
 <CA+P7+xp60r6Tsv0_=Qy6Wo39MmXMbCba7g5goPQD-e8FNaaEjw@mail.gmail.com>
 <xmqqoa95xknc.fsf@gitster.mtv.corp.google.com>
 <20160420161028-mutt-send-email-mst@redhat.com>
 <xmqqpotkw9bi.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
	Jacob Keller <jacob.keller@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Jacob Keller <jacob.e.keller@intel.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 20 18:17:25 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1asuoe-0001EI-JM
	for gcvg-git-2@plane.gmane.org; Wed, 20 Apr 2016 18:17:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751369AbcDTQRU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Apr 2016 12:17:20 -0400
Received: from cloud.peff.net ([50.56.180.127]:52974 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751126AbcDTQRU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Apr 2016 12:17:20 -0400
Received: (qmail 29567 invoked by uid 102); 20 Apr 2016 16:17:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 20 Apr 2016 12:17:19 -0400
Received: (qmail 32212 invoked by uid 107); 20 Apr 2016 16:17:18 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 20 Apr 2016 12:17:18 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 20 Apr 2016 12:17:17 -0400
Content-Disposition: inline
In-Reply-To: <xmqqpotkw9bi.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292038>

On Wed, Apr 20, 2016 at 09:09:53AM -0700, Junio C Hamano wrote:

> "Michael S. Tsirkin" <mst@redhat.com> writes:
> 
> > FWIW IIRC what that commit is about is ability to reorder the chunks in
> > a patch without changing patch-id. Not about keeping id stable across
> > git revisions.
> 
> OK, but "reorder the chunks" is not meant to stay to be the _ONLY_
> purpose for an option whose name is a broad "--[un]stable", but
> merely one (and only) possible cause of patch-id instability that
> happened to be noticed as an issue back then and was dealt with that
> commit, no?  In other words, the intent of the "--stable" feature is
> to give a stable ID that is not affected by random end-user settings
> (e.g. diff.orderfile) and if somebody invents a new configurable knob
> in the future, they are supposed to pay attention to the "--stable"
> feature or existing users who do use "--stable" will be broken, no?

I forgot that we added "--stable". Evne if it is not meant to be about
stability across versions, is there any reason _not_ to turn off
this heuristic for --stable (or for patch-ids in general)?

I guess maybe that creates some inconsistency between generating a
patch-id directly, and making one from a diff given on stdin (though I
don't know that we can promise much about the latter in the general
case; we can fix file ordering, but we don't have enough information to
tweak other aspects).

-Peff
