From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 33/94] builtin/apply: move 'p_value_known' global into 'struct apply_state'
Date: Thu, 12 May 2016 12:43:59 -0700
Message-ID: <xmqqk2izdpts.fsf@gitster.mtv.corp.google.com>
References: <20160511131745.2914-1-chriscool@tuxfamily.org>
	<20160511131745.2914-34-chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Jeff King <peff@peff.net>,
	Karsten Blees <karsten.blees@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Christian Couder <chriscool@tuxfamily.org>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 12 21:44:11 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0wWn-000370-Tf
	for gcvg-git-2@plane.gmane.org; Thu, 12 May 2016 21:44:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932216AbcELToF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 May 2016 15:44:05 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62429 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932098AbcELToE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 May 2016 15:44:04 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 0B19B1BE0B;
	Thu, 12 May 2016 15:44:03 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=OYXjtMt/7fHTDclZohj5eFy5uhY=; b=Grr1vT
	BnbaRTHtbN9du52SOd4vyWH9VHmBZjTRM2sRMAMaceI0rG3AdijhUiJJEj3CnxNq
	su12m7KCylrQgl6x7n6IJbA8fSMqhxhnkXaJ03WYEsqZPHw5ltfDiUaVWFzIQS6k
	lL+FULaFLbA+YRAXAPd2m7PE6lNuFvrrkecdc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=YhlLRoEPsqB01V7ICFM/TEifSkU543Ve
	o2HbzZTSI0c9haeBFZlYAgtMzTxAbf2W6DEUA/lTAztkFfTnZ7zBX7U3vGp3jr4W
	Y9YURYNezbSO1VcLUyXncwVjpr6gY68oZiRzPv89IutId4jxTSfhxNOnEHo4T6s+
	BnIAY2I1sac=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 015FF1BE0A;
	Thu, 12 May 2016 15:44:03 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 360B81BE09;
	Thu, 12 May 2016 15:44:02 -0400 (EDT)
In-Reply-To: <20160511131745.2914-34-chriscool@tuxfamily.org> (Christian
	Couder's message of "Wed, 11 May 2016 15:16:44 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: E0CE32AE-1879-11E6-AD82-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294437>

Christian Couder <christian.couder@gmail.com> writes:

> To libify the apply functionality the 'p_value_known' variable should
> not be static and global to the file. Let's move it into
> 'struct apply_state'.

This and p_value belong together, I would think, so this can be
squashed with 32/94 if the series is to be rerolled (this alone is
not a reason to reroll the series, though).

>
> Reviewed-by: Stefan Beller <sbeller@google.com>
> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---
>  builtin/apply.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
>
> diff --git a/builtin/apply.c b/builtin/apply.c
> index 4e476d5..30eea9c 100644
> --- a/builtin/apply.c
> +++ b/builtin/apply.c
> @@ -63,13 +63,12 @@ struct apply_state {
>  	int line_termination;
>  
>  	int p_value;
> +	int p_value_known;
>  	unsigned int p_context;
>  };
>  
>  static int newfd = -1;
>  
> -static int p_value_known;
> -
>  static const char * const apply_usage[] = {
>  	N_("git apply [<options>] [<patch>...]"),
>  	NULL
> @@ -882,14 +881,14 @@ static void parse_traditional_patch(struct apply_state *state,
>  
>  	first += 4;	/* skip "--- " */
>  	second += 4;	/* skip "+++ " */
> -	if (!p_value_known) {
> +	if (!state->p_value_known) {
>  		int p, q;
>  		p = guess_p_value(state, first);
>  		q = guess_p_value(state, second);
>  		if (p < 0) p = q;
>  		if (0 <= p && p == q) {
>  			state->p_value = p;
> -			p_value_known = 1;
> +			state->p_value_known = 1;
>  		}
>  	}
>  	if (is_dev_null(first)) {
> @@ -4595,7 +4594,7 @@ static int option_parse_p(const struct option *opt,
>  {
>  	struct apply_state *state = opt->value;
>  	state->p_value = atoi(arg);
> -	p_value_known = 1;
> +	state->p_value_known = 1;
>  	return 0;
>  }
