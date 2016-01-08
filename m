From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v2 0/4] Ensure that we can build without libgen.h
Date: Fri, 8 Jan 2016 17:21:07 +0100 (CET)
Message-ID: <cover.1452270051.git.johannes.schindelin@gmx.de>
References: <25a2598e756959f55f06ae6b4dc6f448e3b6b127.1443624188.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org, Ramsay Jones <ramsay@ramsayjones.plus.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 08 17:21:47 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aHZnF-00076w-M7
	for gcvg-git-2@plane.gmane.org; Fri, 08 Jan 2016 17:21:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755869AbcAHQVY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Jan 2016 11:21:24 -0500
Received: from mout.gmx.net ([212.227.17.21]:51751 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755813AbcAHQVR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jan 2016 11:21:17 -0500
Received: from virtualbox ([37.24.143.74]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0Lj4xG-1ZePDW1SLG-00dBTe; Fri, 08 Jan 2016 17:21:08
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <25a2598e756959f55f06ae6b4dc6f448e3b6b127.1443624188.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:XEgiUFWP47ilTS4daWz0xACEej1uRno+VjI2AeB1emPc/Yh69r7
 DHUNFu6bYdTD/wdyTTyb+mcXA0c12qRxoNjkfRZOMv0OX9mP4S4Z75NeH6MRGf89BtbySVo
 Wlhc+enZAc+roFj9AujuoJi1dFxQmYxRUwdmqMoa+6nMue+CvpZUi2JDDrqC1qenjPqjnzP
 rCmbg2tPnJ99N1GJIaJBw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:DL+nDrJg7Ao=:5mBNW+Py7Mxd7vQ5gn/R9U
 lRUg8qJpIp6bFRH/4AYoptRAHxIc1hoGhOEffxquTHHu3N0Baae+zabFTurCcYGdcMnFPZITn
 7pkzHEjcu2ReA9IwGTPHYVMozUG9e+VnEpRJ0TOVigR8ZvM6TpYxcr0h6TBy8wmK4OcOqo5J3
 hN+bBPX3DBjCO+QAoMdhgKpvGfs2rKRwyq0FEUViBjqLSEsHA2Ibj43Q89tP6HYeiWiiUk5g2
 7Yyk/QpK1M5IswuV3noOOa3Qg4NVEIBsshkMtQt/vJMW9sspZP+A86pJ8549UfoQmVsfw8WfX
 aN5//7P98BMfw3GoY+Rjhib1yAwceob/zDO/f/PkNyuEb4zHz1kEczLH2qj7gS2ZrXCaN4h+8
 q9Sjls2gPFSTArsmLifHZH3B228Hoafkxnht2g6+uqgYHzY8IKr+TkkCZcNNKHlp1mn/mz4Wu
 gsFNddXQoy+M1zrNJMD2RtPnFXX+0ex08XItVEYqwwsJKhzW17RB8qhfiCuVuKGs5WlzD/Xa6
 j/WF14deo9LIAN1lbBk4AqdP89CV2l14AFFPvltnEp8lBCFt3ob/5dXwYM1r4XiL243ABNRXx
 v+h/ziEvlhn6Oy3x7z0S1W1xo2+52ljFxGh5TNUIGzbhtYEDuLcO7uAodF0jKIj8s7hUp/PX+
 9P8PXKlQOq5wHugrgjd6ys85bWiTop6TZGUQJfcppb8MFW2VNFFxVVDcrr9se+pwF3QCZvR1u
 gHk6IGlTCkj9L14Z8MVPXFBXf5w/Yq5sfU2rfzqfVp8GhswrSJPDgPY1jw9/6NnLd7qe5QU9 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283567>

This mini series adds a fall-back for the `dirname()` function that we use
e.g. in git-am. This is necessary because not all platforms have a working
libgen.h. MSys2 (on which Git for Windows relies) does have a libgen.h, but
its `basename()` implementation is broken, thus we cannot use it.


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
 test-path-utils.c     | 168 ++++++++++++++++++++++++++++++++++++++++++++++++++
 7 files changed, 261 insertions(+), 24 deletions(-)

Interdiff vs v1:

 diff --git a/compat/basename.c b/compat/basename.c
 index 10dba38..0a2ed25 100644
 --- a/compat/basename.c
 +++ b/compat/basename.c
 @@ -1,28 +1,58 @@
  #include "../git-compat-util.h"
 +#include "../strbuf.h"
  
  /* Adapted from libiberty's basename.c.  */
  char *gitbasename (char *path)
  {
  	const char *base;
 -	/* Skip over the disk name in MSDOS pathnames. */
 -	if (has_dos_drive_prefix(path))
 -		path += 2;
 +
 +	if (path)
 +		skip_dos_drive_prefix(&path);
 +
 +	if (!path || !*path)
 +		return ".";
 +
  	for (base = path; *path; path++) {
 -		if (is_dir_sep(*path))
 -			base = path + 1;
 +		if (!is_dir_sep(*path))
 +			continue;
 +		do {
 +			path++;
 +		} while (is_dir_sep(*path));
 +		if (*path)
 +			base = path;
 +		else
 +			while (--path != base && is_dir_sep(*path))
 +				*path = '\0';
  	}
  	return (char *)base;
  }
  
  char *gitdirname(char *path)
  {
 -	char *p = path, *slash, c;
 +	char *p = path, *slash = NULL, c;
 +	int dos_drive_prefix;
 +
 +	if (!p)
 +		return ".";
  
 -	/* Skip over the disk name in MSDOS pathnames. */
 -	if (has_dos_drive_prefix(p))
 -		p += 2;
 -	/* POSIX.1-2001 says dirname("/") should return "/" */
 -	slash = is_dir_sep(*p) ? ++p : NULL;
 +	if ((dos_drive_prefix = skip_dos_drive_prefix(&p)) && !*p) {
 +		static struct strbuf buf = STRBUF_INIT;
 +
 +dot:
 +		strbuf_reset(&buf);
 +		strbuf_addf(&buf, "%.*s.", dos_drive_prefix, path);
 +		return buf.buf;
 +	}
 +
 +	/*
 +	 * POSIX.1-2001 says dirname("/") should return "/", and dirname("//")
 +	 * should return "//", but dirname("///") should return "/" again.
 +	 */
 +	if (is_dir_sep(*p)) {
 +		if (!p[1] || (is_dir_sep(p[1]) && !p[2]))
 +			return path;
 +		slash = ++p;
 +	}
  	while ((c = *(p++)))
  		if (is_dir_sep(c)) {
  			char *tentative = p - 1;
 @@ -35,7 +65,7 @@ char *gitdirname(char *path)
  		}
  
  	if (!slash)
 -		return ".";
 +		goto dot;
  	*slash = '\0';
  	return path;
  }
 diff --git a/compat/mingw.c b/compat/mingw.c
 index 5edea29..1b3530a 100644
 --- a/compat/mingw.c
 +++ b/compat/mingw.c
 @@ -1934,26 +1934,22 @@ pid_t waitpid(pid_t pid, int *status, int options)
  
  int mingw_offset_1st_component(const char *path)
  {
 -	int offset = 0;
 -	if (has_dos_drive_prefix(path))
 -		offset = 2;
 +	char *pos = (char *)path;
  
  	/* unc paths */
 -	else if (is_dir_sep(path[0]) && is_dir_sep(path[1])) {
 -
 +	if (!skip_dos_drive_prefix(&pos) &&
 +			is_dir_sep(pos[0]) && is_dir_sep(pos[1])) {
  		/* skip server name */
 -		char *pos = strpbrk(path + 2, "\\/");
 +		pos = strpbrk(pos + 2, "\\/");
  		if (!pos)
  			return 0; /* Error: malformed unc path */
  
  		do {
  			pos++;
  		} while (*pos && !is_dir_sep(*pos));
 -
 -		offset = pos - path;
  	}
  
 -	return offset + is_dir_sep(path[offset]);
 +	return pos + is_dir_sep(*pos) - path;
  }
  
  int xutftowcsn(wchar_t *wcs, const char *utfs, size_t wcslen, int utflen)
 diff --git a/compat/mingw.h b/compat/mingw.h
 index 57ca477..b3e5044 100644
 --- a/compat/mingw.h
 +++ b/compat/mingw.h
 @@ -361,7 +361,15 @@ HANDLE winansi_get_osfhandle(int fd);
   * git specific compatibility
   */
  
 -#define has_dos_drive_prefix(path) (isalpha(*(path)) && (path)[1] == ':')
 +#define has_dos_drive_prefix(path) \
 +	(isalpha(*(path)) && (path)[1] == ':' ? 2 : 0)
 +static inline int mingw_skip_dos_drive_prefix(char **path)
 +{
 +	int ret = has_dos_drive_prefix(*path);
 +	*path += ret;
 +	return ret;
 +}
 +#define skip_dos_drive_prefix mingw_skip_dos_drive_prefix
  #define is_dir_sep(c) ((c) == '/' || (c) == '\\')
  static inline char *mingw_find_last_dir_sep(const char *path)
  {
 diff --git a/git-compat-util.h b/git-compat-util.h
 index 996ee17..94f311a 100644
 --- a/git-compat-util.h
 +++ b/git-compat-util.h
 @@ -337,6 +337,14 @@ static inline int git_has_dos_drive_prefix(const char *path)
  #define has_dos_drive_prefix git_has_dos_drive_prefix
  #endif
  
 +#ifndef skip_dos_drive_prefix
 +static inline int git_skip_dos_drive_prefix(const char **path)
 +{
 +	return 0;
 +}
 +#define skip_dos_drive_prefix git_skip_dos_drive_prefix
 +#endif
 +
  #ifndef is_dir_sep
  static inline int git_is_dir_sep(int c)
  {
 diff --git a/path.c b/path.c
 index 3cd155e..8b7e168 100644
 --- a/path.c
 +++ b/path.c
 @@ -782,13 +782,10 @@ const char *relative_path(const char *in, const char *prefix,
  	else if (!prefix_len)
  		return in;
  
 -	if (have_same_root(in, prefix)) {
 +	if (have_same_root(in, prefix))
  		/* bypass dos_drive, for "c:" is identical to "C:" */
 -		if (has_dos_drive_prefix(in)) {
 -			i = 2;
 -			j = 2;
 -		}
 -	} else {
 +		i = j = has_dos_drive_prefix(in);
 +	else {
  		return in;
  	}
  
 @@ -943,11 +940,10 @@ const char *remove_leading_path(const char *in, const char *prefix)
  int normalize_path_copy_len(char *dst, const char *src, int *prefix_len)
  {
  	char *dst0;
 +	int i;
  
 -	if (has_dos_drive_prefix(src)) {
 +	for (i = has_dos_drive_prefix(src); i > 0; i--)
  		*dst++ = *src++;
 -		*dst++ = *src++;
 -	}
  	dst0 = dst;
  
  	if (is_dir_sep(*src)) {
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
