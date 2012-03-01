From: Nelson Benitez Leon <nelsonjesus.benitez@seap.minhap.es>
Subject: Re: [PATCH 2/3] http: try standard proxy env vars when http.proxy
 config option is not set
Date: Thu, 01 Mar 2012 10:57:03 +0100
Message-ID: <4F4F47EF.40405@seap.minhap.es>
References: <4F4CCE8A.4010800@seap.minhap.es><20120228191514.GD11260@sigill.intra.peff.net><4F4D2AAD.3040107@vilain.net><20120228193443.GB11725@sigill.intra.peff.net><4F4E01EB.3070707@seap.minhap.es> <20120229210816.GB628@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Sam Vilain <sam@vilain.net>, Thomas Rast <trast@inf.ethz.ch>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Mar 01 09:59:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S31rG-0006LG-W8
	for gcvg-git-2@plane.gmane.org; Thu, 01 Mar 2012 09:59:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932206Ab2CAI70 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Mar 2012 03:59:26 -0500
Received: from luthien1.mpt.es ([82.150.0.102]:26760 "EHLO luthien2.map.es"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758686Ab2CAI70 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Mar 2012 03:59:26 -0500
Received: from correo.map.es (unknown [10.1.31.23])
	by luthien2.map.es (Postfix) with ESMTP id D12F4B70DD;
	Thu,  1 Mar 2012 09:58:24 +0100 (CET)
Received: from [10.47.128.147] (unknown [10.1.29.79])
	by correo.map.es (Postfix) with ESMTP id 1B6E9203900;
	Thu,  1 Mar 2012 09:58:20 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:10.0.1) Gecko/20120216 Thunderbird/10.0.1
In-Reply-To: <20120229210816.GB628@sigill.intra.peff.net>
X-map-MapScanner: Libre de virus, Libre de virus
X-Spam-Status: No, No
X-map-MapScanner-Information: 
X-map-MapScanner-ID: D12F4B70DD.DB760
X-map-MapScanner-From: nelsonjesus.benitez@seap.minhap.es
X-map-MailScanner-Watermark: 1331197105.99469@Ss37Rvx9DltcOWOpDtYcrQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191907>

On 02/29/2012 10:08 PM, Jeff King wrote:
> On Wed, Feb 29, 2012 at 11:46:03AM +0100, Nelson Benitez Leon wrote:
> 
>>> Good point. We sometimes follow this order:
>>>
>>>   1. git-specific environment variables (i.e., $GIT_HTTP_PROXY, if
>>>      it existed)
>>>   2. git config files (i.e., http.proxy)
>>>   3. generic system environment (i.e., $http_proxy).
>>>
>>> So thinking about it that way, the original patch makes more sense.
>>
>> So, in PATCH 2/3, apart from expanding the commit message.. do we want
>> to support HTTP_PROXY or only http_proxy ? HTTP_PROXY seems to not be
>> very used by existent programs, but support it it's only a gentenv call..
> 
> If HTTP_PROXY is not in wide use, I don't see a reason to support it.

Ok

> And I take back what I said about environment precedence, based on the
> discussion. Also, I don't think there is a need to strdup the results of
> getenv here, is there? So I think the code you want is just:
> 
>   if (!curl_http_proxy)
>           curl_http_proxy = getenv("http_proxy");

but curl_http_proxy gets freed in http_cleanup as follows:

free((void *)curl_http_proxy);

Is it ok to free strings returned by getenv() ? I thought nope, so I
used strdup which existent code was already using..
> 
> and the justification for the commit message is that we need to know the
> proxy value outside of curl, because the next patch will do some
> extra processing on the value.
> 
> -Peff
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
