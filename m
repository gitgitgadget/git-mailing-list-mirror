Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 555431F403
	for <e@80x24.org>; Mon, 11 Jun 2018 09:58:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932694AbeFKJ6E (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Jun 2018 05:58:04 -0400
Received: from mail187-21.suw11.mandrillapp.com ([198.2.187.21]:22022 "EHLO
        mail187-21.suw11.mandrillapp.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932453AbeFKJ6D (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 11 Jun 2018 05:58:03 -0400
X-Greylist: delayed 900 seconds by postgrey-1.27 at vger.kernel.org; Mon, 11 Jun 2018 05:58:03 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=mandrill; d=nexedi.com;
 h=From:Subject:To:Cc:Message-Id:References:In-Reply-To:Date:MIME-Version:Content-Type:Content-Transfer-Encoding; i=kirr@nexedi.com;
 bh=Tz0mRjWlIBzAhlrZng70NG/e0dk7STR029SYVj1rU/4=;
 b=SeUei1+tT1PjMVCcDjKjcSsO29Ko1KcYKfGA8NaM1b8gxfNu4odXdj63djIt7Y+M+3zuFZ1sSoQX
   QEzqET/4GZaipbKsTIItsMg67zI0lEbVAzIrE2a9njP7vQ30ADtDUtbRCJVOwG1GXslLsHoxqRof
   yUdRRRQJTAD3jMeFO8A=
Received: from pmta01.mandrill.prod.suw01.rsglab.com (127.0.0.1) by mail187-21.suw11.mandrillapp.com id h3p3qm174i4g for <git@vger.kernel.org>; Mon, 11 Jun 2018 09:43:03 +0000 (envelope-from <bounce-md_31050260.5b1e4426.v1-51bcbfb8563343caa3603307a7ec04f3@mandrillapp.com>)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandrillapp.com; 
 i=@mandrillapp.com; q=dns/txt; s=mandrill; t=1528710182; h=From : 
 Subject : To : Cc : Message-Id : References : In-Reply-To : Date : 
 MIME-Version : Content-Type : Content-Transfer-Encoding : From : 
 Subject : Date : X-Mandrill-User : List-Unsubscribe; 
 bh=Tz0mRjWlIBzAhlrZng70NG/e0dk7STR029SYVj1rU/4=; 
 b=fxkB0hNg1FgLBQkhJD4ufQVA2kmu5k4Bl/ygmucmzbgeF0t7E64Ie980KZb2O66TulpxRv
 KF3NN74HwI43WSWlH6FKSCclx4LbRFwRTlFWpWAuRPdYA7fHGDgMRxFmukDe0XCVLE/u+MbK
 AYTknPkNF+BrhGNJ1r1TWk4p4oHZE=
From:   Kirill Smelkov <kirr@nexedi.com>
Subject: Re: [PATCH v2] fetch-pack: don't try to fetch peel values with --all
Received: from [87.98.221.171] by mandrillapp.com id 51bcbfb8563343caa3603307a7ec04f3; Mon, 11 Jun 2018 09:43:02 +0000
To:     Jeff King <peff@peff.net>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Brandon Williams <bmwill@google.com>,
        Takuto Ikuta <tikuta@chromium.org>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Git List <git@vger.kernel.org>
Message-Id: <20180611094255.GA15563@deco.navytux.spb.ru>
References: <20180610143231.7131-1-kirr@nexedi.com> <20180611042016.GA31642@sigill.intra.peff.net> <20180611044710.GB31642@sigill.intra.peff.net> <CAPig+cT73d0rYoSbt7oHVG4MYHVvjKidP0ogRwV+9F73jcjZEA@mail.gmail.com> <20180611055357.GA16430@sigill.intra.peff.net>
In-Reply-To: <20180611055357.GA16430@sigill.intra.peff.net>
X-Report-Abuse: Please forward a copy of this message, including all headers, to abuse@mandrill.com
X-Report-Abuse: You can also report abuse here: http://mandrillapp.com/contact/abuse?id=31050260.51bcbfb8563343caa3603307a7ec04f3
X-Mandrill-User: md_31050260
Date:   Mon, 11 Jun 2018 09:43:02 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff,

On Mon, Jun 11, 2018 at 01:53:57AM -0400, Jeff King wrote:
> On Mon, Jun 11, 2018 at 01:28:23AM -0400, Eric Sunshine wrote:
> 
> > On Mon, Jun 11, 2018 at 12:47 AM, Jeff King <peff@peff.net> wrote:
> > > Subject: fetch-pack: don't try to fetch peeled values with --all
> > > [...]
> > > Original report and test from Kirill Smelkov.
> > >
> > > Signed-off-by: Kirill Smelkov <kirr@nexedi.com>
> > > Signed-off-by: Jeff King <peff@peff.net>
> > > ---
> > > diff --git a/t/t5500-fetch-pack.sh b/t/t5500-fetch-pack.sh
> > > @@ -506,30 +506,45 @@ test_expect_success 'test missing ref before existing' '
> > > +test_expect_success 'test --all wrt tag to non-commits' '
> > > +       blob_sha1=$(echo "hello blob" | git hash-object -t blob -w --stdin) &&
> > > +       git tag -a -m "tag -> blob" tag-to-blob $blob_sha1 &&
> > > +       tree_sha1=$(printf "100644 blob $blob_sha1\tfile\n" | git mktree) &&
> > 
> > Perhaps modernize these names to 'blob_oid' and 'tree_oid', or even
> > simpler, just 'blob' and 'tree'.
> 
> Looking deeper, we do not need these trees and blobs at all. The problem
> is really just a tag that peels to an object that is not otherwise a ref
> tip, regardless of its type.

Thanks for feedback and for coming up with the fix. Sure, I'm ok with
moving the test into your patch. However, even if a test becomes
different - narrowing down root of _current_ problem, I suggest to also
keep explicitly testing tag-to-blob and tag-to-tree (and if we really
also want tag-to-commit and tag-to-tag) behaviour. Reason is: if we skip
those now, they can potentially break in the future.

I would also suggest to fix upload-pack, as it is just not consistent to
reject sending objects that were advertised, and so can strike again
some way in the future. After all git.git's fetch-pack is not the only
git client that should be possible to interact with git.git's
upload-pack on remote side, right?

By the way, another problem I noticed with fetch-pack is that fetching
with --all from completely empty repository also fails:

	.../r$ git init --bare repo.git
	Initialized empty Git repository in /home/kirr/tmp/trashme/r/repo.git/
	.../r$ mkdir clone
	.../r$ cd clone/
	.../r/clone$ git init
	Initialized empty Git repository in /home/kirr/tmp/trashme/r/clone/.git/
	.../r/clone$ git fetch-pack --all ../repo.git/
	fatal: no matching remote head
	.../r/clone$ echo $?
	128
	.../r/clone$ git ls-remote ../repo.git/
	.../r/clone$ echo $?
	0
	.../r/clone$ git fetch ../repo.git/ 'refs/*:refs/repo/*'
	.../r/clone$ echo $?
	0

I'm not sure, but I would say that `fetch-pack --all` from an empty
repository should not fail and should just give empty output as fetch
does.

For the reference all the cases presented here are real - they appear in
our repositories on lab.nexedi.com for which I maintain the backup, and
I've noticed them in the process of switching git-backup from using
fetch to fetch-pack here:

https://lab.nexedi.com/kirr/git-backup/blob/0ab7bbb6/git-backup.go#L436

Kirill



> So below is a patch that simplifies the test even further (the actual
> code change is the same).
> 
> > > +       git tag -a -m "tag -> tree" tag-to-tree $tree_sha1 &&
> > > +       mkdir fetchall &&
> > > +       (
> > > +               cd fetchall &&
> > > +               git init &&
> > > +               git fetch-pack --all .. &&
> > 
> > Simpler:
> > 
> >     git init fetchall &&
> >     (
> >         cd fetchall &&
> >         git fetch-pack --all .. &&
> > 
> > Although, I see that this script already has a mix of the two styles
> > (simpler and not-so-simple), so...
> 
> The nearby tests actually reuse the "client" directory. We can do that,
> too, if we simply create new objects for our test, to make sure they
> still need fetching. See below (we could also use "git -C" there, but
> the subshell matches the other tests).
> 
> -- >8 --
> Subject: fetch-pack: don't try to fetch peel values with --all
> 
> When "fetch-pack --all" sees a tag-to-blob on the remote, it
> tries to fetch both the tag itself ("refs/tags/foo") and the
> peeled value that the remote advertises ("refs/tags/foo^{}").
> Asking for the object pointed to by the latter can cause
> upload-pack to complain with "not our ref", since it does
> not mark the peeled objects with the OUR_REF (unless they
> were at the tip of some other ref).
> 
> Arguably upload-pack _should_ be marking those peeled
> objects. But it never has in the past, since clients would
> generally just ask for the tag and expect to get the peeled
> value along with it. And that's how "git fetch" works, as
> well as older versions of "fetch-pack --all".
> 
> The problem was introduced by 5f0fc64513 (fetch-pack:
> eliminate spurious error messages, 2012-09-09). Before then,
> the matching logic was something like:
> 
>   if (refname is ill-formed)
>      do nothing
>   else if (doing --all)
>      always consider it matched
>   else
>      look through list of sought refs for a match
> 
> That commit wanted to flip the order of the second two arms
> of that conditional. But we ended up with:
> 
>   if (refname is ill-formed)
>     do nothing
>   else
>     look through list of sought refs for a match
> 
>   if (--all and no match so far)
>     always consider it matched
> 
> That means tha an ill-formed ref will trigger the --all
> conditional block, even though we should just be ignoring
> it. We can fix that by having a single "else" with all of
> the well-formed logic, that checks the sought refs and
> "--all" in the correct order.
> 
> Reported-by: Kirill Smelkov <kirr@nexedi.com>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  fetch-pack.c          |  8 ++++----
>  t/t5500-fetch-pack.sh | 10 ++++++++++
>  2 files changed, 14 insertions(+), 4 deletions(-)
> 
> diff --git a/fetch-pack.c b/fetch-pack.c
> index a320ce9872..cc7a42fee9 100644
> --- a/fetch-pack.c
> +++ b/fetch-pack.c
> @@ -657,11 +657,11 @@ static void filter_refs(struct fetch_pack_args *args,
>  				}
>  				i++;
>  			}
> -		}
>  
> -		if (!keep && args->fetch_all &&
> -		    (!args->deepen || !starts_with(ref->name, "refs/tags/")))
> -			keep = 1;
> +			if (!keep && args->fetch_all &&
> +			    (!args->deepen || !starts_with(ref->name, "refs/tags/")))
> +				keep = 1;
> +		}
>  
>  		if (keep) {
>  			*newtail = ref;
> diff --git a/t/t5500-fetch-pack.sh b/t/t5500-fetch-pack.sh
> index d4f435155f..5726f83ea3 100755
> --- a/t/t5500-fetch-pack.sh
> +++ b/t/t5500-fetch-pack.sh
> @@ -518,6 +518,16 @@ test_expect_success 'test --all, --depth, and explicit tag' '
>  	) >out-adt 2>error-adt
>  '
>  
> +test_expect_success 'test --all with tag to non-tip' '
> +	git commit --allow-empty -m non-tip &&
> +	git commit --allow-empty -m tip &&
> +	git tag -m "annotated" non-tip HEAD^ &&
> +	(
> +		cd client &&
> +		git fetch-pack --all ..
> +	)
> +'
> +
>  test_expect_success 'shallow fetch with tags does not break the repository' '
>  	mkdir repo1 &&
>  	(
> -- 
> 2.18.0.rc1.446.g4486251e51
