From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v9 1/1] http: Add Accept-Language header if possible
Date: Thu, 26 Feb 2015 17:45:58 -0500
Message-ID: <20150226224558.GA10311@peff.net>
References: <xmqqpp8xmwnp.fsf@gitster.dls.corp.google.com>
 <20150226030416.GA6121@peff.net>
 <xmqqmw40l777.fsf@gitster.dls.corp.google.com>
 <20150226213356.GA14464@peff.net>
 <xmqqa900l57y.fsf@gitster.dls.corp.google.com>
 <CAGZ79kbUOhbs2DpM3CK=f+Gwj3v-q44Q7beiVgDHPPwm+rhEng@mail.gmail.com>
 <20150226220609.GA24663@peff.net>
 <20150226220759.GB24663@peff.net>
 <CAGZ79kar4Uf-mCwXpexPvNztwd_vfjdCoT_dDXULkOrCqUhG=A@mail.gmail.com>
 <20150226223603.GA27946@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Yi EungJun <semtlenori@gmail.com>,
	Git List <git@vger.kernel.org>,
	Yi EungJun <eungjun.yi@navercorp.com>,
	Peter Krefting <peter@softwolves.pp.se>,
	Michael Blume <blume.mike@gmail.com>,
	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Thu Feb 26 23:46:10 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YR7C2-0002Vz-Sh
	for gcvg-git-2@plane.gmane.org; Thu, 26 Feb 2015 23:46:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754805AbbBZWqC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Feb 2015 17:46:02 -0500
Received: from cloud.peff.net ([50.56.180.127]:53934 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753643AbbBZWqB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Feb 2015 17:46:01 -0500
Received: (qmail 20755 invoked by uid 102); 26 Feb 2015 22:46:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 26 Feb 2015 16:46:01 -0600
Received: (qmail 28997 invoked by uid 107); 26 Feb 2015 22:46:02 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 26 Feb 2015 17:46:02 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 26 Feb 2015 17:45:58 -0500
Content-Disposition: inline
In-Reply-To: <20150226223603.GA27946@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264477>

On Thu, Feb 26, 2015 at 05:36:03PM -0500, Jeff King wrote:

> > [-Wstrict-prototypes]
> >  const char *get_preferred_languages();
> >  ^
> 
> Hmph. The compiler is right that it should be:
> 
>  const char *get_preferred_languages(void);
> 
> but my gcc (4.9.2, with -Wstrict_prototypes) does not seem to notice it!
> Weird.

Ugh. I have a snippet in my config.mak that relaxes the warnings on older
versions of git, and it was accidentally triggering due to a typo. :(

So that explains that. Junio, do you mind squashing in:

diff --git a/gettext.h b/gettext.h
index 5d8d2df..33696a4 100644
--- a/gettext.h
+++ b/gettext.h
@@ -89,6 +89,6 @@ const char *Q_(const char *msgid, const char *plu, unsigned long n)
 #define N_(msgid) (msgid)
 #endif
 
-const char *get_preferred_languages();
+const char *get_preferred_languages(void);
 
 #endif
