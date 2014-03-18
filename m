From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] tests: set temp variables using 'env' in test
 function instead of subshell
Date: Tue, 18 Mar 2014 17:45:36 -0400
Message-ID: <20140318214536.GA10076@sigill.intra.peff.net>
References: <244284@gmane.comp.version-control.git>
 <1395144518-2489-1-git-send-email-unsignedzero@gmail.com>
 <xmqqd2hj6y5o.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: David Tran <unsignedzero@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 18 22:45:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WQ1pQ-0005iz-CC
	for gcvg-git-2@plane.gmane.org; Tue, 18 Mar 2014 22:45:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756914AbaCRVpk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Mar 2014 17:45:40 -0400
Received: from cloud.peff.net ([50.56.180.127]:42156 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756851AbaCRVpj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Mar 2014 17:45:39 -0400
Received: (qmail 11736 invoked by uid 102); 18 Mar 2014 21:45:39 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 18 Mar 2014 16:45:39 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 18 Mar 2014 17:45:36 -0400
Content-Disposition: inline
In-Reply-To: <xmqqd2hj6y5o.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244385>

On Tue, Mar 18, 2014 at 01:37:39PM -0700, Junio C Hamano wrote:

> > diff --git a/t/t1300-repo-config.sh b/t/t1300-repo-config.sh
> > index c9c426c..3e3f77b 100755
> > --- a/t/t1300-repo-config.sh
> > +++ b/t/t1300-repo-config.sh
> > @@ -974,24 +974,15 @@ test_expect_success SYMLINKS 'symlinked configuration' '
> >  '
> >
> >  test_expect_success 'nonexistent configuration' '
> > -	(
> > -		GIT_CONFIG=doesnotexist &&
> > -		export GIT_CONFIG &&
> > -		test_must_fail git config --list &&
> > -		test_must_fail git config test.xyzzy
> > -	)
> > +	test_must_fail env GIT_CONFIG=doesnotexist git config --list &&
> > +	test_must_fail env GIT_CONFIG=doesnotexist git config test.xyzzy
> >  '

Isn't GIT_CONFIG here another way of saying:

  test_must_fail git config -f doesnotexist --list

Perhaps that is shorter and more readable still (and there are a few
similar cases in this patch.

-Peff
