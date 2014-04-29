From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v4 2/2] test/send-email: to-cover, cc-cover tests
Date: Tue, 29 Apr 2014 23:05:10 +0300
Message-ID: <20140429200510.GA20753@redhat.com>
References: <1398750059-11955-1-git-send-email-mst@redhat.com>
 <1398750059-11955-2-git-send-email-mst@redhat.com>
 <xmqqppk0j6yx.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 29 21:05:08 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WfDKw-00009i-1P
	for gcvg-git-2@plane.gmane.org; Tue, 29 Apr 2014 21:05:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965036AbaD2TEz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Apr 2014 15:04:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41533 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932491AbaD2TEy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Apr 2014 15:04:54 -0400
Received: from int-mx14.intmail.prod.int.phx2.redhat.com (int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s3TJ4p9Y031014
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 29 Apr 2014 15:04:51 -0400
Received: from redhat.com (dhcp-4-223.tlv.redhat.com [10.35.4.223])
	by int-mx14.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with SMTP id s3TJ4ngb022582;
	Tue, 29 Apr 2014 15:04:50 -0400
Content-Disposition: inline
In-Reply-To: <xmqqppk0j6yx.fsf@gitster.dls.corp.google.com>
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.27
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247605>

On Tue, Apr 29, 2014 at 12:01:10PM -0700, Junio C Hamano wrote:
> "Michael S. Tsirkin" <mst@redhat.com> writes:
> 
> > Add tests for the new feature.
> >
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > ---
> >  t/t9001-send-email.sh | 45 +++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 45 insertions(+)
> >
> > diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
> > index 1ecdacb..97cc094 100755
> > --- a/t/t9001-send-email.sh
> > +++ b/t/t9001-send-email.sh
> > @@ -1334,6 +1334,51 @@ test_expect_success $PREREQ '--force sends cover letter template anyway' '
> >  	test -n "$(ls msgtxt*)"
> >  '
> >  
> > +test_cover_addresses () {
> > +	header="$1"
> > +	shift
> > +	clean_fake_sendmail &&
> > +	rm -fr outdir &&
> > +	git format-patch --cover-letter -2 -o outdir &&
> > +	cover=`echo outdir/0000-*.patch` &&
> > +	mv $cover cover-to-edit.patch &&
> > +	sed "s/^From:/$header: extra@address.com\nFrom:/" cover-to-edit.patch > $cover &&
> 
> Please do the redirection like this:
> 
> 	sed "s/^From:/$header: extra@address.com\nFrom:/" cover-to-edit.patch >"$cover" &&
> 
> in your later patches (I'll tweak this patch myself, so no need to
> resend).  We know >$cover should be the same as >"$cover", but it
> was reported that some version of bash does not know it and
> complains instead (see Documentation/CodingGuidelines).

I'll try to remember this, thanks.

-- 
MST
