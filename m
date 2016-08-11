Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6571120193
	for <e@80x24.org>; Thu, 11 Aug 2016 20:50:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932247AbcHKUuT (ORCPT <rfc822;e@80x24.org>);
	Thu, 11 Aug 2016 16:50:19 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51225 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932180AbcHKUuR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Aug 2016 16:50:17 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 6163031D2A;
	Thu, 11 Aug 2016 16:50:16 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=vDr+NwW9AAIERAi3MvMYqyZkcjI=; b=GeGxQI
	4dmT31KH6W1nv8DlbJ5j/L0YZbF+P9CX57TQ07eEsCMQ10kPOaBKGg1nAzdWl9qz
	dWE1Sl1I8P+Q6WWhcP5kG3TXlLgYUL8omp6TMmbzGprhG2WpY7nTMsVoc0rL9kRW
	t5RAH7IXie3KFay4xXdLkU4ESRxIusRevrEgU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=QduREb7gWBr/v/EzzTEklK7nUcwcYZPh
	j5i3O4Etguwx4KGF82NTbC7pb7Pv1j2DQ/Yhk43rR/5N0gX/2ee9mHLahJG6iQ5p
	AIgDZCnzcQXQe0vqS+3Al+DcPycPh5c7Ba0SRgliv75jkQttdXYFui9IqAEqVow6
	AL+Ka+//8oA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 5784131D29;
	Thu, 11 Aug 2016 16:50:16 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C2F2131D28;
	Thu, 11 Aug 2016 16:50:15 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Jacob Keller <jacob.e.keller@intel.com>
Cc:	git@vger.kernel.org, Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH v4 2/2] diff: add SUBMODULE_DIFF format to display submodule diff
References: <20160810231908.26330-1-jacob.e.keller@intel.com>
	<20160810231908.26330-2-jacob.e.keller@intel.com>
Date:	Thu, 11 Aug 2016 13:50:13 -0700
In-Reply-To: <20160810231908.26330-2-jacob.e.keller@intel.com> (Jacob Keller's
	message of "Wed, 10 Aug 2016 16:19:08 -0700")
Message-ID: <xmqqmvkjyqre.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 34C999DE-6005-11E6-9F84-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Jacob Keller <jacob.e.keller@intel.com> writes:

> diff --git a/submodule.c b/submodule.c
> index 1b5cdfb7e784..36f8fd00c3ce 100644
> --- a/submodule.c
> +++ b/submodule.c
> @@ -333,6 +333,73 @@ static void print_submodule_summary(struct rev_info *rev, FILE *f,
>  	strbuf_release(&sb);
>  }
>  
> +void show_submodule_diff(FILE *f, const char *path,
> +		const char *line_prefix,
> +		unsigned char one[20], unsigned char two[20],
> +		unsigned dirty_submodule, const char *meta,
> +		const char *a_prefix, const char *b_prefix,
> +		const char *reset)
> +{
> +	struct child_process cp = CHILD_PROCESS_INIT;
> +	struct strbuf sb = STRBUF_INIT;
> +	struct strbuf submodule_git_dir = STRBUF_INIT;
> +	const char *git_dir, *message = NULL;
> +	int create_dirty_diff = 0;
> +	FILE *diff;
> +	char c;

The variables message, diff and c are not used, are they?
