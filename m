From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 10/17] trailer: if no input file is passed, read from stdin
Date: Thu, 06 Feb 2014 13:51:36 -0800
Message-ID: <xmqq4n4byknr.fsf@gitster.dls.corp.google.com>
References: <20140130064217.7504.473.chriscool@tuxfamily.org>
	<20140130064921.7504.57934.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Johan Herland <johan@herland.net>,
	Josh Triplett <josh@joshtriplett.org>,
	Thomas Rast <tr@thomasrast.ch>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Dan Carpenter <dan.carpenter@oracle.com>,
	Greg Kroah-Hartman <greg@kroah.com>, Jeff King <peff@peff.net>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Thu Feb 06 22:51:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WBWrJ-0004Du-MZ
	for gcvg-git-2@plane.gmane.org; Thu, 06 Feb 2014 22:51:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754409AbaBFVvl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Feb 2014 16:51:41 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48281 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752891AbaBFVvk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Feb 2014 16:51:40 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4DAD06ABEA;
	Thu,  6 Feb 2014 16:51:40 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=UpJXsq1Cpfh01Tk2w2lTqrGY39c=; b=jfBCVM
	LMbZNPzD5CuRAK9CMmW0hoOyyf4IMNlwvEChByvPuL/HgTfBW8jMSpyfMGF8XBAd
	xA760Quahr+NakVHZ3HDv2/hbhyrpINsGEaJL4pHaciL4831etUKQjzJ0DVSH36g
	vX03vBe8Kq5rs38srFRSRJyWx6GFL2sTCY0f4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=GqfVTK++HEjfDQPPTNCrWTlF9jVPIaMi
	/CkMCU046aDajlsFMAzjnS5uB88KTpBpms3xMCTqsBwvTAzs4uA9UDZpaO59g/xA
	a++roUJf25PSTVhgaO5oN3gyXTU7V9hz9I64hIBKIXI04oU5YmcV0IZJ7UTYIh6H
	X2sh71A+Zf0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2B3636ABE9;
	Thu,  6 Feb 2014 16:51:40 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5D2636ABE5;
	Thu,  6 Feb 2014 16:51:39 -0500 (EST)
In-Reply-To: <20140130064921.7504.57934.chriscool@tuxfamily.org> (Christian
	Couder's message of "Thu, 30 Jan 2014 07:49:13 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: DB9DC678-8F78-11E3-BECC-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241747>

Christian Couder <chriscool@tuxfamily.org> writes:

> It is simpler and more natural if the "git interpret-trailers"
> is made a filter as its output already goes to sdtout.

sdtout???

>
> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---
>  builtin/interpret-trailers.c  |  2 +-
>  t/t7513-interpret-trailers.sh |  7 +++++++
>  trailer.c                     | 15 +++++++++------
>  3 files changed, 17 insertions(+), 7 deletions(-)
>
> diff --git a/builtin/interpret-trailers.c b/builtin/interpret-trailers.c
> index 04b0ae2..ae8e561 100644
> --- a/builtin/interpret-trailers.c
> +++ b/builtin/interpret-trailers.c
> @@ -23,7 +23,7 @@ int cmd_interpret_trailers(int argc, const char **argv, const char *prefix)
>  
>  	struct option options[] = {
>  		OPT_BOOL(0, "trim-empty", &trim_empty, N_("trim empty trailers")),
> -		OPT_FILENAME(0, "infile", &infile, N_("use message from file")),
> +		OPT_FILENAME(0, "infile", &infile, N_("use message from file, instead of stdin")),
>  		OPT_END()
>  	};
>  
> diff --git a/t/t7513-interpret-trailers.sh b/t/t7513-interpret-trailers.sh
> index 8be333c..f5ef81f 100755
> --- a/t/t7513-interpret-trailers.sh
> +++ b/t/t7513-interpret-trailers.sh
> @@ -205,4 +205,11 @@ test_expect_success 'using "ifMissing = doNothing"' '
>  	test_cmp expected actual
>  '
>  
> +test_expect_success 'with input from stdin' '
> +	cat complex_message_body >expected &&
> +	printf "Bug #42\nFixes: \nAcked-by= \nAcked-by= Junio\nAcked-by= Peff\nReviewed-by: \nSigned-off-by: \n" >>expected &&
> +	git interpret-trailers "review:" "fix=53" "cc=Linus" "ack: Junio" "fix=22" "bug: 42" "ack: Peff" < complex_message >actual &&
> +	test_cmp expected actual
> +'
> +
>  test_done
> diff --git a/trailer.c b/trailer.c
> index 8681aed..73a65e0 100644
> --- a/trailer.c
> +++ b/trailer.c
> @@ -464,8 +464,13 @@ static struct strbuf **read_input_file(const char *infile)
>  {
>  	struct strbuf sb = STRBUF_INIT;
>  
> -	if (strbuf_read_file(&sb, infile, 0) < 0)
> -		die_errno(_("could not read input file '%s'"), infile);
> +	if (infile) {
> +		if (strbuf_read_file(&sb, infile, 0) < 0)
> +			die_errno(_("could not read input file '%s'"), infile);
> +	} else {
> +		if (strbuf_read(&sb, fileno(stdin), 0) < 0)
> +			die_errno(_("could not read from stdin"));
> +	}
>  
>  	return strbuf_split(&sb, '\n');
>  }
> @@ -530,10 +535,8 @@ void process_trailers(const char *infile, int trim_empty, int argc, const char *
>  
>  	git_config(git_trailer_config, NULL);
>  
> -	/* Print the non trailer part of infile */
> -	if (infile) {
> -		process_input_file(infile, &infile_tok_first, &infile_tok_last);
> -	}
> +	/* Print the non trailer part of infile (or stdin if infile is NULL) */
> +	process_input_file(infile, &infile_tok_first, &infile_tok_last);
>  
>  	arg_tok_first = process_command_line_args(argc, argv);
