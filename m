Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E96B31F790
	for <e@80x24.org>; Tue,  2 May 2017 12:31:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751323AbdEBMa7 (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 May 2017 08:30:59 -0400
Received: from mout.gmx.net ([212.227.17.20]:49492 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751060AbdEBMa5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 May 2017 08:30:57 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LvUwp-1e5yvf0lH9-010aW2; Tue, 02
 May 2017 14:30:52 +0200
Date:   Tue, 2 May 2017 14:30:37 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 4/5] Fix the remaining tests that failed with
 core.autocrlf=true
In-Reply-To: <cover.1493728172.git.johannes.schindelin@gmx.de>
Message-ID: <543904d5608af500617eb4094a8b40cce29f55b8.1493728172.git.johannes.schindelin@gmx.de>
References: <cover.1493728172.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:sX1+IMIyGL8MBGTgSv1qERc0d6NCPvkE76naDogVOd3d0zjASOZ
 hZcthNuaDW+QFTQkZQuVPITYIvXBVqVaXOATD/aN6B7y7BIvH3F8F5S7TzBFTKoiRn6GVFB
 d8oTChRru9YuzT8iIYIP9tMWKsdt/w/Z/Oyt2ZvYGse0qKWMaEB+Sl8L0LEwlnyAdwOugxs
 uRe/AYtv24lNueCd1WBlg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:m7BBfzHZOww=:dUx9pjf7+pJNtmKPGJ4yc1
 OslhYb0ETaBWQNhzhuYq6caJMdK+x2j7mdMc601KYfqUpM8AIqqW1eg2IJJs/XowPNJSoV+ZT
 x6kSvIHfBQNYl44DHJ9z60cUhL5QWFalsnSwzU+Fss1OveEDre0206vEy559bNTX01+9+h2Sb
 3UwwvezqiE7N1fYRdgn+zwfNtZK2JimrfDX2j0afvIr6JV7QnIcgjECkxNQsx9uthvF/ImvWS
 U4CFfwmKjOYKvJmnT+PeDPTm4ktSZUYWEjmTEzUOdvvc5kdhmPbc6cCXz+hyIilznkwIKVixP
 H++1N8Rw64dRurAAMmEJMlbh6v7Zhzb7IJrNsulaHEPN3MDi35Kqwh3Hq3S/4rfOyUesbCqWc
 gjOw9WkASJJqCgADD3VGUV++FyezjhG8hQ+5ny7piwK/UrLNEnUrqvYoYaDwXYG9OQAPU2YG7
 FAP5mzR0pLbOFBcpumde9rmhtDg4QXwoqaMiFCjmBFspD9ZPnRCNfyyW9PJrHnOTvFT6SFC8V
 EL0ta7FiEMl4Z9lsrAT52kVftNjmNa2yJrhrPau/MS3+1UmTVATWvIUYZXj8+F5V4cTJ8vAhj
 V3zNYlE2suORqK2xDiCtTcnROasbgufkAihiKESEkmKVcBboTffS+qbL3UXQyCRUOkyJMDe6t
 XfkJA+/SIlkuBfygZ4LS4vaOTQhMjLYcjIvbUIyBt695MtI9sNveXKD+T8gsiW0O92r8Q3GiT
 jV1k8T4qgYAnoS6UcYt/cf1Tn9ILQUgUKerhYrsmXFQiTuS001NvFIarbG8/J9x62oqYzLJ4A
 PhrKa//
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The test suite is mainly developed on Linux and MacOSX, which is the
reason that nobody thought to mark files as LF-only as needed.

The symptom is a test suite that fails left and right when being checked
out using Git for Windows (which defaults to core.autocrlf=true).

Mostly, the problems stem from Git's (LF-only) output being compared to
hard-coded files that are checked out with line endings according to
core.autocrlf (which is of course incorrect).

Note: the test suite also uses the t/README file as well as the COPYING
file in t/diff-lib/, expecting LF-only line endings explicitly and
failing if that assumption does not hold true. That is why we mark them
as LF-only in the .gitattributes, too.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/.gitattributes | 28 +++++++++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/t/.gitattributes b/t/.gitattributes
index 2d44088f56e..4064eba354d 100644
--- a/t/.gitattributes
+++ b/t/.gitattributes
@@ -1,2 +1,28 @@
+README eol=lf
 t[0-9][0-9][0-9][0-9]/* -whitespace
-t0110/url-* binary
+/diff-lib/COPYING eol=lf
+/t0110/url-* binary
+/t3900/*.txt eol=lf
+/t3901*.txt eol=lf
+/t4034/*/* eol=lf
+/t4013/* eol=lf
+/t4018/* eol=lf
+/t4100/* eol=lf
+/t4101/* eol=lf
+/t4109/* eol=lf
+/t4110/* eol=lf
+/t4135/* eol=lf
+/t4211/* eol=lf
+/t4252/* eol=lf
+/t5100/* eol=lf
+/t5515/* eol=lf
+/t556x_common eol=lf
+/t7500/* eol=lf
+/t8005/*.txt eol=lf
+/t9110/svm.dump eol=lf
+/t9111/svnsync.dump eol=lf
+/t9115/funky-names.dump eol=lf
+/t9121/renamed-dir.dump eol=lf
+/t913[56]/svn.dump eol=lf
+/t915[0134]/*.dump eol=lf
+/t9161/branches.dump eol=lf
-- 
2.12.2.windows.2.800.gede8f145e06


