From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v2 4/4] t0060: verify that basename() and dirname() work as
 expected
Date: Fri, 8 Jan 2016 17:21:22 +0100 (CET)
Message-ID: <eca740dbf6271bd69f2ccb14163175996ef7c837.1452270051.git.johannes.schindelin@gmx.de>
References: <25a2598e756959f55f06ae6b4dc6f448e3b6b127.1443624188.git.johannes.schindelin@gmx.de> <cover.1452270051.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org, Ramsay Jones <ramsay@ramsayjones.plus.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 08 17:21:43 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aHZnH-00076w-JN
	for gcvg-git-2@plane.gmane.org; Fri, 08 Jan 2016 17:21:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755798AbcAHQVh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Jan 2016 11:21:37 -0500
Received: from mout.gmx.net ([212.227.15.15]:55114 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755874AbcAHQV3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jan 2016 11:21:29 -0500
Received: from virtualbox ([37.24.143.74]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0M6ilI-1a35qZ14aK-00wYXS; Fri, 08 Jan 2016 17:21:23
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <cover.1452270051.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:r8QsT2mtJ1vtqcigPD0Y+FfTN3uKc8NiDsngT0Jhkk3Z9xM8242
 omspdorO4wQbDArBf/QSnDypHAlsfnDWJEr2nWzM7vOCi+ryz0V1l7mgyi0WFE32avkXt5r
 voUIPulVRAPPkMzRvAR1s5lAdLOE2rYbCN+cC+VKRnGxy7TbRZNUteMbdrDmZlLhHmYhBd3
 YdP3x82ehUj08F6dAcyHA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:QWNddsEwHU4=:KqF8gUL0ZwQKtRhsmgLjre
 L9ELFw2uhPCa+xGWDZN9hyRBlSDZNQG1kg9qFxhigers7sqOtM2rFIX7cBamNgrv3k9H0a0YW
 ppPCE/b9L2Mm/6asLXtHMR17JrOY7DQThtvmsA0zYgjyc1LG24kmIQHMRwX8Fbev+SLiypCEd
 KIesdTRCtgvbkKS8Na9A+7Z/VNVyS4UIvqLEgBUlY0j3/TJSfxW/zbvm8M4wU7w0XEoQqm1Ov
 bMQN0uGo458DIRAiuq922yrEH9rGjeKTd9D3EqFq1aT/2/KwO5bk7v0f/rypyRVDy+6BjEaWa
 RDkPbE9/MQ0TT4y4DKCCzPP0afNxnYhztqB+aOI0MUaw/dmWYhMO9FX9egP/WFLCTVvK0oaZ1
 fscVulrAmNR8GSN1I7JCWrBupCqfGZHavVdywCldTS/7zb5TVWeznPSgU3jnu+zuhhgI4tYsg
 Zgt0RWbIr+w/Cg3hZKgN9syq3NzVte26iYdfl7Eo5Jc8/hylxtzkTHEtmdHe029kcSy2Pl8Fj
 EYTy+C1945ubGMdvtokKWhnZqjeHC4oHhSoxVN5MUWs8Ux/LPyOqKFYxca0ZoHkcAaRZO1pcw
 AVq0agWMPUvqxtE467A/uE7pj9y7I+b92kZSjgIM2KFh4pMvWiYAUH00xQIVDEY0wfch1s7i/
 f/y3r4Gw1RAQoaeEdHClrxzoc/enzem0CqJxnl7iJg7DKML/iYy+FVOuU/BQ8EdTklYlXdAWN
 fHnu05U3FRKmvTv/BmZMAsQnnmOaeTMds3/FFC+llEPed0774PiP/hfmeswobalfTO+IISpw 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283565>

Unfortunately, some libgen implementations yield outcomes different from
what Git expects. For example, mingw-w64-crt provides a basename()
function, that shortens `path0/` to `path`!

So let's verify that the basename() and dirname() functions we use conform
to what Git expects.

Derived-from-code-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t0060-path-utils.sh |   3 +
 test-path-utils.c     | 168 ++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 171 insertions(+)

diff --git a/t/t0060-path-utils.sh b/t/t0060-path-utils.sh
index 627ef85..f0152a7 100755
--- a/t/t0060-path-utils.sh
+++ b/t/t0060-path-utils.sh
@@ -59,6 +59,9 @@ case $(uname -s) in
 	;;
 esac
 
+test_expect_success basename 'test-path-utils basename'
+test_expect_success dirname 'test-path-utils dirname'
+
 norm_path "" ""
 norm_path . ""
 norm_path ./ ""
diff --git a/test-path-utils.c b/test-path-utils.c
index c67bf65..74e74c9 100644
--- a/test-path-utils.c
+++ b/test-path-utils.c
@@ -39,6 +39,168 @@ static void normalize_argv_string(const char **var, const char *input)
 		die("Bad value: %s\n", input);
 }
 
+struct test_data {
+	char *from;  /* input:  transform from this ... */
+	char *to;    /* output: ... to this.            */
+};
+
+static int test_function(struct test_data *data, char *(*func)(char *input),
+	const char *funcname)
+{
+	int failed = 0, i;
+	static char buffer[1024];
+	char *to;
+
+	for (i = 0; data[i].to; i++) {
+		if (!data[i].from)
+			to = func(NULL);
+		else {
+			strcpy(buffer, data[i].from);
+			to = func(buffer);
+		}
+		if (strcmp(to, data[i].to)) {
+			error("FAIL: %s(%s) => '%s' != '%s'\n",
+				funcname, data[i].from, to, data[i].to);
+			failed++;
+		}
+	}
+	return !!failed;
+}
+
+static struct test_data basename_data[] = {
+	/* --- POSIX type paths --- */
+	{ NULL,              "."    },
+	{ "",                "."    },
+	{ ".",               "."    },
+	{ "..",              ".."   },
+	{ "/",               "/"    },
+#if defined(__CYGWIN__) && !defined(NO_LIBGEN_H)
+	{ "//",              "//"   },
+	{ "///",             "//"   },
+	{ "////",            "//"   },
+#else
+	{ "//",              "/"    },
+	{ "///",             "/"    },
+	{ "////",            "/"    },
+#endif
+	{ "usr",             "usr"  },
+	{ "/usr",            "usr"  },
+	{ "/usr/",           "usr"  },
+	{ "/usr//",          "usr"  },
+	{ "/usr/lib",        "lib"  },
+	{ "usr/lib",         "lib"  },
+	{ "usr/lib///",      "lib"  },
+
+#if defined(__MINGW32__) || defined(_MSC_VER)
+
+	/* --- win32 type paths --- */
+	{ "\\usr",           "usr"  },
+	{ "\\usr\\",         "usr"  },
+	{ "\\usr\\\\",       "usr"  },
+	{ "\\usr\\lib",      "lib"  },
+	{ "usr\\lib",        "lib"  },
+	{ "usr\\lib\\\\\\",  "lib"  },
+	{ "C:/usr",          "usr"  },
+	{ "C:/usr",          "usr"  },
+	{ "C:/usr/",         "usr"  },
+	{ "C:/usr//",        "usr"  },
+	{ "C:/usr/lib",      "lib"  },
+	{ "C:usr/lib",       "lib"  },
+	{ "C:usr/lib///",    "lib"  },
+	{ "C:",              "."    },
+	{ "C:a",             "a"    },
+	{ "C:/",             "/"    },
+	{ "C:///",           "/"    },
+#if defined(NO_LIBGEN_H)
+	{ "\\",              "\\"   },
+	{ "\\\\",            "\\"   },
+	{ "\\\\\\",          "\\"   },
+#else
+
+	/* win32 platform variations: */
+#if defined(__MINGW32__)
+	{ "\\",              "/"    },
+	{ "\\\\",            "/"    },
+	{ "\\\\\\",          "/"    },
+#endif
+
+#if defined(_MSC_VER)
+	{ "\\",              "\\"   },
+	{ "\\\\",            "\\"   },
+	{ "\\\\\\",          "\\"   },
+#endif
+
+#endif
+#endif
+	{ NULL,              "."    },
+	{ NULL,              NULL   }
+};
+
+static struct test_data dirname_data[] = {
+	/* --- POSIX type paths --- */
+	{ NULL,              "."      },
+	{ "",                "."      },
+	{ ".",               "."      },
+	{ "..",              "."      },
+	{ "/",               "/"      },
+	{ "//",              "//"     },
+#if defined(__CYGWIN__) && !defined(NO_LIBGEN_H)
+	{ "///",             "//"     },
+	{ "////",            "//"     },
+#else
+	{ "///",             "/"      },
+	{ "////",            "/"      },
+#endif
+	{ "usr",             "."      },
+	{ "/usr",            "/"      },
+	{ "/usr/",           "/"      },
+	{ "/usr//",          "/"      },
+	{ "/usr/lib",        "/usr"   },
+	{ "usr/lib",         "usr"    },
+	{ "usr/lib///",      "usr"    },
+
+#if defined(__MINGW32__) || defined(_MSC_VER)
+
+	/* --- win32 type paths --- */
+	{ "\\",              "\\"     },
+	{ "\\\\",            "\\\\"   },
+	{ "\\usr",           "\\"     },
+	{ "\\usr\\",         "\\"     },
+	{ "\\usr\\\\",       "\\"     },
+	{ "\\usr\\lib",      "\\usr"  },
+	{ "usr\\lib",        "usr"    },
+	{ "usr\\lib\\\\\\",  "usr"    },
+	{ "C:a",             "C:."    },
+	{ "C:/",             "C:/"    },
+	{ "C:///",           "C:/"    },
+	{ "C:/usr",          "C:/"    },
+	{ "C:/usr/",         "C:/"    },
+	{ "C:/usr//",        "C:/"    },
+	{ "C:/usr/lib",      "C:/usr" },
+	{ "C:usr/lib",       "C:usr"  },
+	{ "C:usr/lib///",    "C:usr"  },
+	{ "\\\\\\",          "\\"     },
+	{ "\\\\\\\\",        "\\"     },
+#if defined(NO_LIBGEN_H)
+	{ "C:",              "C:."    },
+#else
+
+	/* win32 platform variations: */
+#if defined(__MINGW32__)
+	/* the following is clearly wrong ... */
+	{ "C:",              "."      },
+#endif
+
+#if defined(_MSC_VER)
+	{ "C:",              "C:."    },
+#endif
+
+#endif
+#endif
+	{ NULL,              "."      },
+	{ NULL,              NULL     }
+};
+
 int main(int argc, char **argv)
 {
 	if (argc == 3 && !strcmp(argv[1], "normalize_path_copy")) {
@@ -133,6 +295,12 @@ int main(int argc, char **argv)
 		return 0;
 	}
 
+	if (argc == 2 && !strcmp(argv[1], "basename"))
+		return test_function(basename_data, basename, argv[1]);
+
+	if (argc == 2 && !strcmp(argv[1], "dirname"))
+		return test_function(dirname_data, dirname, argv[1]);
+
 	fprintf(stderr, "%s: unknown function name: %s\n", argv[0],
 		argv[1] ? argv[1] : "(there was none)");
 	return 1;
-- 
2.6.3.windows.1.300.g1c25e49
