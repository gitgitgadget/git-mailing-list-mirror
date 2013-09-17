From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] diff: add a config option to control orderfile
Date: Tue, 17 Sep 2013 23:38:07 +0300
Message-ID: <20130917203807.GA22059@redhat.com>
References: <20130915074900.GA30438@redhat.com>
 <20130915080830.GA30465@redhat.com>
 <xmqq8uyv1kka.fsf@gitster.dls.corp.google.com>
 <20130917164226.GB20672@redhat.com>
 <xmqqfvt3z7i4.fsf@gitster.dls.corp.google.com>
 <20130917172829.GA21121@redhat.com>
 <xmqq38p3z5kg.fsf@gitster.dls.corp.google.com>
 <20130917201401.GA22000@redhat.com>
 <20130917201604.GA22008@redhat.com>
 <20130917201828.GC16860@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Sep 17 22:37:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VM21E-0002nz-6G
	for gcvg-git-2@plane.gmane.org; Tue, 17 Sep 2013 22:37:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753378Ab3IQUhB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Sep 2013 16:37:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47703 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753041Ab3IQUhA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Sep 2013 16:37:00 -0400
Received: from int-mx02.intmail.prod.int.phx2.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r8HKZtMv010965
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Tue, 17 Sep 2013 16:35:55 -0400
Received: from redhat.com (vpn1-4-197.ams2.redhat.com [10.36.4.197])
	by int-mx02.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with SMTP id r8HKZrG0008535;
	Tue, 17 Sep 2013 16:35:53 -0400
Content-Disposition: inline
In-Reply-To: <20130917201828.GC16860@sigill.intra.peff.net>
X-Scanned-By: MIMEDefang 2.67 on 10.5.11.12
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234923>

On Tue, Sep 17, 2013 at 04:18:28PM -0400, Jeff King wrote:
> On Tue, Sep 17, 2013 at 11:16:04PM +0300, Michael S. Tsirkin wrote:
> 
> > > Thinking about it some more, it's a best effort thing anyway,
> > > correct?
> > > 
> > > So how about, instead of doing a hash over the whole input,
> > > we hash each chunk and XOR them together?
> > > 
> > > This way it will be stable against chunk reordering, and
> > > no need to keep patch in memory.
> > > 
> > > Hmm?
> > 
> > ENOCOFFEE
> > 
> > That was a silly suggestion, two identical chunks aren't that unlikely :)
> 
> In a single patch, they should not be, as we should be taking into
> account the filenames, no?

Right.

> You could also do it hierarchically. Hash each chunk, store only the
> hashes, then sort them and hash the result. That still has O(chunks)
> storage, but it is only one hash per chunk, not the whole data.

Could be optional too :)
Or maybe just sum byte by byte instead.

> A problem with both schemes, though, is that they are not
> backwards-compatible with existing git-patch-id implementations.

Could you clarify?
We never send patch IDs on the wire - how isn't this compatible?

> Whereas
> sorting the data itself is (kind of, at least with respect to people who
> are not using orderfile).
> 
> -Peff
