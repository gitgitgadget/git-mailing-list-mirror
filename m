From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: Patchset NTLM-Authentication
Date: Tue, 21 Feb 2012 14:28:17 +0100
Message-ID: <8762f05n9q.fsf_-_@thomas.inf.ethz.ch>
References: <4CDEC141B5583D408E79F2931DB7708301802B70@GSX300A.mxchg.m.corp>
	<87vcn0h77a.fsf@thomas.inf.ethz.ch>
	<4CDEC141B5583D408E79F2931DB7708301802BE7@GSX300A.mxchg.m.corp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: <git@vger.kernel.org>, <gitster@pobox.com>, <avarab@gmail.com>
To: "Schmidt, Marco" <Marco.Schmidt@cassidian.com>
X-From: git-owner@vger.kernel.org Tue Feb 21 14:28:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rzpla-0006Oz-Ox
	for gcvg-git-2@plane.gmane.org; Tue, 21 Feb 2012 14:28:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754257Ab2BUN2V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Feb 2012 08:28:21 -0500
Received: from edge10.ethz.ch ([82.130.75.186]:14417 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753171Ab2BUN2U (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Feb 2012 08:28:20 -0500
Received: from CAS20.d.ethz.ch (172.31.51.110) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.1.355.2; Tue, 21 Feb
 2012 14:28:17 +0100
Received: from thomas.inf.ethz.ch.ethz.ch (129.132.153.233) by CAS20.d.ethz.ch
 (172.31.51.110) with Microsoft SMTP Server (TLS) id 14.1.355.2; Tue, 21 Feb
 2012 14:28:17 +0100
In-Reply-To: <4CDEC141B5583D408E79F2931DB7708301802BE7@GSX300A.mxchg.m.corp>
	(Marco Schmidt's message of "Tue, 21 Feb 2012 12:42:26 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191155>

"Schmidt, Marco" <Marco.Schmidt@cassidian.com> writes:

> Thanks for your reply. I have used the wereHamster bundler service and
> created the following patch. May I ask you to test the patch and check
> again for more style violations?

Please keep these discussions public, so that others can learn and
(heaven forbid...) point out _my_ mistakes.

I'll discuss the file you attached below.  Keep in mind that unless
there is a compelling reason not to do that, you should send your
patches inline.  This allows for much easier review on the list.

> Subject: [PATCH] Allow NTLM-Authentication against a http-proxy server - Add
>  config option "http.proxyauthany" - Set CURLOPT_PROXYAUTH
>  to CURLAUTH_ANY if option curl_http_proxyauthany is true.
> 
> ---

You can already see that you did not adhere to the standard format of a
commit message: one line summary, followed by a blank line, followed by
a long description.  So the above might have been written (dropping the
Subject: pseudoheader tag now):

} Allow NTLM-Authentication against a http-proxy server
} 
} - Add config option "http.proxyauthany"
} 
} - Set CURLOPT_PROXYAUTH to CURLAUTH_ANY if option
}   curl_http_proxyauthany is true.

Now bear in mind that I have no clue about curl (except that it
downloads stuff ;-) and especially about its authentication parts.  But
allow me to sketch a different commit message that highlights what I
would like to see answered.  I am merely using the knowledge I could
glean from 2min of googling around; I am not saying that anything of it
is correct, so you should fix it as needed!

  http/curl: let user configure "any" proxy authentication

  Normally, curl uses only the "basic" authentication scheme when
  talking to proxies, which may not be desirable (it sends the password
  in cleartext) or sufficient (the author needs NTLM authentication for
  his proxy).

  Introduce the config setting http.proxyAuthAny.  When enabled, we tell
  curl to use any authentication scheme supported by the proxy.

  This mostly parallels http.authAny which was introduced in b8ac923
  (Add an option for using any HTTP authentication scheme, not only
  basic, 2009-11-27).  http.authAny was removed, and its feature
  unconditionally enabled, in 525ecd2 (Remove http.authAny, 2009-12-28).
  However the reasoning of the latter does not apply here because XXXX.


Some notes on the code/patch: There was some trailing whitespace, please
make sure you remove it.

Usually we introduce a setting (command line option or environment
variable) that can be tweaked to override the configuration.  b8ac923
did this if you need some inspiration :-)  Otherwise you should make an
argument why this is not needed.

 +#ifdef LIBCURL_CAN_HANDLE_AUTH_ANY
> +	if (curl_http_proxyauthany) {
> +		curl_easy_setopt(result, CURLOPT_PROXYAUTH, CURLAUTH_ANY);
> +	}
> +#endif

My google is failing me as to when this feature was introduced or how
common curls without it still are.  But you could be extra doubly nice
to the user and warn if s/he enabled the feature, but git cannot adhere
to the request because curl doesn't support it.  (Then again b8ac923
didn't go that far either.)

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
