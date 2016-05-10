From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v3 0/2] Support marking .git/ (or all files) as hidden on
 Windows
Date: Tue, 10 May 2016 13:59:04 +0200 (CEST)
Message-ID: <cover.1462881473.git.johannes.schindelin@gmx.de>
References: <cover.1462603453.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org, Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Erik Faye-Lund <kusmabite@googlemail.com>,
	Pat Thoyts <patthoyts@users.sourceforge.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 10 13:59:42 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b06KD-0007GN-CJ
	for gcvg-git-2@plane.gmane.org; Tue, 10 May 2016 13:59:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751889AbcEJL7d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 May 2016 07:59:33 -0400
Received: from mout.gmx.net ([212.227.15.19]:56739 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751492AbcEJL7c (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 May 2016 07:59:32 -0400
Received: from virtualbox ([37.24.143.84]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0Likl3-1bcAkx1xAz-00cwKE; Tue, 10 May 2016 13:59:06
 +0200
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <cover.1462603453.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:KbDXWT2SR+oXAQDdt6braQzn8RvqShxMlUL86nXdZuZm/bas6Ie
 MI9Sh5+mn2twADuojizbJLbqWwAFVdkbb8iZNwZaIpUoQJo7JtS7lkx0tKj0Xj71H9aYAQZ
 rHtRmQObhhSlGtO4tSsU0RQBxpFC4wLodRpVlIlG3xu6xbD2eTEyRhi8ULuDJn7QRhSXFgA
 UAxyYTc2qRr9qB9gWFf3g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:7HJMWtw3SWc=:eCoK8D0GlMzrN5vGdPV94Z
 cNx70qFVq7dRP99Q/bF0nraLhAJiZON8qFx3h/vsQjpssyVnkxeQ8ycAtxw8h/CrieK+vxN5Z
 EOFtQIPG/MXTCuYV1RQKefQwRO6ejPalQWvjfophQlFoJBeubXFn+hEJoILH6tJgtfq7AwRUG
 4sDdYkjMLM3/f56QJ7PU8kSN9XC7McJOGCuBPvH4ivt1UL++D0sMYeRZbt/6KUb2K9LyJPPYL
 PnBnZY7DAHHQ+xB84UNs1+cXIXZqcBc4sjj34UmpUgRt3G+KyCswqvmB2wfKoYmJFOXUgzIbY
 18jsniE4qjUFBpb7SGQoZzcvXjqt9rh9/jX1RhhB6pK8itSyo6YrV6UrKZWWPwWhHS3SVl81e
 Wm1brrTqtGANKLv+NkVjtJUWnAe3zzdW2OECUFaiC1n1DzXTnQGXTWa+kfSdMW0BSd5OIGCng
 LXuXjGICE8MQqbpDTXchZPxsNN3g1pPih+5zA3qDE/7O5lfJxjN5PZJM5YeW4CNbHFgInAObd
 h9MwilORzVLweCLlgU6pkLmZ1ZRNRRbyyfxSZOUf9kFa+MOdoC9igRTR2grRQOEDreT+5Ox5N
 noCxAQuIZJzuK189o6kiuBiY0sqGOHKw1B7q/X4ths0s/tKHiSXMvxdsGzM/lBPKvs9P8l7g0
 p6SM/xOH1pECZ3vrlpxIH1dWnbqu9JceyDB1WNcFPcQgS1h8eHJoUFaIFGiHcfWN5D/H/uheR
 JdNbdJed3iLva+ZPlHIifwaz9fi/T8qBIrfLJX1vmf2ZFHb93yAAEHEjQrl9h0PCc7kvOkh+ 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294124>

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

This iteration addresses Junio's most recent round of concerns. Oh, and
while at it, it also avoids setting attributes unnecessarily.


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

Published-As: https://github.com/dscho/git/releases/tag/hide-dotgit-v3
Interdiff vs v2:

 diff --git a/cache.h b/cache.h
 index 743b081..5f72f59 100644
 --- a/cache.h
 +++ b/cache.h
 @@ -704,7 +704,7 @@ extern int auto_comment_line_char;
  enum hide_dotfiles_type {
  	HIDE_DOTFILES_FALSE = 0,
  	HIDE_DOTFILES_TRUE,
 -	HIDE_DOTFILES_DOTGITONLY,
 +	HIDE_DOTFILES_DOTGITONLY
  };
  extern enum hide_dotfiles_type hide_dotfiles;
  
 diff --git a/compat/mingw.c b/compat/mingw.c
 index 3ecde84..a8218e6 100644
 --- a/compat/mingw.c
 +++ b/compat/mingw.c
 @@ -318,12 +318,12 @@ static inline int needs_hiding(const char *path)
  
  static int set_hidden_flag(const wchar_t *path, int set)
  {
 -	DWORD attribs = GetFileAttributesW(path);
 +	DWORD original = GetFileAttributesW(path), modified;
  	if (set)
 -		attribs |= FILE_ATTRIBUTE_HIDDEN;
 +		modified = original | FILE_ATTRIBUTE_HIDDEN;
  	else
 -		attribs &= ~FILE_ATTRIBUTE_HIDDEN;
 -	if (SetFileAttributesW(path, attribs))
 +		modified = original & ~FILE_ATTRIBUTE_HIDDEN;
 +	if (original == modified || SetFileAttributesW(path, modified))
  		return 0;
  	errno = err_win_to_posix(GetLastError());
  	return -1;
 @@ -377,7 +377,7 @@ int mingw_open (const char *filename, int oflags, ...)
  		if (fd < 0 && errno == EACCES)
  			fd = _wopen(wfilename, oflags & ~O_CREAT, mode);
  		if (fd >= 0 && set_hidden_flag(wfilename, 1))
 -			warning("Could not mark '%s' as hidden.", filename);
 +			warning("could not mark '%s' as hidden.", filename);
  	}
  	return fd;
  }
 @@ -419,12 +419,12 @@ FILE *mingw_fopen (const char *filename, const char *otype)
  		xutftowcs(wotype, otype, ARRAY_SIZE(wotype)) < 0)
  		return NULL;
  	if (hide && !access(filename, F_OK) && set_hidden_flag(wfilename, 0)) {
 -		error("Could not unhide %s", filename);
 +		error("could not unhide %s", filename);
  		return NULL;
  	}
  	file = _wfopen(wfilename, wotype);
  	if (file && hide && set_hidden_flag(wfilename, 1))
 -		warning("Could not mark '%s' as hidden.", filename);
 +		warning("could not mark '%s' as hidden.", filename);
  	return file;
  }
  
 @@ -439,12 +439,12 @@ FILE *mingw_freopen (const char *filename, const char *otype, FILE *stream)
  		xutftowcs(wotype, otype, ARRAY_SIZE(wotype)) < 0)
  		return NULL;
  	if (hide && !access(filename, F_OK) && set_hidden_flag(wfilename, 0)) {
 -		error("Could not unhide %s", filename);
 +		error("could not unhide %s", filename);
  		return NULL;
  	}
  	file = _wfreopen(wfilename, wotype, stream);
  	if (file && hide && set_hidden_flag(wfilename, 1))
 -		warning("Could not mark '%s' as hidden.", filename);
 +		warning("could not mark '%s' as hidden.", filename);
  	return file;
  }
  

-- 
2.8.2.463.g99156ee
