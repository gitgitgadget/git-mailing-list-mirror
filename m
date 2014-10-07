From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH RFC] git-am: support any number of signatures
Date: Wed, 8 Oct 2014 00:29:37 +0300
Message-ID: <20141007212937.GA14632@redhat.com>
References: <20140613080036.GA2117@redhat.com>
 <xmqqy4x03ecm.fsf@gitster.dls.corp.google.com>
 <20140615102736.GA11798@redhat.com>
 <xmqqy4wwraoz.fsf@gitster.dls.corp.google.com>
 <20140618030903.GA19593@redhat.com>
 <CAPc5daVTZynCKMubZmreAjBh3i51wPaAA+8vSRwB9dGrrJb6FA@mail.gmail.com>
 <xmqq38f2jed3.fsf@gitster.dls.corp.google.com>
 <20140922140144.GA9769@redhat.com>
 <CAP8UFD2W1r9859FgpBXqvdNLAfXoCwjpEFpTKXU6fGuC_8uvBg@mail.gmail.com>
 <xmqqbnq6jm0s.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Christian Couder <christian.couder@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 07 23:26:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XbcGt-0001cV-Jp
	for gcvg-git-2@plane.gmane.org; Tue, 07 Oct 2014 23:26:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754244AbaJGV0M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Oct 2014 17:26:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:32813 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754058AbaJGV0L (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Oct 2014 17:26:11 -0400
Received: from int-mx14.intmail.prod.int.phx2.redhat.com (int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s97LQ5Qf008666
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 7 Oct 2014 17:26:06 -0400
Received: from redhat.com (ovpn-116-74.ams2.redhat.com [10.36.116.74])
	by int-mx14.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with SMTP id s97LQ3L0003501;
	Tue, 7 Oct 2014 17:26:04 -0400
Content-Disposition: inline
In-Reply-To: <xmqqbnq6jm0s.fsf@gitster.dls.corp.google.com>
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.27
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257962>

On Tue, Sep 23, 2014 at 10:15:47AM -0700, Junio C Hamano wrote:
> Christian Couder <christian.couder@gmail.com> writes:
> 
> > On Mon, Sep 22, 2014 at 4:01 PM, Michael S. Tsirkin <mst@redhat.com> wrote:
> >> ...
> >> As a reminder, this old patchset (that I replied to) enhanced git am -s
> >> with an option to add different signatures depending on
> >> the option passed to the -s flag.
> >> E.g. I have
> >> [am "a"]
> >>         signoff = "Acked-by: Michael S. Tsirkin <mst@redhat.com>"
> >>
> >> [am "r"]
> >>         signoff = "Reviewed-by: Michael S. Tsirkin <mst@redhat.com>"
> >>
> >> [am "t"]
> >>         signoff = "Tested-by: Michael S. Tsirkin <mst@redhat.com>"
> >>
> >> and now:
> >>         git am -s art
> >> adds all 3 signatures when applying the patch.
> >
> > This is probably not as simple as you would like but it works with
> > something like:
> >
> > $ git interpret-trailers --trailer "Acked-by: Michael S. Tsirkin
> > <mst@redhat.com>" --trailer "Reviewed-by: Michael S. Tsirkin
> > <mst@redhat.com>"  --trailer "Tested-by: Michael S. Tsirkin
> > <mst@redhat.com>" 0001-foo.patch >to_apply/0001-foo.patch
> >
> > and then:
> >
> > $ git am to_apply/*.patch
> 
> If I understand it correctly, Michael is envisioning to implement
> his "git am -s art" (I would recommend against reusing -s for this,
> though.  "git am --trailer art" is fine) and doing so by using
> interpret-trailers as an internal implementation detail, so I would
> say the above is a perfectly fine way to do so.  An equivalent of
> that command line is synthesized and run internally in his version
> of "git am" when his "git am" sees "--trailer art" option using
> those am.{"a","r","t"}.trailer configuration variables.

Hmm I wonder why do you dislike reusing -s with a parameter for this.
To me, this looks like a superset of the default -s functionality: -s
adds the default signature, -s "x" adds signature "x" ...  Users don't
really care that one is implemented as a trailer and another isn't.  In
fact, default -s can be implemented as a trailer too, right?

Could you clarify please?

-- 
MST
