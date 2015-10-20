From: Johan Laenen <johan.laenen+cygwin@gmail.com>
Subject: Commit 5841520b makes it impossible to connect to github from behind my company's firewall.
Date: Tue, 20 Oct 2015 11:20:52 +0000 (UTC)
Message-ID: <loom.20151020T131513-529@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 20 13:25:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZoV2a-0000v5-Og
	for gcvg-git-2@plane.gmane.org; Tue, 20 Oct 2015 13:25:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751943AbbJTLZM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Oct 2015 07:25:12 -0400
Received: from plane.gmane.org ([80.91.229.3]:46836 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751563AbbJTLZL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Oct 2015 07:25:11 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1ZoV2P-0000m4-1b
	for git@vger.kernel.org; Tue, 20 Oct 2015 13:25:05 +0200
Received: from 193.191.180.235 ([193.191.180.235])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 20 Oct 2015 13:25:05 +0200
Received: from johan.laenen+cygwin by 193.191.180.235 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 20 Oct 2015 13:25:05 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 193.191.180.235 (Mozilla/5.0 (Windows NT 6.1; rv:41.0) Gecko/20100101 Firefox/41.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279905>

Commit 5841520b makes it impossible to connect to github from behind my
company's firewall.

I'm running CYGWIN_NT-6.1 and the default git version 2.5.3 complains with a
fatal error when trying to git pull:

$ /bin/git --version
git version 2.5.3
$ /bin/git pull
fatal: unable to access 'https://github.com/gargle/french/': Unknown SSL
protocol error in connection to github.com:443

Taking the sources of git 2.6.1. and compiling with commit 5841520b in
http.c reverted gives me a working git.

My http.c now looks like:

 466     if (curl_http_proxy) {
 467         curl_easy_setopt(result, CURLOPT_PROXY, curl_http_proxy);
 468 #if LIBCURL_VERSION_NUM >= 0x070a07
 469         curl_easy_setopt(result, CURLOPT_PROXYAUTH, CURLAUTH_ANY);
 470 #endif
 471     }

And it works:

$ git --version
git version 2.6.1
$ git pull
Already up-to-date.



Greetings,

Johan
