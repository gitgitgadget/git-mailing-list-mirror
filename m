Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 923422036C
	for <e@80x24.org>; Thu,  5 Oct 2017 03:31:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751297AbdJEDbK (ORCPT <rfc822;e@80x24.org>);
        Wed, 4 Oct 2017 23:31:10 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61855 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751223AbdJEDbJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Oct 2017 23:31:09 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C1859AA5E5;
        Wed,  4 Oct 2017 23:31:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=7zM13UzM4UqqoHZkFXzAUfzo3As=; b=TJ8zTG
        L4VH7vAwf7CtSzcaQtofWGQ0RElsED4JSat7jW4Brr4xqU6fvWAxk6eZcujh9vOg
        6oltE7nWUZfEJiGbeoU3igWEUX/63ePKMYCjso8wDQdVqFeDAocGH2WMIDqHEty6
        L5Qr/nG5EflfzfdR+bzakgccmzTsDjk1srCH8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=fYBTE9lQ7IEmm6NYa/LX2vpknC8utg+0
        xFDwb71rqh14hzqSchbhZqOiknF1WDGceym/p+mJIpsuzo/DR7rsHkPhBXGA5m5k
        HRrGWZjuOI4lXkQdRlBNl07Smf+It+GkvlSa34lYpMHgFirhp7JX9ek7o6ahRaUq
        8z77F4XHR0Y=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A9FBDAA5E4;
        Wed,  4 Oct 2017 23:31:08 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1C473AA5E3;
        Wed,  4 Oct 2017 23:31:08 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Cc:     Robert Dailey <rcdailey.lists@gmail.com>, Git <git@vger.kernel.org>
Subject: Re: Line ending normalization doesn't work as expected
References: <CAHd499B5hM9ixnsnwWwB2uyDT10dRQpN473m5QjxH9raHtFXiw@mail.gmail.com>
        <958c9b03-062c-0bea-3b25-939a36659f32@web.de>
        <CAHd499AD5Kgbp-vxXTnEPkb-Mb5oEeXhaRO5kGniDdqmXwd2QQ@mail.gmail.com>
        <88c57b88-ef2c-d7db-15e2-12791d4cb201@web.de>
        <xmqq8tgrhdt0.fsf@gitster.mtv.corp.google.com>
        <CAHd499BCMOcur6NRbKfwd81zpnyzoiVCY54d=UmGpAhbD7AVTA@mail.gmail.com>
        <20171004211734.GA25379@tor.lan>
        <xmqq7ewa9xw6.fsf@gitster.mtv.corp.google.com>
Date:   Thu, 05 Oct 2017 12:31:06 +0900
In-Reply-To: <xmqq7ewa9xw6.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Thu, 05 Oct 2017 10:38:49 +0900")
Message-ID: <xmqqo9pm8e4l.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A02B6DE8-A97D-11E7-BB78-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Both this and its "git read-tree --empty" cousin share a grave
> issue.  The "git add ." step would mean that before doing these
> commands, your working tree must be truly clean, i.e. the paths
> in the filesystem known to the index must match what is in the
> index (modulo the line-ending gotcha you are trying to correct), 
> *AND* there must be *NO* untracked paths you do not want to add
> in the working tree.
>
> That is a reason why we should solve it differently.  Perhaps adding
> a new option "git add --rehash" to tell Git "Hey, you may think some
> paths in the index and in the working tree are identical and no need
> to re-register, but you are WRONG.  For each path in the index,
> remove it and then register the object by hashing the contents from
> the filesystem afresh!" would be the best way to go.

Here is just to illustrate the direction I was heading to in the
above.  This is not even compile tested and I won't guarantee what
corner cases there are, though.

In a true production code, we shouldn't be using string-list with
two loops, but I just didn't want to spend more braincycles worrying
about removing from the list and then adding to it, both inside a
single loop that iterates over it in a mere illustration patch.

The second loop uses a simple "remove then add", but I think it
should rather be a "mark ce that it will _never_ match anything on
the working tree" followed by "add_file_to_cache()".  Currently we
do not have the "mark ce that it never matches" operation that lets
us bypass the comparison with the current cache entry (with safecrlf
thing that interferes), but we can afford to use a (in-core only)
bit in the ce flags word to represent this and plumb it through.
That way, we will still preserve the executable bit from the
original entry, hopefully ;-)


 builtin/add.c | 42 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 41 insertions(+), 1 deletion(-)

diff --git a/builtin/add.c b/builtin/add.c
index 5d5773d5cd..264f84dbe7 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -26,6 +26,7 @@ static const char * const builtin_add_usage[] = {
 };
 static int patch_interactive, add_interactive, edit_interactive;
 static int take_worktree_changes;
+static int rehash;
 
 struct update_callback_data {
 	int flags;
@@ -121,6 +122,41 @@ int add_files_to_cache(const char *prefix,
 	return !!data.add_errors;
 }
 
+static int rehash_tracked_files(const char *prefix, const struct pathspec *pathspec,
+				int flags)
+{
+	struct string_list paths = STRING_LIST_INIT_DUP;
+	struct string_list_item *path;
+	int i, retval = 0;
+
+	for (i = 0; i < active_nr; i++) {
+		struct cache_entry *ce = active_cache[i];
+
+		if (ce_stage(ce))
+			continue; /* do not touch unmerged paths */
+		if (!S_ISREG(ce->ce_mode) && !S_ISLNK(ce->ce_mode))
+			continue; /* do not touch non blobs */
+		if (pathspec && !ce_path_match(ce, pathspec, NULL))
+			continue;
+		string_list_append(&paths, ce->name);
+	}
+
+	for_each_string_list_item(path, &paths) {
+		/*
+		 * Having a blob contaminated with CR will trigger the
+		 * safe-crlf kludge, avoidance of which is the primary
+		 * thing this helper function exists.  Remove it and
+		 * then re-add it.  Note that this may lose executable
+		 * bit on a filesystem that lacks it.
+		 */
+		remove_file_from_cache(path->string);
+		add_file_to_cache(path->string, flags);
+	}
+
+	string_list_clear(&paths, 0);
+	return retval;
+}
+
 static char *prune_directory(struct dir_struct *dir, struct pathspec *pathspec, int prefix)
 {
 	char *seen;
@@ -274,6 +310,7 @@ static struct option builtin_add_options[] = {
 	OPT_BOOL('e', "edit", &edit_interactive, N_("edit current diff and apply")),
 	OPT__FORCE(&ignored_too, N_("allow adding otherwise ignored files")),
 	OPT_BOOL('u', "update", &take_worktree_changes, N_("update tracked files")),
+	OPT_BOOL(0, "rehash", &rehash, N_("really update tracked files")),
 	OPT_BOOL('N', "intent-to-add", &intent_to_add, N_("record only the fact that the path will be added later")),
 	OPT_BOOL('A', "all", &addremove_explicit, N_("add changes from all tracked and untracked files")),
 	{ OPTION_CALLBACK, 0, "ignore-removal", &addremove_explicit,
@@ -498,7 +535,10 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 
 	plug_bulk_checkin();
 
-	exit_status |= add_files_to_cache(prefix, &pathspec, flags);
+	if (rehash)
+		exit_status |= rehash_tracked_files(prefix, &pathspec, flags);
+	else
+		exit_status |= add_files_to_cache(prefix, &pathspec, flags);
 
 	if (add_new_files)
 		exit_status |= add_files(&dir, flags);
