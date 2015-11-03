From: Knut Franke <k.franke@science-computing.de>
Subject: Re: [PATCH 2/2] http: use credential API to handle proxy
 authentication
Date: Tue, 3 Nov 2015 10:31:04 +0100
Message-ID: <20151103093103.GB6354@science-computing.de>
References: <1445882109-18184-1-git-send-email-k.franke@science-computing.de>
 <1446483264-15123-1-git-send-email-k.franke@science-computing.de>
 <1446483264-15123-3-git-send-email-k.franke@science-computing.de>
 <xmqqbnbcdnb8.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 03 10:41:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZtY5v-0008JD-ES
	for gcvg-git-2@plane.gmane.org; Tue, 03 Nov 2015 10:41:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753016AbbKCJlI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Nov 2015 04:41:08 -0500
Received: from mx1.science-computing.de ([217.243.222.155]:42847 "EHLO
	mx1.science-computing.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752995AbbKCJlC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Nov 2015 04:41:02 -0500
X-Greylist: delayed 595 seconds by postgrey-1.27 at vger.kernel.org; Tue, 03 Nov 2015 04:41:02 EST
Received: from localhost (localhost [127.0.0.1])
	by scmail.science-computing.de (Postfix) with ESMTP id D7C51492D;
	Tue,  3 Nov 2015 10:31:04 +0100 (CET)
X-Virus-Scanned: amavisd-new
Received: from scmail.science-computing.de ([127.0.0.1])
	by localhost (guiness.science-computing.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Bedy_mPyY5Iw; Tue,  3 Nov 2015 10:31:04 +0100 (CET)
Received: from hallasan.science-computing.de (hallasan.science-computing.de [10.10.24.76])
	by scmail.science-computing.de (Postfix) with ESMTP id 4202127C7;
	Tue,  3 Nov 2015 10:31:04 +0100 (CET)
Received: by hallasan.science-computing.de (Postfix, from userid 1633)
	id 32F32A797B; Tue,  3 Nov 2015 10:31:04 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <xmqqbnbcdnb8.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280788>

On 2015-11-02 14:54, Junio C Hamano wrote:
> >  static void init_curl_proxy_auth(CURL *result)
> >  {
> > +	if (proxy_auth.username) {
> > +		if (!proxy_auth.password)
> > +			credential_fill(&proxy_auth);
> > +#if LIBCURL_VERSION_NUM >= 0x071301
> > +		curl_easy_setopt(result, CURLOPT_PROXYUSERNAME,
> > +			proxy_auth.username);
> > +		curl_easy_setopt(result, CURLOPT_PROXYPASSWORD,
> > +			proxy_auth.password);
> > +#else
> > +		struct strbuf s = STRBUF_INIT;
> > +		strbuf_addstr_urlencode(&s, proxy_auth.username, 1);
> > +		strbuf_addch(&s, ':');
> > +		strbuf_addstr_urlencode(&s, proxy_auth.password, 1);
> > +		curl_proxyuserpwd = strbuf_detach(&s, NULL);
> > +		curl_easy_setopt(result, CURLOPT_PROXYUSERPWD, curl_proxyuserpwd);
> > +#endif
> 
> I think #else clause of this thing would introduce decl-after-stmt
> compilation error.

I've actually tested this with CURL 7.15.5 (0x070f05), and didn't get any
compilation error.


Cheers,
Knut
-- 
Vorstandsvorsitzender/Chairman of the board of management:
Gerd-Lothar Leonhart
Vorstand/Board of Management:
Dr. Bernd Finkbeiner, Dr. Arno Steitz
Vorsitzender des Aufsichtsrats/
Chairman of the Supervisory Board:
Philippe Miltin
Sitz/Registered Office: Tuebingen
Registergericht/Registration Court: Stuttgart
Registernummer/Commercial Register No.: HRB 382196
