From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v3 4/4] t0060: verify that basename() and dirname() work as
 expected
Date: Mon, 11 Jan 2016 19:30:04 +0100 (CET)
Message-ID: <056411e53cd5772f36ce4e0c2f18aae0db015970.1452536924.git.johannes.schindelin@gmx.de>
References: <cover.1452270051.git.johannes.schindelin@gmx.de> <cover.1452536924.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org, Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 11 19:30:33 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aIhEb-0008HW-OQ
	for gcvg-git-2@plane.gmane.org; Mon, 11 Jan 2016 19:30:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933629AbcAKSaS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jan 2016 13:30:18 -0500
Received: from mout.gmx.net ([212.227.17.22]:60678 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933270AbcAKSaP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jan 2016 13:30:15 -0500
Received: from virtualbox ([37.24.143.74]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0MCL6r-1aRBfj3xcP-0098Ap; Mon, 11 Jan 2016 19:30:07
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <cover.1452536924.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:szVp3D9hOR8wx1z+PMqn4cxL4rNir/2DJ0IMnov2yOxYnKqx8sz
 WSr1q5ggclAJZAbiHSCSdMlQHHhHKPfiTa6Ko+X47ys0VZEsdJfM3GK6WKNEB/yKcXAoiUY
 IF1cXjpXmGtuC533iIbnVjBqzZ/EtEkBAgEL1t5OxCmQ5o0djbgCtd1I9d+XgHkDXylgHr2
 lZXOrwX7kX9ny6HkzKGCg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:J6iiwnz+s1k=:c35OwDG/Il/EUH+fMYOijK
 EL0vukFYTyst6r0xeFhNoEpwIBpiAEsPtjuEjtHboZW9UuvHMmO2SNd0fWCc6tJHtHal+jZOh
 pxNWZCC5kya2CvAXldxKKqdDMoS1o8m9q9NoedExacFjrsKcAjNd/zl6WTfXRpkwpnPFpveU8
 Kxy+ZoS/KPBV4AMYj+9fndDb47WWEGZtSIhHore59E4QobcyL1gVyrKhGJgm3W4hXAl1+6itE
 0xJgM/oOllblPNsELhhxzOF5VYX9lUhslp3FggUB5RMqYtNND2EJKbC6oMlWDGF0VRQ3rIXJs
 s7LUR17E4LU/QjjTUgcwHqgAFWIbIAICGRs5Sd1k1GsIk1KdUeCEt4ov9Im/t4zayG77FeOx3
 j3jiBDV35LvhLgofMTSfsxo4CmWByEoIsAcMo93xLEvi9GiMozhkzfvIpd4YrJYDvT5/cczdU
 WvJcP/Yvz0hUPP1qVSjZZQBz0k3pvAugeRdqNiixyTM3xFubc3fUfvaTEz6DRSxiklFVaExE+
 D08+3N09JsEqllSimyfSEQ66Ugsq3ZS51e59FHdLFznMxICZQ069eD4WgVc7ugQGOKbCdd0L3
 h86ROYTnmMJeP61JDE0oQTs9jZLll7RuDNQ3/8PT9q5a6Pwn6PPu+aTazJsgqxk7U71MjTZ6B
 gOOhFSC6+0FSJ+8TAVy9ktUrVtmmchNVSTlRYgUJgPbDWpKhuVuAugU4O4uSJ86EfoVbDJ62Y
 dJ8+DksusG0dPlAIbHn497obutVGe5qAGFAKAXB64BJccG+scqKX+FQzBOmD7BLMv9W7J9H6 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283693>

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
