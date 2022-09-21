Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDBB8C6FA82
	for <git@archiver.kernel.org>; Wed, 21 Sep 2022 20:12:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230258AbiIUUM0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Sep 2022 16:12:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229970AbiIUUMZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Sep 2022 16:12:25 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFD3FA4049
        for <git@vger.kernel.org>; Wed, 21 Sep 2022 13:12:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1663791140;
        bh=KJWDbRyfY6BzQKpbK7jH9r+tQLECYiF17bknjSV7e+U=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=MxGVQIniSsSO+nEZUgm2LEyGz+v0W6xPdGDGxQWTBkFUGZ559yk3RoCNzKtVB1GDd
         nlfuqVF9hOGOVwYwom/AxfQ3rSHeXWzBgWy/s7SHmuh5CnSLgtUVYeg2/TVtSMK9Ho
         JpJ7tADuFpJ72Xs0tzm9HloLX8s0jzBxbAhly+mU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.23.115.55] ([89.1.213.188]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MbRfv-1p7y3h2hvV-00brka; Wed, 21
 Sep 2022 22:12:20 +0200
Date:   Wed, 21 Sep 2022 22:12:20 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     Taylor Blau <me@ttaylorr.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH] merge-tree: fix segmentation fault in read-only
 repositories
In-Reply-To: <Yysw/YIxx/JRF4Ph@nand.local>
Message-ID: <26922prr-pn98-40q9-q537-8sp986r07136@tzk.qr>
References: <pull.1362.git.1663774248660.gitgitgadget@gmail.com> <Yysw/YIxx/JRF4Ph@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:XzuuWCIypIgqpY31kuJPhxQQXqF4G21/Lsb3Mg3Ov6ytLSNmTA4
 FK8ABjSLczidKae8lF9b18pU1Nzctm4kZaVp98S6uPbs5K2F/U92xTu++73l6etu1r1uFq3
 P+e1XufcgHPsRES26pZWjv6vDwNlJYqKUFHzULXZmdhwDA2CWMWacKGWk/sFRqnBIpBurr8
 AW5RC+xi918k0V2+/q+ZA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:i6Ei7GDlnuU=:Zm4qbEwl9N/VntwXXBrj9C
 zhnAENUabD4anusR53uGrtiXT/TBhdr0FojiCcWo9FQ2XMPkfTcjj0AAyY6F0TyI7wIJ33HFP
 f1oy+IUpxFj+u/pt+W5loOjioDDszI5dRoTf+AihLJchGPau68Bylt7w5BC9MUY4f77IYe2c9
 9LxUNfigho+U4yPmyiD3NPwQmNzWRbs/eYFRG7GQhyI+E2rCS5MUKkZWu3/j27EU/Kzs+12+q
 CSZdmpqmXozD2LMJ8+9sgelKmrSNZs3Fb++p4A54ziGsB4Uik7ffpHwsFMkx8pd4lc5JbRBPB
 OggQxWD54qGF2SA1M5ssdx/cIoW5d3kzK1ALGYg+aCUrepaYAKxnr39JMpg7dl/RKepUOp0NA
 9pXR9wXO9twyxgQrTrMw9a0bZu96dtGL6j7pAnP5BW5XkZ6oB1O4T/+2MlumlQ+TS4XQ8rxjt
 DCTc5BPTdDk6vPrBgAuT9ijC9m9A1DzKugnp4P4bVwvgFOIZwakKZcsuHVG+Qef3ESCiEtXSb
 HhS7KWipAQxE6xHu9RCzLr5/OZG0fW986NntDBhDOUKD5OhjWojHQHpD61+4TwqSYA17k9WEe
 gkS5ejnd9OE6XJECClMyh3HOLCaTaJScrUBMC64o4K7VYHDzxouu7x4mgbjKDAg6ygGqRliJu
 nKHnw7vUaFPd7aQ+l14b8ZHC8/LF4Jgi3wlDwjv9VuluYJ/ryKQ2yAh1TLKN8nh3HodmP9uV4
 HiMJ5Qql2sIKoV5NvDRQNmA3p15IbhzIGPX+ON29pz2KNT7ZiBF9IKwrIevNWtlUDBh1TZfrz
 INWkrrVuGNk6nXHbZFT+TOUa83AzQIczQDNl+Pm960r8Vu6kkIbdN8yJa0vnagnhfixrVcusv
 pKtAFf4BVU9u04zJVdYX6Iewfg/PLkmgTPqSr123uKBvx6niR3bG03ke01VOzRkTMN6Datizh
 cs9MBWXVuZWLofS2r2CfkH/0gVtXrsmupabe2YP8EtkTPjjSwWVUdUJXmEYqLcswDulYyhlim
 drS7p3eti1aKfSM/w+6iWjJ8O4ckZJnXbAWJRxuUxcGqHNT2GkqgeCwY3ktYZ1H1SM8Pf4vld
 6EQu54M9QjQDMLAeXjTZITmOj38EvPtg8VFZcAlTTM19XbWtphQ3xF8Y0Yt+TVih7FvMr6CuB
 qCWwfYSoKUuApzckpKx78R4Q2H
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Taylor,

On Wed, 21 Sep 2022, Taylor Blau wrote:

> On Wed, Sep 21, 2022 at 03:30:48PM +0000, Johannes Schindelin via GitGit=
Gadget wrote:
> > diff --git a/builtin/merge-tree.c b/builtin/merge-tree.c
> > index ae5782917b9..25c7142a882 100644
> > --- a/builtin/merge-tree.c
> > +++ b/builtin/merge-tree.c
> > @@ -412,6 +412,7 @@ static int real_merge(struct merge_tree_options *o=
,
> >  	struct commit_list *merge_bases =3D NULL;
> >  	struct merge_options opt;
> >  	struct merge_result result =3D { 0 };
> > +	const struct object_id *tree_oid;
> >
> >  	parent1 =3D get_merge_parent(branch1);
> >  	if (!parent1)
> > @@ -446,7 +447,8 @@ static int real_merge(struct merge_tree_options *o=
,
> >  	if (o->show_messages =3D=3D -1)
> >  		o->show_messages =3D !result.clean;
> >
> > -	printf("%s%c", oid_to_hex(&result.tree->object.oid), line_terminatio=
n);
> > +	tree_oid =3D result.tree ? &result.tree->object.oid : null_oid();
> > +	printf("%s%c", oid_to_hex(tree_oid), line_termination);
>
> My understanding is that we can get a clean result from
> merge_incore_recursive(), but still have failed to write the physical
> tree object out?

No, we do not get a clean result _because_ we have failed to write the
tree object.

> In other words, the two sides *could* have been merged, but the actual
> result of doing that merge couldn't be written to disk (e.g., because
> the repository is read-only or some such)?

Since we could not write the tree object, we cannot say whether the
overall merge could have been merged or not.

All we can say is whether the merge has been clean _so far_ or not. Which
is not very helpful.

Now, taking that thought a bit further, I did get suspicious that my patch
still contained a bug, and lo and behold, this bug really was there: when
the merge _has_ been clean so far, we report success (via exit code 0),
even if the tree could not be written, and therefore the `git merge-tree`
command should have failed!

I fixed the bug in the upcoming v2 and extended the test case to verify
that this bug no longer exists.

> If so, then this approach makes sense, and I agree with your idea to
> use the all-zeros OID instead of the empty tree one. It would be
> nice(r?) if we could just abort this command earlier, since `merge-tree`
> promises that we'll write the result out as an object. So I don't think
> a non-zero exit before we have to print the resulting tree object would
> be unexpected.

The idea of aborting the command earlier might make sense in isolation,
and when you're familiar with Git's built-ins taking the easy `die()` way
out upon failure without having to bother to release resources.

However, when you keep in mind that the `merge-tree` command is far from
its full potential and that really interesting ideas are still to be
implemented, some even well on their way like batched merges (see
https://github.com/gitgitgadget/git/pull/1361), it starts to become a much
better idea to keep the code as libified as possible, without any aborts.
Such an abort in the middle of the code path would interfere horribly with
the idea of batched merges.

> But I don't have a strong feeling about it either way. So, if you want
> to proceed here and just emit the all-zeros OID, I think that is a fine
> approach.
>
> > diff --git a/t/t4301-merge-tree-write-tree.sh b/t/t4301-merge-tree-wri=
te-tree.sh
> > index 28ca5c38bb5..e56b1ba6e50 100755
> > --- a/t/t4301-merge-tree-write-tree.sh
> > +++ b/t/t4301-merge-tree-write-tree.sh
> > @@ -810,4 +810,12 @@ test_expect_success 'can override merge of unrela=
ted histories' '
> >  	test_cmp expect actual
> >  '
> >
> > +test_expect_success 'merge-ort fails gracefully in a read-only reposi=
tory' '
> > +	git init --bare read-only &&
> > +	git push read-only side1 side2 &&
> > +	test_when_finished "chmod -R u+w read-only" &&
>
> Do we care about keeping this read-only repository around after the
> test is done? It seems odd to have a directory called "read-only" be
> user-writable. I'd probably just as soon replace this with:
>
>   test_when_finished "rm -fr read-only" &&

Speaking from way more experience debugging CI failures than I care to
have, it makes a lot of sense to keep this directory until the complete
test script finishes with utter success. Because if the test case fails,
and the CI tars up the "trash" directory, and the crucial files to
diagnose what might have gone wrong are missing from that tar file, my own
future life will be a lot harder than I like.

Ciao,
Dscho
