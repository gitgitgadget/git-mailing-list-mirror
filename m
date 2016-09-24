Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 936B41F935
	for <e@80x24.org>; Sat, 24 Sep 2016 18:55:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932455AbcIXSzi (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Sep 2016 14:55:38 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55652 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1757507AbcIXSzh (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Sep 2016 14:55:37 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8C7E03C0DC;
        Sat, 24 Sep 2016 14:55:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=XOoU41eLXCRaRat3IU45CEwS0O0=; b=Hwl0dS
        rOUOimPC8xiJKqkPsJMM4xQpgOtSOuWbkUE3LUI+Xm6cpjKqmJ5qNf0k0V0IJDRc
        ajGLPSgu5ZQgaLnz9NASwhVOjGKHtq3VVADcM8sKMW90wQpPL2o65l4rHRj/TlPh
        1h11gjlhHjwvjTmMhlvg0f6xG6HUKliBnlpFw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=kP3TW85FRg/kO2xaLVsUPai1iBN1BsBl
        5CYcz7K+/QXuoJWF/vlukPUo4jVYpib/io28EgjV0U0WJhF6f7POBpXPqLMavyP+
        wLkzUweVtJ/mIFnMmI1CN/tHiSyK9rkgplrukMLgcqGAAKui+cJ4e4iK6XxKrLSt
        slrYRRCyAEk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 843383C0DB;
        Sat, 24 Sep 2016 14:55:36 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 081F63C0DA;
        Sat, 24 Sep 2016 14:55:35 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org, git@drmicha.warpmail.net,
        max.nordlund@sqore.com
Subject: Re: [PATCH v2 4/3] init: combine set_git_dir_init() and init_db() into one
References: <xmqqbmzf6e0r.fsf@gitster.mtv.corp.google.com>
        <20160923111206.8596-1-pclouds@gmail.com>
        <xmqqshsqz0s1.fsf@gitster.mtv.corp.google.com>
Date:   Sat, 24 Sep 2016 11:55:33 -0700
In-Reply-To: <xmqqshsqz0s1.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Fri, 23 Sep 2016 15:53:02 -0700")
Message-ID: <xmqq8tuhyvoa.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7A4DD13C-8288-11E6-A6AE-EAAE7A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> I think this 4/3 is not quite enough to fix the damage to the code
> caused by 2/3.
> ...
> after 4/3 is applied, we should be able to remove the global
> variable 2/3 introduced, make init_db() receive that information as
> the return value of set_git_dir_init(), and pass that as a parameter
> to create_default_files().

That would look something like this squashed into 4/3, I think.  I
am not sure if a commit that squashes 2/3, 3/3, 4/3 and this update
together is harder to understand than keeping 2/3, 3/3 and a fixed
4/3 separate, though.  The end result looks much better structured
than before 2/3 is applied to my quick scan-through of the code.

In any case, the log message of 2/3 needs to be updated to retitle
it, I think.  "do not ... more often than necessary" makes it sound
as if we were doing things that did not make any difference in the
end result, wasting cycles.  But what you actually wanted to achieve
was not to "avoid unnecessary work"--doing so gave a broken
behaviour and that was what you were fixing, "do not record broken
core.worktree", perhaps?

The solution (if we squash 2-4 and the fixup below) is to stop
feeding get_git_dir() to needs_work_tree_config(), because the
parameter to the latter is the path to ".git" that presumably is at
the top of the working tree, and get_git_dir() is not that when
"gitdir" file is involved.  So a rewritten log message may say
something like...

    init: do not set unnecessary core.worktree

    The function needs_work_tree_config() that is called from
    create_default_files() is supposed to be fed the path to ".git"
    that looks as if it is at the top of the working tree, and
    decide if that location matches the actual worktree being used.
    This comparison allows "git init" to decide if core.worktree
    needs to be recorded in the working tree.

    In the current code, however, we feed the return value from
    get_git_dir(), which can be totally different from what the
    function expects when "gitdir" file is involved.  Instead of
    giving the path to the ".git" at the top of the working tree, we
    end up feeding the actual path that the file points at.

    This original location of ".git" however is only known to a
    helper function set_git_dir_init() that must be called before
    init_db() is called (they both have only two callsites, one in
    "git init" and the other in "git clone"), and in the current
    code, this original location is not visible to its callers.

    By doing the following two things:

    * Move call to set_git_dir_init() to init_db(), as the two must
      always be called in this order, and adjust its current
      callers.

    * Make set_git_dir_init() return the original location of ".git"
      to the caller, which is init_db(), and have it passed to
      create_default_files() as a new parameter.

   pass the correct location down to needs_work_tree_config() to fix
   this.

This suggests that 2/3, 3/3 and fixed 4/3 could be done in two
logical steps.  The first bullet point can be done as a separate
preparatory step, and on top of that, the second bullet point can be
done as a separate "fix".



 builtin/init-db.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/builtin/init-db.c b/builtin/init-db.c
index ee7942f..527722c 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -23,7 +23,6 @@ static int init_is_bare_repository = 0;
 static int init_shared_repository = -1;
 static const char *init_db_template_dir;
 static const char *git_link;
-static const char *original_git_dir;
 
 static void copy_templates_1(struct strbuf *path, struct strbuf *template,
 			     DIR *dir)
@@ -172,7 +171,8 @@ static int needs_work_tree_config(const char *git_dir, const char *work_tree)
 	return 1;
 }
 
-static int create_default_files(const char *template_path)
+static int create_default_files(const char *template_path,
+				const char *original_git_dir)
 {
 	struct stat st1;
 	struct strbuf buf = STRBUF_INIT;
@@ -312,11 +312,11 @@ static void create_object_directory(void)
 	strbuf_release(&path);
 }
 
-static int set_git_dir_init(const char *git_dir,
-			    const char *real_git_dir,
-			    int exist_ok)
+static char *set_git_dir_init(const char *git_dir,
+			      const char *real_git_dir,
+			      int exist_ok)
 {
-	original_git_dir = xstrdup(real_path(git_dir));
+	char *original_git_dir = xstrdup(real_path(git_dir));
 
 	if (real_git_dir) {
 		struct stat st;
@@ -339,7 +339,7 @@ static int set_git_dir_init(const char *git_dir,
 		git_link = NULL;
 	}
 	startup_info->have_repository = 1;
-	return 0;
+	return original_git_dir;
 }
 
 static void separate_git_dir(const char *git_dir)
@@ -367,9 +367,10 @@ int init_db(const char *git_dir, const char *real_git_dir,
 	    const char *template_dir, unsigned int flags)
 {
 	int reinit;
+	char *original_git_dir;
 
-	set_git_dir_init(git_dir, real_git_dir, flags & INIT_DB_EXIST_OK);
-
+	flags |= INIT_DB_EXIST_OK;
+	original_git_dir = set_git_dir_init(git_dir, real_git_dir, flags);
 	git_dir = get_git_dir();
 
 	if (git_link)
@@ -386,7 +387,7 @@ int init_db(const char *git_dir, const char *real_git_dir,
 	 */
 	check_repository_format();
 
-	reinit = create_default_files(template_dir);
+	reinit = create_default_files(template_dir, original_git_dir);
 
 	create_object_directory();
 
