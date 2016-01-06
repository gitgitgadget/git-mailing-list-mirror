From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v2 0/2] Correctly handle transient files in shared
 repositories
Date: Wed, 6 Jan 2016 14:09:36 +0100 (CET)
Message-ID: <cover.1452085713.git.johannes.schindelin@gmx.de>
References: <4aa11f02f4de113bf38152b8815658da42690f43.1450549280.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org, Yaroslav Halchenko <yoh@onerussian.com>,
	=?ISO-8859-15?Q?SZEDER_G=E1bor?= <szeder@ira.uka.de>,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 06 14:10:16 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aGnqx-0004dP-DN
	for gcvg-git-2@plane.gmane.org; Wed, 06 Jan 2016 14:10:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752007AbcAFNKA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Jan 2016 08:10:00 -0500
Received: from mout.gmx.net ([212.227.15.19]:59733 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751601AbcAFNJ6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jan 2016 08:09:58 -0500
Received: from virtualbox ([37.24.143.74]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0Ltqb7-1a6sLP0hoT-011BuP; Wed, 06 Jan 2016 14:09:38
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <4aa11f02f4de113bf38152b8815658da42690f43.1450549280.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:muUvRmua1HXgXnFGGeiYgic5RUSxBvG60UJc/B7Tjkc9CL6lpSj
 B3aiIz5pchkSqjWZlfGXnXVQP+mGk/MDiF/mj2+Ib68HA0TcGLJB7ZCovOE2txxZiEfFtbc
 i8mRNch7betTOKjHxSg1YLrQovsG9UX1hhDcIvR2+JwIeaY/w9KJoc7hnbcA5Rko9Y0XRsZ
 MRSsLUDRwJkDuTT/hv3Vg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:e/SDyFqLIbU=:0aS8JB52DsFQcgs7l3KcgP
 FJF5yQx4q2pG3WAtyCiYRhbkvXMqsurx8W1CN52fsowicMUpUbBEB2RgC/Fq/RVI7eyJTEtIL
 PIKy8zQAKaz8f0HVUoAmeq8nodC0JKndQ97FDMsrl7vQlbz/SUvU7Df3uZb/cHCrGoMBKxRKk
 JM172CFxkA0H3GOo2TKjQMWjVWjrltuQ3l/kgqOYMXLpEmZRt4/YumfPn2tO3sjT+AjKS0XFk
 D5p2N/PVYK/ge90ENE5fYQxHawT1Zk67XGM598V+phb1n7IfYK0x24CAXkWdZrg1bQx9/4roQ
 7HMFYGvVcQcYEb/6YouB2rgjyj3+/Zo73vB1LRPJ7efuHrhXUPlVNzUdlNhdSGFYTcbihlFrG
 Tv8APxhFYhE+N6D+qvlr3RMqXnpDa3bjNwjfVtHARmQhOCw1KgJhmKLVeu1JZLuYvuf/VzJ0s
 U5ZAnUFYyXmjy+5/FLxcHTREZNL8oISHg/FOhFHB4ejLtngrKfZQ6FTjmWi6lbpHp5RlNodyo
 Y8V2h60vkf3v/sVKub+oe0SXSmeFcWMA1UV1Q9cSgoaBrc1h+hgcWbjD8dk7I9ZPcegEHFh07
 dHkfDB/u6JYh148Uhl+2HcIzq/M2cGbZbpD9STgnBgx23XsdMC5Blrrwg1Kut43B4uJ7bb8ai
 Pgd/bL/CQafsCy+dsVVH4nGnrucsOE7iViNsV+3EO62bkzQSnvad4cgvOBgK5MwhWW24Gw2xE
 Jz9ZnN01eKmWM8RKzIw/u5WbcfdjsiM1cn3HN4+sSXxSoKalICFLQpb/g2MROIRPG/Z6rjYT 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283444>

Transient files, e.g. commit messages, are writable only by the owner,
even in shared repositories, to avoid interference between competing
users working on the same files.

These files are typically not deleted after use. As a consequence, we
have to delete such files before writing when they are owned by someone
else than the current user.

Reported-by: Yaroslav Halchenko <yoh@onerussian.com>


Johannes Schindelin (2):
  commit: allow editing the commit message even in shared repos
  Handle more file writes correctly in shared repos

 builtin/commit.c      |  2 +-
 builtin/fast-export.c |  2 +-
 builtin/fetch.c       |  2 +-
 git-compat-util.h     |  1 +
 wrapper.c             | 13 +++++++++++++
 5 files changed, 17 insertions(+), 3 deletions(-)

Interdiff vs v1:

 diff --git a/builtin/commit.c b/builtin/commit.c
 index 3bfd457..89bf6ad 100644
 --- a/builtin/commit.c
 +++ b/builtin/commit.c
 @@ -761,7 +761,7 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
  		hook_arg2 = "";
  	}
  
 -	s->fp = fopen(git_path(commit_editmsg), "w");
 +	s->fp = fopen_for_writing(git_path(commit_editmsg));
  	if (s->fp == NULL)
  		die_errno(_("could not open '%s'"), git_path(commit_editmsg));
  
 @@ -905,7 +905,6 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
  	strbuf_release(&committer_ident);
  
  	fclose(s->fp);
 -	adjust_shared_perm(git_path(commit_editmsg));
  
  	/*
  	 * Reject an attempt to record a non-merge empty commit without
 diff --git a/builtin/fast-export.c b/builtin/fast-export.c
 index d9ac5d8..2471297 100644
 --- a/builtin/fast-export.c
 +++ b/builtin/fast-export.c
 @@ -880,7 +880,7 @@ static void export_marks(char *file)
  	FILE *f;
  	int e = 0;
  
 -	f = fopen(file, "w");
 +	f = fopen_for_writing(file);
  	if (!f)
  		die_errno("Unable to open marks file %s for writing.", file);
  
 diff --git a/builtin/fetch.c b/builtin/fetch.c
 index 586840d..33f04c1 100644
 --- a/builtin/fetch.c
 +++ b/builtin/fetch.c
 @@ -840,7 +840,7 @@ static void check_not_current_branch(struct ref *ref_map)
  static int truncate_fetch_head(void)
  {
  	const char *filename = git_path_fetch_head();
 -	FILE *fp = fopen(filename, "w");
 +	FILE *fp = fopen_for_writing(filename);
  
  	if (!fp)
  		return error(_("cannot open %s: %s\n"), filename, strerror(errno));
 diff --git a/git-compat-util.h b/git-compat-util.h
 index 2da0a75..e8f2867 100644
 --- a/git-compat-util.h
 +++ b/git-compat-util.h
 @@ -733,6 +733,7 @@ extern int xmkstemp_mode(char *template, int mode);
  extern int odb_mkstemp(char *template, size_t limit, const char *pattern);
  extern int odb_pack_keep(char *name, size_t namesz, const unsigned char *sha1);
  extern char *xgetcwd(void);
 +extern FILE *fopen_for_writing(const char *path);
  
  #define REALLOC_ARRAY(x, alloc) (x) = xrealloc((x), (alloc) * sizeof(*(x)))
  
 diff --git a/wrapper.c b/wrapper.c
 index b43d437..29a45d2 100644
 --- a/wrapper.c
 +++ b/wrapper.c
 @@ -391,6 +391,19 @@ FILE *xfdopen(int fd, const char *mode)
  	return stream;
  }
  
 +FILE *fopen_for_writing(const char *path)
 +{
 +	FILE *ret = fopen(path, "w");
 +
 +	if (!ret && errno == EPERM) {
 +		if (!unlink(path))
 +			ret = fopen(path, "w");
 +		else
 +			errno = EPERM;
 +	}
 +	return ret;
 +}
 +
  int xmkstemp(char *template)
  {
  	int fd;

-- 
2.6.3.windows.1.300.g1c25e49
