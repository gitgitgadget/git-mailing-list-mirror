From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v3 2/3] patch-id: document new behaviour
Date: Wed, 2 Apr 2014 22:02:43 +0300
Message-ID: <20140402190243.GA13425@redhat.com>
References: <1396202583-2572-1-git-send-email-mst@redhat.com>
 <1396202583-2572-2-git-send-email-mst@redhat.com>
 <xmqqmwg65gp7.fsf@gitster.dls.corp.google.com>
 <20140331192604.GF12208@redhat.com>
 <xmqq7g7a5ek9.fsf@gitster.dls.corp.google.com>
 <20140331204205.GB12403@redhat.com>
 <xmqqy4zntx1p.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, sunshine@sunshineco.com, jrnieder@gmail.com,
	peff@peff.net
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 03 13:33:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WVeUb-000348-7e
	for gcvg-git-2@plane.gmane.org; Thu, 03 Apr 2014 12:03:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933011AbaDBTCU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Apr 2014 15:02:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:12113 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933008AbaDBTCT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Apr 2014 15:02:19 -0400
Received: from int-mx12.intmail.prod.int.phx2.redhat.com (int-mx12.intmail.prod.int.phx2.redhat.com [10.5.11.25])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s32J25ht001174
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Wed, 2 Apr 2014 15:02:06 -0400
Received: from redhat.com (vpn1-4-40.ams2.redhat.com [10.36.4.40])
	by int-mx12.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with SMTP id s32J23kJ009117;
	Wed, 2 Apr 2014 15:02:03 -0400
Content-Disposition: inline
In-Reply-To: <xmqqy4zntx1p.fsf@gitster.dls.corp.google.com>
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.25
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245718>

On Wed, Apr 02, 2014 at 11:18:26AM -0700, Junio C Hamano wrote:
> "Michael S. Tsirkin" <mst@redhat.com> writes:
> 
> > On Mon, Mar 31, 2014 at 12:54:46PM -0700, Junio C Hamano wrote:
> >> "Michael S. Tsirkin" <mst@redhat.com> writes:
> >> 
> >> > The hash used is mostly an internal implementation detail, isn't it?
> >> 
> >> Yes, but that does not mean we can break people who keep an external
> >> database indexed with the patch-id by changing the default under
> >> them, and "they can give --unstable option to work it around" is a
> >> workaround, not a fix.  Without this change, they did not have to do
> >> anything.
> >> 
> >> I would imagine that most of these people will be using the plain
> >> vanilla "git show" output without any ordering or hunk splitting
> >> when coming up with such a key.  A possible way forward to allow the
> >> configuration that corresponds to "-O<orderfile>" while not breaking
> >> the existing users could be to make the "patch-id --stable" kick in
> >> automatically (of course, do this only when the user did not give
> >> the "--unstable" command line option to override) when we see the
> >> orderfile configuration in the repository, or when we see that the
> >> incoming patch looks like reordered (e.g. has multiple "diff --git"
> >> header lines that refer to the same path,
> >
> > This would require us to track affected files in memory.
> > Issue?
> 
> Don't we already do that in order to handle a patch that touches the
> same path more than once anyway?

At least I don't see it in builtin/patch-id.c

> I think a possibly larger issue
> might be that you would still want to do the hashing in a single
> pass so you may need to always keep two accumulated hashes, before
> you can decide if the patch is or is not a straight-forward one and
> use one of the two, but that hopefully should not require a rocket
> scientist.

But the issue is that equivalent patches would get a different hash.
This is what I tried to fix, after all.

So I think I prefer using an option and not a heuristic if you
are fine with that.
At some point in the future we might flip the default.

-- 
MST
