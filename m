From: <Ken.Fuchs@bench.com>
Subject: FW: git via http protocol _and_ a proxy using NTLM authentication -- git 1.5.4.2 & curl 7.18.0
Date: Tue, 26 Feb 2008 15:43:30 -0600
Message-ID: <AA28F077645B324881335614E4F7C428034C00@win-ex01.bench.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Feb 26 22:44:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JU7av-00025J-JG
	for gcvg-git-2@gmane.org; Tue, 26 Feb 2008 22:44:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754590AbYBZVng (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Feb 2008 16:43:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762868AbYBZVng
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Feb 2008 16:43:36 -0500
Received: from tx-smtp01.bench.com ([12.163.172.137]:41995 "EHLO
	tx-smtp01.bench.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752932AbYBZVnf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 Feb 2008 16:43:35 -0500
Received: from unknown (HELO smtp.corp.bench.com) ([167.67.199.66])
  by tx-smtp01.bench.com with ESMTP; 26 Feb 2008 15:45:54 -0600
Received: from win-ex01.bench.com ([167.67.1.16]) by smtp.corp.bench.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 26 Feb 2008 15:43:33 -0600
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: git via http protocol _and_ a proxy using NTLM authentication -- git 1.5.4.2 & curl 7.18.0
Thread-Index: Ach1vZvAImDfdl+pRwC6xCKWgBJeawCEsmNwAAbW0OAAAcWUAAABMc5AAABrefAAAJP5kAABWDPgACOeshAABjsYoAAEU7gwAAGJ6FAAACXVMA==
X-OriginalArrivalTime: 26 Feb 2008 21:43:33.0396 (UTC) FILETIME=[A269DD40:01C878C0]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75179>

Need help to modify git to work with the http protocol _and_
a proxy using HTLM authentication.

--

The following changes were made to http.c (for NTLM authentication):

$ diff -c /mnt/nfs/git/git-1.5.4.2/http.c.orig \
    /mnt/nfs/git/git-1.5.4.2/http.c
--- 215,220 ----
--- 215,223 ----
        if (curl_http_proxy)
                curl_easy_setopt(result, CURLOPT_PROXY,
curl_http_proxy);

+       curl_easy_setopt(result, CURLOPT_PROXYAUTH,
(long)CURLAUTH_NTLM);
+       curl_easy_setopt(result, CURLOPT_PROXYUSERPWD,
+               "<user-id>:<password>");
+
        return result;
  }
$

--

git fetch _not_ working via an NTML proxy:

$ http_proxy=<proxy-domain>:<proxy-port> GIT_CURL_VERBOSE=1 \
    git fetch http://www.kernel.org/pub/scm/git/git.git

[A few paragraphs of proxy authentication debug output that
BogoFilter apparently gives a high SPAM quotient to, so I've
given up trying to include it.]

fatal: Couldn't find remote ref HEAD
$ 

It seems that git fetch (via HTLM proxy) works until

> fatal: Couldn't find remote ref HEAD

git 1.5.4.2 dies on line 158 of builtin-fetch.c,
because the call to get_remote_ref() in remote.c fails.

Does anything need to be changed in remote.c?

Any other suggestions?

Thanks,

Ken Fuchs
