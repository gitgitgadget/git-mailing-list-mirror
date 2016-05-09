From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v7 0/3] Add support for sending additional HTTP headers (part
 2)
Date: Mon, 9 May 2016 08:18:46 +0200 (CEST)
Message-ID: <cover.1462774709.git.johannes.schindelin@gmx.de>
References: <cover.1462342213.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Lars Schneider <larsxschneider@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 09 08:19:37 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1azeXC-0003fo-I7
	for gcvg-git-2@plane.gmane.org; Mon, 09 May 2016 08:19:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751026AbcEIGTF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 May 2016 02:19:05 -0400
Received: from mout.gmx.net ([212.227.15.19]:54548 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750974AbcEIGTD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 May 2016 02:19:03 -0400
Received: from virtualbox ([37.24.143.84]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0LgZRV-1bN9K204NJ-00nwz8; Mon, 09 May 2016 08:18:43
 +0200
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <cover.1462342213.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:6tmYOupQUsrRZe3Pfyl8JnKj9qG7MDfGXbx8tgNTvyWZczbuR5+
 mzN0JbITfb2FdNQzRTbumJLgC5mGgqoCKhlfR25H9+WNO9Wp8Ygwa5GKPM6PqNUZGUZaPca
 3DNZ015KGCzocUtrbzx5NOxzX2aeoqXHI3yrTzPgSnoOxk2i+cm6F3q8m0kswiSAyNvAvOl
 nZf7M95Cx0sMY3ZL3O65g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:gH2YHtmXPtA=:MuuQM98lLV5rkFAkopAt/R
 eUHlLcOf8NruYWM/nQTedjwa31+mQZlcC0jPj1MNnuH5RCZbkjLZ0ch2WR9ou6DP0nMIcg0aq
 mvnUQiRrmpf8xtn7wxkCQUILA/3HQEMAuIKD13QS3Kc93plvwiKBio1dBbbYPEu3Pea5wJWco
 ccPDCX6xpR0DncKEF1316YMXfx86y261wYsesP57UtfNtHAy8z3r0D9QdgGTAAikEQ5MdZp78
 z1h6yyXA/7TkVMDOwq1FUEwPlELik3AaHojd82DgZK6vj7SiJ3LrCAEvdyv/5c7vGA3U1QPVE
 +gnwGCXPw1bycjlCOIlAmzbl9Xtm3NWTtg+2jrhN3oDJMsycplhXnLkrO+D97SX1pdiG6eXud
 8EozJAgbVlhfcdgm7yAWE/2Gd5gZZNKSAZVuwWH5nrRoNPk2Xq9edWZrP6ugCS4yxZfJvlhJw
 Fk2BgmNfXO2dGyldIswSXxLW+5A/b6AZfVqD8NHOHTRvBUQ7Qm6grBo1th/mUrNQyp1/AC8EH
 uXMEaIt3fHGYTLiwQAwIZDU2U8I3pKgdfLFUvF80o+fNovOeA78XwQ6t0GqjfpNi9jmx/toXD
 sMEtaqHedG6snnrNfehvrMARRVjihmQfW3r1aJq58HTfaN8+pm6tclq9WmKBwjxgn1m/7hxfd
 tbni6RN8Dh5KBbtqsis/Kn98mkCg3ivXqegOEZHMqdQgEhOz1H8lntmy2Rwlu3QTQO3uZCWTi
 /7DuHyZ90ZIywRNSjQSUDLNXhKlwc3moiDjC1mkvWcBWY0TT9dZrIca38UkMoKKYviNKZW7P 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293985>

My use case is an army of build agents that need only limited and
selective access to otherwise private repositories.

The first part already made it into `master`, this is the remainder.

This iteration still has the specific patch to make `git -c
http.extraHeader=... submodule update` work; I plan to keep only the
test (and adjust the commit message) as soon as Peff's patch is applied
that skips -c ... sanitizing for submodules.


Johannes Schindelin (3):
  tests: Adjust the configuration for Apache 2.2
  t5551: make the test for extra HTTP headers more robust
  submodule: pass on http.extraheader config settings

 builtin/submodule--helper.c |  3 ++-
 t/lib-httpd/apache.conf     | 12 ++++++++----
 t/t5551-http-fetch-smart.sh | 14 ++++++++++++--
 3 files changed, 22 insertions(+), 7 deletions(-)

Published-As: https://github.com/dscho/git/releases/tag/extra-http-headers-v7
Interdiff vs v6:

 diff --git a/t/lib-httpd/apache.conf b/t/lib-httpd/apache.conf
 index b8ed96f..29b34bb 100644
 --- a/t/lib-httpd/apache.conf
 +++ b/t/lib-httpd/apache.conf
 @@ -103,10 +103,6 @@ Alias /auth/dumb/ www/auth/dumb/
  	Header set Set-Cookie name=value
  </LocationMatch>
  <LocationMatch /smart_headers/>
 -	<RequireAll>
 -		Require expr %{HTTP:x-magic-one} == 'abra'
 -		Require expr %{HTTP:x-magic-two} == 'cadabra'
 -	</RequireAll>
  	SetEnv GIT_EXEC_PATH ${GIT_EXEC_PATH}
  	SetEnv GIT_HTTP_EXPORT_ALL
  </LocationMatch>
 @@ -136,6 +132,14 @@ RewriteRule ^/ftp-redir/(.*)$ ftp://localhost:1000/$1 [R=302]
  RewriteRule ^/loop-redir/x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-(.*) /$1 [R=302]
  RewriteRule ^/loop-redir/(.*)$ /loop-redir/x-$1 [R=302]
  
 +# Apache 2.2 does not understand <RequireAll>, so we use RewriteCond.
 +# And as RewriteCond unfortunately lacks "not equal" matching, we use this
 +# ugly trick to fail *unless* the two headers are present.
 +RewriteCond %{HTTP:x-magic-one} =abra
 +RewriteCond %{HTTP:x-magic-two} =cadabra
 +RewriteRule ^/smart_headers/.* - [L]
 +RewriteRule ^/smart_headers/.* - [F]
 +
  <IfDefine SSL>
  LoadModule ssl_module modules/mod_ssl.so
  
 diff --git a/t/t5551-http-fetch-smart.sh b/t/t5551-http-fetch-smart.sh
 index 1794168..2f375eb 100755
 --- a/t/t5551-http-fetch-smart.sh
 +++ b/t/t5551-http-fetch-smart.sh
 @@ -283,7 +283,8 @@ test_expect_success EXPENSIVE 'http can handle enormous ref negotiation' '
  '
  
  test_expect_success 'custom http headers' '
 -	test_must_fail git fetch "$HTTPD_URL/smart_headers/repo.git" &&
 +	test_must_fail git -c http.extraheader="x-magic-two: cadabra" \
 +		fetch "$HTTPD_URL/smart_headers/repo.git" &&
  	git -c http.extraheader="x-magic-one: abra" \
  	    -c http.extraheader="x-magic-two: cadabra" \
  	    fetch "$HTTPD_URL/smart_headers/repo.git" &&

-- 
2.8.2.463.g99156ee
