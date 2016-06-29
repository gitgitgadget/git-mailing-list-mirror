Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6F24820FCF
	for <e@80x24.org>; Wed, 29 Jun 2016 20:41:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751290AbcF2Uls (ORCPT <rfc822;e@80x24.org>);
	Wed, 29 Jun 2016 16:41:48 -0400
Received: from mail-it0-f48.google.com ([209.85.214.48]:38888 "EHLO
	mail-it0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750921AbcF2Ulq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jun 2016 16:41:46 -0400
Received: by mail-it0-f48.google.com with SMTP id h190so53169070ith.1
        for <git@vger.kernel.org>; Wed, 29 Jun 2016 13:40:29 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Nr90x89l3wfy05MxqTc94aGrND/f0eKKvn6U1hrtVHw=;
        b=nSd+9WfDDXbub7/m2PaujobPsvyCnv2oiRcZqozB9jU6gQjTGATq9pb46aR9tugIuJ
         tIYuDBwVpgX6NQyJ1aaf/WLL14AxPePjQQxyEvCGySWIKUthdZfIUhY7G3EU/0NYjHCT
         AQVNWVEz+5GoW+d3kyt2Isy7gdlIFkXN/J+csD/WhR9XAOuZiHzOBdR+yXdpRH3S/zte
         wJYJR0ucz9IxWruDTeU3sp5Z5u3qhLk9ViRIn83b+X7Z9AZw//bSIB+Fg34nMivNLf3P
         V3HJfPf1rvIG0EI19ib8sOfst1KjttcK5tDJp6zXkaYzyWt4myST7dtFBj/dJl0bvkBu
         VTmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Nr90x89l3wfy05MxqTc94aGrND/f0eKKvn6U1hrtVHw=;
        b=BghWblHkHDP5wp7hRugs3gXzchmCIo9QS+rUiFDdC1fsoymo+ZEe+2P0Cov/TR3OfW
         yfJPm2Kg4GKEI2ytOF5GrquHTMCQ3045U4nSBMJxWnnAwu+F6ZUJUwhkqyES1m6w3jH5
         ftkbZCRGWkoyfJ+bTmHUdNDUNzpSYrNJmBljgE/fplWtLbW1Hv5XE/PpITLU4sW3EDE2
         K4yPt+qiq0DStUPQpUMrzjZDkMbt49bDYVkrHCq5ql7bOHgLbDEdxadzx9LUdFH7IL4G
         zlAUiIl1E9OCVUMjaKzn3ulbDwdqNbOlwVt3bSCh0iGA7ttniRtmd9fiqy4IXYO/tS6z
         XalQ==
X-Gm-Message-State: ALyK8tIRvSaOU+jH8fBCsswPjLlNaZinbpvXxhNFHtJYaie5O+aKibT/Tp1qk53gIf5HvpGADq+l8L0/jJ2/h/El
X-Received: by 10.36.69.4 with SMTP id y4mr22145270ita.49.1467232828376; Wed,
 29 Jun 2016 13:40:28 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.136.16 with HTTP; Wed, 29 Jun 2016 13:40:27 -0700 (PDT)
In-Reply-To: <xmqqtwgb52py.fsf@gitster.mtv.corp.google.com>
References: <OF95D98CB6.47969C1C-ONC1257FE1.0058D980-C1257FE1.0059986D@dakosy.de>
 <xmqqd1n0552i.fsf@gitster.mtv.corp.google.com> <xmqqtwgb52py.fsf@gitster.mtv.corp.google.com>
From:	Stefan Beller <sbeller@google.com>
Date:	Wed, 29 Jun 2016 13:40:27 -0700
Message-ID: <CAGZ79kYS=XWBpEBJsj95FV+j+HLxg=5xqwD73618t7ERYrKUfA@mail.gmail.com>
Subject: Re: git pull --rebase should use fast forward merge if possible
To:	Junio C Hamano <gitster@pobox.com>
Cc:	neuling@dakosy.de, "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Wed, Jun 29, 2016 at 10:23 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>>> Is it possible to change the behavior of "git pull
>>> --rebase=true|preserve|interactive" to use a fast forward merge if the
>>> remote branch is ahead and the local branch contains no new commits?
>>
>> Interesting.  I do not think of a reason why we shouldn't.

Me neither.

>>
>> If we were still working in scripted Porcelain, it would have been a
>> five minute hack, perhaps like this.
>>
>>  contrib/examples/git-pull.sh | 8 ++++++++
>>  1 file changed, 8 insertions(+)
>
> ... and if we have to work with built-ins, it becomes a lot larger
> than a five-minute hack, unfortunately.
>
> Something like this may have a chance of working ;-)
>
>  builtin/pull.c | 22 ++++++++++++++++++----
>  1 file changed, 18 insertions(+), 4 deletions(-)
>
> diff --git a/builtin/pull.c b/builtin/pull.c
> index bf3fd3f..777ae56 100644
> --- a/builtin/pull.c
> +++ b/builtin/pull.c
> @@ -878,10 +878,24 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
>                 if (merge_heads.nr > 1)
>                         die(_("Cannot merge multiple branches into empty head."));
>                 return pull_into_void(*merge_heads.sha1, curr_head);
> -       } else if (opt_rebase) {
> -               if (merge_heads.nr > 1)
> -                       die(_("Cannot rebase onto multiple branches."));
> +       }
> +       if (opt_rebase && merge_heads.nr > 1)
> +               die(_("Cannot rebase onto multiple branches."));
> +
> +       if (opt_rebase) {
> +               struct commit_list *list = NULL;
> +               struct commit *merge_head, *head;
> +
> +               head = lookup_commit_reference(orig_head);
> +               commit_list_insert(head, &list);
> +               merge_head = lookup_commit_reference(merge_heads.sha1[0]);

The crashes for merge_heads.nr == 0.
(I did not inspect code further up if this is caught before, I think
it would trigger if
you and the remote are on an initial commit with no parents?)

> +               if (is_descendant_of(merge_head, list)) {
> +                       /* we can fast-forward this without invoking rebase */
> +                       opt_ff = "--ff-only";
> +                       return run_merge();
> +               }
>                 return run_rebase(curr_head, *merge_heads.sha1, rebase_fork_point);
> -       } else
> +       }
> +       else

Keep the style ?

>                 return run_merge();
>  }
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
