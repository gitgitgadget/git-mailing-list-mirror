From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] Teach merge the '[-e|--edit]' option
Date: Fri, 07 Oct 2011 15:15:55 -0700
Message-ID: <7vfwj4tplw.fsf@alter.siamese.dyndns.org>
References: <7vk48gwvyd.fsf@alter.siamese.dyndns.org>
 <1318023997-54810-1-git-send-email-jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	"Todd A. Jacobs" <nospam+listmail@codegnome.org>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Sat Oct 08 00:16:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RCIi3-0001Tw-9I
	for gcvg-git-2@lo.gmane.org; Sat, 08 Oct 2011 00:16:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758602Ab1JGWP6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Oct 2011 18:15:58 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:65074 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754716Ab1JGWP6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Oct 2011 18:15:58 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3068F536D;
	Fri,  7 Oct 2011 18:15:57 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=IbwUl+SPosNFA4cT/SwoNu/j9W8=; b=pbYP5s
	8oMuDcZEJi/Y0nqrg5CSr6rASRLUZXV7C7BoLXnTUDnPkombiNqxozNvPeS0wumW
	h+b6vpR2C5TxW4NNegEJjqqH4fGNDhVMlW7bekIPwuIPNSRMsIR7Bh5oX1IXgvIF
	wX6I8uAvguHmbRDTHSUp0aO1UejxPxXsnm+RU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=r+Lr1PtJLEnD3FKlsr2moVw3bg/Oa6Sy
	6+oae6ooylhLVaEAZkqhKsEfPeGQzgtb6YImZjShGV7E6SQ0RtUj799Lygl9jKUF
	YiJPPfmo6yanPrEVk9v7bR5kHI1hcIBgzqyJS1I4xehaUDCCLC0ZaKjgfKyWACkd
	RXQxdVJHTMM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 28225536C;
	Fri,  7 Oct 2011 18:15:57 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 87C9C5369; Fri,  7 Oct 2011
 18:15:56 -0400 (EDT)
In-Reply-To: <1318023997-54810-1-git-send-email-jaysoffian@gmail.com> (Jay
 Soffian's message of "Fri, 7 Oct 2011 17:46:37 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: EDC16FC2-F131-11E0-A730-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183117>

Jay Soffian <jaysoffian@gmail.com> writes:

> Implemented internally instead of as "git merge --no-commit && git commit"
> so that "merge --edit" is otherwise consistent (hooks, etc) with "merge".
>
> Signed-off-by: Jay Soffian <jaysoffian@gmail.com>
> ---
> On Fri, Oct 7, 2011 at 1:30 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> If we wanted to do this properly, we should update builtin/merge.c to call
>> launch_editor() before it runs commit_tree(), in a way similar to how
>
> I disagree that this is the proper way to do it. --edit is a new option, there's
> no obviously "correct" behavior. You think 'merge --edit' should behave just
> like 'merge', I think 'merge --edit' should behave like 'merge --no-commit &&
> commit'.
>
> The commit performed internally by git-merge is already wildly inconsistent with
> git-commit.

Think and look forward.

You are complaining that the "commit" does not know enough to behave as if
it were a part of the merge command workflow if you split a usual merge
into two steps "merge --no-commit; commit".

How would you make it better? Would you strip all the things usual "merge"
does, so that it would work identically to the split one, losing some hook
support and such, or would you rather make the split case work similar to
the usual merge?

I'd say between "merge" and "merge --no-commit ; commit", the latter is
what needs to be fixed. Viewed that way, why would you even consider
making the new option behave similar to the _wrong_ one?

> I didn't bother with the commit status, it's more code than I wanted
> to deal with duplicating/refactoring from commit.c.

What do you mean by "commit status"? If you mean this patch is incomplete,
it would have been nicer if it were labeled with [PATCH/RFC].

> diff --git a/builtin/merge.c b/builtin/merge.c
> index ee56974371..0dee53b7e4 100644
> --- a/builtin/merge.c
> +++ b/builtin/merge.c
> @@ -46,6 +46,7 @@ static const char * const builtin_merge_usage[] = {
>  
>  static int show_diffstat = 1, shortlog_len, squash;
>  static int option_commit = 1, allow_fast_forward = 1;
> +static int option_edit = 0;

No need to move this into .data segment when it can be in .bss
segment. Drop the unnecessary " = 0" before ";".

> @@ -842,30 +845,54 @@ static void add_strategies(const char *string, unsigned attr)
>  
>  }
>  
> -static void write_merge_msg(void)
> +static void write_merge_msg(struct strbuf *msg)
>  {
>  	int fd = open(git_path("MERGE_MSG"), O_WRONLY | O_CREAT, 0666);
>  	if (fd < 0)
>  		die_errno(_("Could not open '%s' for writing"),
>  			  git_path("MERGE_MSG"));
> -	if (write_in_full(fd, merge_msg.buf, merge_msg.len) != merge_msg.len)
> +	if (write_in_full(fd, msg->buf, msg->len) != msg->len)
>  		die_errno(_("Could not write to '%s'"), git_path("MERGE_MSG"));
>  	close(fd);
>  }
>  
> -static void read_merge_msg(void)
> +static void read_merge_msg(struct strbuf *msg)
>  {
> -	strbuf_reset(&merge_msg);
> -	if (strbuf_read_file(&merge_msg, git_path("MERGE_MSG"), 0) < 0)
> +	strbuf_reset(msg);
> +	if (strbuf_read_file(msg, git_path("MERGE_MSG"), 0) < 0)
>  		die_errno(_("Could not read from '%s'"), git_path("MERGE_MSG"));
>  }
>  
> -static void run_prepare_commit_msg(void)
> +static void write_merge_state();

s/()/(void)/;

Thanks.
