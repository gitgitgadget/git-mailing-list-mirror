From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] diff: add a config option to control orderfile
Date: Tue, 24 Sep 2013 23:15:15 +0300
Message-ID: <20130924201515.GB23319@redhat.com>
References: <20130917201401.GA22000@redhat.com>
 <20130917201604.GA22008@redhat.com>
 <20130917201828.GC16860@sigill.intra.peff.net>
 <20130917203807.GA22059@redhat.com>
 <20130917205615.GA20178@sigill.intra.peff.net>
 <20130919213226.GA21291@redhat.com>
 <20130923210915.GA11202@redhat.com>
 <20130923213729.GE9464@google.com>
 <20130924055419.GA11208@redhat.com>
 <20130924193610.GO9464@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 24 22:13:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VOYyu-0005Ow-KX
	for gcvg-git-2@plane.gmane.org; Tue, 24 Sep 2013 22:13:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754197Ab3IXUNH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Sep 2013 16:13:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:61161 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753091Ab3IXUNH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Sep 2013 16:13:07 -0400
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r8OKCwwB013278
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Tue, 24 Sep 2013 16:12:58 -0400
Received: from redhat.com (vpn1-6-23.ams2.redhat.com [10.36.6.23])
	by int-mx10.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with SMTP id r8OKCuPs027957;
	Tue, 24 Sep 2013 16:12:57 -0400
Content-Disposition: inline
In-Reply-To: <20130924193610.GO9464@google.com>
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.23
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235315>

On Tue, Sep 24, 2013 at 12:36:10PM -0700, Jonathan Nieder wrote:
> Michael S. Tsirkin wrote:
> > On Mon, Sep 23, 2013 at 02:37:29PM -0700, Jonathan Nieder wrote:
> 
> >>  a) When asked to compute the patch-id of a seekable file, use the
> >>     current streaming implementation until you notice a filename that
> >>     is out of order.  Then start over with sorted hunks (for example
> >>     building a table of offsets within the patch for each hunk to
> >>     support this).
> >>
> >>     When asked to compute the patch-id of an unseekable file, stream
> >>     to a temporary file under $GIT_DIR to get a seekable file.
> >
> > This can be computed in one pass: just keep two checksums around.
> >
> > But the result won't be stable: if you get same patch from two
> > people one is ordered, the other isn't, you get two different checksums.
> 
> Sorry for the lack of clarity.  In this case (a), I meant "sort the
> diff hunks and use the *old* patch-id definition with sorted hunks,

Well, then the result is not compatible with what
original patch-id would produce.
Basically you are either not stable or not compatible :)

> which produces a stable result but requires random access.
> 
> However:
> 
> [...]
> >>  b) Unconditionally use the new patch-id definition that is stable
> >>     under permutation of hunks.  If and when someone complains that
> >>     this invalidates their old patch-ids, they can work on adding a
> >>     nice interface for getting the old-style patch-ids.  I suspect it
> >>     just wouldn't come up.
> >
> > That's certainly easy to implement.
> 
> Yes, (b) seems like the best option to me, for what it's worth.
> 
> Thanks again,
> Jonathan

OK, thanks.

Just making sure: is it correct that there's no requirement to use same
algorithm between patch-ids.c and builtin/patch-id.c ?
