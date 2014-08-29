From: Scott Schmit <i.grok@comcast.net>
Subject: Re: [PATCH] pretty: Provide a strict ISO8601 date format
Date: Fri, 29 Aug 2014 13:44:39 -0400
Message-ID: <20140829174439.GA10274@odin.ulthar.us>
References: <1409248189-31409-1-git-send-email-bbolli@ewanet.ch>
 <xmqq61hc8bvq.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Beat Bolli <bbolli@ewanet.ch>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 29 19:50:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XNQK4-0008E0-Hm
	for gcvg-git-2@plane.gmane.org; Fri, 29 Aug 2014 19:50:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753727AbaH2Rus (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Aug 2014 13:50:48 -0400
Received: from qmta05.westchester.pa.mail.comcast.net ([76.96.62.48]:38877
	"EHLO qmta05.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753268AbaH2Rur (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 29 Aug 2014 13:50:47 -0400
X-Greylist: delayed 365 seconds by postgrey-1.27 at vger.kernel.org; Fri, 29 Aug 2014 13:50:47 EDT
Received: from omta12.westchester.pa.mail.comcast.net ([76.96.62.44])
	by qmta05.westchester.pa.mail.comcast.net with comcast
	id khfa1o0020xGWP855hkiW8; Fri, 29 Aug 2014 17:44:42 +0000
Received: from odin.ulthar.us ([IPv6:2001:470:8c86:0:225:64ff:fe8b:c2f2])
	by omta12.westchester.pa.mail.comcast.net with comcast
	id khkg1o00Y2Ekl483Yhkh9M; Fri, 29 Aug 2014 17:44:41 +0000
Received: from odin.ulthar.us (localhost [127.0.0.1])
	by odin.ulthar.us (8.14.7/8.14.5) with ESMTP id s7THieN5014419;
	Fri, 29 Aug 2014 13:44:40 -0400
Received: (from draco@localhost)
	by odin.ulthar.us (8.14.7/8.14.7/Submit) id s7THidGD014418;
	Fri, 29 Aug 2014 13:44:39 -0400
Content-Disposition: inline
In-Reply-To: <xmqq61hc8bvq.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
	s=q20140121; t=1409334282;
	bh=2t3hLvMhn7Ost2WNl+yKR+O6pQ4s9FzrgwHfQiBUYOM=;
	h=Received:Received:Received:Received:Date:From:To:Subject:
	 Message-ID:MIME-Version:Content-Type;
	b=PjjQiOz+EmBV0+1psDnaM4ei7hdYsw57X8g7Q9D/1sm0P4V+VKc42p4w5FNppu899
	 N4dWIwZEMbqUL8iCiE4ZevFhxpX69a8STcBDOMbXE7g2bCv+0KA+VxDOnPBws1RkEw
	 9lHxVLVe684y6duZewI8R6Ct+ApPb+i2svHFfn9ckfUN49qseao7JKZ9S0BKoVxDRe
	 MRJAXQlg9v+zhnPHvU/CDCg0nqGbpLIS5r8HM5XVxOM0gy7tK+UUwvwNKtZKy+aIeu
	 HmWfktNhhyBi3oJ0P6/vvlHRmnoBvwolbUisK2XBpyqTjvetcsc1dX/O7sCkOGrkp7
	 OIqwkU/vDGptQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256169>

On Thu, Aug 28, 2014 at 03:53:13PM -0700, Junio C Hamano wrote:
> Beat Bolli writes:
> > +	else if (mode == DATE_ISO8601_STRICT)
> > +		strbuf_addf(&timebuf, "%04d-%02d-%02dT%02d:%02d:%02d%+03d:%02d",
> > +				tm->tm_year + 1900,
> > +				tm->tm_mon + 1,
> > +				tm->tm_mday,
> > +				tm->tm_hour, tm->tm_min, tm->tm_sec,
> > +				tz / 100, abs(tz % 100));
> 
> Wouldn't this misidentify a zone that is 30 minutes off of GMT,
> i.e. tz == -30?  tz/100 would not be negative and "%+03d:" would
> happily show "+00:", no?

No.  strbuf_addf uses strbuf_vaddf which uses vsnprintf(3).  From man
vsnprintf(3):
>   The flag characters
>       The character % is followed by zero or more of the following
>       flags:
>
>       +      A sign (+ or -) should always be placed before a number
>              produced by a signed conversion.  By default a sign is
>              used only for negative numbers.  A + overrides a space if
>              both are used.

Perhaps you misread "%+03d:" as "+%02d:"?

-- 
Scott Schmit
