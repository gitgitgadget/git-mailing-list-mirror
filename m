From: =?UTF-8?B?TWljaGHFgg==?= Kiedrowicz <michal.kiedrowicz@gmail.com>
Subject: Re: [PATCH 2/2] shortlog: add '--sort-key' and '--sort-key-regexp'
 options
Date: Wed, 15 Jul 2009 17:37:14 +0200
Message-ID: <20090715173714.1f5240c4@gmail.com>
References: <alpine.LFD.2.01.0907141852400.13838@localhost.localdomain>
	<7v8wiqfj60.fsf@alter.siamese.dyndns.org>
	<alpine.DEB.1.00.0907151316320.4410@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jul 15 17:37:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MR6Xx-0006KR-LL
	for gcvg-git-2@gmane.org; Wed, 15 Jul 2009 17:37:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755536AbZGOPhW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Jul 2009 11:37:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755523AbZGOPhW
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Jul 2009 11:37:22 -0400
Received: from fg-out-1718.google.com ([72.14.220.155]:18107 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755325AbZGOPhV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Jul 2009 11:37:21 -0400
Received: by fg-out-1718.google.com with SMTP id e12so897036fga.17
        for <git@vger.kernel.org>; Wed, 15 Jul 2009 08:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:in-reply-to:references:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=nTpwlXVPTNSzKK3RDi5gwOmfgi7crD/J2MP2LdYXENo=;
        b=W5WLkdiYP+bSEs9O69cp3mDxAK7RKlshd5ixO5CB6MMvTgQmqmtaYdP7n8s1n8o0XG
         WwXBMrrm3RMlaN8H+cRh5ZBT++iw7yTi2F1XMr227aPF/v9I7LT1DPyrMoEKGDHLjeM/
         0DwbG6nkNQCb95cIFroydTCextQmN69MmSSyc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer
         :mime-version:content-type:content-transfer-encoding;
        b=C9WkKR24BCvy8WYC7ERqKOPISBM6jkHYNy9i4rsSNWbwW1mRfYZ4tGyMlTdUf9XRJn
         8lKV0vHi1x0lAImpKdRVW/kmpLX266CT/FIxmbS9FCQwoPLOnEsLJAdSMJ6+osc1ORn5
         oys3Qo2TeXXfhgW4CWeqjTnE3r68TKUyVzC+w=
Received: by 10.86.76.4 with SMTP id y4mr5119304fga.22.1247672238954;
        Wed, 15 Jul 2009 08:37:18 -0700 (PDT)
Received: from localhost (77-253-141-120.adsl.inetia.pl [77.253.141.120])
        by mx.google.com with ESMTPS id 12sm8550214fgg.19.2009.07.15.08.37.18
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 15 Jul 2009 08:37:18 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0907151316320.4410@intel-tinevez-2-302>
X-Mailer: Claws Mail 3.7.1 (GTK+ 2.14.7; x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123323>

Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:

> 
> Instead of always sorting by author, allow to sort by either
> a whitespace-delimited field or by a regular expression (first group)
> on the oneline.
> 
> For example, this will give you an overview of the weekday/commit
> distribution:
> 
> 	git shortlog -k 1 --pretty=%cD -s -n
> 
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
> 
> 	Pretty obviously, in git.git this shows that Saturday and
> 	Wednesday, your designated Git days, are on top of the list,
> but what is interesting to me is that the difference between
> Wednesday and Sunday is not all that much.
> 
> 	Sorry, no time for tests, maybe somebody else can help out?
> 
>  Documentation/git-shortlog.txt |   13 +++++++-
>  builtin-shortlog.c             |   64
> +++++++++++++++++++++++++++++++++++++--
> shortlog.h                     |    1 + 3 files changed, 73
> insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/git-shortlog.txt
> b/Documentation/git-shortlog.txt index 42463a9..3155361 100644
> --- a/Documentation/git-shortlog.txt
> +++ b/Documentation/git-shortlog.txt
> @@ -9,7 +9,7 @@ SYNOPSIS
>  --------
>  [verse]
>  git log --pretty=short | 'git shortlog' [-h] [-n] [-s] [-e] [-w]
> -git shortlog [-n|--numbered] [-s|--summary] [-e|--email]
> [-w[<width>[,<indent1>[,<indent2>]]]] [<committish>...] +git shortlog
> [-n|--numbered] [-s|--summary] [-e|--email]
> [-w[<width>[,<indent1>[,<indent2>]]]] [(-K|--sort-key-regexp)
> <regexp>] [(-k|--sort-key) <n>] [<committish>...] DESCRIPTION
> ----------- @@ -45,6 +45,17 @@ OPTIONS
>  	and subsequent lines are indented by `indent2` spaces.
> `width`, `indent1`, and `indent2` default to 76, 6 and 9 respectively.
>  
> +-K <regexp>::
> +--sort-key-regexp <regexp>::
> +	Instead of sorting by author, sort by a regular expression
> on the
> +	commit subject (or whatever you specified using --pretty)
> +
> +-k <number>::
> +--sort-key <number>::
> +	Instead of sorting by author, sort by a given
> whitespace-delimited
> +	field of the commit subject (or whatever you specified using
> +	--pretty).  The first field is 1.
> +
>  
>  MAPPING AUTHORS
>  ---------------
> diff --git a/builtin-shortlog.c b/builtin-shortlog.c
> index a684422..2cab5e4 100644
> --- a/builtin-shortlog.c
> +++ b/builtin-shortlog.c
> @@ -145,9 +145,37 @@ static void read_from_stdin(struct shortlog *log)
>  
>  void shortlog_add_commit(struct shortlog *log, struct commit *commit)
>  {
> +	struct strbuf buf = STRBUF_INIT;
> +	char *key = NULL;
>  	const char *author = NULL, *buffer;
>  
>  	buffer = commit->buffer;
> +	if (log->user_format)
> +		pretty_print_commit(CMIT_FMT_USERFORMAT, commit,
> &buf,
> +			DEFAULT_ABBREV, "", "", DATE_NORMAL, 0);
> +
> +	if (log->sort_key) {
> +		const char *p = buf.buf;
> +		regmatch_t match[2];
> +
> +		if (!log->user_format) {
> +			p = strstr(buffer, "\n\n");
> +			if (!p)
> +				return;
> +			p += 2;
> +		}
> +
> +		if (!regexec(log->sort_key, p, 2, match, 0) &&
> +				match[1].rm_so >= 0)
> +			author = key = xstrndup(p + match[1].rm_so,
> +				match[1].rm_eo - match[1].rm_so);
> +		else
> +			author = "<null>";
> +		insert_one_record1(log, key, p);
> +		strbuf_release(&buf);

Missing free()?

> +		return;
> +	}
> +
>  	while (*buffer && *buffer != '\n') {
>  		const char *eol = strchr(buffer, '\n');
>  
> @@ -164,10 +192,6 @@ void shortlog_add_commit(struct shortlog *log,
> struct commit *commit) die("Missing author: %s",
>  		    sha1_to_hex(commit->object.sha1));
>  	if (log->user_format) {
> -		struct strbuf buf = STRBUF_INIT;
> -
> -		pretty_print_commit(CMIT_FMT_USERFORMAT, commit,
> &buf,
> -			DEFAULT_ABBREV, "", "", DATE_NORMAL, 0);
>  		insert_one_record(log, author, buf.buf);
>  		strbuf_release(&buf);
>  		return;
> @@ -175,6 +199,7 @@ void shortlog_add_commit(struct shortlog *log,
> struct commit *commit) if (*buffer)
>  		buffer++;
>  	insert_one_record(log, author, !*buffer ? "<none>" : buffer);
> +	free(key);

Is it the right place for free()?

Here is valgrind output:

==9005== 98,085 bytes in 19,218 blocks are definitely lost in loss record 23 of 25
==9005==    at 0x4A08CFE: malloc (vg_replace_malloc.c:207
==9005==    by 0x4A8D25: xmalloc (wrapper.c:20)
==9005==    by 0x4A8DE1: xmemdupz (wrapper.c:45)
==9005==    by 0x44AFDD: shortlog_add_commit (builtin-shortlog.c:170)
==9005==    by 0x44B31C: cmd_shortlog (builtin-shortlog.c:212)
==9005==    by 0x4049A2: handle_internal_command (git.c:246)
==9005==    by 0x404B63: main (git.c:438)
