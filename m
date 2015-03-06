From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] log: decorate detached HEAD differently
Date: Fri, 06 Mar 2015 11:03:40 -0800
Message-ID: <xmqq61aeymlv.fsf@gitster.dls.corp.google.com>
References: <CAPc5daWz-Xa7q6f9RzgTP4has8DcCG4QgK7SMGNbH6KGnEyr2Q@mail.gmail.com>
	<015d6992d2c2165045117f763d9ce3131979c2db.1425658434.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Julien Cretel <j.cretel@umail.ucc.ie>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Mar 06 20:03:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YTxXI-0005nW-ER
	for gcvg-git-2@plane.gmane.org; Fri, 06 Mar 2015 20:03:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755902AbbCFTDo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Mar 2015 14:03:44 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:65367 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755595AbbCFTDn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Mar 2015 14:03:43 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B10663D973;
	Fri,  6 Mar 2015 14:03:42 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Um0NEs4vOwpl6XsCKqMfO7J5bEQ=; b=kGCDoV
	RtPeuZTyNKVHL3VpjvzDg+stbL0IYy+MzwvPjbsq6rMfo44tLNSQXfpi3Tw7EKrw
	ggROpZ69CXWtu19s2arveWz8YJG7SUK43jfhWQ76dVqBx0ib2YU6sYEB9ghP1ukM
	8esXbmy5d6KBHmJ1VxwqpVnhje+AHZ7nYDnfY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=yaHQY51q6lmfB+cT1I02j8isC66FlLip
	H5HVU1IAZHUM50rHhdiw9rM9HDxvzKp0LTFFojbtloMWY+Pth4Ow5Un+ertdOrX9
	Kg9OgBU32srjDn4MG6aMNGK4qFXW8EaO2B3SmD+C109vb/ViskEuDImY8jbQKIzO
	KCnygYyC6cw=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A82853D972;
	Fri,  6 Mar 2015 14:03:42 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4E4013D971;
	Fri,  6 Mar 2015 14:03:41 -0500 (EST)
In-Reply-To: <015d6992d2c2165045117f763d9ce3131979c2db.1425658434.git.git@drmicha.warpmail.net>
	(Michael J. Gruber's message of "Fri, 6 Mar 2015 17:15:16 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 80ECF1FE-C433-11E4-B2AA-29999F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264953>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> "git status" and "git branch" let the user know when the HEAD is
> detached, as well as the current branch, while "git log --decorate" does not.
>
> Change the decoration by a non-detached HEAD pointing to branch foo to
> "HEAD->foo". This can be seen as giving more information about the
> decoration item itself in the same way as we prefix tags by "tag: ".
>
> Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
> ---
>
> Notes:
>     v2 decorates the HEAD pointing to master as "HEAD->master", a detached
>     HEAD just as "HEAD". The "->" hopefully conveys the symlink nature - a
>     "=" would be confusing.
>     
>     Somehow I still prefer "detached HEAD", dunno. Maybe in addition?
>     
>     Note that now a checked branch is listed twice, once as target of the
>     HEAD, once as branch: They are two different refs and colored differently.

The pointee of HEAD would always be branch and will always appear on
the output when you show HEAD->$name_of_that_branch; is it feasible
to drop the duplicate, I wonder?

>
>  log-tree.c                             | 8 +++++++-
>  t/t4013/diff.log_--decorate=full_--all | 2 +-
>  t/t4013/diff.log_--decorate_--all      | 2 +-
>  t/t4207-log-decoration-colors.sh       | 2 +-
>  4 files changed, 10 insertions(+), 4 deletions(-)
>
> diff --git a/log-tree.c b/log-tree.c
> index 7f0890e..38862bb 100644
> --- a/log-tree.c
> +++ b/log-tree.c
> @@ -118,8 +118,11 @@ static int add_ref_decoration(const char *refname, const unsigned char *sha1, in
>  		type = DECORATION_REF_TAG;
>  	else if (!strcmp(refname, "refs/stash"))
>  		type = DECORATION_REF_STASH;
> -	else if (!strcmp(refname, "HEAD"))
> +	else if (!strcmp(refname, "HEAD")) {
> +		unsigned char junk_sha1[20];
>  		type = DECORATION_REF_HEAD;
> +		refname = resolve_ref_unsafe("HEAD", 0, junk_sha1, NULL);
> +	}
>  
>  	if (!cb_data || *(int *)cb_data == DECORATE_SHORT_REFS)
>  		refname = prettify_refname(refname);
> @@ -198,6 +201,9 @@ void format_decorations_extended(struct strbuf *sb,
>  		strbuf_addstr(sb, decorate_get_color(use_color, decoration->type));
>  		if (decoration->type == DECORATION_REF_TAG)
>  			strbuf_addstr(sb, "tag: ");
> +		else if (decoration->type == DECORATION_REF_HEAD &&
> +			 strcmp(decoration->name, "HEAD"))
> +			strbuf_addstr(sb, "HEAD->");
>  		strbuf_addstr(sb, decoration->name);
>  		strbuf_addstr(sb, color_reset);
>  		prefix = separator;
> diff --git a/t/t4013/diff.log_--decorate=full_--all b/t/t4013/diff.log_--decorate=full_--all
> index 44d4525..3758ae9 100644
> --- a/t/t4013/diff.log_--decorate=full_--all
> +++ b/t/t4013/diff.log_--decorate=full_--all
> @@ -5,7 +5,7 @@ Date:   Mon Jun 26 00:06:00 2006 +0000
>  
>      Rearranged lines in dir/sub
>  
> -commit 59d314ad6f356dd08601a4cd5e530381da3e3c64 (HEAD, refs/heads/master)
> +commit 59d314ad6f356dd08601a4cd5e530381da3e3c64 (HEAD->refs/heads/master, refs/heads/master)
>  Merge: 9a6d494 c7a2ab9
>  Author: A U Thor <author@example.com>
>  Date:   Mon Jun 26 00:04:00 2006 +0000
> diff --git a/t/t4013/diff.log_--decorate_--all b/t/t4013/diff.log_--decorate_--all
> index 27d3eab..df702ae 100644
> --- a/t/t4013/diff.log_--decorate_--all
> +++ b/t/t4013/diff.log_--decorate_--all
> @@ -5,7 +5,7 @@ Date:   Mon Jun 26 00:06:00 2006 +0000
>  
>      Rearranged lines in dir/sub
>  
> -commit 59d314ad6f356dd08601a4cd5e530381da3e3c64 (HEAD, master)
> +commit 59d314ad6f356dd08601a4cd5e530381da3e3c64 (HEAD->master, master)
>  Merge: 9a6d494 c7a2ab9
>  Author: A U Thor <author@example.com>
>  Date:   Mon Jun 26 00:04:00 2006 +0000
> diff --git a/t/t4207-log-decoration-colors.sh b/t/t4207-log-decoration-colors.sh
> index 925f577..0437ff2 100755
> --- a/t/t4207-log-decoration-colors.sh
> +++ b/t/t4207-log-decoration-colors.sh
> @@ -44,7 +44,7 @@ test_expect_success setup '
>  '
>  
>  cat >expected <<EOF
> -${c_commit}COMMIT_ID${c_reset}${c_commit} (${c_HEAD}HEAD${c_reset}${c_commit},\
> +${c_commit}COMMIT_ID${c_reset}${c_commit} (${c_HEAD}HEAD->master${c_reset}${c_commit},\
>   ${c_tag}tag: v1.0${c_reset}${c_commit},\
>   ${c_tag}tag: B${c_reset}${c_commit},\
>   ${c_branch}master${c_reset}${c_commit})${c_reset} B
