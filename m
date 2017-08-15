Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AB33C208B8
	for <e@80x24.org>; Tue, 15 Aug 2017 18:26:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752428AbdHOS0n (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Aug 2017 14:26:43 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53603 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751482AbdHOS0n (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Aug 2017 14:26:43 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6A4AE9A948;
        Tue, 15 Aug 2017 14:26:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=vQww20qoZyvHGj3FPUq7vism7Kg=; b=OAnBbA
        E970lPT6ews46h4ZzmEBaFi1qS8tM44HbwCOsW2hmUoTirfdEmB4T60qMoCQb6NS
        l5SbWXrHuvXe+HxZRBRSIt+TyVINrPuKG9IU/Je9CfNHTdwcJQDWaR747MJGAQ4c
        ebwqZflgSMa5IeSYwnu0wisVDhAlHWhvwRwbM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=q2APFek4VJEK79/CDXXQmJrMEULOLLZF
        lCNq2koUNZeGV2EhNKyBjuv6TJwU8ChCVcnF2iLw8uJicG/oNABMftj6gRqVmpNW
        HLUK2a9Bwf1M2qs4q5QBabseM8Q3hg2R3ROZ7xDdTj7Q2+B+yCx/BSwPET8+UGyU
        Xks1pr3+1ug=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 61BA69A947;
        Tue, 15 Aug 2017 14:26:35 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id AA8CA9A942;
        Tue, 15 Aug 2017 14:26:34 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Patryk Obara <patryk.obara@gmail.com>
Cc:     git@vger.kernel.org,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH 4/5] commit: implement free_commit_graft
References: <cover.1502796628.git.patryk.obara@gmail.com>
        <cover.1502796628.git.patryk.obara@gmail.com>
        <945cc94bedab645885f9025cee51efd8205a69a4.1502796628.git.patryk.obara@gmail.com>
Date:   Tue, 15 Aug 2017 11:26:32 -0700
In-Reply-To: <945cc94bedab645885f9025cee51efd8205a69a4.1502796628.git.patryk.obara@gmail.com>
        (Patryk Obara's message of "Tue, 15 Aug 2017 13:49:05 +0200")
Message-ID: <xmqqshgsr8kn.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 44A41726-81E7-11E7-9AE3-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Patryk Obara <patryk.obara@gmail.com> writes:

> Signed-off-by: Patryk Obara <patryk.obara@gmail.com>
> ---
>  commit.c | 11 ++++++++---
>  commit.h |  1 +
>  2 files changed, 9 insertions(+), 3 deletions(-)

I do not see a need to make this new function extern.  Shouldn't it
be made "static" and revert the change to commit.h?

> diff --git a/commit.c b/commit.c
> index 499fb14..6a145f1 100644
> --- a/commit.c
> +++ b/commit.c
> @@ -109,15 +109,20 @@ static int commit_graft_pos(const unsigned char *sha1)
>  			commit_graft_sha1_access);
>  }
>  
> +void free_commit_graft(struct commit_graft *graft)
> +{
> +	free(graft);
> +}
> +
>  int register_commit_graft(struct commit_graft *graft, int ignore_dups)
>  {
>  	int pos = commit_graft_pos(graft->oid.hash);
>  
>  	if (0 <= pos) {
>  		if (ignore_dups)
> -			free(graft);
> +			free_commit_graft(graft);
>  		else {
> -			free(commit_graft[pos]);
> +			free_commit_graft(commit_graft[pos]);
>  			commit_graft[pos] = graft;
>  		}
>  		return 1;
> @@ -163,7 +168,7 @@ struct commit_graft *read_graft_line(struct strbuf *line)
>  
>  bad_graft_data:
>  	error("bad graft data: %s", buf);
> -	free(graft);
> +	free_commit_graft(graft);
>  	return NULL;
>  }
>  
> diff --git a/commit.h b/commit.h
> index baecc0a..c1b319f 100644
> --- a/commit.h
> +++ b/commit.h
> @@ -247,6 +247,7 @@ struct commit_graft {
>  };
>  typedef int (*each_commit_graft_fn)(const struct commit_graft *, void *);
>  
> +void free_commit_graft(struct commit_graft *);
>  struct commit_graft *read_graft_line(struct strbuf *line);
>  int register_commit_graft(struct commit_graft *, int);
>  struct commit_graft *lookup_commit_graft(const struct object_id *oid);
