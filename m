From: Nelson Benitez Leon <nelsonjesus.benitez@seap.minhap.es>
Subject: Re: [PATCH v2 3/3] http: when proxy url has username but no password,
 ask for password
Date: Fri, 02 Mar 2012 15:05:17 +0100
Message-ID: <4F50D39D.5040806@seap.minhap.es>
References: <4F4FBE6C.5050507@seap.minhap.es><4F4FB69C.7000708@vilain.net><20120301215812.GG17631@sigill.intra.peff.net><4F50CC41.5020307@seap.minhap.es> <20120302124538.GA10637@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Sam Vilain <sam@vilain.net>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Mar 02 14:07:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S3SDG-0004v5-Qc
	for gcvg-git-2@plane.gmane.org; Fri, 02 Mar 2012 14:07:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757762Ab2CBNHw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Mar 2012 08:07:52 -0500
Received: from luthien1.map.es ([82.150.0.102]:34097 "EHLO luthien2.map.es"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756894Ab2CBNHv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Mar 2012 08:07:51 -0500
Received: from correo.map.es (unknown [10.1.24.76])
	by luthien2.map.es (Postfix) with ESMTP id AC35188058;
	Fri,  2 Mar 2012 14:06:50 +0100 (CET)
Received: from [10.47.128.147] (unknown [10.1.29.79])
	by correo.map.es (Postfix) with ESMTP id 8369F2C4F4;
	Fri,  2 Mar 2012 14:06:34 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:10.0.1) Gecko/20120216 Thunderbird/10.0.1
In-Reply-To: <20120302124538.GA10637@sigill.intra.peff.net>
X-map-MapScanner: Libre de virus, Libre de virus
X-Spam-Status: No, No
X-map-MapScanner-Information: 
X-map-MapScanner-ID: AC35188058.0A3AE
X-map-MapScanner-From: nelsonjesus.benitez@seap.minhap.es
X-map-MailScanner-Watermark: 1331298413.15244@I0qLgo+NMSzrsgIYlbOcWQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192038>

On 03/02/2012 01:45 PM, Jeff King wrote:
> On Fri, Mar 02, 2012 at 02:33:53PM +0100, Nelson Benitez Leon wrote:
> 
>>> So there's the history lesson. What should proxy auth do?
>>>
>>>   1. Definitely respond to HTTP 407 by prompting on the fly; this code
>>>      should go along-side the HTTP 401 code in http.c.
>>>
>>>   2. Definitely do the pre-prompt thing when http_proactive_auth is set
>>>      (which is used only by http-push). Unless somebody really feels
>>>      like re-writing http-push to handle retries for authentication.
>>>
>>>   3. Consider doing the pre-prompt thing when http_proactive_auth is not
>>>      set. This can save a round-trip, but we should not do it if there
>>>      is a good reason not to. The two possible reasons I can think of
>>>      are:
>>>
>>>        a. Like http auth, if curl will read the proxy credentials from
>>>           .netrc, then we should not do it for the same reasons
>>>           mentioned in 986bbc0.
>>>
>>>        b. If people realistically have proxy URLs with usernames but do
>>>           _not_ want to ask for a password, then the prompt will be
>>>           annoying. I'm not sure that anybody expects that.
>>
>> So, trying to sum up, I will try to redo patch-set as follows:
>> - Ignore PATCH 2/3 , that is, we won't read any env var.
>> - Let cURL try to connect and if that fails with 407 , then do a credential_fill
>> and try to reconnect.
>>
>> Is that ok? or do I need to do something more?
> 
> I think you'll still need to read the env var, because you'll need to
> know the proxy URL when getting the password (to ask credential helpers
> properly, and to prompt the user).

Ok, but I can read it after receiving the 407 (and in case we were not
using http.proxy) so discarding PATCH 2/3 still applies, ok? or we need
to read it first-hand for the http_proactive_auth you mention below?

> 
> Also, I think you'll need to call credential_fill() when
> http_proactive_auth is set. Otherwise http-push will not be able to do
> proxy auth.

I still don't get what proactive_auth is about, will ask you when I get
to that part of the patch.

Thank you,


> -Peff
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
