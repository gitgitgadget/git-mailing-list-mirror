From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH] t0060: loosen overly strict expectations
Date: Thu, 14 Jan 2016 07:48:27 +0100 (CET)
Message-ID: <eccf149d9557fd9afb591d9411ecb0b3460c9eb0.1452754049.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org, Michael Blume <blume.mike@gmail.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	=?ISO-8859-15?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 14 07:48:54 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJbiG-0006RG-KK
	for gcvg-git-2@plane.gmane.org; Thu, 14 Jan 2016 07:48:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750778AbcANGst (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jan 2016 01:48:49 -0500
Received: from mout.gmx.net ([212.227.15.19]:59475 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750741AbcANGss (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jan 2016 01:48:48 -0500
Received: from virtualbox ([37.24.143.74]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0MhhwJ-1aVvvL3nZj-00MwtP; Thu, 14 Jan 2016 07:48:29
 +0100
X-X-Sender: virtualbox@virtualbox
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:2aO0KaspqygovgG3EVzNFrkI6jk23qfvz/AziAJHJP2BFxPvvmK
 IyaRjLzh2nQxEcqPH14905XVZhMV1ZJRpnC0cqYuv8IXsSi6Mf60G6ywts3KpodR4vgjqKg
 983KYHE4Wn9yQgP4AWPY5Ik0KkkYB7LYE5XbdqlZHHCoRWcARCS1JfuYDXlHRVy9XNxXOEe
 9AvkDMQvp3Ct/NDEzrYiQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:RCLjHrCUwE0=:YtfMVMkOHR6KkraT1m5PIy
 PpokM4RaWC4cVf4eTOUKi7aFVcNUiVXEKIdX/A812Wkpv7e31WmZF3FHkJplpuA23qZkFZvUM
 cA6JhQJeNqzjn6ihhIbX7+eVfDF8FnryaGSUmNsj3Us7tIfT57a5PtaCPVhBu8niCBtJPjgeb
 QvSrT0zFeDIM/rCrs9g8jhwkzNcJiVHF8T2SPUeX2cGdar06O/jACKuOdWwf5tOFgqZIWm1RX
 NCHKveKymMGOGs5LcInOM4vB2VpQ5QX+SX+iX7Y9fxV+YPj8nJAMMTKIThwxwmSJulWhsm7Pm
 RexRPcwpTR6zjAT2YGnyeAqHWC1kH7YI8xdLwNfXYbkuuWDFVmb9wRuVcNypSVAOneoDsI6DY
 fxKyGInMXtJS3d1oC+OB54117UcsYhq912iUHxH9HnBChgVNC2T6nfFvwV6yEDvq5O9JZHYV6
 yXOxj5hAe3l1Hk+9XgXTnMgnfbEMvhbdSBW3C+oKT5QpqMpKj0RlBGRKx4B8UmAE0VGoFF558
 YTvdEP2XRNRoLp3aMD4mT1qXXOAfLgsfZL1Q8qEGVwH/fFnk62/NC0MSQiQCSSXm6qgFLhyed
 VsRc86VOaH/3ZkRbfQt/ar4HOyoH/8UIVaIbahhKyiwy5ipR3QRfmUMggqKkvfAYmcrmD/MFg
 nZO8+CvjcNFxu5+ZNrm9vvUvY7UQUdecgawB1QWMq1Cy40Rn4AVdz+1Y1ULADv42j1pBOz167
 Yy9Pixm4/N0lJ24JfpnPclHJRsd+V/jthnzj3dcZ1/hDXC32P1i8eJ1SjuzDkKBPAneFLOuI 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284019>

The dirname() tests file were developed and tested on only the five
platforms available to the developer at the time, namely: Linux (both 32
and 64bit), Windows XP 32-bit (MSVC), MinGW 32-bit and Cygwin 32-bit.

http://pubs.opengroup.org/onlinepubs/9699919799/functions/basename.html
(i.e. the POSIX spec) says, in part:

	If the string pointed to by path consists entirely of the '/'
	character, basename() shall return a pointer to the string "/".
	If the string pointed to by path is exactly "//", it is
	implementation-defined whether "/" or "//" is returned.

The thinking behind testing precise, OS-dependent output values was to
document that different setups produce different values. However, as the
test failures on MacOSX illustrated eloquently: hardcoding pretty much each
and every setup's expectations is pretty fragile.

This is not limited to the "//" vs "/" case, of course, other inputs are
also allowed to produce multiple outpus by the POSIX specs.

So let's just test for all allowed values and be done with it. This still
documents that Git cannot rely on one particular output value in those
cases, so the intention of the original tests is still met.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	This is the promised fix.

 test-path-utils.c | 78 +++++++++++++++----------------------------------------
 1 file changed, 21 insertions(+), 57 deletions(-)

diff --git a/test-path-utils.c b/test-path-utils.c
index 4ab68ac..c3adcd8 100644
--- a/test-path-utils.c
+++ b/test-path-utils.c
@@ -42,6 +42,7 @@ static void normalize_argv_string(const char **var, const char *input)
 struct test_data {
 	const char *from;  /* input:  transform from this ... */
 	const char *to;    /* output: ... to this.            */
+	const char *alternative; /* output: ... or this.      */
 };
 
 static int test_function(struct test_data *data, char *(*func)(char *input),
@@ -58,11 +59,18 @@ static int test_function(struct test_data *data, char *(*func)(char *input),
 			strcpy(buffer, data[i].from);
 			to = func(buffer);
 		}
-		if (strcmp(to, data[i].to)) {
+		if (!strcmp(to, data[i].to))
+			continue;
+		if (!data[i].alternative)
 			error("FAIL: %s(%s) => '%s' != '%s'\n",
 				funcname, data[i].from, to, data[i].to);
-			failed = 1;
-		}
+		else if (!strcmp(to, data[i].alternative))
+			continue;
+		else
+			error("FAIL: %s(%s) => '%s' != '%s', '%s'\n",
+				funcname, data[i].from, to, data[i].to,
+				data[i].alternative);
+		failed = 1;
 	}
 	return failed;
 }
@@ -74,15 +82,9 @@ static struct test_data basename_data[] = {
 	{ ".",               "."    },
 	{ "..",              ".."   },
 	{ "/",               "/"    },
-#if defined(__CYGWIN__) && !defined(NO_LIBGEN_H)
-	{ "//",              "//"   },
-	{ "///",             "//"   },
-	{ "////",            "//"   },
-#else
-	{ "//",              "/"    },
-	{ "///",             "/"    },
-	{ "////",            "/"    },
-#endif
+	{ "//",              "/", "//" },
+	{ "///",             "/", "//" },
+	{ "////",            "/", "//" },
 	{ "usr",             "usr"  },
 	{ "/usr",            "usr"  },
 	{ "/usr/",           "usr"  },
@@ -92,7 +94,6 @@ static struct test_data basename_data[] = {
 	{ "usr/lib///",      "lib"  },
 
 #if defined(__MINGW32__) || defined(_MSC_VER)
-
 	/* --- win32 type paths --- */
 	{ "\\usr",           "usr"  },
 	{ "\\usr\\",         "usr"  },
@@ -111,26 +112,9 @@ static struct test_data basename_data[] = {
 	{ "C:a",             "a"    },
 	{ "C:/",             "/"    },
 	{ "C:///",           "/"    },
-#if defined(NO_LIBGEN_H)
-	{ "\\",              "\\"   },
-	{ "\\\\",            "\\"   },
-	{ "\\\\\\",          "\\"   },
-#else
-
-	/* win32 platform variations: */
-#if defined(__MINGW32__)
-	{ "\\",              "/"    },
-	{ "\\\\",            "/"    },
-	{ "\\\\\\",          "/"    },
-#endif
-
-#if defined(_MSC_VER)
-	{ "\\",              "\\"   },
-	{ "\\\\",            "\\"   },
-	{ "\\\\\\",          "\\"   },
-#endif
-
-#endif
+	{ "\\",              "\\", "/" },
+	{ "\\\\",            "\\", "/" },
+	{ "\\\\\\",          "\\", "/" },
 #endif
 	{ NULL,              NULL   }
 };
@@ -142,14 +126,9 @@ static struct test_data dirname_data[] = {
 	{ ".",               "."      },
 	{ "..",              "."      },
 	{ "/",               "/"      },
-	{ "//",              "//"     },
-#if defined(__CYGWIN__) && !defined(NO_LIBGEN_H)
-	{ "///",             "//"     },
-	{ "////",            "//"     },
-#else
-	{ "///",             "/"      },
-	{ "////",            "/"      },
-#endif
+	{ "//",              "/", "//" },
+	{ "///",             "/", "//" },
+	{ "////",            "/", "//" },
 	{ "usr",             "."      },
 	{ "/usr",            "/"      },
 	{ "/usr/",           "/"      },
@@ -159,7 +138,6 @@ static struct test_data dirname_data[] = {
 	{ "usr/lib///",      "usr"    },
 
 #if defined(__MINGW32__) || defined(_MSC_VER)
-
 	/* --- win32 type paths --- */
 	{ "\\",              "\\"     },
 	{ "\\\\",            "\\\\"   },
@@ -180,21 +158,7 @@ static struct test_data dirname_data[] = {
 	{ "C:usr/lib///",    "C:usr"  },
 	{ "\\\\\\",          "\\"     },
 	{ "\\\\\\\\",        "\\"     },
-#if defined(NO_LIBGEN_H)
-	{ "C:",              "C:."    },
-#else
-
-	/* win32 platform variations: */
-#if defined(__MINGW32__)
-	/* the following is clearly wrong ... */
-	{ "C:",              "."      },
-#endif
-
-#if defined(_MSC_VER)
-	{ "C:",              "C:."    },
-#endif
-
-#endif
+	{ "C:",              "C:.", "." },
 #endif
 	{ NULL,              NULL     }
 };
-- 
2.6.3.windows.1.300.g1c25e49
