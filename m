Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8E69A1F43C
	for <e@80x24.org>; Tue, 14 Nov 2017 19:52:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754322AbdKNTwu (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Nov 2017 14:52:50 -0500
Received: from mail-io0-f172.google.com ([209.85.223.172]:43293 "EHLO
        mail-io0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753115AbdKNTws (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Nov 2017 14:52:48 -0500
Received: by mail-io0-f172.google.com with SMTP id 134so25666536ioo.0
        for <git@vger.kernel.org>; Tue, 14 Nov 2017 11:52:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PHpSnhoSapHA20Fq91hzVjkA5Zt2vyc+xiQZBXbwoN8=;
        b=RJCQYljy5Dpa8RE/ApzfF520Pn8uQorSk42mcLI0sg0Z5tFCy2DG1gG0CBMBf8WsWE
         ZYyQ9OIvtvSnIqWXY1SvbkfGoPp6ZBIJLKCHsWrGW43u6h0YAZugwW2DUb+M24SFvI+X
         cU8IXDLByD91gSXeYrdZMPDHpSP1SULsUE56Z7G+25F0PbL+AubLQUecnM+hrXwOvD3L
         3opaXwHV6jyENP8gIl5SVf4izNOIyZLxqQj9eRT79wY6+8WheYzlerCGBJjqHR7Na7Hi
         KYbCsUXa1engpxc9pqoUNEozVml1wYOKTMTDYSxDl5xsYtm6cSKoSYAZOnQY/dGp0Z2p
         WDEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PHpSnhoSapHA20Fq91hzVjkA5Zt2vyc+xiQZBXbwoN8=;
        b=Y/jWqd8o8ps4SziHFaS4EMnY1CofkwqwmhnQBGPXNDmSHfd17D4zfrIcpj8e2Mh20J
         G3oVjNmKa3DtW/iALzrgfQLI60n+pahsSk2/eURgHNdRm61UWyyNlMUD8Jk9ZJvtDAlE
         FWnCDBBdj4N6rTCIGUvAq4JWCroIttUc0WhgkHERwY72szGrNnTJooFnGh5cuIyhMjaU
         JZZcCGCFO16GCRKSUvBFptwpi30mohHS8WxKR/EflMWP9DTZAdR6+BwYhoSoDBwikwC9
         zUeMaddFBm4Zt4ip3N0OJFrFMI9Mk/FypDjYK00OXi7W1/qJH3z9SSbXPe8ETpqpwBm+
         qDcw==
X-Gm-Message-State: AJaThX7UyEfz4bJTkFbZ+VMebs6GiASdEiJmYKj+Y56fVN46tWCEiJnH
        QHZo5CBsn6sE7+L1Rv5TKrYNHA==
X-Google-Smtp-Source: AGs4zMbkEuQ0TLj1FTN0S1CSOLPyYTOwILqaaHKoIwO0IoQi91P9kG4hyS/rIbtUVB6IgYYSw4JjAQ==
X-Received: by 10.107.22.69 with SMTP id 66mr15609372iow.150.1510689167526;
        Tue, 14 Nov 2017 11:52:47 -0800 (PST)
Received: from twelve3.mtv.corp.google.com ([2620:0:100e:422:9ca7:c33c:854a:a353])
        by smtp.gmail.com with ESMTPSA id i62sm8796716ioe.31.2017.11.14.11.52.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Nov 2017 11:52:46 -0800 (PST)
Date:   Tue, 14 Nov 2017 11:52:45 -0800
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Johannes.Schindelin@gmx.de, git@vger.kernel.org,
        jacob.keller@gmail.com, me@ikke.info, schwab@linux-m68k.org
Subject: Re: [PATCHv3 3/7] revision.h: introduce blob/tree walking in order
 of the commits
Message-Id: <20171114115245.d150b8f741b6f809951cbec1@google.com>
In-Reply-To: <20171102194148.2124-4-sbeller@google.com>
References: <20171031211852.13001-1-sbeller@google.com>
        <20171102194148.2124-1-sbeller@google.com>
        <20171102194148.2124-4-sbeller@google.com>
X-Mailer: Sylpheed 3.4.1 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu,  2 Nov 2017 12:41:44 -0700
Stefan Beller <sbeller@google.com> wrote:

> @@ -239,6 +239,8 @@ void traverse_commit_list(struct rev_info *revs,
>  		if (commit->tree)
>  			add_pending_tree(revs, commit->tree);
>  		show_commit(commit, data);
> +		if (revs->tree_blobs_in_commit_order)
> +			traverse_trees_and_blobs(revs, &csp, show_object, data);
>  	}
>  	traverse_trees_and_blobs(revs, &csp, show_object, data);
>  

I would have expected add_pending_tree() above to no longer be invoked.
If it still needs to be invoked, maybe add an explanation in the form of
a comment or commit message.

> +test_expect_success 'rev-list --in-commit-order' '
> +	for x in one two three four
> +	do
> +		echo $x >$x &&
> +		git add $x &&
> +		git commit -m "add file $x" ||
> +		return 1
> +	done &&
> +	for x in four three
> +	do
> +		git rm $x &&
> +		git commit -m "remove $x" ||
> +		return 1
> +	done &&
> +	git rev-list --in-commit-order --objects HEAD >actual.raw &&
> +	cut -c 1-40 >actual <actual.raw &&
> +
> +	git cat-file --batch-check="%(objectname)" >expect.raw <<-\EOF &&
> +		HEAD^{commit}
> +		HEAD^{tree}
> +		HEAD^{tree}:one
> +		HEAD^{tree}:two
> +		HEAD~1^{commit}
> +		HEAD~1^{tree}
> +		HEAD~1^{tree}:three
> +		HEAD~2^{commit}
> +		HEAD~2^{tree}
> +		HEAD~2^{tree}:four
> +		HEAD~3^{commit}
> +		# HEAD~3^{tree} skipped, same as HEAD~1^{tree}
> +		HEAD~4^{commit}
> +		# HEAD~4^{tree} skipped, same as HEAD^{tree}
> +		HEAD~5^{commit}
> +		HEAD~5^{tree}
> +	EOF
> +	grep -v "#" >expect <expect.raw &&
> +
> +	test_cmp expect actual
> +'

Would it be useful to have another test without --in-commit-order, so
that we can see the difference (and ensure that existing behavior is
unchanged)?
