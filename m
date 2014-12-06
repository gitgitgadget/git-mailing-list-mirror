From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: Accept-language test fails on Mac OS
Date: Sat, 06 Dec 2014 22:04:06 +0100
Message-ID: <54836F46.9080009@web.de>
References: <CAO2U3QgoSmYkDYbvFnChxPMrTCEboUbk1NWjv+9Us60EfozN_w@mail.gmail.com>	<xmqqppbxogli.fsf@gitster.dls.corp.google.com>	<CAO2U3QikrHRC0PncO2vxFMv88HMnJHYa1AiPak+Lp0OU1u6dZA@mail.gmail.com>	<5482D180.9010002@web.de> <CAFT+Tg_4EJ15CmujDtcubfw+0rr2J=pbjccqSSs9tmj-rz6+eQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: semtlenori@gmail.com,
	=?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>,
	Michael Blume <blume.mike@gmail.com>
X-From: git-owner@vger.kernel.org Sat Dec 06 22:05:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XxMXn-0002Eq-6P
	for gcvg-git-2@plane.gmane.org; Sat, 06 Dec 2014 22:05:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752273AbaLFVEP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Dec 2014 16:04:15 -0500
Received: from mout.web.de ([212.227.17.12]:63914 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752223AbaLFVEP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Dec 2014 16:04:15 -0500
Received: from macce.local ([78.72.72.190]) by smtp.web.de (mrweb103) with
 ESMTPSA (Nemesis) id 0MORqb-1Y2bBk1MaD-005o8c; Sat, 06 Dec 2014 22:04:10
 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
In-Reply-To: <CAFT+Tg_4EJ15CmujDtcubfw+0rr2J=pbjccqSSs9tmj-rz6+eQ@mail.gmail.com>
X-Provags-ID: V03:K0:KgMnxXJAX/2CYqLW9CLbx1n80HhZZdr/qAzRH55aUgIech82g/J
 La21i6PLij9FU4bz4U88AUVgGxYVLIozpYlP6pAGL+qMVwCw5ADBYa1pigoeNt/sHd7kG+E
 /+L6lR6tEyd8+T/SRq5NzccSYy6bGa226bNwKHVY5I5E2cdTVO5Of0Kb1CIyHrXikmw6njc
 IEKjUVAsiNvP8GtxHy62g==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260964>

On 2014-12-06 20.44, Yi, EungJun wrote:
> Could you tell me your locale information from executing 'locale'
> command and the verbose message you can get by accessing any git
> repository via HTTP protocol? (e.g. GIT_CURL_VERBOSE=1 git clone
> http://github.com/foo/bar )
locale -a
C
C.UTF-8
en_US.utf8
icelandic
is_IS
is_IS.iso88591
is_IS.utf8
POSIX

-----------------------------
After patching like this:
diff --git a/t/t5550-http-fetch-dumb.sh b/t/t5550-http-fetch-dumb.sh
index fc6e7fc..1e42b42 100755
--- a/t/t5550-http-fetch-dumb.sh
+++ b/t/t5550-http-fetch-dumb.sh
@@ -205,8 +205,8 @@ check_language () {
        LANG=$5 \
        git ls-remote "$HTTPD_URL/dumb/repo.git" 2>&1 |
        tr -d '\015' |
-       sort -u >stderr &&
-       grep -i ^Accept-Language: stderr >actual &&
+       sort -u >stderr
+       grep -i ^Accept-Language: stderr >actual
        test_cmp expect actual
 }
-----------
I get this:


expecting success: 
        check_language "ko-KR, *;q=0.1" ko_KR.UTF-8 de_DE.UTF-8 ja_JP.UTF-8 en_US.UTF-8 &&
        check_language "de-DE, *;q=0.1" ""          de_DE.UTF-8 ja_JP.UTF-8 en_US.UTF-8 &&
        check_language "ja-JP, *;q=0.1" ""          ""          ja_JP.UTF-8 en_US.UTF-8 &&
        check_language "en-US, *;q=0.1" ""          ""          ""          en_US.UTF-8

--- expect      2014-12-06 21:00:59.000000000 +0000
+++ actual      2014-12-06 21:00:59.000000000 +0000
@@ -1 +0,0 @@
-Accept-Language: de-DE, *;q=0.1
not ok 25 - git client sends Accept-Language based on LANGUAGE, LC_ALL, LC_MESSAGES and LANG
#       
#               check_language "ko-KR, *;q=0.1" ko_KR.UTF-8 de_DE.UTF-8 ja_JP.UTF-8 en_US.UTF-8 &&
#               check_language "de-DE, *;q=0.1" ""          de_DE.UTF-8 ja_JP.UTF-8 en_US.UTF-8 &&
#               check_language "ja-JP, *;q=0.1" ""          ""          ja_JP.UTF-8 en_US.UTF-8 &&
#               check_language "en-US, *;q=0.1" ""          ""          ""          en_US.UTF-8
#       
