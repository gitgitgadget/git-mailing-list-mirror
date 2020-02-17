Return-Path: <SRS0=dbxk=4F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 709B0C3B1BF
	for <git@archiver.kernel.org>; Mon, 17 Feb 2020 00:06:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FCBA208C3
	for <git@archiver.kernel.org>; Mon, 17 Feb 2020 00:06:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="WLHhVDTG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726259AbgBQAF6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 16 Feb 2020 19:05:58 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:65521 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726183AbgBQAF6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Feb 2020 19:05:58 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 7307BAE5B8;
        Sun, 16 Feb 2020 19:05:57 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=uxVduRIBnCLz1WF7jBlIkkc46uM=; b=WLHhVD
        TGZPMgzoDvehTkNOLD+Pwr7q8sC1075L8vitJwuTDiOoQhc3hOunNlEPb9YoV+Nc
        NxdwMKC3Yi+G0+g67mKRE9uI/2OdVVUn0n7C/3V5edGfj6R1sayEGsCTHVMD+XDO
        F+PujXjX7xUBXppSM8V8F2rXNnuUSiGcc41ps=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=wOsKrDVT5euOsrbV/Rh4MAYvR6cYBvzH
        df+wNEVeHiIvE+wDxzC5I/M50Opp7ceMw0m+8X/SLh5Jeiu5YakqLsxPeZv4Jx3w
        nkWvHlgqJYV3GRmFyTv2hiyJOh8IyGkkXOSUpT+HIyIZLZa28UFFxmD+PLL1IkCd
        sj+OdxDd7ko=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 6CA37AE5B7;
        Sun, 16 Feb 2020 19:05:57 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 93E38AE5B1;
        Sun, 16 Feb 2020 19:05:54 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Abhishek Kumar <abhishekkumar8222@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [GSoC Patch 1/5] lib-log-graph.sh: consolidate test_cmp_graph logic
References: <20200216134750.18947-1-abhishekkumar8222@gmail.com>
Date:   Sun, 16 Feb 2020 16:05:52 -0800
In-Reply-To: <20200216134750.18947-1-abhishekkumar8222@gmail.com> (Abhishek
        Kumar's message of "Sun, 16 Feb 2020 19:17:46 +0530")
Message-ID: <xmqqk14mm61r.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 441101A8-5119-11EA-B14F-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Abhishek Kumar <abhishekkumar8222@gmail.com> writes:

> Logic for comparing log graphs is duplicated across test scripts.
> ...
>  t/lib-log-graph.sh | 39 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 39 insertions(+)
>  create mode 100644 t/lib-log-graph.sh

The presentation order of the patches may be less than ideal, in
that it introduces totally unused code in step 1/5 that is hard to
compare with what it will be used to replace with, and it is
impossible to tell if the potential issues readers see in this step
are merely inherited from existing tests or new issues introduced by
this series, before reading the later steps.

> diff --git a/t/lib-log-graph.sh b/t/lib-log-graph.sh
> new file mode 100644
> index 0000000000..999f2600de
> --- /dev/null
> +++ b/t/lib-log-graph.sh
> @@ -0,0 +1,39 @@
> +# Helpers shared by the test scripts for comparing log graphs.
> +
> +sanitize_output() {

One SP around both sides of ().  I suspect that all helper functions
in this patch has this style violation.

As a library-ish function that can be used outside individual test
script, "output" without any clarification is too broad a word to
act as an object of sanitizing.  Is this function to sanitize the
output from "git log"?  Perhaps at the minimum, it should be called
sanitize_log_output then.

> +	sed -e 's/ *$//' \
> +	    -e 's/commit [0-9a-f]*$/commit COMMIT_OBJECT_NAME/' \
> +	    -e 's/Merge: [ 0-9a-f]*$/Merge: MERGE_PARENTS/' \
> +	    -e 's/Merge tag.*/Merge HEADS DESCRIPTION/' \
> +	    -e 's/Merge commit.*/Merge HEADS DESCRIPTION/' \

These are understandable anonymization; so is the last "index" one.

> +	    -e 's/, 0 deletions(-)//' \
> +	    -e 's/, 0 insertions(+)//' \
> +	    -e 's/ 1 files changed, / 1 file changed, /' \
> +	    -e 's/, 1 deletions(-)/, 1 deletion(-)/' \
> +	    -e 's/, 1 insertions(+)/, 1 insertion(+)/' \

These might deserve comments.  IIUC, all of these are historical
accident and no longer necessary.

> +	    -e 's/index [0-9a-f]*\.\.[0-9a-f]*/index BEFORE..AFTER/'
> +}
> +
> +# Assume expected graph is in file `expect`
> +test_cmp_graph_file() {
> +	git log --graph "$@" >output &&
> +	sanitize_output >output.trimmed <output &&

Pay attention to the names.  If you are "sanitizing", then the
result is not "trimmed".  Call it "sanitized".

> +	test_i18ncmp expect output.trimmed
> +}
> +
> +test_cmp_graph() {
> +	cat >expect &&
> +	test_cmp_graph_file "$@"
> +}

I am not sure if this wrapper is useful or obscuring.  Open coding
the caller of this wrapper, i.e.

	cat >expect <<-\EOF &&
	expected pattern
	EOF
	test_cmp_graph_file $args

is not all that cumbersome, and it might make it more transparent to
the readers what is going on.  I'd need to see the callsites in
later steps to decide it is a good idea.

> +# Assume expected graph is in file `expect.colors`
> +test_cmp_colored_graph_file() {
> +	git log --graph --color=always "$@" >output.colors.raw &&
> +	test_decode_color <output.colors.raw | sed "s/ *\$//" >output.colors &&
> +	test_cmp expect.colors output.colors
> +}
> +
> +test_cmp_colored_graph() {
> +	cat >expect.colors &&
> +	test_cmp_colored_graph_file "$@"
> +}

So unlike test_cmp_graph family, colored counterparts do not
anonymize?  That sounds a bit harder to use, but we cannot really
tell if that is an issue before seeing the callsites in later steps.

Thanks.
