Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 74AAA203E2
	for <e@80x24.org>; Mon, 25 Jul 2016 17:49:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753174AbcGYRtc (ORCPT <rfc822;e@80x24.org>);
	Mon, 25 Jul 2016 13:49:32 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55816 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753115AbcGYRta (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jul 2016 13:49:30 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 7B23130042;
	Mon, 25 Jul 2016 13:49:29 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=pyOatHjAWRolppaFH71CD/B3C9U=; b=PurZfC
	1pfuR9YEPIJ62woBYwAXjGP/tcNA/GAhQJ/lYF9SP99smEvuvDpGiOG1QTULxiR+
	1n9k4F+l6DQNpLU/PoMIyvBm1OKGc2LTRbvh8vofPY7VH/rW5WfczNSq25Bn1QV+
	5+qYV+dhPHHKWRtJbJzq+si9VZLxtXHPAJJ5Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=pBoPLk3B/55V/gFO8ooxxKE21A9fN0TH
	K3gqETaHCLWxHxbUiUAePokHSo6pp9Snb6t0Jo2PyeyDRwBarCJtBV94JiJJPTkp
	qMv2pspscxiJfg1GsfRmju0i8SWF3+ByZ68bjkmZmWGxc1s0qFIV8sf00Lfsjaqr
	vGcrzLs7EkE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 720AA30041;
	Mon, 25 Jul 2016 13:49:29 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E91DC3003F;
	Mon, 25 Jul 2016 13:49:28 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Vasco Almeida <vascomalmeida@sapo.pt>
Cc:	Git <git@vger.kernel.org>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v2] i18n: notes: mark comment for translation
References: <1469283027-23055-1-git-send-email-vascomalmeida@sapo.pt>
Date:	Mon, 25 Jul 2016 10:49:26 -0700
In-Reply-To: <1469283027-23055-1-git-send-email-vascomalmeida@sapo.pt> (Vasco
	Almeida's message of "Sat, 23 Jul 2016 14:10:27 +0000")
Message-ID: <xmqqr3ah621l.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 228A7E0A-5290-11E6-8004-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Vasco Almeida <vascomalmeida@sapo.pt> writes:

>  static const char note_template[] =
> -	"\nWrite/edit the notes for the following object:\n";
> +	N_("Write/edit the notes for the following object:");
>  
>  struct note_data {
>  	int given;
> @@ -179,7 +179,8 @@ static void prepare_note_data(const unsigned char *object, struct note_data *d,
>  			copy_obj_to_fd(fd, old_note);
>  
>  		strbuf_addch(&buf, '\n');
> -		strbuf_add_commented_lines(&buf, note_template, strlen(note_template));
> +		strbuf_addch(&buf, '\n');
> +		strbuf_add_commented_lines(&buf, _(note_template), strlen(_(note_template)));

I do not quite understand why you want the blank lines surrounding
the message outside add_commented_lines() call.  I think the intent
is to produce

    #
    # Write/edit the notes for the following object:
    #

with the single call.  If you pushed the newlines outside the
message, wouldn't you end up having this instead (____ denoting an
extra empty line each before and after the message)?

    ____
    # Write/edit the notes for the following object:
    ____

