Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7BE361F403
	for <e@80x24.org>; Thu, 14 Jun 2018 05:40:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752765AbeFNFkE (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Jun 2018 01:40:04 -0400
Received: from mail179-28.suw41.mandrillapp.com ([198.2.179.28]:53640 "EHLO
        mail179-28.suw41.mandrillapp.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751872AbeFNFkD (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 14 Jun 2018 01:40:03 -0400
X-Greylist: delayed 900 seconds by postgrey-1.27 at vger.kernel.org; Thu, 14 Jun 2018 01:40:03 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=mandrill; d=nexedi.com;
 h=From:Subject:To:Cc:Message-Id:References:In-Reply-To:Date:MIME-Version:Content-Type:Content-Transfer-Encoding; i=kirr@nexedi.com;
 bh=rNUHvo7NueXNPpc4vFMonPBqTlF23WjfAWe6Nc+srwc=;
 b=m21oVfmxtcWs4v5uF5fm5ncnX7YxT1KVz/xzYdic+ZWOweHgKvq1L5VWGVESqnkdvqHl90gtBu6A
   q7eBcz6ySIhkN4ooMrM8uhBbeWDxEyw2hqcx3vOoBQ+7ellnRFiJICI+qdoOzZOKoZ3AMSGEYC5R
   bukaFejHIzLMlx6jAEE=
Received: from pmta04.mandrill.prod.suw01.rsglab.com (127.0.0.1) by mail179-28.suw41.mandrillapp.com id h47vr622s286 for <git@vger.kernel.org>; Thu, 14 Jun 2018 05:25:02 +0000 (envelope-from <bounce-md_31050260.5b21fc2e.v1-4dd4d592106f41278f05d59d459d6ab2@mandrillapp.com>)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandrillapp.com; 
 i=@mandrillapp.com; q=dns/txt; s=mandrill; t=1528953902; h=From : 
 Subject : To : Cc : Message-Id : References : In-Reply-To : Date : 
 MIME-Version : Content-Type : Content-Transfer-Encoding : From : 
 Subject : Date : X-Mandrill-User : List-Unsubscribe; 
 bh=rNUHvo7NueXNPpc4vFMonPBqTlF23WjfAWe6Nc+srwc=; 
 b=aUE5Yg1tBjQoVJOYW6wDmoZRJpx9iD/ZyokJt4f1JPvaHjR6HzrPLPwREZ6ITc4/W0OLvk
 g2EbH0bzVchYU/SqAUga9o8e6LCsWCgB5GryHx5esE++iTeHm9h8qCKpudz5vciMHW+0t7By
 CUqJ/FxmaaJsMSVSV8l9lYFLTDSGw=
From:   Kirill Smelkov <kirr@nexedi.com>
Subject: Re: [PATCH] fetch-pack: test explicitly that --all can fetch tag references pointing to non-commits
Received: from [87.98.221.171] by mandrillapp.com id 4dd4d592106f41278f05d59d459d6ab2; Thu, 14 Jun 2018 05:25:02 +0000
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Brandon Williams <bmwill@google.com>,
        Takuto Ikuta <tikuta@chromium.org>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        <git@vger.kernel.org>
Message-Id: <20180614052455.GA2861@deco.navytux.spb.ru>
References: <20180612185413.GA21856@deco.navytux.spb.ru> <20180613111840.1427-1-kirr@nexedi.com> <xmqqbmce7fcm.fsf@gitster-ct.c.googlers.com> <20180613184301.GB22854@deco.navytux.spb.ru> <20180613210509.GA15574@sigill.intra.peff.net> <20180613231147.GA21025@sigill.intra.peff.net>
In-Reply-To: <20180613231147.GA21025@sigill.intra.peff.net>
X-Report-Abuse: Please forward a copy of this message, including all headers, to abuse@mandrill.com
X-Report-Abuse: You can also report abuse here: http://mandrillapp.com/contact/abuse?id=31050260.4dd4d592106f41278f05d59d459d6ab2
X-Mandrill-User: md_31050260
Date:   Thu, 14 Jun 2018 05:25:02 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 13, 2018 at 07:11:47PM -0400, Jeff King wrote:
> On Wed, Jun 13, 2018 at 05:05:09PM -0400, Jeff King wrote:
> 
> > > In order to be sure fetching funky tags will never break, let's
> > > explicitly test all relevant cases with 4 tag objects pointing to 1) a
> > > blob, 2) a tree, 3) a commit, and 4) another tag objects. The referenced
> > > tag objects themselves are referenced from under regular refs/tags/*
> > > namespace. Before e9502c0a7f `fetch-pack --all` was failing e.g. this way:
> > > 
> > >         .../git/t/trash directory.t5500-fetch-pack/fetchall$ git ls-remote ..
> > >         44085874...        HEAD
> > >         ...
> > >         bc4e9e1f...        refs/tags/tag-to-blob
> > >         038f48ad...        refs/tags/tag-to-blob^{}	# peeled
> > >         520db1f5...        refs/tags/tag-to-tree
> > >         7395c100...        refs/tags/tag-to-tree^{}	# peeled
> > > 
> > >         .../git/t/trash directory.t5500-fetch-pack/fetchall$ git fetch-pack --all ..
> > >         fatal: A git upload-pack: not our ref 038f48ad...
> > >         fatal: The remote end hung up unexpectedly
> > 
> > TBH, I do not find this snippet all that compelling. We know that
> > e9502c0a7f already fixed the bug, and that it had nothing to do with
> > non-commits at all.
> > 
> > The primary reason to add these tests is that in general we do not cover
> > fetch-pack over tags to non-commits. And I think the reason to use
> > otherwise unreferenced objects is that it they are more likely to have
> > detectable symptoms if they tickle a bug.
> > 
> > So why don't we say that, instead of re-hashing output from the earlier
> > fix?
> 
> Hmm, it looks like this already hit 'next', so it is too late to change
> the commit message (although 'next' will get rewound after the release,
> so we _could_ do it then).
> 
> I also was going to suggest these style fixes, which could be applied on
> top (or squashed if we end up going that route). I actually wonder if
> the final tag one could just use two invocations of "git tag -m", but
> it's probably not worth spending too much time on polishing.

Jeff, thanks for corrections. I originally tried to look into invoking
"git tag" two times, but since git tag always creates a reference it
would not be semantically the same as having one referenced tag object
pointing to another tag object which does not have anything in refs/
pointing to it directly.

Maybe the commit text is not good but I tried to explain the reason you
are talking about with "In order to be sure fetching funky tags will
never break ..."

Kirill

> -- >8 --
> Subject: [PATCH] t5500: prettify non-commit tag tests
> 
> We don't need to use backslash continuation, as the "&&"
> already provides continuation (and happily soaks up empty
> lines between commands).
> 
> We can also expand the multi-line printf into a
> here-document, which lets us use line breaks more naturally
> (and avoids another continuation that required us to break
> the natural indentation).
> 
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  t/t5500-fetch-pack.sh | 19 +++++++++++++------
>  1 file changed, 13 insertions(+), 6 deletions(-)
> 
> diff --git a/t/t5500-fetch-pack.sh b/t/t5500-fetch-pack.sh
> index ea6570e819..3d33ab3875 100755
> --- a/t/t5500-fetch-pack.sh
> +++ b/t/t5500-fetch-pack.sh
> @@ -533,19 +533,26 @@ test_expect_success 'test --all wrt tag to non-commits' '
>  	# are reachable only via created tag references.
>  	blob=$(echo "hello blob" | git hash-object -t blob -w --stdin) &&
>  	git tag -a -m "tag -> blob" tag-to-blob $blob &&
> - \
> +
>  	tree=$(printf "100644 blob $blob\tfile" | git mktree) &&
>  	git tag -a -m "tag -> tree" tag-to-tree $tree &&
> - \
> +
>  	tree2=$(printf "100644 blob $blob\tfile2" | git mktree) &&
>  	commit=$(git commit-tree -m "hello commit" $tree) &&
>  	git tag -a -m "tag -> commit" tag-to-commit $commit &&
> - \
> +
>  	blob2=$(echo "hello blob2" | git hash-object -t blob -w --stdin) &&
> -	tag=$(printf "object $blob2\ntype blob\ntag tag-to-blob2\n\
> -tagger author A U Thor <author@example.com> 0 +0000\n\nhello tag" | git mktag) &&
> +	tag=$(git mktag <<-EOF
> +		object $blob2
> +		type blob
> +		tag tag-to-blob2
> +		tagger author A U Thor <author@example.com> 0 +0000
> +
> +		hello tag
> +	EOF
> +	) &&
>  	git tag -a -m "tag -> tag" tag-to-tag $tag &&
> - \
> +
>  	# `fetch-pack --all` should succeed fetching all those objects.
>  	mkdir fetchall &&
>  	(
> -- 
> 2.18.0.rc2.519.gb87ed92113
