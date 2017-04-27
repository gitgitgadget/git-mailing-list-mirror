Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F0003207E4
	for <e@80x24.org>; Thu, 27 Apr 2017 06:47:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932127AbdD0GrZ (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Apr 2017 02:47:25 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:35027 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753767AbdD0GrY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Apr 2017 02:47:24 -0400
Received: by mail-pf0-f193.google.com with SMTP id a188so6820734pfa.2
        for <git@vger.kernel.org>; Wed, 26 Apr 2017 23:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=w8J2sYMnP2wvRZLiuPbcy1SQpQI4eGJiOwc10MaSpBQ=;
        b=OzatobRG8zxsM95oYL6/JBPDUyvOrtbBvlOBa4rLmd+n6EhMYZXo3l3kIbhbuA0p9+
         rmtCjGi+yuUYwM21Uub+JoDMryGD+MuF3V0l6/poniNquSyhl5em6KFXh9mZMCq6830H
         famLNPmVPfAmFVIL6q3O4j45CCtJG03vbJiQwEm6B1YXPM5FjnjORXtdCxvU/Hgbm622
         vl065zNOcEUSdhQNtb3iju8nItnGzS4N+uGVDPmNMXWXNSXIDkms2BM30q42GGtad8Lr
         ZKgnJUiNoIVDSJWL3UWAcEiJo/a+oel5ZnmsdowZPHhRSN2g3x9o3fc+56WmavZDmXf9
         jAsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=w8J2sYMnP2wvRZLiuPbcy1SQpQI4eGJiOwc10MaSpBQ=;
        b=RoWjdI7ckVrBeQYc2M2Lox5F2kzmzv99cxqXCHGjw4XkdnN0Vsg9yt+q7oHg04DWjn
         gbJONs4HgNKAN9iI/8wEdEI8Vg57snFGOao2/9Uo1ibGhG3HNF4qbDK2oTMXTpZRvV3C
         BT9r2uYvfVoeN6AkISNACrsuBj0pHM0zQEoNqcg2mt/Zw/wgkSBSOI+L4MHuPf6eaEpD
         3M8IIHjdLI8XWepedVTP3YyNVotF8+QaX8tlnNBg9zTTVx0RPpjFCcAtcnzZjtHemZ+O
         jt4V8Webd56C0H2X6gGAPVdz/9oDNjybBBLgFVu6lhrxx1/SK7cOMi3b9H6ML8vwLxTs
         xfUA==
X-Gm-Message-State: AN3rC/4oSrg3xcDkQGK1DFirgrI5HLpglKE9Eq1SWPr1JMY+fpQybDUA
        5X3rHdbY5ba1AM8DEaq8RA==
X-Received: by 10.98.57.71 with SMTP id g68mr3964686pfa.53.1493275643348;
        Wed, 26 Apr 2017 23:47:23 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:d550:ca2:cfe6:6d97])
        by smtp.gmail.com with ESMTPSA id 133sm2316852pfv.127.2017.04.26.23.47.22
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 26 Apr 2017 23:47:22 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, Philip Oakley <philipoakley@iee.org>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 4/9] rebase -i: also expand/collapse the SHA-1s via the rebase--helper
References: <cover.1493128210.git.johannes.schindelin@gmx.de>
        <cover.1493207864.git.johannes.schindelin@gmx.de>
        <df5263cc0cad5cffbd1932d4b9b8e5c0507536e6.1493207864.git.johannes.schindelin@gmx.de>
        <xmqqr30eo36n.fsf@gitster.mtv.corp.google.com>
Date:   Wed, 26 Apr 2017 23:47:22 -0700
In-Reply-To: <xmqqr30eo36n.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Wed, 26 Apr 2017 22:00:16 -0700")
Message-ID: <xmqqfugumjnp.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
>
>> diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
>> index 214af0372ba..52a19e0bdb3 100644
>> --- a/git-rebase--interactive.sh
>> +++ b/git-rebase--interactive.sh
>> @@ -774,11 +774,11 @@ transform_todo_ids () {
>>  }
>>  
>>  expand_todo_ids() {
>> -	transform_todo_ids
>> +	git rebase--helper --expand-sha1s
>>  }
>>  
>>  collapse_todo_ids() {
>> -	transform_todo_ids --short
>> +	git rebase--helper --shorten-sha1s
>>  }
>
> Obviously correct ;-)  But doesn't this make transform_todo_ids ()
> helper unused and removable?

Ehh, in case it was notclear, I meant the helper function in shell,
not the one you added below to C code.
>
>> +int transform_todo_ids(int shorten_sha1s)
>> +{

