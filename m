From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v5 0/2] Add support for sending additional HTTP headers
Date: Thu, 28 Apr 2016 12:03:34 +0200 (CEST)
Message-ID: <cover.1461837783.git.johannes.schindelin@gmx.de>
References: <3b71deffa5d07cf73a793773cc3d60ff611843fa.1461759454.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 28 12:04:00 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1avinf-0000um-Kr
	for gcvg-git-2@plane.gmane.org; Thu, 28 Apr 2016 12:03:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753448AbcD1KDz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Apr 2016 06:03:55 -0400
Received: from mout.gmx.net ([212.227.15.19]:57808 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752907AbcD1KDy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Apr 2016 06:03:54 -0400
Received: from virtualbox ([37.24.143.127]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0LoVvG-1bbu1y00N8-00gUpJ; Thu, 28 Apr 2016 12:03:36
 +0200
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <3b71deffa5d07cf73a793773cc3d60ff611843fa.1461759454.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:qx5ywB65y1w9IjlUG6nt6KTK/sIzN9KI5SQrldCHqixosgehDO+
 l+RUNVG7KKvXpWlKYeMcLMPM1EurJn1Zx9xnY/gDPQIn+J5Ca1klVDSNXG/7V2YeReEcGFk
 f9L2doEARwkzwvhWbnTX0nOtwjnccoogM0RKtQ1z/F8t+knpbofo/6Mo8KZzk9ipXX1Ax5a
 O25L/EFb/gtMY8R5rOWGA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:6emReaMXmUM=:ZOsvsu79oExEosV9NhR9EE
 z4VHIFUmvqsrYhO8Sb0xRfH+A8mUdNWtmoZIg0x1eDZhzPuwATK7f+CIt9TCrv/uUHpMHejKl
 DxuPi2448AlvnUA5TBiQ8qNiKFW27zoFCJlCXbNqwRnVcrlbFBTVVOuHQNkl4PVZW0O5XmZu3
 JB7jswDVKLOTZ6nBrRP87IyNFxgo6dCLNS5607Z56+QPxdsIz//xjNW6W95qb7DWG/zsZ5KGI
 RyQkvtwFdEaCz0bNk2+aKYvlMemtpH2kfz+ftF4+givC+lldSQcyzHGdsEwRQTXk4Vd+RABvH
 G302u1TzUS3i+HcHiEa1QiqeecZkT+4lrh0Kg0XkLL20c/KguL9DuyA3w6paM7IBMB3DQLGIf
 xsDSWFKbxnnnGi6+UQtaSIkti/V5FOg53cIn3vELGVR/W9nAnGFsaec0rC8ynh8JDqJKhsmLl
 OMHQcgRqXoomV4HT72bFD73DUqyK8t1/GfUqeJUexK/QxBdYD7XdZoYH4k8u0SO2YiLMbApo+
 4FnLGgB+P/ZGepab58steUGgMhc2cOvg8FGxhgqLoSTrG1zJBbGSlHw04dO/fx5SJVEgnWE6F
 T/ybzduePGnQW47Ak0XEkx76OhpafssRw5kPtAnuuTeKAjMGeLXHl4pZjcU5Z4VOrKWiUBbY4
 4fwI34I/9BrgeXzdhwHHSi2bKz7yWaH1/qpqlbXeLwRjhvw+qP8Ebi8PGajV/I8YmbDKBh5i7
 oaoVh3ttNXfWZbTZpDLz4ucN6D6wJbHqmAVLJsYTnZZGoAM83j8eHtmym2WwCSsSymnHQKtR 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292860>

My use case is an army of build agents that need only limited and
selective access to otherwise private repositories.

I apologize for sending out v5 after v4 was already acknowledged: my
initial testing was on simple repositories and I forgot that my build
agents need to handle submodules, too.

So here goes v5, the only change being the addition of the second patch
that adds support for passing the extra headers to git-submodule through
the command-line.


Johannes Schindelin (2):
  http: support sending custom HTTP headers
  submodule: pass on http.extraheader config settings

 Documentation/config.txt    |  6 ++++++
 builtin/submodule--helper.c |  4 +++-
 http-push.c                 | 10 +++++-----
 http.c                      | 35 ++++++++++++++++++++++++++++++++---
 http.h                      |  1 +
 remote-curl.c               |  4 ++--
 t/lib-httpd/apache.conf     |  8 ++++++++
 t/t5551-http-fetch-smart.sh | 16 ++++++++++++++++
 8 files changed, 73 insertions(+), 11 deletions(-)

Interdiff vs v4:

 diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
 index 3bd6883..b338f93 100644
 --- a/builtin/submodule--helper.c
 +++ b/builtin/submodule--helper.c
 @@ -127,7 +127,9 @@ static int module_name(int argc, const char **argv, const char *prefix)
   */
  static int submodule_config_ok(const char *var)
  {
 -	if (starts_with(var, "credential."))
 +	if (starts_with(var, "credential.") ||
 +			(starts_with(var, "http.") &&
 +			 ends_with(var, ".extraheader")))
  		return 1;
  	return 0;
  }
 diff --git a/t/t5551-http-fetch-smart.sh b/t/t5551-http-fetch-smart.sh
 index e44fe72..1794168 100755
 --- a/t/t5551-http-fetch-smart.sh
 +++ b/t/t5551-http-fetch-smart.sh
 @@ -286,7 +286,16 @@ test_expect_success 'custom http headers' '
  	test_must_fail git fetch "$HTTPD_URL/smart_headers/repo.git" &&
  	git -c http.extraheader="x-magic-one: abra" \
  	    -c http.extraheader="x-magic-two: cadabra" \
 -	    fetch "$HTTPD_URL/smart_headers/repo.git"
 +	    fetch "$HTTPD_URL/smart_headers/repo.git" &&
 +	git update-index --add --cacheinfo 160000,$(git rev-parse HEAD),sub &&
 +	git config -f .gitmodules submodule.sub.path sub &&
 +	git config -f .gitmodules submodule.sub.url \
 +		"$HTTPD_URL/smart_headers/repo.git" &&
 +	git submodule init sub &&
 +	test_must_fail git submodule update sub &&
 +	git -c http.extraheader="x-magic-one: abra" \
 +	    -c http.extraheader="x-magic-two: cadabra" \
 +		submodule update sub
  '
  
  stop_httpd

-- 
2.8.1.306.gff998f2
