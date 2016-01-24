From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v2 0/1] Let merge-file write out conflict markers with correct
 EOLs
Date: Sun, 24 Jan 2016 11:48:27 +0100 (CET)
Message-ID: <cover.1453632296.git.johannes.schindelin@gmx.de>
References: <cover.1453482052.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org, Beat Bolli <dev+git@drbeat.li>,
	Jeff King <peff@peff.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	=?ISO-8859-15?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jan 24 11:48:47 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aNIDu-00059K-FU
	for gcvg-git-2@plane.gmane.org; Sun, 24 Jan 2016 11:48:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751823AbcAXKsm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Jan 2016 05:48:42 -0500
Received: from mout.gmx.net ([212.227.15.15]:59339 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751314AbcAXKsk (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Jan 2016 05:48:40 -0500
Received: from virtualbox ([37.24.143.74]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0MIdTM-1aPU4l0c5w-002DEa; Sun, 24 Jan 2016 11:48:32
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <cover.1453482052.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:5TPNakWHj0yx4W0mAhsxQMlXM686jxq6CXlApQ3NrS6JwEX491O
 foygqOduKjTohhpqZTQzBM2fWbt2FldBjWwVY0kdt7AQucujM/McbtT56ySvVORwsBih2pP
 0mw1168t0P/ilG/iUCQ5v0ArweR7BHTK3gUTI2rkrVBJ9B3o//i8L5x6xAmKtMGznrzUxsr
 tS6jQkiEYSBKQHtcVMt+g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:E5YB9W5tGGM=:PpWF50Ua7V4Hj4D8JkOO0N
 Lk/Nw7FH1eXyEBfLfVquOMEx9x/LStn6xvBhiQnJSgIJkVRx5XIY5XBqkoa+G7Nz6uelP/jlN
 h3yzuLaOw7Q6dEIUaSvtgF1pCiXjWeIrw6O/BOFJSEL6le+8ymsjoYn59iMJ7vQF5Ak72VizC
 iMfajg4XoC1ykUFVBx13EQus2VuFXVAB8OydINP5DQY7dihCIMKrxJMPpzq0i4RdiV2UoJmbC
 CtUoqC0HXqtt/DrfU8FvM6i3NXmG4zyg0huT0EvY2I+LXqL6HEKfa08qZUVnD7ImlffmLIrjc
 eume1Uy6qFYLRiia5tTYdTLaG9FYwLRFoBtvYLZcrRcj5DQkgfgIVm7xsYVRfEtPvzdyQnjRd
 f/FvPR/xUgyo3bbDQpk+v3VZaVZn6ZvJM+XPsT059mNp7DPAvh/EKhW1yA2Ow3kryqCGJgf9N
 meWKLCyErdTs6nSLFt+gusptM3UhmTtv18zW0RkBWol0RS8aIFBwhI0R0/Pkgk3ovoL0X3ja0
 M8bVB1aBuqLhf1DsAXleVQVmV+R4GECe3oEe9/KvBiJU51U9NyZs+zWAnxILfhiwc9A3oyDQH
 2WLZfK66fxPE0qfjAsfHPxfzb2wRndEasRpInuQvtUt3fOmkKHOGEOwxLVKkTZNmttGcqzNq2
 HZGOaw9JGiIwVs8w6/KXR/Kj1pfLZb9s/JQVVhOyueAy4PicaYHEbqbKC1IZ2QqMiaGyBsVw+
 JR5/OXnKf+K+vwsF2ofDispT63ZfDRSBvQPeMo/ayipL4MO87AjzKhYLQj1E5QPKJtT8Fv0f 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284643>

The original patch was sent by Beat Bolli in
http://thread.gmane.org/gmane.comp.version-control.git/281600

My suggestion to extend it to respect gitattributes led to
changes that broke the original patch. And they were misguided
to begin with (see below).

Since there have been a couple of "What's cooking" mails
containing unheard calls for updates on this patch, I took it
on myself to fix things.

Junio's comment that we might look at blobs containing CR/LF
line endings made me rethink the entire approach, and I am now
convinced that we need to abandon the entire idea to make the
conflict markers depend on config settings or attributes:
after all, I introduced `git merge-file` as a replacement for
GNU merge that can be used *outside* of any repository, by design.

The crucial idea hit me yesterday when I took a step back: all
we need to do is to ensure that the end-of-line style is matched
when *all* input files are LF-only, or when they are all CR/LF.
In all other cases, we have mixed line endings anyway.

And to do that, it is sufficient to look at *one single line
ending* in the context. Technically, it does not even have to be
the context, but the first line endings of the first file would
be enough, however it is so much more pleasant if the conflict
marker's eol matches the one of the preceding line.

To prevent my future self from repeating mistakes, I added a
little bit of background to the commit message.

Since this is a complete rewrite, the interdiff is pretty useless
and only included for the record.


Johannes Schindelin (1):
  merge-file: let conflict markers match end-of-line style of the
    context

 t/t6023-merge-file.sh | 12 +++++++++++
 xdiff/xmerge.c        | 57 +++++++++++++++++++++++++++++++++++++++++++++++----
 2 files changed, 65 insertions(+), 4 deletions(-)

Interdiff vs v1:

 diff --git a/builtin/merge-file.c b/builtin/merge-file.c
 index 9ce830a..5544705 100644
 --- a/builtin/merge-file.c
 +++ b/builtin/merge-file.c
 @@ -81,7 +81,6 @@ int cmd_merge_file(int argc, const char **argv, const char *prefix)
  					argv[i]);
  	}
  
 -	xmp.crlf = eol_for_path(names[0], NULL, 0) == EOL_CRLF;
  	xmp.ancestor = names[1];
  	xmp.file1 = names[0];
  	xmp.file2 = names[2];
 diff --git a/convert.c b/convert.c
 index b458734..814e814 100644
 --- a/convert.c
 +++ b/convert.c
 @@ -758,35 +758,6 @@ static void convert_attrs(struct conv_attrs *ca, const char *path)
  	}
  }
  
 -enum eol eol_for_path(const char *path, const char *src, size_t len)
 -{
 -	struct conv_attrs ca;
 -	struct text_stat stats;
 -
 -	if (!path) {
 -		memset(&ca, 0, sizeof(ca));
 -		ca.crlf_action = CRLF_AUTO;
 -		ca.eol_attr = EOL_UNSET;
 -	} else {
 -		convert_attrs(&ca, path);
 -		if (ca.eol_attr == EOL_UNSET)
 -			ca.eol_attr = output_eol(ca.crlf_action);
 -		if (ca.eol_attr != EOL_UNSET)
 -			return ca.eol_attr;
 -	}
 -	if (!len || (ca.crlf_action != CRLF_AUTO &&
 -				ca.crlf_action != CRLF_GUESS))
 -		return core_eol;
 -	ca.crlf_action = input_crlf_action(ca.crlf_action, ca.eol_attr);
 -	gather_stats(src, len, &stats);
 -	if (ca.crlf_action == CRLF_GUESS && stats.cr > stats.crlf)
 -		return core_eol;
 -	else if (stats.crlf)
 -		return EOL_CRLF;
 -	else
 -		return EOL_LF;
 -}
 -
  int would_convert_to_git_filter_fd(const char *path)
  {
  	struct conv_attrs ca;
 diff --git a/convert.h b/convert.h
 index 1892867..d9d853c 100644
 --- a/convert.h
 +++ b/convert.h
 @@ -33,8 +33,6 @@ enum eol {
  
  extern enum eol core_eol;
  
 -extern enum eol eol_for_path(const char *path, const char *src, size_t len);
 -
  /* returns 1 if *dst was used */
  extern int convert_to_git(const char *path, const char *src, size_t len,
  			  struct strbuf *dst, enum safe_crlf checksafe);
 diff --git a/t/t6023-merge-file.sh b/t/t6023-merge-file.sh
 index a131749..f0cb9ce 100755
 --- a/t/t6023-merge-file.sh
 +++ b/t/t6023-merge-file.sh
 @@ -346,18 +346,16 @@ test_expect_success 'conflict at EOF without LF resolved by --union' \
  	 printf "line1\nline2\nline3x\nline3y" >expect.txt &&
  	 test_cmp expect.txt output.txt'
  
 -test_expect_success 'conflict markers contain CRLF when core.eol=crlf' '
 +test_expect_success 'conflict markers match existing line endings' '
 +	append_cr <nolf-orig.txt >crlf-orig.txt &&
 +	append_cr <nolf-diff1.txt >crlf-diff1.txt &&
 +	append_cr <nolf-diff2.txt >crlf-diff2.txt &&
  	test_must_fail git -c core.eol=crlf merge-file -p \
 -		nolf-diff1.txt nolf-orig.txt nolf-diff2.txt >output.txt &&
 -	test $(sed -n "/\.txt\r$/p" output.txt | wc -l) = 3
 -'
 -
 -test_expect_success 'conflict markers heed gitattributes over core.eol=crlf' '
 -	git config core.eol crlf &&
 -	echo "*.txt eol=lf" >>.gitattributes &&
 +		crlf-diff1.txt crlf-orig.txt crlf-diff2.txt >crlf.txt &&
 +	test $(tr "\015" Q <crlf.txt | grep "\\.txtQ$" | wc -l) = 3 &&
  	test_must_fail git -c core.eol=crlf merge-file -p \
 -		nolf-diff1.txt nolf-orig.txt nolf-diff2.txt >output.txt &&
 -	test $(sed -n "/\.txt\r$/p" output.txt | wc -l) = 0
 +		nolf-diff1.txt nolf-orig.txt nolf-diff2.txt >nolf.txt &&
 +	test $(tr "\015" Q <nolf.txt | grep "\\.txtQ$" | wc -l) = 0
  '
  
  test_done
 diff --git a/xdiff/xdiff.h b/xdiff/xdiff.h
 index a5bea4a..c033991 100644
 --- a/xdiff/xdiff.h
 +++ b/xdiff/xdiff.h
 @@ -122,7 +122,6 @@ typedef struct s_xmparam {
  	int level;
  	int favor;
  	int style;
 -	int crlf;
  	const char *ancestor;	/* label for orig */
  	const char *file1;	/* label for mf1 */
  	const char *file2;	/* label for mf2 */
 diff --git a/xdiff/xmerge.c b/xdiff/xmerge.c
 index 4ff0db4..c852acc 100644
 --- a/xdiff/xmerge.c
 +++ b/xdiff/xmerge.c
 @@ -143,15 +143,56 @@ static int xdl_orig_copy(xdfenv_t *xe, int i, int count, int add_nl, char *dest)
  	return xdl_recs_copy_0(1, xe, i, count, add_nl, dest);
  }
  
 +/*
 + * Returns 1 if the i'th line ends in CR/LF (if it is the last line and
 + * has no eol, the preceding line, if any), 0 if it ends in LF-only, and
 + * -1 if the line ending cannot be determined.
 + */
 +static int is_eol_crlf(xdfile_t *file, int i)
 +{
 +	long size;
 +
 +	if (i < file->nrec - 1)
 +		/* All lines before the last *must* end in LF */
 +		return (size = file->recs[i]->size) > 1 &&
 +			file->recs[i]->ptr[size - 2] == '\r';
 +	if (!file->nrec)
 +		/* Cannot determine eol style from empty file */
 +		return -1;
 +	if ((size = file->recs[i]->size) &&
 +			file->recs[i]->ptr[size - 1] == '\n')
 +		/* Last line; ends in LF; Is it CR/LF? */
 +		return size > 1 &&
 +			file->recs[i]->ptr[size - 2] == '\r';
 +	if (!i)
 +		/* The only line has no eol */
 +		return -1;
 +	/* Determine eol from second-to-last line */
 +	return (size = file->recs[i - 1]->size) > 1 &&
 +		file->recs[i - 1]->ptr[size - 2] == '\r';
 +}
 +
  static int fill_conflict_hunk(xdfenv_t *xe1, const char *name1,
  			      xdfenv_t *xe2, const char *name2,
  			      const char *name3,
 -			      int size, int i, int style, int crlf,
 +			      int size, int i, int style,
  			      xdmerge_t *m, char *dest, int marker_size)
  {
  	int marker1_size = (name1 ? strlen(name1) + 1 : 0);
  	int marker2_size = (name2 ? strlen(name2) + 1 : 0);
  	int marker3_size = (name3 ? strlen(name3) + 1 : 0);
 +	int needs_cr;
 +
 +	/* Match post-images' preceding, or first, lines' end-of-line style */
 +	needs_cr = is_eol_crlf(&xe1->xdf2, m->i1 ? m->i1 - 1 : 0);
 +	if (needs_cr)
 +		needs_cr = is_eol_crlf(&xe2->xdf2, m->i2 ? m->i2 - 1 : 0);
 +	/* Look at pre-image's first line, unless we already settled on LF */
 +	if (needs_cr)
 +		needs_cr = is_eol_crlf(&xe1->xdf1, 0);
 +	/* If still undecided, use LF-only */
 +	if (needs_cr < 0)
 +		needs_cr = 0;
  
  	if (marker_size <= 0)
  		marker_size = DEFAULT_CONFLICT_MARKER_SIZE;
 @@ -161,7 +202,7 @@ static int fill_conflict_hunk(xdfenv_t *xe1, const char *name1,
  			      dest ? dest + size : NULL);
  
  	if (!dest) {
 -		size += marker_size + 1 + crlf + marker1_size;
 +		size += marker_size + 1 + needs_cr + marker1_size;
  	} else {
  		memset(dest + size, '<', marker_size);
  		size += marker_size;
 @@ -170,7 +211,7 @@ static int fill_conflict_hunk(xdfenv_t *xe1, const char *name1,
  			memcpy(dest + size + 1, name1, marker1_size - 1);
  			size += marker1_size;
  		}
 -		if (crlf)
 +		if (needs_cr)
  			dest[size++] = '\r';
  		dest[size++] = '\n';
  	}
 @@ -182,7 +223,7 @@ static int fill_conflict_hunk(xdfenv_t *xe1, const char *name1,
  	if (style == XDL_MERGE_DIFF3) {
  		/* Shared preimage */
  		if (!dest) {
 -			size += marker_size + 1 + crlf + marker3_size;
 +			size += marker_size + 1 + needs_cr + marker3_size;
  		} else {
  			memset(dest + size, '|', marker_size);
  			size += marker_size;
 @@ -191,7 +232,7 @@ static int fill_conflict_hunk(xdfenv_t *xe1, const char *name1,
  				memcpy(dest + size + 1, name3, marker3_size - 1);
  				size += marker3_size;
  			}
 -			if (crlf)
 +			if (needs_cr)
  				dest[size++] = '\r';
  			dest[size++] = '\n';
  		}
 @@ -200,11 +241,11 @@ static int fill_conflict_hunk(xdfenv_t *xe1, const char *name1,
  	}
  
  	if (!dest) {
 -		size += marker_size + 1 + crlf;
 +		size += marker_size + 1 + needs_cr;
  	} else {
  		memset(dest + size, '=', marker_size);
  		size += marker_size;
 -		if (crlf)
 +		if (needs_cr)
  			dest[size++] = '\r';
  		dest[size++] = '\n';
  	}
 @@ -213,7 +254,7 @@ static int fill_conflict_hunk(xdfenv_t *xe1, const char *name1,
  	size += xdl_recs_copy(xe2, m->i2, m->chg2, 1,
  			      dest ? dest + size : NULL);
  	if (!dest) {
 -		size += marker_size + 1 + crlf + marker2_size;
 +		size += marker_size + 1 + needs_cr + marker2_size;
  	} else {
  		memset(dest + size, '>', marker_size);
  		size += marker_size;
 @@ -222,7 +263,7 @@ static int fill_conflict_hunk(xdfenv_t *xe1, const char *name1,
  			memcpy(dest + size + 1, name2, marker2_size - 1);
  			size += marker2_size;
  		}
 -		if (crlf)
 +		if (needs_cr)
  			dest[size++] = '\r';
  		dest[size++] = '\n';
  	}
 @@ -234,7 +275,7 @@ static int xdl_fill_merge_buffer(xdfenv_t *xe1, const char *name1,
  				 const char *ancestor_name,
  				 int favor,
  				 xdmerge_t *m, char *dest, int style,
 -				 int crlf, int marker_size)
 +				 int marker_size)
  {
  	int size, i;
  
 @@ -245,8 +286,8 @@ static int xdl_fill_merge_buffer(xdfenv_t *xe1, const char *name1,
  		if (m->mode == 0)
  			size = fill_conflict_hunk(xe1, name1, xe2, name2,
  						  ancestor_name,
 -						  size, i, style, crlf, m,
 -						  dest, marker_size);
 +						  size, i, style, m, dest,
 +						  marker_size);
  		else if (m->mode & 3) {
  			/* Before conflicting part */
  			size += xdl_recs_copy(xe1, i, m->i1 - i, 0,
 @@ -427,7 +468,6 @@ static int xdl_do_merge(xdfenv_t *xe1, xdchange_t *xscr1,
  	int level = xmp->level;
  	int style = xmp->style;
  	int favor = xmp->favor;
 -	int crlf = xmp->crlf;
  
  	if (style == XDL_MERGE_DIFF3) {
  		/*
 @@ -563,7 +603,7 @@ static int xdl_do_merge(xdfenv_t *xe1, xdchange_t *xscr1,
  		int size = xdl_fill_merge_buffer(xe1, name1, xe2, name2,
  						 ancestor_name,
  						 favor, changes, NULL, style,
 -						 crlf, marker_size);
 +						 marker_size);
  		result->ptr = xdl_malloc(size);
  		if (!result->ptr) {
  			xdl_cleanup_merge(changes);
 @@ -572,7 +612,7 @@ static int xdl_do_merge(xdfenv_t *xe1, xdchange_t *xscr1,
  		result->size = size;
  		xdl_fill_merge_buffer(xe1, name1, xe2, name2,
  				      ancestor_name, favor, changes,
 -				      result->ptr, style, crlf, marker_size);
 +				      result->ptr, style, marker_size);
  	}
  	return xdl_cleanup_merge(changes);
  }

-- 
2.7.0.windows.1.7.g55a05c8
