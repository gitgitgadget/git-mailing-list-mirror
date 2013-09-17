From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] diff: add a config option to control orderfile
Date: Tue, 17 Sep 2013 16:18:28 -0400
Message-ID: <20130917201828.GC16860@sigill.intra.peff.net>
References: <20130903210815.GB24480@redhat.com>
 <20130915074900.GA30438@redhat.com>
 <20130915080830.GA30465@redhat.com>
 <xmqq8uyv1kka.fsf@gitster.dls.corp.google.com>
 <20130917164226.GB20672@redhat.com>
 <xmqqfvt3z7i4.fsf@gitster.dls.corp.google.com>
 <20130917172829.GA21121@redhat.com>
 <xmqq38p3z5kg.fsf@gitster.dls.corp.google.com>
 <20130917201401.GA22000@redhat.com>
 <20130917201604.GA22008@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: "Michael S. Tsirkin" <mst@redhat.com>
X-From: git-owner@vger.kernel.org Tue Sep 17 22:18:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VM1jM-0007xu-9m
	for gcvg-git-2@plane.gmane.org; Tue, 17 Sep 2013 22:18:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753366Ab3IQUSg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Sep 2013 16:18:36 -0400
Received: from cloud.peff.net ([50.56.180.127]:47602 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752828Ab3IQUSf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Sep 2013 16:18:35 -0400
Received: (qmail 20887 invoked by uid 102); 17 Sep 2013 20:18:36 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 17 Sep 2013 15:18:36 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 17 Sep 2013 16:18:28 -0400
Content-Disposition: inline
In-Reply-To: <20130917201604.GA22008@redhat.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234917>

On Tue, Sep 17, 2013 at 11:16:04PM +0300, Michael S. Tsirkin wrote:

> > Thinking about it some more, it's a best effort thing anyway,
> > correct?
> > 
> > So how about, instead of doing a hash over the whole input,
> > we hash each chunk and XOR them together?
> > 
> > This way it will be stable against chunk reordering, and
> > no need to keep patch in memory.
> > 
> > Hmm?
> 
> ENOCOFFEE
> 
> That was a silly suggestion, two identical chunks aren't that unlikely :)

In a single patch, they should not be, as we should be taking into
account the filenames, no?

You could also do it hierarchically. Hash each chunk, store only the
hashes, then sort them and hash the result. That still has O(chunks)
storage, but it is only one hash per chunk, not the whole data.

A problem with both schemes, though, is that they are not
backwards-compatible with existing git-patch-id implementations. Whereas
sorting the data itself is (kind of, at least with respect to people who
are not using orderfile).

-Peff
