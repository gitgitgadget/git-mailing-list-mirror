From: Mike Gaffney <mr.gaffo@gmail.com>
Subject: Re: [PATCH][v2] http authentication via prompts (with correct line
  lengths)
Date: Fri, 13 Mar 2009 07:47:30 -0500
Message-ID: <49BA55E2.1060604@gmail.com>
References: <49B5AF67.6050508@gmail.com> <7v1vt6dxg9.fsf@gitster.siamese.dyndns.org> <49B5F0BA.3070806@gmail.com> <7v63ihdgy6.fsf@gitster.siamese.dyndns.org> <e2b179460903120153u5fdb58b6tf3027eea23673df0@mail.gmail.com> <7vsklihsti.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Mike Ralphson <mike.ralphson@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 13 13:48:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Li6ok-00045S-3Q
	for gcvg-git-2@gmane.org; Fri, 13 Mar 2009 13:48:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752806AbZCMMrV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Mar 2009 08:47:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751624AbZCMMrV
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Mar 2009 08:47:21 -0400
Received: from 9a.26.1243.static.theplanet.com ([67.18.38.154]:36089 "EHLO
	rubble.crucialcrossbar.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750852AbZCMMrU (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 13 Mar 2009 08:47:20 -0400
Received: from adsl-70-130-135-214.dsl.stlsmo.swbell.net ([70.130.135.214] helo=[192.168.1.102])
	by rubble.crucialcrossbar.com with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.69)
	(envelope-from <mr.gaffo@gmail.com>)
	id 1Li6nB-0008Mf-3V; Fri, 13 Mar 2009 06:47:13 -0600
User-Agent: Thunderbird 2.0.0.19 (Windows/20081209)
In-Reply-To: <7vsklihsti.fsf@gitster.siamese.dyndns.org>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - rubble.crucialcrossbar.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - gmail.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113178>

I was going to try and clean this up this weekend or early next week. I'm also
trying to encourage open source submissions at work and was using this
as an example patch to get people going (we need the fix to use git). So
I do plan finishing this, just have to do it when I have time.

Daniel, thanks for the link, I had been wondering what was introduced when in curl.

-Mike

Junio C Hamano wrote:
> Mike Ralphson <mike.ralphson@gmail.com> writes:
> 
>> Elsewhere we seem to protect use of CURL_NETRC_OPTIONAL by checking
>> for LIBCURL_VERSION_NUM >= 0x070907. I have an ancient curl here
>> (curl-7.9.3-2ssl) which doesn't seem to have this option, so building
>> next is broken on AIX for me from this morning (c33976cb).
> 
> Yeah, I did this as "How about doing it this way without adding a band-aid
> configuration options" demonstration, and meant to clean it up (rather,
> meant to wait for the original submitter to clean-up) before moving it
> forward, but I forgot.  Sorry about that.
> 
> How does this look?
> 
> http://curl.haxx.se/libcurl/c/curl_easy_setopt.html seems to say "added in
> 7.X.Y" for some options but does say when CURLOPT_USERPWD was added, so I
> am assuming it was available even in very early versions...
> 
> -- >8 --
> From 750d9305009a0f3fd14c0b5c5e62ae1eb2b18fda Mon Sep 17 00:00:00 2001
> From: Junio C Hamano <gitster@pobox.com>
> Date: Thu, 12 Mar 2009 22:34:43 -0700
> Subject: [PATCH] http.c: CURLOPT_NETRC_OPTIONAL is not available in ancient versions of cURL
> 
> Besides, we have already called easy_setopt with the option before coming
> to this function if it was available, so there is no need to repeat it
> here.
> 
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  http.c |    4 +---
>  1 files changed, 1 insertions(+), 3 deletions(-)
> 
> diff --git a/http.c b/http.c
> index b8f947e..2fc55d6 100644
> --- a/http.c
> +++ b/http.c
> @@ -138,9 +138,7 @@ static int http_options(const char *var, const char *value, void *cb)
>  
>  static void init_curl_http_auth(CURL *result)
>  {
> -	if (!user_name)
> -		curl_easy_setopt(result, CURLOPT_NETRC, CURL_NETRC_OPTIONAL);
> -	else {
> +	if (user_name) {
>  		struct strbuf up = STRBUF_INIT;
>  		if (!user_pass)
>  			user_pass = xstrdup(getpass("Password: "));

-- 
-Mike Gaffney (http://rdocul.us)
