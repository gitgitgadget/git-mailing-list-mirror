From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 4/4] gc: remove broken symrefs
Date: Mon, 28 Sep 2015 11:49:50 -0700
Message-ID: <xmqqh9mecrap.fsf@gitster.mtv.corp.google.com>
References: <xmqqr3lnuzqu.fsf@gitster.mtv.corp.google.com>
	<cover.1443448748.git.johannes.schindelin@gmx.de>
	<fb29b39adf14a702c5127d722d86647a3dc9c891.1443448748.git.johannes.schindelin@gmx.de>
	<xmqqpp12croq.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Sep 28 20:49:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZgdUq-0004BZ-Lz
	for gcvg-git-2@plane.gmane.org; Mon, 28 Sep 2015 20:49:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751255AbbI1Stw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Sep 2015 14:49:52 -0400
Received: from mail-pa0-f47.google.com ([209.85.220.47]:36240 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751165AbbI1Stw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Sep 2015 14:49:52 -0400
Received: by pablk4 with SMTP id lk4so84686290pab.3
        for <git@vger.kernel.org>; Mon, 28 Sep 2015 11:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=r17k1b7qAk/n7uBE3LznVMIiGYjq/RDKlqjFOrrK1Fk=;
        b=sC+hSB470KoWg8nDwCQABKPsZE0oDHE3hAET03+SOTBJskicACyIW+1Aiz+oyNxFOW
         fPyeQBkjCtg6LPwio4EiMtyMGmpoEtltjf4DbzuIisc35Un6oIdEF/jGfLAEoZZ4Xl5T
         Tl0oOo5qw12yQtCQaB2UrCGoLMporSN96LVO7mLkPwMud9uSDLe0uUreTkOrBuEzy5+m
         ysBpbKBgkb68Am9DnrMq1zgEVQJDq6wIvXsQ0XXRk+OlWGZj9nFnHqLL2Cqwyvdhupd2
         kq+v0eHfcfMq9An9sHotNfiJ4FxRuor4sF0cl9rMUBJk8XyVhf/X+jQeKYXBdpaIEsyz
         vbTA==
X-Received: by 10.66.157.137 with SMTP id wm9mr28596007pab.30.1443466191482;
        Mon, 28 Sep 2015 11:49:51 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:66:24f2:2685:8011])
        by smtp.gmail.com with ESMTPSA id fm5sm20917747pab.24.2015.09.28.11.49.50
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 28 Sep 2015 11:49:50 -0700 (PDT)
In-Reply-To: <xmqqpp12croq.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Mon, 28 Sep 2015 11:41:25 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278743>

Junio C Hamano <gitster@pobox.com> writes:

> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
>
>> When encountering broken symrefs, such as a stale remote HEAD (which can
>> happen if the active branch was renamed in the remote), it is more
>> helpful to remove those symrefs than to exit with an error.
>
> I think this depends on the perspective.  One side of me says that a
> remote HEAD that points at refs/remotes/origin/topic that no longer
> exists is still giving me a valuable information and it should take
> a conscious action by the user to remove it, or evne better to
> repoint it to a more useful place.  And from that point of view,
> removing is not all that helpful.  Keeping them and not allowing
> them to exit with an error would be a real improvement.
>
> On the other hand, I can certainly understand a view that considers
> that such a dangling symbolic ref is merely a cruft like any other
> cruft, and "gc" is all about removing cruft.
>
> It just feels to me that this is a bit more valuable than other
> kinds of cruft, but maybe it is just me.

Sorry, it is a bad habit of me to send out without concluding
remark, leaving the recipient hanging without knowing what the next
step should be.

I meant to say that I plan to, and I indeed did, queue these 4
without changes.  I am not opposed to the removal so strongly to
reject [4/4].

The above comment was that I just do not know if this is the right
thing to do, or it will be hurting users.

Thanks.

>
>>
>> This fixes https://github.com/git-for-windows/git/issues/423
>>
>> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
>> ---
>>  builtin/prune.c | 12 +++++++++++-
>>  t/t6500-gc.sh   |  2 +-
>>  2 files changed, 12 insertions(+), 2 deletions(-)
>>
>> diff --git a/builtin/prune.c b/builtin/prune.c
>> index d6f664f..337b12a 100644
>> --- a/builtin/prune.c
>> +++ b/builtin/prune.c
>> @@ -6,6 +6,7 @@
>>  #include "reachable.h"
>>  #include "parse-options.h"
>>  #include "progress.h"
>> +#include "refs.h"
>>  
>>  static const char * const prune_usage[] = {
>>  	N_("git prune [-n] [-v] [--expire <time>] [--] [<head>...]"),
>> @@ -100,6 +101,7 @@ static void remove_temporary_files(const char *path)
>>  int cmd_prune(int argc, const char **argv, const char *prefix)
>>  {
>>  	struct rev_info revs;
>> +	struct string_list broken_symrefs = STRING_LIST_INIT_DUP;
>>  	struct progress *progress = NULL;
>>  	const struct option options[] = {
>>  		OPT__DRY_RUN(&show_only, N_("do not remove, show only")),
>> @@ -110,6 +112,7 @@ int cmd_prune(int argc, const char **argv, const char *prefix)
>>  		OPT_END()
>>  	};
>>  	char *s;
>> +	int i;
>>  
>>  	expire = ULONG_MAX;
>>  	save_commit_buffer = 0;
>> @@ -136,7 +139,14 @@ int cmd_prune(int argc, const char **argv, const char *prefix)
>>  	if (show_progress)
>>  		progress = start_progress_delay(_("Checking connectivity"), 0, 0, 2);
>>  
>> -	mark_reachable_objects(&revs, 1, expire, progress, NULL);
>> +	revs.ignore_missing = 1;
>> +	mark_reachable_objects(&revs, 1, expire, progress, &broken_symrefs);
>> +	for (i = 0; i < broken_symrefs.nr; i++) {
>> +		char *path = broken_symrefs.items[i].string;
>> +		printf("Removing stale ref %s\n", path);
>> +		if (!show_only && delete_ref(path, NULL, REF_NODEREF))
>> +			die("Could not remove stale ref %s", path);
>> +	}
>>  	stop_progress(&progress);
>>  	for_each_loose_file_in_objdir(get_object_directory(), prune_object,
>>  				      prune_cruft, prune_subdir, NULL);
>> diff --git a/t/t6500-gc.sh b/t/t6500-gc.sh
>> index b736774..0ae4271 100755
>> --- a/t/t6500-gc.sh
>> +++ b/t/t6500-gc.sh
>> @@ -30,7 +30,7 @@ test_expect_success 'gc -h with invalid configuration' '
>>  	test_i18ngrep "[Uu]sage" broken/usage
>>  '
>>  
>> -test_expect_failure 'gc removes broken refs/remotes/<name>/HEAD' '
>> +test_expect_success 'gc removes broken refs/remotes/<name>/HEAD' '
>>  	git init remote &&
>>  	(
>>  		cd remote &&
