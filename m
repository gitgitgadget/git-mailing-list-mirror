From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v6 0/2] Add support for sending additional HTTP headers
Date: Wed, 4 May 2016 08:14:07 +0200 (CEST)
Message-ID: <cover.1462342213.git.johannes.schindelin@gmx.de>
References: <cover.1461837783.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 04 08:14:23 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axq4k-0001mc-DX
	for gcvg-git-2@plane.gmane.org; Wed, 04 May 2016 08:14:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757066AbcEDGOS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 May 2016 02:14:18 -0400
Received: from mout.gmx.net ([212.227.15.15]:64697 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751853AbcEDGOR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 May 2016 02:14:17 -0400
Received: from virtualbox ([37.24.143.84]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0MaZWz-1bD2Vd431V-00K9M2; Wed, 04 May 2016 08:14:09
 +0200
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <cover.1461837783.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:22RMD4keK6enX5vvn+DSNm/7Oh0aJsZHeiVhCOLXemu7mmxcKli
 vvmKOIerw3Vpicc+Z6OBCG3535Tt+pRybEj+KpjLQEc9VWkkj51+zadriJ/YRIRjk8LKWRx
 6XNaLcA6XwHpRHHdc0uEcjMIny28fJ50rqaxaZ74mOkqkmnteeu1cbspGpDmAZ0xE0iAsUG
 mSvro9/nPPAukm6Zqgu9w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Z0qEsoJXVM8=:+MQmnqMzofFrun9OH+VEKE
 AS0BRYHuKKwKu2eD6bNsgRd8nkOPpXWaPFkNiebcRn1nAOl45XwYlAA+0Szh/c12dHzYb1uc0
 QIJN9RtYwGCiUeh2cg5BZSG19w6CXXgCKyUYSwUw9VTzgRopyyApP2OAnUf7uUnpU39b+7tWF
 srYH9mi40D2F9z39Tf5LwgAlfBvk4LuL4B1fBDRYjRDonO8KY/nE0dS+1n0WbFZ9aMus70dFD
 i6OXzFrZkISVesI1wu21DEg67ai0uhoDOqTyJry4JFkgkEZwDdp0bn5Bm85ztAjLIF8yclOC6
 fd42Vh0pBPvA/baKTM1ljNbvWgwnibraO63XKM95cioE3phnwxPZRgoEKmZaPyQ5QYw2a8u/e
 dgV1HeR31cC7znEj6xXznv1Oqn7oFXgsDMy4YgXcmPhIcojCy82cOaM+5tby0Y3CwC8ZfAlqL
 0/F9UAVGgYWurwHfvch9Mii4rodT2tcMGip8ELnZEI4a6iWaHgnanlmR8He/oJlEyMOMYN5x6
 BwntUjD3tyTfizPH1/ipNSUUfiUNSAd/OLOjKc5h09VRBKTK5xltpszdXYPbRH/cSLxl4ltAK
 He58RVVOAVGVkGTjaE4Zyw7XGHM0Ua206opi+QlpvS/zv2n3W98a/waix8Ot39niWznF63K+3
 A4rj+EsUQ0WXPBLklCGQzsxI2kVzQIVYWguYMFKovYACW1H4JuWz/HlVj8bte10DMbG6rqKmr
 wlIZSE2DCU4Qll5oH0J+VrYKgB/l8Iltgl0HKR+qlSdgbMR6+96Rqwls5hgCKsC2Ougl7e+z 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293496>

My use case is an army of build agents that need only limited and
selective access to otherwise private repositories.

v6 supports submodules better by allowing

	git -c http.extraheader submodule update

to work as one would expect intuitively.

Johannes Schindelin (2):
  http: support sending custom HTTP headers
  submodule: pass on http.extraheader config settings

 Documentation/config.txt    |  6 ++++++
 builtin/submodule--helper.c |  3 ++-
 http-push.c                 | 10 +++++-----
 http.c                      | 35 ++++++++++++++++++++++++++++++++---
 http.h                      |  1 +
 remote-curl.c               |  4 ++--
 t/lib-httpd/apache.conf     |  8 ++++++++
 t/t5551-http-fetch-smart.sh | 16 ++++++++++++++++
 8 files changed, 72 insertions(+), 11 deletions(-)

Interdiff vs v5:

 diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
 index b338f93..789e081 100644
 --- a/builtin/submodule--helper.c
 +++ b/builtin/submodule--helper.c
 @@ -128,8 +128,7 @@ static int module_name(int argc, const char **argv, const char *prefix)
  static int submodule_config_ok(const char *var)
  {
  	if (starts_with(var, "credential.") ||
 -			(starts_with(var, "http.") &&
 -			 ends_with(var, ".extraheader")))
 +	    (starts_with(var, "http.") && ends_with(var, ".extraheader")))
  		return 1;
  	return 0;
  }

-- 
2.8.1.306.gff998f2
