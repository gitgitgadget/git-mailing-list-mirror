From: Sam Vilain <sam@vilain.net>
Subject: Re: [PATCH v2 2/3] http: try http_proxy env var when http.proxy config
 option is not set
Date: Thu, 01 Mar 2012 09:45:35 -0800
Message-ID: <4F4FB5BF.8000904@vilain.net>
References: <4F4FBE0F.6020004@seap.minhap.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, peff@peff.net
To: Nelson Benitez Leon <nelsonjesus.benitez@seap.minhap.es>
X-From: git-owner@vger.kernel.org Thu Mar 01 18:45:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S3A4c-0001ft-DL
	for gcvg-git-2@plane.gmane.org; Thu, 01 Mar 2012 18:45:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754334Ab2CARpi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Mar 2012 12:45:38 -0500
Received: from uk.vilain.net ([92.48.122.123]:53672 "EHLO uk.vilain.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753353Ab2CARpi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Mar 2012 12:45:38 -0500
Received: by uk.vilain.net (Postfix, from userid 1001)
	id 637348276; Thu,  1 Mar 2012 17:45:37 +0000 (GMT)
X-Spam-Checker-Version: SpamAssassin 3.3.1 (2010-03-16) on uk.vilain.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=unavailable version=3.3.1
Received: from [IPv6:::1] (localhost [127.0.0.1])
	by uk.vilain.net (Postfix) with ESMTP id D85528209;
	Thu,  1 Mar 2012 17:45:35 +0000 (GMT)
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.7; rv:10.0.2) Gecko/20120216 Thunderbird/10.0.2
In-Reply-To: <4F4FBE0F.6020004@seap.minhap.es>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191952>

On 3/1/12 10:21 AM, Nelson Benitez Leon wrote:
> CuRL already reads it, but if $http_proxy has username but no password
> curl will not ask you for the password.. so we read it ourselves to
> detect that and ask for the password.

That's not what this change does.  This change explicitly loads from the 
environment the 'http_proxy' variable and sets up curl to use it.  As 
Junio said, this is (on its own) a regression.

Sam


> Signed-off-by: Nelson Benitez Leon<nbenitezl@gmail.com>
> ---
>   http.c |    7 +++++++
>   1 files changed, 7 insertions(+), 0 deletions(-)
>
> diff --git a/http.c b/http.c
> index 8ac8eb6..8932da5 100644
> --- a/http.c
> +++ b/http.c
> @@ -295,6 +295,13 @@ static CURL *get_curl_handle(void)
>   	if (curl_ftp_no_epsv)
>   		curl_easy_setopt(result, CURLOPT_FTP_USE_EPSV, 0);
>
> +	if (!curl_http_proxy) {
> +		const char *env_proxy;
> +		env_proxy = getenv("http_proxy");
> +		if (env_proxy) {
> +			curl_http_proxy = xstrdup(env_proxy);
> +		}
> +	}
>   	if (curl_http_proxy) {
>   		curl_easy_setopt(result, CURLOPT_PROXY, curl_http_proxy);
>   		curl_easy_setopt(result, CURLOPT_PROXYAUTH, CURLAUTH_ANY);
