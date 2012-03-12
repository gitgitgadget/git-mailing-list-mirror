From: Nelson Benitez Leon <nelsonjesus.benitez@seap.minhap.es>
Subject: [PATCH v4 0/5] New roll of proxy improvements
Date: Mon, 12 Mar 2012 18:24:53 +0100
Message-ID: <4F5E3165.9090304@seap.minhap.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: peff@peff.net, sam@vilain.net
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 12 17:26:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S784j-0005Tz-TU
	for gcvg-git-2@plane.gmane.org; Mon, 12 Mar 2012 17:26:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751608Ab2CLQ0S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Mar 2012 12:26:18 -0400
Received: from luthien1.map.es ([213.9.211.102]:24491 "EHLO luthien2.map.es"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751417Ab2CLQ0R (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Mar 2012 12:26:17 -0400
Received: from correo.map.es (unknown [10.1.24.76])
	by luthien2.map.es (Postfix) with ESMTP id 3BF89F690A;
	Mon, 12 Mar 2012 17:26:07 +0100 (CET)
Received: from [10.47.128.147] (unknown [10.1.29.55])
	by correo.map.es (Postfix) with ESMTP id 389882C684;
	Mon, 12 Mar 2012 17:26:02 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:10.0.1) Gecko/20120216 Thunderbird/10.0.1
X-map-MapScanner: Libre de virus, Libre de virus
X-Spam-Status: No, No
X-map-MapScanner-Information: 
X-map-MapScanner-ID: 3BF89F690A.9ACE5
X-map-MapScanner-From: nelsonjesus.benitez@seap.minhap.es
X-map-MailScanner-Watermark: 1332174367.41557@6SnwkxZCBFVZ9z0M8W5SYA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192891>

So here is a new roll based on last comments, changes
from last roll are:

- Unify in new function set_proxy_auth() the code for
setting proxy username and password in cURL options, which is
indepently setted and not as part of the CURLOPT_PROXY as before.

- If using libcurl >= 7.19.1 use options CURLOPT_PROXYUSERNAME
and CURLOPT_PROXYPASSWORD which let special characters like '@'
or ':' to be present in those options and be correctly treated
by libcurl. If libcurl is < 7.19.1 then use CURLOPT_PROXYUSERPWD
option.

- Refactor http_request_reauth() function to permit more than two
retries, this comes from a jeff king's patch.

- Rename HTTP_REAUTH return status to HTTP_RETRY to better fit the
new semantics according to the aforementioned refactor in
http_request_reauth().

Regards,

Nelson Benitez Leon (5):
  http: try http_proxy env var when http.proxy config option is not set
  http: handle proxy proactive authentication
  http: handle proxy authentication failure (error 407)
  http: Avoid limit of retrying request only twice
  http: rename HTTP_REAUTH to HTTP_RETRY

 http.c |   56 ++++++++++++++++++++++++++++++++++++++++++++++++++------
 http.h |    2 +-
 2 files changed, 51 insertions(+), 7 deletions(-)

-- 
1.7.7.6
