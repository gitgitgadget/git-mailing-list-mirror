From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v3 0/6] git send-email suppress-cc=self fixes
Date: Wed, 5 Jun 2013 00:49:22 +0300
Message-ID: <20130604214921.GA30400@redhat.com>
References: <1370332482-12329-1-git-send-email-mst@redhat.com>
 <7v4ndd93ks.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 04 23:48:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ujz6A-000710-K7
	for gcvg-git-2@plane.gmane.org; Tue, 04 Jun 2013 23:48:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751416Ab3FDVsy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Jun 2013 17:48:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60449 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751208Ab3FDVsx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Jun 2013 17:48:53 -0400
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r54Lmpc0005693
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Tue, 4 Jun 2013 17:48:51 -0400
Received: from redhat.com (vpn-203-21.tlv.redhat.com [10.35.203.21])
	by int-mx09.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with SMTP id r54LmlJg028649;
	Tue, 4 Jun 2013 17:48:49 -0400
Content-Disposition: inline
In-Reply-To: <7v4ndd93ks.fsf@alter.siamese.dyndns.org>
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.22
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226414>

On Tue, Jun 04, 2013 at 10:40:51AM -0700, Junio C Hamano wrote:
> "Michael S. Tsirkin" <mst@redhat.com> writes:
> 
> > This includes bugfixes related to handling of --suppress-cc=self
> > flag. Tests are also included.
> 
> Hmph, flipped the patches without test-applying first?

No, I generated the patches with git format-patch,
then processed with git send-email.

> 2/6 adds two lines to test_suppress_self_quoted helper function, but
> that is introduced only at 4/6.

I don't see it
All I see in 2/6 is this:

	diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
	index e1a7f3e..f81e5f5 100755
	--- a/t/t9001-send-email.sh
	+++ b/t/t9001-send-email.sh
	@@ -204,13 +204,15 @@ test_suppress_self_unquoted () {

			unquoted-$3

	+               cccmd--$1 <$2>
	+
			Cc: $1 <$2>
			Signed-off-by: $1 <$2>
		EOF
	 }

	 test_expect_success $PREREQ 'self name is suppressed' "
	-       test_suppress_self_unquoted 'A U Thor' 'author@redhat.com' \
	+       test_suppress_self_unquoted 'A U Thor' 'author@example.com' \
			'self_name_suppressed'
	 "

where's test_suppress_self_quoted here?


> >
> > Changes from v2:
> > 	- add a new test, split patches differently add code comments
> > 		 to address comments by Junio
> > 	- rename example addresses in tests from redhat.com to example.com
> > Changes from v1:
> >         - tweak coding style in tests to address comments by Junio
> >
> >
> > Michael S. Tsirkin (6):
> >   send-email: fix suppress-cc=self on cccmd
> >   t/send-email: test suppress-cc=self on cccmd
> >   send-email: make --suppress-cc=self sanitize input
> >   t/send-email: add test with quoted sender
> >   t/send-email: test suppress-cc=self with non-ascii
> >   test-send-email: test for pre-sanitized self name
> >
> >  git-send-email.perl   | 23 +++++++++++++++--------
> >  t/t9001-send-email.sh | 34 +++++++++++++++++++++++++++++++++-
> >  2 files changed, 48 insertions(+), 9 deletions(-)
