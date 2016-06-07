From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 1/4] bisect--helper: `bisect_clean_state` shell function
 in C
Date: Tue, 7 Jun 2016 18:31:02 -0400
Message-ID: <CAPig+cTqk0d60Omsm12RXF2uzoxoPjbqHj7V8Y=6Uu+fH5b43Q@mail.gmail.com>
References: <20160607205454.22576-1-pranit.bauva@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Lars Schneider <larsxschneider@gmail.com>
To: Pranit Bauva <pranit.bauva@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 08 00:33:04 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bAPX2-0008VP-Qw
	for gcvg-git-2@plane.gmane.org; Wed, 08 Jun 2016 00:31:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423368AbcFGWbH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jun 2016 18:31:07 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:35081 "EHLO
	mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932540AbcFGWbG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jun 2016 18:31:06 -0400
Received: by mail-it0-f68.google.com with SMTP id z123so15614646itg.2
        for <git@vger.kernel.org>; Tue, 07 Jun 2016 15:31:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=hQsePz2M5VJNc/4MB1Jc+7RhA4nGwwx0iJ6tUtKD0Ac=;
        b=Q4kWsW76t2VUAXfF8wdI7CprGPk0Za2IHdghB9KOIPe+DYTCcG5YJfZCzyQOdsdrr6
         zxWRE9nmuSHaLG+I0N/YhHEqdtytOCXfRerF88sYABAgmh1aUHAiGDdSRXBX71zrD/jc
         Gtn1VniTeszS7PjiLA2VFuMk0fhNCWiImRXuys/BsxrNv+8f3+Fj408z1LciyqyFr/OQ
         5kM5/MWqWCI5vUxTfVMGcvL0215OheF8Vbxt+0mRNjsDIfypiKALytaArugPKpqUpMtn
         yiqRyQCjFlWxSwv6Pz7/o8llYHEmj/8LU26SYTRGXjcvX1+8ghzyeYEk2uQpzw0hkxAn
         QUcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=hQsePz2M5VJNc/4MB1Jc+7RhA4nGwwx0iJ6tUtKD0Ac=;
        b=bbHL8M+C2TF7R3tSUHVSgf21FTC/OaOD0eczWfkhqnvj6VG0bA6uXUried+rmYVvz4
         u4rBZfRyAk3CzH83CSAEi5DT55J4s39ve+71nnrLey9Vtif0j7agzCOzXqfN++rLOooh
         sk5j73tqKLh01YCt1cAYd8N4g5iY7DX1MrmT/nGdJN11UwDw9YWryN2Wur/jPau3Fy1U
         lAZLB7te8sPFcb8MayB3MQPcuGdkiE9T4c7ZcSU6HZQlk7Om9wVGU/nFCd8/b2GQm74H
         x2XuxVLvfibGtG1OByEg8qnufM55MqaJNildDptKm5U9PGiBlRxp4wc94e/HnSnbyGvx
         0sUw==
X-Gm-Message-State: ALyK8tKsVfZ9EOwYftPGRX2s3RqISIT+0d94k9VONCA2tWzTc/tXAlJumMMgcMcoocIkVilEnfXmtMf68zDj1w==
X-Received: by 10.107.132.40 with SMTP id g40mr3762723iod.34.1465338663014;
 Tue, 07 Jun 2016 15:31:03 -0700 (PDT)
Received: by 10.79.0.30 with HTTP; Tue, 7 Jun 2016 15:31:02 -0700 (PDT)
In-Reply-To: <20160607205454.22576-1-pranit.bauva@gmail.com>
X-Google-Sender-Auth: n_3X5fvtmXOb1-hn864-ccUbAC8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296741>

On Tue, Jun 7, 2016 at 4:54 PM, Pranit Bauva <pranit.bauva@gmail.com> wrote:
> Reimplement `bisect_clean_state` shell function in C and add a
> `bisect-clean-state` subcommand to `git bisect--helper` to call it from
> git-bisect.sh .
> [...]
> Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
> ---
> diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
> @@ -78,11 +87,43 @@ static int write_terms(const char *bad, const char *good)
> +int mark_for_removal(const char *refname, const struct object_id *oid,
> +                      int flag, void *cb_data)
> +{
> +       struct string_list *refs = cb_data;
> +       char *ref = xstrfmt("refs/bisect/%s", refname);

Here you're allocating a string...

> +       string_list_append(refs, ref);
> +       return 0;
> +}
> +
> +int bisect_clean_state(void)
> +{
> +       int result = 0;
> +       struct string_list refs_for_removal = STRING_LIST_INIT_DUP;
> +       for_each_ref_in("refs/bisect/", mark_for_removal, (void *) &refs_for_removal);

...and the allocated string gets inserted into a string_list which
itself duplicates the string (STRING_LIST_INIT_DUP), so this is
leaking the string you created with xstrfmt(), isn't it?

> +       string_list_append(&refs_for_removal, "BISECT_HEAD");
> +       result |= delete_refs(&refs_for_removal);

Not sure I understand the point of using |= here rather than merely =
since this is the only place 'result' is assigned in this function.

> +       string_list_clear(&refs_for_removal, 0);
> +       remove_path(git_path_bisect_expected_rev());
> +       remove_path(git_path_bisect_ancestors_ok());
> +       remove_path(git_path_bisect_log());
> +       remove_path(git_path_bisect_names());
> +       remove_path(git_path_bisect_run());
> +       remove_path(git_path_bisect_write_terms());
> +       /* Cleanup head-name if it got left by an old version of git-bisect */
> +       remove_path(git_path_head_name());
> +       /* Cleanup BISECT_START last */
> +       remove_path(git_path_bisect_start());

The BISECT_START comment merely repeats what the code itself already
says. I realize that you merely copied this from the shell code, but
it isn't helpful in its current form. Much more helpful would be to
explain *why* this needs to be done last. Perhaps the commit message
of the commit which introduced the comment originally would give a
clue (I haven't checked).

> +       return result;
> +}
> diff --git a/git-bisect.sh b/git-bisect.sh
> @@ -430,27 +430,7 @@ bisect_reset() {
> -bisect_clean_state() {
> -       # There may be some refs packed during bisection.

This comment doesn't seem to be reproduced in the C version. Should it
be? Is it no longer relevant in the C version? What does it mean
exactly?

> -       git for-each-ref --format='%(refname) %(objectname)' refs/bisect/\* |
> -       while read ref hash
> -       do
> -               git update-ref -d $ref $hash || exit
> -       done
> -       rm -f "$GIT_DIR/BISECT_EXPECTED_REV" &&
> -       rm -f "$GIT_DIR/BISECT_ANCESTORS_OK" &&
> -       rm -f "$GIT_DIR/BISECT_LOG" &&
> -       rm -f "$GIT_DIR/BISECT_NAMES" &&
> -       rm -f "$GIT_DIR/BISECT_RUN" &&
> -       rm -f "$GIT_DIR/BISECT_TERMS" &&
> -       # Cleanup head-name if it got left by an old version of git-bisect
> -       rm -f "$GIT_DIR/head-name" &&
> -       git update-ref -d --no-deref BISECT_HEAD &&
> -       # clean up BISECT_START last
> -       rm -f "$GIT_DIR/BISECT_START"
> +       git bisect--helper --bisect-clean-state || exit
>  }
