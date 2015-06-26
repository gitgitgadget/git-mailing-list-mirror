From: Enrique Tobis <Enrique.Tobis@twosigma.com>
Subject: RE: [PATCH] http: always use any proxy auth method available
Date: Fri, 26 Jun 2015 21:53:24 +0000
Message-ID: <FCAB894186380D42A07AFFFA5A1282B8F1EC7AB5@EXMBNJE2.ad.twosigma.com>
References: <FCAB894186380D42A07AFFFA5A1282B8F1EC65FD@EXMBNJE2.ad.twosigma.com>
 <xmqqfv5etgqt.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: "'git@vger.kernel.org'" <git@vger.kernel.org>,
	'Nelson Benitez Leon' <nbenitezl@gmail.com>
To: 'Junio C Hamano' <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jun 27 00:01:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z8bgg-0002XJ-75
	for gcvg-git-2@plane.gmane.org; Sat, 27 Jun 2015 00:01:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752124AbbFZWB0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Jun 2015 18:01:26 -0400
Received: from mxl1.nje.dmz.twosigma.com ([208.77.214.145]:51459 "EHLO
	mxl1.nje.dmz.twosigma.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752173AbbFZWBY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 26 Jun 2015 18:01:24 -0400
X-Greylist: delayed 475 seconds by postgrey-1.27 at vger.kernel.org; Fri, 26 Jun 2015 18:01:23 EDT
Received: by mxl1.nje.dmz.twosigma.com (Postfix, from userid 110)
	id DE127600A3; Fri, 26 Jun 2015 21:53:27 +0000 (GMT)
X-Spam-Checker-Version: SpamAssassin 3.3.2 (2011-06-06) on
	mxl1.nje.dmz.twosigma.com
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00=-1.9 autolearn=no
	version=3.3.2
Received: from EXHTNJE2.ad.twosigma.com (exhtnje2.ad.twosigma.com [172.20.32.80])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mxl1.nje.dmz.twosigma.com (Postfix) with ESMTPS id A50876008B;
	Fri, 26 Jun 2015 21:53:26 +0000 (GMT)
Received: from EXMBNJE2.ad.twosigma.com ([169.254.2.157]) by
 EXHTNJE2.ad.twosigma.com ([172.20.32.80]) with mapi id 14.03.0224.002; Fri,
 26 Jun 2015 17:53:26 -0400
Thread-Topic: [PATCH] http: always use any proxy auth method available
Thread-Index: AdCwOo62xtSDc71ITZiaogSfyRcNiAACzYfOAAAjX5A=
In-Reply-To: <xmqqfv5etgqt.fsf@gitster.dls.corp.google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.20.60.10]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272834>

Thanks for your feedback!

> -----Original Message-----
> From: Junio C Hamano [mailto:jch2355@gmail.com] On Behalf Of Junio C
> Hamano
> Sent: Friday, June 26, 2015 15:25
> To: Enrique Tobis
> Cc: 'git@vger.kernel.org'; 'Nelson Benitez Leon'
> Subject: Re: [PATCH] http: always use any proxy auth method available
> 
> Enrique Tobis <Enrique.Tobis@twosigma.com> writes:
> 
> Thanks.  I wonder why this was addressed me directly (i.e. I am not an area
> expert, and I haven't seen this patch discussed here and reviewed by other
> people), but anyway...

I apologize for that. I misunderstood part of the instructions for submitting patches.

> > By default, libcurl honors some environment variables that specify a
> > proxy (e.g. http_proxy, https_proxy). Also by default, libcurl will
> > only try to authenticate with a proxy using the Basic method.
> 
> OK, that is a statement of two facts.
> 
> What's missing here is what they relate to this change.  Are these two good
> things that we want to keep?  Are these bad things we need to tweak out by
> changing our software?  Or some combination?  Some third key information
> that is left untold?
> 
> > This
> > change makes libcurl always try the most secure proxy authentication
> > method available. As a consequence, you can use environment variables
> > to instruct git to use a proxy that uses an authentication method
> > different from Basic (e.g. Negotiate).
> 
> That is a worthy goal, but the description of the current problem seems
> lacking.  Perhaps you meant something like this:
> 
> 	We use CURLOPT_PROXYAUTH to ask for the most secure
>         authentication method with proxy only when we have
>         curl_http_proxy set, by http.proxy or remote.*.proxy
>         configuration variables.  However, libcurl also allows users
>         to use http proxies by setting some environment variables,
>         and by default the authentication with the proxy uses Basic
>         auth (unless specified with CURLOPT_PROXYAUTH, that is).
> 
> 	By always using CURLOPT_PROXYAUTH to ask for the most secure
> 	authentication method, even when we are not aware that we
> 	are using proxy (because there is no configuration that
> 	tells us so), we can allow users to tell libcurl to use
> 	a proxy with more secure method without setting http.proxy
>         or remote.*.proxy configuration variables.
> 
> But I am just guessing; as I said, I am not an expert in this area of the code.

How about this?

"
We set CURLOPT_PROXYAUTH to use the most secure authentication method available only when the user has set configuration variables to specify a proxy. However, libcurl also supports specifying a proxy through environment variables. In that case libcurl defaults to only using the Basic proxy authentication method.

This change sets CURLOPT_PROXYAUTH to always use the most secure authentication method available, even when there is no git configuration telling us to use a proxy. This allows the user to use environment variables to configure a proxy that requires an authentication method different from Basic.
"

> > Signed-off-by: Enrique A. Tobis <etobis@twosigma.com>
> > ---
> >  http.c |    4 ++--
> >  1 files changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/http.c b/http.c
> > index f0c5bbc..e9c6fdd 100644
> > --- a/http.c
> > +++ b/http.c
> > @@ -416,10 +416,10 @@ static CURL *get_curl_handle(void)
> >
> >  	if (curl_http_proxy) {
> >  		curl_easy_setopt(result, CURLOPT_PROXY, curl_http_proxy);
> > +	}
> >  #if LIBCURL_VERSION_NUM >= 0x070a07
> 
> The authoritative source of truth:
> 
>   https://github.com/bagder/curl/blob/master/docs/libcurl/symbols-in-
> versions
> 
> matches this version number, so there is nothing wrong per-se on this line,
> but it makes me wonder why we didn't do
> 
> 	#ifdef CURLOPT_PROXYAUTH
> 
> instead.  That's not something that should be changed with this change,
> though.
> 
> > -		curl_easy_setopt(result, CURLOPT_PROXYAUTH,
> CURLAUTH_ANY);
> > +	curl_easy_setopt(result, CURLOPT_PROXYAUTH, CURLAUTH_ANY);
> 
> >  #endif
> > -	}
> >
> >  	set_curl_keepalive(result);
> 
> Assuming that I guessed your justification for this change corretly in the
> earlier part of this message, I think the change makes sense.

You did guess correctly. As you said you are not an expert in this area, should I wait until someone else chimes in or is this enough to resubmit for inclusion? Assuming my revised explanation is acceptable, of course.
 
> Thanks.

Thank you!

Enrique
