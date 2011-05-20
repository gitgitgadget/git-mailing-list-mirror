From: David Aguilar <davvid@gmail.com>
Subject: Re: [FEATURE] difftool to provide meaningful names for temporary
 files
Date: Thu, 19 May 2011 21:32:04 -0700
Message-ID: <20110520043202.GC13582@gmail.com>
References: <BANLkTikC6MhvEiw=7JKscN5iOPFzVGxJzA@mail.gmail.com>
 <BANLkTimn4sYCFrLdPWOypwVNUBR5kMVqxg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Eugene Sajine <euguess@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 20 06:32:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QNHNs-00067t-HN
	for gcvg-git-2@lo.gmane.org; Fri, 20 May 2011 06:32:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935120Ab1ETEcL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 May 2011 00:32:11 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:65203 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934971Ab1ETEcK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 May 2011 00:32:10 -0400
Received: by pvg12 with SMTP id 12so1495932pvg.19
        for <git@vger.kernel.org>; Thu, 19 May 2011 21:32:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=KI4CZic0rADIXrNr0CrxGM/wBHf87lXW/VcLh4GnAeg=;
        b=ack7AbYLRVTEi6CXJzrD4Lv8ara5Xjg4KFZ/LK4TCbGs82lfj742sl4KwJ6gMGs8Xe
         lWogA4brNwTVCTKnIaZrH9NFduOQMxWSvbFcz+h+zXJOSCLudGcfSqTuc7m7OXL8l6cw
         A4Qp9EbvR+BUExFgu0fCpEfOX7kLp0RVoqhzA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=VKnGiEKjslds4S6OP1zvEp2sLHSE41snHGzyIb4YzZkPPZqsdlu4kYXx2hi1DhJ+o5
         N3xrZLymmkG3KBb+sD+lOyZCGCJAeOzd2Q5wC0WSUJrkp4w756uCyGfYBxsP8IwHpIgR
         IW6PFUfzft0WTWRQr/iCGB0ZqSKAY63qFKEqY=
Received: by 10.68.43.72 with SMTP id u8mr2989411pbl.259.1305865929730;
        Thu, 19 May 2011 21:32:09 -0700 (PDT)
Received: from gmail.com (208-106-56-2.static.dsltransport.net [208.106.56.2])
        by mx.google.com with ESMTPS id q20sm2195502pbt.72.2011.05.19.21.32.07
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 19 May 2011 21:32:09 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <BANLkTimn4sYCFrLdPWOypwVNUBR5kMVqxg@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174038>

On Wed, May 18, 2011 at 05:54:02PM -0400, Eugene Sajine wrote:
> Hi,
> 
> I noticed many times already that it is at times confusing to
> determine for new users which file versions are shown where in the
> graphical told like gvimdiff or kompare.
> 
> The problem is that when difftool machinery creates a temporary files
> to show in the editor it is creating them with some random hashes in
> the beginning of the file name.
> 
> Is it possible to make the difftool and mergetool smarter to have them
> to create those temporary files with meaningful names, f.e.:
> 
> If I specify:
> Git difftool master dev
> It will create the files with master and dev prefixes correspondingly,
> it will take the two points names and use them in temp file names.
> Master_file.txt vs dev_file.txt
> 
> If I specify:
> Git difftool
> It could take HEAD and local as name prefixes
> 
> Same for mergetool where it could use HEAD and incoming branch name as
> prefixes or something like that.
> 
> Does it make sense?

That makes sense, but part of the reason why we use
mkstemp() is to make the paths random.

This is better then what it was like before, though --
they used to be completely random! ;-)

I think the randomness is a little bit of a security feature.
I wouldn't want to discourage you from trying to make it better,
though.  Here's how I first improved it.  Maybe you can take
this as a starting point for making it better?

# david@lustrous:~/src/git (master)
% git show 003b33a8ad686ee4a0d0b36635bfd6aba940b24a
commit 003b33a8ad686ee4a0d0b36635bfd6aba940b24a
Author: David Aguilar <davvid@gmail.com>
Date:   Sun May 31 01:35:52 2009 -0700

    diff: generate pretty filenames in prep_temp_blob()
    
    Naturally, prep_temp_blob() did not care about filenames.
    As a result, GIT_EXTERNAL_DIFF and textconv generated
    filenames such as ".diff_XXXXXX".
    
    This modifies prep_temp_blob() to generate user-friendly
    filenames when creating temporary files.
    
    Diffing "name.ext" now generates "XXXXXX_name.ext".
    
    Signed-off-by: David Aguilar <davvid@gmail.com>
    Signed-off-by: Junio C Hamano <gitster@pobox.com>

diff --git a/cache.h b/cache.h
index b8503ad..871c984 100644
--- a/cache.h
+++ b/cache.h
@@ -614,6 +614,8 @@ extern int is_empty_blob_sha1(const unsigned char *sha1);
 
 int git_mkstemp(char *path, size_t n, const char *template);
 
+int git_mkstemps(char *path, size_t n, const char *template, int suffix_len);
+
 /*
  * NOTE NOTE NOTE!!
  *
diff --git a/diff.c b/diff.c
index dcfbcb0..4d0a5b9 100644
--- a/diff.c
+++ b/diff.c
@@ -1964,8 +1964,16 @@ static void prep_temp_blob(const char *path, struct diff_tempfile *temp,
 {
 	int fd;
 	struct strbuf buf = STRBUF_INIT;
+	struct strbuf template = STRBUF_INIT;
+	char *path_dup = xstrdup(path);
+	const char *base = basename(path_dup);
 
-	fd = git_mkstemp(temp->tmp_path, PATH_MAX, ".diff_XXXXXX");
+	/* Generate "XXXXXX_basename.ext" */
+	strbuf_addstr(&template, "XXXXXX_");
+	strbuf_addstr(&template, base);
+
+	fd = git_mkstemps(temp->tmp_path, PATH_MAX, template.buf,
+			strlen(base) + 1);
 	if (fd < 0)
 		die("unable to create temp-file: %s", strerror(errno));
 	if (convert_to_working_tree(path,
@@ -1981,6 +1989,8 @@ static void prep_temp_blob(const char *path, struct diff_tempfile *temp,
 	temp->hex[40] = 0;
 	sprintf(temp->mode, "%06o", mode);
 	strbuf_release(&buf);
+	strbuf_release(&template);
+	free(path_dup);
 }
 
 static struct diff_tempfile *prepare_temp_file(const char *name,
diff --git a/path.c b/path.c
index 8a0a674..047fdb0 100644
--- a/path.c
+++ b/path.c
@@ -139,6 +139,22 @@ int git_mkstemp(char *path, size_t len, const char *template)
 	return mkstemp(path);
 }
 
+/* git_mkstemps() - create tmp file with suffix honoring TMPDIR variable. */
+int git_mkstemps(char *path, size_t len, const char *template, int suffix_len)
+{
+	const char *tmp;
+	size_t n;
+
+	tmp = getenv("TMPDIR");
+	if (!tmp)
+		tmp = "/tmp";
+	n = snprintf(path, len, "%s/%s", tmp, template);
+	if (len <= n) {
+		errno = ENAMETOOLONG;
+		return -1;
+	}
+	return mkstemps(path, suffix_len);
+}
 
 int validate_headref(const char *path)
 {
diff --git a/t/t4020-diff-external.sh b/t/t4020-diff-external.sh
index 0720001..4ea42e0 100755
--- a/t/t4020-diff-external.sh
+++ b/t/t4020-diff-external.sh
@@ -136,6 +136,15 @@ test_expect_success 'GIT_EXTERNAL_DIFF with more than one changed files' '
 	GIT_EXTERNAL_DIFF=echo git diff
 '
 
+test_expect_success 'GIT_EXTERNAL_DIFF generates pretty paths' '
+	touch file.ext &&
+	git add file.ext &&
+	echo with extension > file.ext &&
+	GIT_EXTERNAL_DIFF=echo git diff file.ext | grep ......_file\.ext &&
+	git update-index --force-remove file.ext &&
+	rm file.ext
+'
+
 echo "#!$SHELL_PATH" >fake-diff.sh
 cat >> fake-diff.sh <<\EOF
 cat $2 >> crlfed.txt

-- 
					David
