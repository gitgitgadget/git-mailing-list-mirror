From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v4 0/4] Ensure that we can build without libgen.h
Date: Tue, 12 Jan 2016 08:57:16 +0100 (CET)
Message-ID: <cover.1452585382.git.johannes.schindelin@gmx.de>
References: <cover.1452536924.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org, Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 12 08:57:47 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aItpq-0000ia-L5
	for gcvg-git-2@plane.gmane.org; Tue, 12 Jan 2016 08:57:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761846AbcALH5n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Jan 2016 02:57:43 -0500
Received: from mout.gmx.net ([212.227.17.22]:60477 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761498AbcALH5l (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jan 2016 02:57:41 -0500
Received: from virtualbox ([37.24.143.74]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0MYtId-1afk0T1zdL-00VjH4; Tue, 12 Jan 2016 08:57:18
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <cover.1452536924.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:Hr44GP5UNknjG/jArLj9TlobknDWPNPNOmEuDnIpVbtIqkll5t6
 NWanOllbIJwpBz1MzVWALyPXmZ0pDq7N/q3bNh6Lc10CJef9QiZAf9u1wewOH14Qj+IWl0A
 GGaT4vyW8n6CKmINHK9ms/867CYL1pWir0thcOk4HIrvvZiobGI5oLAvqoudfR51Ph/3lLM
 2bav17+eEs2tJ4/oQKRUg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:YkKpC9k64uI=:DEGwKBebOsriMFuRg7MfXZ
 gk4RzbFBj/TYwEOsXr8FxAIWmpihIFwl0E8bWH1ZiFvFp9LDbjOvlCaKhXNSnvh64AdW+jogy
 pfRxVfLHoJBjRTa/qHmGPaiQQceMtVMWOULB4UogtyGCjMRM+8YP95oqxuSwJIaAWGDmVnbrh
 2RrDksH6jcqMIbjTmQXYdTe3tNs19AzC0ay3jjCGFxf7tlWBfjxGWkAckF5/9p1Cut2K16Ad0
 sN48socR02/MLbBVB9l73XcMqS7yylWkym3tRCdEP1Fh8q1rZhsOwuheuLqlLCTv5okgZpPAh
 uSAhW3fwvMtddjXbxMFl7Am5TPelxDjl5zzimqkeDz0cffbl9U2LyVjBVSjw3UmOcnskzcyd1
 ZltJbadvK2vmZS73I1OyFq4JIi+fR77AsyEepYTrYhJ9zgEEQUNJESXPctNAf0jPeXinNgWf5
 hO2mQHLM2K6NlVjMYLUU02obCilo/SixTl8v8JoMwg86x5oGvLDaITWf2w2rE4Cm1mZUKSL96
 lyXQJM8srQaWxPTLpv7akB/OdLXqjRVO4+mwxiAd7R71c+E7gvp7RkfNpFgaxQDxBBvQYpevb
 W4fRrbDUhaN96izBTgJ46FfiR7G2kj0RzA6NqAQO1D96C9z2UWe21CuxomEmgj9TKGxLSa7Oh
 OUikrcBoSgcYXOp0PNAc95vnqeVTF3hS6qheJsz6dKpYsAUgma2MZL0W4tnHn1cux2wZgMAy8
 DD3+/n882uDGdWXHSfkh/il+GPf+XFmjZRXZ96woYch7s467UTZtaSjYZFqOw0WMIARwDJf7 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283773>

This mini series adds a fall-back for the `dirname()` function that we use
e.g. in git-am. This is necessary because not all platforms have a working
libgen.h.

While at it, we ensure that our basename() drop-in conforms to the POSIX
specifications.

In addition to Eric's style improvement, v4 also fixes the signature
of skip_dos_drive_prefix() in the non-Windows case.


Johannes Schindelin (4):
  Refactor skipping DOS drive prefixes
  compat/basename: make basename() conform to POSIX
  Provide a dirname() function when NO_LIBGEN_H=YesPlease
  t0060: verify that basename() and dirname() work as expected

 compat/basename.c     |  66 ++++++++++++++++++--
 compat/mingw.c        |  14 ++---
 compat/mingw.h        |  10 ++-
 git-compat-util.h     |  10 +++
 path.c                |  14 ++---
 t/t0060-path-utils.sh |   3 +
 test-path-utils.c     | 166 ++++++++++++++++++++++++++++++++++++++++++++++++++
 7 files changed, 259 insertions(+), 24 deletions(-)

Interdiff vs v3:

 diff --git a/compat/basename.c b/compat/basename.c
 index 0a2ed25..96bd953 100644
 --- a/compat/basename.c
 +++ b/compat/basename.c
 @@ -29,20 +29,15 @@ char *gitbasename (char *path)
  
  char *gitdirname(char *path)
  {
 +	static struct strbuf buf = STRBUF_INIT;
  	char *p = path, *slash = NULL, c;
  	int dos_drive_prefix;
  
  	if (!p)
  		return ".";
  
 -	if ((dos_drive_prefix = skip_dos_drive_prefix(&p)) && !*p) {
 -		static struct strbuf buf = STRBUF_INIT;
 -
 -dot:
 -		strbuf_reset(&buf);
 -		strbuf_addf(&buf, "%.*s.", dos_drive_prefix, path);
 -		return buf.buf;
 -	}
 +	if ((dos_drive_prefix = skip_dos_drive_prefix(&p)) && !*p)
 +		goto dot;
  
  	/*
  	 * POSIX.1-2001 says dirname("/") should return "/", and dirname("//")
 @@ -64,8 +59,13 @@ dot:
  				slash = tentative;
  		}
  
 -	if (!slash)
 -		goto dot;
 -	*slash = '\0';
 -	return path;
 +	if (slash) {
 +		*slash = '\0';
 +		return path;
 +	}
 +
 +dot:
 +	strbuf_reset(&buf);
 +	strbuf_addf(&buf, "%.*s.", dos_drive_prefix, path);
 +	return buf.buf;
  }
 diff --git a/git-compat-util.h b/git-compat-util.h
 index 94f311a..5f72f1c 100644
 --- a/git-compat-util.h
 +++ b/git-compat-util.h
 @@ -338,7 +338,7 @@ static inline int git_has_dos_drive_prefix(const char *path)
  #endif
  
  #ifndef skip_dos_drive_prefix
 -static inline int git_skip_dos_drive_prefix(const char **path)
 +static inline int git_skip_dos_drive_prefix(char **path)
  {
  	return 0;
  }

-- 
2.6.3.windows.1.300.g1c25e49
