From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v2 0/2] Support marking .git/ (or all files) as hidden on
 Windows
Date: Sat, 7 May 2016 08:44:42 +0200 (CEST)
Message-ID: <cover.1462603453.git.johannes.schindelin@gmx.de>
References: <17d30bb680a0452efd7b3c4f42e2f94478a86273.1462372716.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org, Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Erik Faye-Lund <kusmabite@googlemail.com>,
	Pat Thoyts <patthoyts@users.sourceforge.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 07 08:45:03 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ayvz5-00005t-6N
	for gcvg-git-2@plane.gmane.org; Sat, 07 May 2016 08:45:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751457AbcEGGo5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 May 2016 02:44:57 -0400
Received: from mout.gmx.net ([212.227.17.21]:49606 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751072AbcEGGo4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 May 2016 02:44:56 -0400
Received: from virtualbox ([37.24.143.84]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0MI9n0-1awAYY1Gv8-003shr; Sat, 07 May 2016 08:44:40
 +0200
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <17d30bb680a0452efd7b3c4f42e2f94478a86273.1462372716.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:ZJ/kqtl0FUQSVTWvo8cgGoe7wUo8m/BnpbVQZrGy4X1W3BofCRb
 oPbOFYdT7JvZIdZU6NNF8u5dLA074wCMVU3vh1Cyr9SvNH6bZTLLQ6PcVerSHsis3417FyY
 mmGvhGDK7ZY+YfAv+IfZMuEiA4O4wYjht+wRjN5nKWIJTD8gCrdcEmSPKCY0MQzAtKAFltR
 T8jNGl42RU7nFeLf9q1ww==
X-UI-Out-Filterresults: notjunk:1;V01:K0:5tZB8dTOYHA=:46QvVaB4QyBYRo2JAay+rX
 xwTINWLQoJoNZ4t1IlhXTgJftijHw7nDAKbFXj1G7Vhz6g70Nars+Vd4scZEhYhCO9p6hBz/m
 ciqvI6FmREaym7RShDp/MYzR7yWn8wJre5ArtEq9dpkuYN2msgDe/T33vptUN5P3G1zPXoD7l
 +pTZXGeI2Qbh1MeaUOLx1PI1v0dfDaYO/U/h6xvQ7tX/ajcE8Aszt+BOQrLcdafCgv1IBfquh
 lCV6IYz89/WfrBiqLdE5VzcoSxkklxlwf6meU7Gln0hOFIliC+r3vp9FnouVbfzt7/Ox2OtSJ
 ziafiyn5lmiUhOBILu0zLud5LxMTG7EtTKYvvHXux/aQhJDYXcC5r24RsNTDvAZ7R6kLLQ+7a
 HqKASI0OINEYxnmf9IbCWdOXTzV2bGAVc/C92ggYVZhJVBSrrn4NH5shre5VisUS7DH0I9kVt
 /6K49rQrJMpDrYFe2JbkB8c0vwc3oYEJdNDObqFXvkD3h+WZx7Gil2gldV/wRzgUebrJOQnUr
 7l7W+HLuoRa1+VaoY/tghkcf50y/55iMiP5YZ+kwZB86+qrFOHSC2Fkv0XrugPYZoVXaoNY1l
 3Z9l4LTrzrTkknE+vMiNpE4MRlmsJQEj4vV7ACGMQjgW1RFir2OPtegFlmDOk76XU74OZAHz/
 L3l5FKjArFDXLALK9uGmJ5JVKb5+s8lYWl7wQh3MOi/PbT8bdsWLM8ei6DABD8lZn/LUIj1Jh
 gzw3g75+PEvqNv/NlAa03Z42R7RJfayS5mr5rTsVsDX/UJGuJNdJEQF60gxWKEcGorqXESTr 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293883>

Windows does not share Unix' convention that files and directories whose
names start with a dot are hidden. Hence `.git/`, for example, is in
plain view, and caused quite a bit of trouble: some users wanted to peek
inside and did not understand what it contains, others modified files.

There was a stream of bug reports, until Git for Windows introduced the
(opt-out) option to hide at least the .git/ directory by default. The
option is configured via the config setting core.hideDotFiles, with the
possible values false, true and dotGitOnly (the latter being the
default).

This is a heavily version of patches we carried in Git for Windows for
way too long without submitting them upstream.

In this iteration, I also claim authorship for the patch because by now
Kusma's changes were so contorted and mutilated beyond recognition by me
that I do not want anybody to blame him for my sins.


Johannes Schindelin (2):
  mingw: introduce the 'core.hideDotFiles' setting
  mingw: remove unnecessary definition

 Documentation/config.txt |  6 ++++
 cache.h                  |  7 +++++
 compat/mingw.c           | 74 ++++++++++++++++++++++++++++++++++++++++++++++++
 compat/mingw.h           |  3 --
 config.c                 |  8 ++++++
 environment.c            |  1 +
 t/t0001-init.sh          | 30 ++++++++++++++++++++
 t/t5611-clone-config.sh  | 20 +++++++++++++
 8 files changed, 146 insertions(+), 3 deletions(-)

Published-As: https://github.com/dscho/git/releases/tag/hide-dotgit-v2
Interdiff vs v1:

 diff --git a/Documentation/config.txt b/Documentation/config.txt
 index 5d4e3b2..8747c2c 100644
 --- a/Documentation/config.txt
 +++ b/Documentation/config.txt
 @@ -270,10 +270,10 @@ See linkgit:git-update-index[1].
  The default is true (when core.filemode is not specified in the config file).
  
  core.hideDotFiles::
 -	(Windows-only) If true (which is the default), mark newly-created
 -	directories and files whose name starts with a dot as hidden.
 -	If 'dotGitOnly', only the .git/ directory is hidden, but no other
 -	files starting with a dot.
 +	(Windows-only) If true, mark newly-created directories and files whose
 +	name starts with a dot as hidden.  If 'dotGitOnly', only the `.git/`
 +	directory is hidden, but no other files starting with a dot.  The
 +	default mode is to mark only the `.git/` directory as hidden.
  
  core.ignoreCase::
  	If true, this option enables various workarounds to enable
 diff --git a/builtin/init-db.c b/builtin/init-db.c
 index c4269ac..b2d8d40 100644
 --- a/builtin/init-db.c
 +++ b/builtin/init-db.c
 @@ -370,7 +370,6 @@ int init_db(const char *template_dir, unsigned int flags)
  	check_repository_format();
  
  	reinit = create_default_files(template_dir);
 -	mark_as_git_dir(get_git_dir());
  
  	create_object_directory();
  
 diff --git a/compat/mingw.c b/compat/mingw.c
 index 8b8b01c..3ecde84 100644
 --- a/compat/mingw.c
 +++ b/compat/mingw.c
 @@ -288,31 +288,47 @@ int mingw_rmdir(const char *pathname)
  
  static inline int needs_hiding(const char *path)
  {
 -	return hide_dotfiles == HIDE_DOTFILES_TRUE &&
 -		starts_with(basename((char*)path), ".");
 +	const char *basename;
 +
 +	if (hide_dotfiles == HIDE_DOTFILES_FALSE)
 +		return 0;
 +
 +	/* We cannot use basename(), as it would remove trailing slashes */
 +	mingw_skip_dos_drive_prefix((char **)&path);
 +	if (!*path)
 +		return 0;
 +
 +	for (basename = path; *path; path++)
 +		if (is_dir_sep(*path)) {
 +			do {
 +				path++;
 +			} while (is_dir_sep(*path));
 +			/* ignore trailing slashes */
 +			if (*path)
 +				basename = path;
 +		}
 +
 +	if (hide_dotfiles == HIDE_DOTFILES_TRUE)
 +		return *basename == '.';
 +
 +	assert(hide_dotfiles == HIDE_DOTFILES_DOTGITONLY);
 +	return !strncasecmp(".git", basename, 4) &&
 +		(!basename[4] || is_dir_sep(basename[4]));
  }
  
 -static int make_hidden(const wchar_t *path)
 +static int set_hidden_flag(const wchar_t *path, int set)
  {
  	DWORD attribs = GetFileAttributesW(path);
 -	if (SetFileAttributesW(path, FILE_ATTRIBUTE_HIDDEN | attribs))
 +	if (set)
 +		attribs |= FILE_ATTRIBUTE_HIDDEN;
 +	else
 +		attribs &= ~FILE_ATTRIBUTE_HIDDEN;
 +	if (SetFileAttributesW(path, attribs))
  		return 0;
  	errno = err_win_to_posix(GetLastError());
  	return -1;
  }
  
 -void mingw_mark_as_git_dir(const char *dir)
 -{
 -	wchar_t wdir[MAX_PATH];
 -	if (hide_dotfiles != HIDE_DOTFILES_FALSE && !is_bare_repository())
 -		if (xutftowcs_path(wdir, dir) < 0 || make_hidden(wdir))
 -			warning("Failed to make '%s' hidden", dir);
 -	git_config_set("core.hideDotFiles",
 -		hide_dotfiles == HIDE_DOTFILES_FALSE ? "false" :
 -		(hide_dotfiles == HIDE_DOTFILES_DOTGITONLY ?
 -		 "dotGitOnly" : "true"));
 -}
 -
  int mingw_mkdir(const char *path, int mode)
  {
  	int ret;
 @@ -321,7 +337,7 @@ int mingw_mkdir(const char *path, int mode)
  		return -1;
  	ret = _wmkdir(wpath);
  	if (!ret && needs_hiding(path))
 -		return make_hidden(wpath);
 +		return set_hidden_flag(wpath, 1);
  	return ret;
  }
  
 @@ -348,9 +364,21 @@ int mingw_open (const char *filename, int oflags, ...)
  		if (attrs != INVALID_FILE_ATTRIBUTES && (attrs & FILE_ATTRIBUTE_DIRECTORY))
  			errno = EISDIR;
  	}
 -	if ((oflags & O_CREAT) && fd >= 0 && needs_hiding(filename) &&
 -	    make_hidden(wfilename))
 -		warning("Could not mark '%s' as hidden.", filename);
 +	if ((oflags & O_CREAT) && needs_hiding(filename)) {
 +		/*
 +		 * Internally, _wopen() uses the CreateFile() API which errors
 +		 * out with an ERROR_ACCESS_DENIED if CREATE_ALWAYS was
 +		 * specified and an already existing file's attributes do not
 +		 * match *exactly*. As there is no mode or flag we can set that
 +		 * would correspond to FILE_ATTRIBUTE_HIDDEN, let's just try
 +		 * again *without* the O_CREAT flag (that corresponds to the
 +		 * CREATE_ALWAYS flag of CreateFile()).
 +		 */
 +		if (fd < 0 && errno == EACCES)
 +			fd = _wopen(wfilename, oflags & ~O_CREAT, mode);
 +		if (fd >= 0 && set_hidden_flag(wfilename, 1))
 +			warning("Could not mark '%s' as hidden.", filename);
 +	}
  	return fd;
  }
  
 @@ -382,7 +410,7 @@ int mingw_fgetc(FILE *stream)
  #undef fopen
  FILE *mingw_fopen (const char *filename, const char *otype)
  {
 -	int hide = needs_hiding(filename) && access(filename, F_OK);
 +	int hide = needs_hiding(filename);
  	FILE *file;
  	wchar_t wfilename[MAX_PATH], wotype[4];
  	if (filename && !strcmp(filename, "/dev/null"))
 @@ -390,15 +418,19 @@ FILE *mingw_fopen (const char *filename, const char *otype)
  	if (xutftowcs_path(wfilename, filename) < 0 ||
  		xutftowcs(wotype, otype, ARRAY_SIZE(wotype)) < 0)
  		return NULL;
 +	if (hide && !access(filename, F_OK) && set_hidden_flag(wfilename, 0)) {
 +		error("Could not unhide %s", filename);
 +		return NULL;
 +	}
  	file = _wfopen(wfilename, wotype);
 -	if (file && hide && make_hidden(wfilename))
 +	if (file && hide && set_hidden_flag(wfilename, 1))
  		warning("Could not mark '%s' as hidden.", filename);
  	return file;
  }
  
  FILE *mingw_freopen (const char *filename, const char *otype, FILE *stream)
  {
 -	int hide = needs_hiding(filename) && access(filename, F_OK);
 +	int hide = needs_hiding(filename);
  	FILE *file;
  	wchar_t wfilename[MAX_PATH], wotype[4];
  	if (filename && !strcmp(filename, "/dev/null"))
 @@ -406,8 +438,12 @@ FILE *mingw_freopen (const char *filename, const char *otype, FILE *stream)
  	if (xutftowcs_path(wfilename, filename) < 0 ||
  		xutftowcs(wotype, otype, ARRAY_SIZE(wotype)) < 0)
  		return NULL;
 +	if (hide && !access(filename, F_OK) && set_hidden_flag(wfilename, 0)) {
 +		error("Could not unhide %s", filename);
 +		return NULL;
 +	}
  	file = _wfreopen(wfilename, wotype, stream);
 -	if (file && hide && make_hidden(wfilename))
 +	if (file && hide && set_hidden_flag(wfilename, 1))
  		warning("Could not mark '%s' as hidden.", filename);
  	return file;
  }
 diff --git a/compat/mingw.h b/compat/mingw.h
 index 1de70ff..a1808b4 100644
 --- a/compat/mingw.h
 +++ b/compat/mingw.h
 @@ -416,9 +416,6 @@ int mingw_offset_1st_component(const char *path);
  void mingw_open_html(const char *path);
  #define open_html mingw_open_html
  
 -void mingw_mark_as_git_dir(const char *dir);
 -#define mark_as_git_dir mingw_mark_as_git_dir
 -
  /**
   * Converts UTF-8 encoded string to UTF-16LE.
   *
 diff --git a/git-compat-util.h b/git-compat-util.h
 index ea007e4..1f8b5f3 100644
 --- a/git-compat-util.h
 +++ b/git-compat-util.h
 @@ -1042,8 +1042,4 @@ struct tm *git_gmtime_r(const time_t *, struct tm *);
  #define getc_unlocked(fh) getc(fh)
  #endif
  
 -#ifndef mark_as_git_dir
 -#define mark_as_git_dir(x) /* noop */
 -#endif
 -
  #endif
 diff --git a/t/t5611-clone-config.sh b/t/t5611-clone-config.sh
 index 27d730c..e4850b7 100755
 --- a/t/t5611-clone-config.sh
 +++ b/t/t5611-clone-config.sh
 @@ -37,4 +37,24 @@ test_expect_success 'clone -c config is available during clone' '
  	test_cmp expect child/file
  '
  
 +# Tests for the hidden file attribute on windows
 +is_hidden () {
 +	# Use the output of `attrib`, ignore the absolute path
 +	case "$(attrib "$1")" in *H*?:*) return 0;; esac
 +	return 1
 +}
 +
 +test_expect_success MINGW 'clone -c core.hideDotFiles' '
 +	test_commit attributes .gitattributes "" &&
 +	rm -rf child &&
 +	git clone -c core.hideDotFiles=false . child &&
 +	! is_hidden child/.gitattributes &&
 +	rm -rf child &&
 +	git clone -c core.hideDotFiles=dotGitOnly . child &&
 +	! is_hidden child/.gitattributes &&
 +	rm -rf child &&
 +	git clone -c core.hideDotFiles=true . child &&
 +	is_hidden child/.gitattributes
 +'
 +
  test_done

-- 
2.8.2.463.g99156ee
