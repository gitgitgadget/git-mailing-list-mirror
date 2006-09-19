From: "Art Haas" <ahaas@airmail.net>
Subject: Re: Patch for http-fetch.c and older curl releases
Date: Mon, 18 Sep 2006 19:32:37 -0500
Message-ID: <20060919003237.GH1261@artsapartment.org>
References: <20060918225445.GF1261@artsapartment.org> <7v4pv4pyey.fsf@assigned-by-dhcp.cox.net> <20060918235753.GG1261@artsapartment.org> <7vzmcwogp9.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 19 02:32:56 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GPTXb-0003NV-CL
	for gcvg-git@gmane.org; Tue, 19 Sep 2006 02:32:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751255AbWISAco (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 18 Sep 2006 20:32:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751976AbWISAco
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Sep 2006 20:32:44 -0400
Received: from wmail-2.airmail.net ([209.196.70.85]:1520 "EHLO
	wmail-2.airmail.net") by vger.kernel.org with ESMTP
	id S1751255AbWISAcn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Sep 2006 20:32:43 -0400
Received: from cpe-24-28-121-3.houston.res.rr.com ([24.28.121.3] helo=pcdebian)
	by wmail-2.airmail.net with esmtp (Exim 4.60)
	(envelope-from <ahaas@airmail.net>)
	id 1GPTXW-000LBr-RH
	for git@vger.kernel.org; Mon, 18 Sep 2006 19:32:42 -0500
Received: (qmail 15920 invoked by uid 1000); 19 Sep 2006 00:32:37 -0000
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vzmcwogp9.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27264>

On Mon, Sep 18, 2006 at 05:14:42PM -0700, Junio C Hamano wrote:
> "Art Haas" <ahaas@airmail.net> writes:
> 
> > Here's a patch that does that. I patched 'http.h' as there is already
> > a number of other curl tests in that file. On the machine where the 
> > build was failing, the 'curl-config --vernum' returned '070908',
> > and on my home machine where things build without issue the same
> > command returns '070f05', so I took that value to do the comparison.
> > Perhaps an intermediate value would work as well, but I don't have
> > a suitable version to check.
> >
> > Signed-off-by:  Art Haas <ahaas@airmail.net>
> >
> > diff --git a/http.h b/http.h
> > index 9ca16ac..aeff988 100644
> > --- a/http.h
> > +++ b/http.h
> > @@ -22,6 +22,10 @@ #if LIBCURL_VERSION_NUM < 0x070c04
> >  #define NO_CURL_EASY_DUPHANDLE
> >  #endif
> >  
> > +#if LIBCURL_VERSION_NUM < 0x070f05
> > +#define CURLE_HTTP_RETURNED_ERROR CURLE_HTTP_NOT_FOUND
> > +#endif
> > +
> >  struct slot_results
> >  {
> >  	CURLcode curl_result;
> >
> 
> Eh, why not
> 
>         #ifndef CURLE_HTTP_RETURNED_ERROR
>         #define CURLE_HTTP_RETURNED_ERROR CURLE_HTTP_NOT_FOUND
>         #endif

Hi.

Both 'CURLE_HTTP_RETURNED_ERROR' and 'CURLE_HTTP_NOT_FOUND' are part of
an enumeration, not preprocessor '#define' values. I suppose that the
odd-looking 'E' in the names is meant to signify 'enum'.

Art Haas
-- 
Man once surrendering his reason, has no remaining guard against absurdities
the most monstrous, and like a ship without rudder, is the sport of every wind.

-Thomas Jefferson to James Smith, 1822
