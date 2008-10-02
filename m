From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH] git commit: Repaint the output format bikeshed (again)
Date: Thu, 02 Oct 2008 07:40:28 +0200
Message-ID: <48E45ECC.8070104@op5.se>
References: <20081001154425.GE21310@spearce.org> <48E3E66E.7020501@op5.se> <20081001220604.GB18058@coredump.intra.peff.net> <20081001223125.GA25267@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Shawn Pearce <spearce@spearce.org>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Oct 02 07:41:48 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KlGwd-0003bJ-Tb
	for gcvg-git-2@gmane.org; Thu, 02 Oct 2008 07:41:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751992AbYJBFkg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Oct 2008 01:40:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751628AbYJBFkg
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Oct 2008 01:40:36 -0400
Received: from mail.op5.se ([193.201.96.20]:53226 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751278AbYJBFkf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Oct 2008 01:40:35 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 76AD224B0008;
	Thu,  2 Oct 2008 07:32:03 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.499
X-Spam-Level: 
X-Spam-Status: No, score=-2.499 tagged_above=-10 required=6.6
	tests=[BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3bSFcetqwaln; Thu,  2 Oct 2008 07:31:59 +0200 (CEST)
Received: from clix.int.op5.se (unknown [172.27.78.18])
	by mail.op5.se (Postfix) with ESMTP id 419FA1B80048;
	Thu,  2 Oct 2008 07:31:59 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.16 (X11/20080723)
In-Reply-To: <20081001223125.GA25267@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97290>

Jeff King wrote:
> On Wed, Oct 01, 2008 at 06:06:04PM -0400, Jeff King wrote:
> 
>> I think I still like your other proposal:
>>
>>   [branch] created b930c4a: "i386: Snib the sprock"
> 
> And here is the patch, since it was sitting uncommitted in my working
> tree. Feel free to ignore.
> 
> BTW, we should apply _something_ since what is currently in next has a
> bug: it lacks a space between "DETACHED commit" and the hash:
> 
>   Created DETACHED commit4fde0d0 (subject line)
> 
> -- >8 --
> reformat informational commit message
> 
> When committing, we print a message like:
> 
>   Created [DETACHED commit] <hash> (<subject>) on <branch>
> 
> The most useful bit of information there (besides the
> detached status, if it is present) is which branch you made
> the commit on. However,  it is sometimes hard to see because
> the subject dominates the line.
> 
> Instead, let's put the most useful information (detached
> status and commit branch) on the far left, with the subject
> (which is least likely to be interesting) on the far right.
> 
> We'll use brackets to offset the branch name so the line is
> not mistaken for an error line of the form "program: some
> sort of error". E.g.,:
> 
>   [jk/bikeshed] created bd8098f: "reformat informational commit message"
> ---

No sign-off.

>  builtin-commit.c |   37 ++++++++++---------------------------
>  1 files changed, 10 insertions(+), 27 deletions(-)
> 
> diff --git a/builtin-commit.c b/builtin-commit.c
> index e4e1448..7a66e5a 100644
> --- a/builtin-commit.c
> +++ b/builtin-commit.c
> @@ -878,35 +878,13 @@ int cmd_status(int argc, const char **argv, const char *prefix)
>  	return commitable ? 0 : 1;
>  }
>  
> -static char *get_commit_format_string(void)
> -{
> -	unsigned char sha[20];
> -	const char *head = resolve_ref("HEAD", sha, 0, NULL);
> -	struct strbuf buf = STRBUF_INIT;
> -
> -	/* use shouty-caps if we're on detached HEAD */
> -	strbuf_addf(&buf, "format:%s", strcmp("HEAD", head) ? "" : "DETACHED commit");
> -	strbuf_addstr(&buf, "%h (%s)");
> -
> -	if (!prefixcmp(head, "refs/heads/")) {
> -		const char *cp;
> -		strbuf_addstr(&buf, " on ");
> -		for (cp = head + 11; *cp; cp++) {
> -			if (*cp == '%')
> -				strbuf_addstr(&buf, "%x25");
> -			else
> -				strbuf_addch(&buf, *cp);
> -		}
> -	}
> -
> -	return strbuf_detach(&buf, NULL);
> -}
> -
>  static void print_summary(const char *prefix, const unsigned char *sha1)
>  {
>  	struct rev_info rev;
>  	struct commit *commit;
> -	char *format = get_commit_format_string();
> +	static const char *format = "format:%h: \"%s\"";
> +	unsigned char junk_sha1[20];
> +	const char *head = resolve_ref("HEAD", junk_sha1, 0, NULL);
>  
>  	commit = lookup_commit(sha1);
>  	if (!commit)
> @@ -931,7 +909,13 @@ static void print_summary(const char *prefix, const unsigned char *sha1)
>  	rev.diffopt.break_opt = 0;
>  	diff_setup_done(&rev.diffopt);
>  
> -	printf("Created %s", initial_commit ? "root-commit " : "");
> +	printf("[%s%s]: created ",
> +		!prefixcmp(head, "refs/heads/") ?
> +			head + 11 :
> +			!strcmp(head, "HEAD") ?
> +				"detached HEAD" :
> +				head,
> +		initial_commit ? " (root-commit)" : "");
>  

Personally, I'm not overly fond of things like
   something ? yay : nay_but_try ? worked_now : still_no_go
since I find them hard to read without thinking a lot.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
