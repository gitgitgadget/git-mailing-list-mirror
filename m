From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] http: Support sending custom HTTP headers
Date: Tue, 26 Apr 2016 17:37:32 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1604261733410.2896@virtualbox>
References: <abe253758829795c285c2036196ebe7edd9bab34.1461589951.git.johannes.schindelin@gmx.de> <20160425170326.GA1551@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Apr 26 17:38:01 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1av53n-0007TL-JS
	for gcvg-git-2@plane.gmane.org; Tue, 26 Apr 2016 17:38:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752501AbcDZPhv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Apr 2016 11:37:51 -0400
Received: from mout.gmx.net ([212.227.15.19]:51307 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752424AbcDZPht (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Apr 2016 11:37:49 -0400
Received: from virtualbox ([37.24.143.127]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0MHHdb-1ayhfp2Ejb-00E3fB; Tue, 26 Apr 2016 17:37:34
 +0200
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <20160425170326.GA1551@sigill.intra.peff.net>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:O/e0c5roNGvjFKu3MNPFymS8gzPr49N0s3f7GVsBQUE8vywmFKT
 PiwJlUlt7t/ueNfRgJVF8kqAVVwtiqai3SYtiQ31n43Vxxaujhty3KaINEn0/w6hcoJyW+b
 8MZKGQ5A1N5ZmwvFlxc7gvU5LRjLTRKQ8MOlJtw83Smj+oxscKJq97ejYeh5C8oo2Dr/wA6
 DDKIO5WhDUlDWuwBqWifg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:MBx33hgjdQQ=:opR2D6EUkvVrMXdfiJNBOx
 sXDLeCWthQP+ZgXXmePzWwIrPXx5XcJHi3m5M9n58mAqfqGDVgVoJMzImd1ztijihugZ8MN5x
 LpHU3742lJhxAhLEYxlm3Gs72mMfygYxV+KJiLgO0a0BSWeeLvZ8KwWltet0JWdo+yunl5GtE
 BJzxQvFlrNs3ZMR1zYMJ4b5S100FEw2aQi684MX/szkwi72/hKOUMj4Lh8msw9rimO6HYThiJ
 i0ZWxwf0+MUCiFfz3e1GG1cXfr+Cp8ZAJX7flEt5PiX9SDGtnlZWt21BHlkp5uJKk0/Vx2Wk5
 i0l6lowk0036ncLsk1h1o0KSTP04QkNrUhbiCNUuvEhe3pwhhbHLYZkYOMzc+G9Xk2unVEsMj
 oDYqBHepsDZm1DlOI8ZlFGH/5k4v8Uro+0VqbJX8S6cT67tn/b9BgSselDdw3sHSN8wytH+9P
 5pIIqSJMJka0+puKbUGC0rfGCUMICyigM+REuV4MB07tS2yY9IFlmcK2wky9jAbiZkFC737wZ
 Nt8X1qfsUBR2iCG0GZWZHjGxkcVrmwyossiyeXErfmrQjclsL5/Wlix0JRUOiuXkMiZbu/Pvq
 6qAK9cHc5lvCNOlJJwllSnPIRE0J6h3trrQftKKxpUa370TefIlGKqY13PszkT0lSLrdXdYi7
 930R9VPfulkqSmcTtCfeAkDvmDVJKJHvLFBgUuFdggHQODneG7bufQIQNHRImqVUz/mkPPYdC
 St/hswD5B8vL14hHW2Aq15UzUxpFslBF7CLODFH4YJPK8eV0jr3+iFj9uyTEOLR8j27h+phv 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292604>

Hi Peff,

On Mon, 25 Apr 2016, Jeff King wrote:

> On Mon, Apr 25, 2016 at 03:13:08PM +0200, Johannes Schindelin wrote:
> 
> > diff --git a/http.c b/http.c
> > index 4304b80..02d7147 100644
> > --- a/http.c
> > +++ b/http.c
> > @@ -114,6 +114,7 @@ static unsigned long http_auth_methods = CURLAUTH_ANY;
> >  
> >  static struct curl_slist *pragma_header;
> >  static struct curl_slist *no_pragma_header;
> > +static struct curl_slist *extra_http_headers;
> >  
> >  static struct active_request_slot *active_queue_head;
> >  
> > @@ -323,6 +324,12 @@ static int http_options(const char *var, const char *value, void *cb)
> >  #endif
> >  	}
> >  
> > +	if (!strcmp("http.extraheader", var)) {
> > +		extra_http_headers =
> > +			curl_slist_append(extra_http_headers, value);
> > +		return 0;
> > +	}
> 
> I wondered if this would trigger for "http.*.extraheader", too. And it
> should, as that is all handled in the caller of http_options. Good.

Yes, I was surprised about that, too, but all the other http.* settings
are handled via the urlmatch mechanism (which rewrites the matching
http.<URL>.* settings).

> > @@ -678,8 +685,10 @@ void http_init(struct remote *remote, const char *url, int proactive_auth)
> >  	if (remote)
> >  		var_override(&http_proxy_authmethod, remote->http_proxy_authmethod);
> >  
> > -	pragma_header = curl_slist_append(pragma_header, "Pragma: no-cache");
> > -	no_pragma_header = curl_slist_append(no_pragma_header, "Pragma:");
> > +	pragma_header = curl_slist_append(http_get_default_headers(),
> > +		"Pragma: no-cache");
> > +	no_pragma_header = curl_slist_append(http_get_default_headers(),
> > +		"Pragma:");
> 
> This looked wrong to me at first, because we are appending to the
> default header list in each case. But the secret sauce is that calling
> http_get_default_headers() actually creates a _new_ list that is a copy
> of the default headers (and the caller can do what they will with it,
> and must free it).
> 
> I think that's really the only sane way to do it because of curl's
> interfaces. But maybe it is worth a comment either here, or along with
> http_get_default_headers(), or both.

I chose to rename it to http_copy_default_headers(); That should make it
easier to understand.

Ciao,
Dscho
