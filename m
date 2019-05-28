Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 655D31F462
	for <e@80x24.org>; Tue, 28 May 2019 17:55:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727677AbfE1Rzg (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 May 2019 13:55:36 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62473 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726969AbfE1Rzg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 May 2019 13:55:36 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 01B3C14970D;
        Tue, 28 May 2019 13:55:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=c9zfdhGFWzPtQptJPCO0u5Dymgc=; b=eEZV6N
        eS63YSYJ34wdlwtwaTv4rZKdMQoRDtaVx/jmwK7H6tKKu9Lf6XyO64bx9GS0jld/
        UYjBycUGVE0jVR00Z8VPa1OpExdkf5h3QXIPPYxK0cM8fRR4yRO4cj40wa3diEw3
        /74bvPbne3zT0tEZwMPB5RMpYljMS0WUTC8w8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=coz+Rbehw4w+6y9MeHxaoKk7Qfi1nSVN
        0xYpnNISW98vztxrIP2fQCt+/LG0W3gFpBaxDWX09OtmrezKqybBrxZ6uIseyvCe
        ZDXxcphy0If9Os4h869GV+vMtrdvTXpDDYDMmvWEbIZHRPhS/yREqyg9JDdujtCK
        x5vI7ytkA7o=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id EEA8514970C;
        Tue, 28 May 2019 13:55:30 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 57F0314970B;
        Tue, 28 May 2019 13:55:30 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Simon Williams <simon@no-dns-yet.org.uk>
Cc:     git@vger.kernel.org, Luke Diamand <luke@diamand.org>
Subject: Re: [PATCH v2] git-p4: Allow unshelving of branched files
References: <20190522062120.GB5224@buzz.no-dns-yet.org.uk>
Date:   Tue, 28 May 2019 10:55:29 -0700
In-Reply-To: <20190522062120.GB5224@buzz.no-dns-yet.org.uk> (Simon Williams's
        message of "Wed, 22 May 2019 07:21:20 +0100")
Message-ID: <xmqqr28i31m6.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C8543782-8171-11E9-95FA-46F8B7964D18-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Simon Williams <simon@no-dns-yet.org.uk> writes:

> When unshelving a changelist, git-p4 tries to work out the appropriate
> parent commit in a given branch (default: HEAD).  To do this, it looks
> at the state of any pre-existing files in the target Perforce branch,
> omitting files added in the shelved changelist.  Currently, only files
> added (or move targets) are classed as new.  However, files integrated
> from other branches (i.e. a 'branch' action) also need to be considered
> as added, for this purpose.
>
> Signed-off-by: Simon Williams <simon@no-dns-yet.org.uk>
> Signed-off-by: Luke Diamand <luke@diamand.org>

I'll tweak the last one from "S-o-b" to "Acked-by" while queuing.
Thanks, both.

> ---
>  git-p4.py           | 2 +-
>  t/t9832-unshelve.sh | 8 +++++++-
>  2 files changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/git-p4.py b/git-p4.py
> index 5b79920f46..81a525858b 100755
> --- a/git-p4.py
> +++ b/git-p4.py
> @@ -1309,7 +1309,7 @@ def processContent(self, git_mode, relPath, contents):
>  
>  class Command:
>      delete_actions = ( "delete", "move/delete", "purge" )
> -    add_actions = ( "add", "move/add" )
> +    add_actions = ( "add", "branch", "move/add" )
>  
>      def __init__(self):
>          self.usage = "usage: %prog [options]"
> diff --git a/t/t9832-unshelve.sh b/t/t9832-unshelve.sh
> index 41c09f11f4..cde9f86cd6 100755
> --- a/t/t9832-unshelve.sh
> +++ b/t/t9832-unshelve.sh
> @@ -22,7 +22,10 @@ test_expect_success 'init depot' '
>  		: >file_to_move &&
>  		p4 add file_to_delete &&
>  		p4 add file_to_move &&
> -		p4 submit -d "add files to delete"
> +		p4 submit -d "add files to delete" &&
> +		echo file_to_integrate >file_to_integrate &&
> +		p4 add file_to_integrate &&
> +		p4 submit -d "add file to integrate"
>  	)
>  '
>  
> @@ -40,6 +43,7 @@ test_expect_success 'create shelved changelist' '
>  		p4 delete file_to_delete &&
>  		p4 edit file_to_move &&
>  		p4 move file_to_move moved_file &&
> +		p4 integrate file_to_integrate integrated_file &&
>  		p4 opened &&
>  		p4 shelve -i <<EOF
>  Change: new
> @@ -53,6 +57,7 @@ Files:
>  	//depot/file_to_delete
>  	//depot/file_to_move
>  	//depot/moved_file
> +	//depot/integrated_file
>  EOF
>  
>  	) &&
> @@ -65,6 +70,7 @@ EOF
>  		test_path_is_file file2 &&
>  		test_cmp file1 "$cli"/file1 &&
>  		test_cmp file2 "$cli"/file2 &&
> +		test_cmp file_to_integrate "$cli"/integrated_file &&
>  		test_path_is_missing file_to_delete &&
>  		test_path_is_missing file_to_move &&
>  		test_path_is_file moved_file
> -- 
> 2.17.1
>
>
> Regards,
