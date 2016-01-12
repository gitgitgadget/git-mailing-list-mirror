From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v4 4/4] t0060: verify that basename() and dirname() work as
 expected
Date: Tue, 12 Jan 2016 08:57:57 +0100 (CET)
Message-ID: <7d73267984ab029df022477e341c536e111eafdd.1452585382.git.johannes.schindelin@gmx.de>
References: <cover.1452536924.git.johannes.schindelin@gmx.de> <cover.1452585382.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org, Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 12 08:58:22 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aItqK-0000xV-1C
	for gcvg-git-2@plane.gmane.org; Tue, 12 Jan 2016 08:58:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753788AbcALH6H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Jan 2016 02:58:07 -0500
Received: from mout.gmx.net ([212.227.17.22]:49293 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752208AbcALH6F (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jan 2016 02:58:05 -0500
Received: from virtualbox ([37.24.143.74]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0MfEsY-1aYuIJ3pJC-00OpIO; Tue, 12 Jan 2016 08:57:58
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <cover.1452585382.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:FGlNoL1MLox5BoJS37Hf7GP6a5RBj8tOeU89GRrvZWK/g7tzwtx
 Uz+CtmSVnf+5lLLdNOoMYZNiZJgoOwughd+MuDEpm688txuVBlcQFsWTf1QobeiDV4WFIa5
 O6qag3H5g5tOIekk1vKn0NerGHTE0yG4aL/V/Vd75ua0eJsBT4JKXuKDBjY7WBHHlqSWTo8
 bm28Hm8f/pREFwL0NcGvQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Q73HpltjyKA=:5dDSQNF/m3VkJHWym1ZKMW
 jbBRhQtbtQjE/aQl6hWmKTVUWGdXkFFvaV0jC01cuLbZqq10TcNiHMzLMj+qnxiCaRS/3WcjX
 vHrGi/lx1volj07Ls/WF7qJ7eD/i+MSPnz2w4LoXVi5C+eaTTRrRMnzDzGExpOT/KYg+ugNxt
 bGFSqdOIqSt4S0gRIOnRdkO567If4xCaMQr2ajmZ1ejWsZJFpdJXFju+B4ChKnUyCGLSAWsh5
 gHQzEVF4doQUiCAWXMzFP8E6Z4XdBqRHpC+LM4JSyw/qjFkWmbVTs2pA8YZ9h6nKJ/h95qEmJ
 sd6GzuiAWjR/9GrKjU75i2cW6jnlmX1bjOzJCf5vfGqvF/iVIfSul5KlXFQ5dzZsm6g9J6hHL
 ls6/c5/72k7Ea7an/ykjfHYWYNiRLdXjxhSGQ0Y9P7uHYY59LMQhI3Dfxd+uHlE9N7SoHcIyp
 xsZTsalqIEDkYCWxEvKaAQStqCy0fLS6pGshoPTB4cllR2z9LVe5w6fDrnvsISoj5VbZtEJLc
 UXKJWvLb7BDsDDiMzi+BYhytJaJixhWwCi3D3MU48GStnCOmwJ4LNutVlLjrZuMHdvZ0kGcJm
 j/Rc0HSobQwKNqbm8VJc3VHbiSHOkIeSzlwMkMiw+IySTVj7lJ+1SbML6qpt6p6LTTI/4R7q7
 mbGOKcbKrIdpU0NDtPsCxNW0iVhj7RD/S7b+g195rzDSkRVaLbzQLiEcvAzUXFrAEY2Whnemt
 nG3XSiyy3BfvvNfhkEleNrn1RWCMDmLw06XVEuho+R8mu25V4neoe0I1vvYJ+TzWHNSbnPXW 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283775>

Unfortunately, some libgen implementations yield outcomes different
from what Git expects. For example, mingw-w64-crt provides a basename()
function, that shortens `path0/` to `path`!

So let's verify that the basename() and dirname() functions we use
conform to what Git expects.

Derived-from-code-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t0060-path-utils.sh |   3 +
 test-path-utils.c     | 166 ++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 169 insertions(+)

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
index c67bf65..4ab68ac 100644
--- a/test-path-utils.c
+++ b/test-path-utils.c
@@ -39,6 +39,166 @@ static void normalize_argv_string(const char **var, const char *input)
 		die("Bad value: %s\n", input);
 }
 
+struct test_data {
+	const char *from;  /* input:  transform from this ... */
+	const char *to;    /* output: ... to this.            */
+};
+
+static int test_function(struct test_data *data, char *(*func)(char *input),
+	const char *funcname)
+{
+	int failed = 0, i;
+	char buffer[1024];
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
+			failed = 1;
+		}
+	}
+	return failed;
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
+	{ NULL,              NULL     }
+};
+
 int main(int argc, char **argv)
 {
 	if (argc == 3 && !strcmp(argv[1], "normalize_path_copy")) {
@@ -133,6 +293,12 @@ int main(int argc, char **argv)
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
