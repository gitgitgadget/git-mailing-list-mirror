From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] diff: add a config option to control orderfile
Date: Tue, 17 Sep 2013 23:16:04 +0300
Message-ID: <20130917201604.GA22008@redhat.com>
References: <xmqqioyhu8wd.fsf@gitster.dls.corp.google.com>
 <20130903210815.GB24480@redhat.com>
 <20130915074900.GA30438@redhat.com>
 <20130915080830.GA30465@redhat.com>
 <xmqq8uyv1kka.fsf@gitster.dls.corp.google.com>
 <20130917164226.GB20672@redhat.com>
 <xmqqfvt3z7i4.fsf@gitster.dls.corp.google.com>
 <20130917172829.GA21121@redhat.com>
 <xmqq38p3z5kg.fsf@gitster.dls.corp.google.com>
 <20130917201401.GA22000@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 17 22:14:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VM1ep-0005Kp-DV
	for gcvg-git-2@plane.gmane.org; Tue, 17 Sep 2013 22:13:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753343Ab3IQUNz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Sep 2013 16:13:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:61180 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752921Ab3IQUNy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Sep 2013 16:13:54 -0400
Received: from int-mx01.intmail.prod.int.phx2.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r8HKDqC3001916
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Tue, 17 Sep 2013 16:13:52 -0400
Received: from redhat.com (vpn1-4-197.ams2.redhat.com [10.36.4.197])
	by int-mx01.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with SMTP id r8HKDoDZ021248;
	Tue, 17 Sep 2013 16:13:51 -0400
Content-Disposition: inline
In-Reply-To: <20130917201401.GA22000@redhat.com>
X-Scanned-By: MIMEDefang 2.67 on 10.5.11.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234915>

On Tue, Sep 17, 2013 at 11:14:01PM +0300, Michael S. Tsirkin wrote:
> On Tue, Sep 17, 2013 at 11:06:07AM -0700, Junio C Hamano wrote:
> > "Michael S. Tsirkin" <mst@redhat.com> writes:
> > 
> > > On Tue, Sep 17, 2013 at 10:24:19AM -0700, Junio C Hamano wrote:
> > >> "Michael S. Tsirkin" <mst@redhat.com> writes:
> > >> 
> > >> > So might it not be useful to tweak patch id to
> > >> > sort the diff, making it a bit more stable?
> > >> 
> > >> That is one thing that needs to be done, I think.  But it would be
> > >> unfortunate if we have to do that unconditionally, though, as we may
> > >> be "buffering" many hundred kilobytes of patch text in core.  If we
> > >> can do so without regressing the streaming performance for the most
> > >> common case of not using the orderfile on the generating side (hence
> > >> not having to sort on the receiving end), it would be ideal.  I am
> > >> not sure offhand how much code damage we are talking about, though.
> > >
> > > So make it conditional on the presence of the orderefile option?
> > 
> > That would mean that those who set orderfile from configuration in
> > the future will have to always suffer, I would think.  Is that
> > acceptable?  I dunno.
> > 
> > Also, if the sender used a non-standard order, the recipient does
> > not know what order the patch was generated, and the recipient does
> > not use a custom orderfile, what should happen?  I thought your idea
> > was to normalize by using some canonical order that is not affected
> > by the orderfile to make sure patch-id stays stable, so I would
> > imagine that such a recipient who does not have orderfile specified
> > still needs to sort before hashing, no?
> 
> Thinking about it some more, it's a best effort thing anyway,
> correct?
> 
> So how about, instead of doing a hash over the whole input,
> we hash each chunk and XOR them together?
> 
> This way it will be stable against chunk reordering, and
> no need to keep patch in memory.
> 
> Hmm?

ENOCOFFEE

That was a silly suggestion, two identical chunks aren't that unlikely :)

> -- 
> MST
