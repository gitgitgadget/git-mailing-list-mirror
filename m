Return-Path: <SRS0=+hCi=DN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA1EAC41604
	for <git@archiver.kernel.org>; Tue,  6 Oct 2020 19:31:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 77C442065C
	for <git@archiver.kernel.org>; Tue,  6 Oct 2020 19:31:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="FYYm33US"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727112AbgJFTbX (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Oct 2020 15:31:23 -0400
Received: from mout.gmx.net ([212.227.17.20]:35437 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726981AbgJFTbX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Oct 2020 15:31:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1602012678;
        bh=jtSsO8O/n24JgvgwV7Ivhh27Up4ugatFNLkoopgKuDs=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=FYYm33USoWO1+pb4y6RFNdKIaOVek17vSWBt1qJ5I5iC8KojWyI7avwb2v0ovoQZP
         7+eF1V94YMc5EUHtmfNQatienACb4gb88opnFWIFisjdW0LNY3tVTP6xPs0b94S39E
         MijAlN8Ui7XcKgXCWg0kB8AM6jePNridHsB8SIjg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.20.73.169] ([89.1.215.4]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MHXFx-1kD0ei39Xd-00DYb1; Tue, 06
 Oct 2020 21:31:17 +0200
Date:   Tue, 6 Oct 2020 21:31:16 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Denton Liu <liu.denton@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 2/2] checkout: learn to respect checkout.guess
In-Reply-To: <xmqqtuv75ha8.fsf@gitster.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.2010062123060.50@tvgsbejvaqbjf.bet>
References: <cover.1601810233.git.liu.denton@gmail.com> <8172602f6f1bbdfe39c8a1219dd3b9a222eb65fa.1601810233.git.liu.denton@gmail.com> <xmqqwo057ul5.fsf@gitster.c.googlers.com> <20201006080730.GA2419589@generichostname>
 <xmqqtuv75ha8.fsf@gitster.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:9E15qLot27msmUjf2Rm26DJN52p6WBzXaleL3yeuwzmr1k/fp39
 +3Y4fNRE4BUgiEMd5mvTR5I3HFm4VV41Oc4r2Stdbjy/I0xQ1Wxslere7SRzFYBRl1TVI4i
 kPBDlYM3fm8t/bzIEGoNWzIhyMBjy5E6ceHsJCzLCzEUbCLmDKiOgAWND5lGc7sEA//MmJK
 aZ/7sRGMgKZuqosNaYT3g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:TFG6PNmaxnQ=:+kpmi/R7qIfX9BFQDXul2d
 MsL8gYb4urTJ9J3l9Dm0SNwvjmNfQpf9fWraGMjLWUcIPqIawTTylcTJbB7rajvajki/G0O+M
 bk8j3cnBuKzHaG0q7v5bOzLntwtArH127IU2tMBCDq+AzRbZ7fsPIe5foPESEPrJSaGYkUodI
 HZLqvwh/QyifwYIoZPwZaJELQlNOabmdLLRcUvSXoMnQwAqt7MfG60nQ7ZKLuvSQza4YbZzLW
 HXAjsT8sI6ugTN0oD1Nqb3LhRb6r2dcqyaDJGdMoY4TgvtvjVlGX4krqMXNXwfLFp0OzwGMLM
 UpY8BzZtw6ufnutcbyPCTl02o/1QEh89J9FKe95eHdQERkIhgwAbiKCUgn6AEMJi2jHMvkkNt
 KF8VkIYKhTvZKJSOUsAGwlDLmf2OsSG+l//RHcv61zMJmu/vHWeG8XYCEWG/ZvsRPaz4bD7gE
 BXEDIDzcH15ch+Dv/mS0oVFQzA6WK3I3DZ6aXpjAFSBQGV8Z/YY7IbYefPu0NpUUZrDNm1YKL
 hCxsb+6bxpSY7RHOSsYKZ5Q1H8Q9GlC1L17Sq83j81Z43unnElQH0JE4y+Qz05SaDYYMxqpVM
 EAmiROzvfznKDKSA8WhpAcysB8DbH8AUG44+yPW2HGJmLprWnbhuCunUqYYCZI+GpPsAYBggE
 XWHNbmnoIqkh9cWUMJWl7ykwh97zmvxQnZueYPdP80gEUWXHt7fvG6CrkcGgwgeMg4g7CgEUz
 HFi56UeusBpZK8r8sCet62KvtAhY1mY8T4ACbiuaMplpz5jS9UC5pxKshfSo2LwLqXeh8CXZ8
 7sDFH61mAH8rqU9i1e38Reads3UDkkxMmQ3t4BYqgMQjYPcxfSjEojBP6VyufwDqC+eYrXctz
 sTka8u6kmLQyUls5YPlV7FntdoJMKmqS9qQFm0JI3o69I2mK9W05f6rmCJDYeksQuWRozA1RR
 8/joc8Nl871SXds4+10lRgNyqGS6QaBM1NdvOxR8hSL0ksHgaWZsl+q8Db6rjvxc+J2pvhLnD
 /R8GUvGR06G6GYz/FBop3in+cLHUQ3D11wG2NMNAVs9J4m4ETaCGLtbPHeW4oHGzIujxj4z9y
 +zxuomR0xxkGUm9yr8hZ7TYC6RRH0QAiLtdBUEsKXm0N/tNuzOqS5qUWUUgxeByVxf5xoKS76
 CmZZ/bNBhMR1eJ169W16+B4xEXTymjXoilADlDRvz9+CDEe6av9qfZekClX+VdEZ+dRjbnphx
 kUNca7PRMoZxmU+BbKqy1OLfP1WnCHxnyj5Mamw==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Tue, 6 Oct 2020, Junio C Hamano wrote:

> Denton Liu <liu.denton@gmail.com> writes:
>
> > On Sun, Oct 04, 2020 at 10:46:14AM -0700, Junio C Hamano wrote:
> >> Denton Liu <liu.denton@gmail.com> writes:
> >>
> >> > The current behavior of git checkout/switch is that --guess is curr=
ently
> >> > enabled by default. However, some users may not wish for this to ha=
ppen
> >> > automatically. Instead of forcing users to specify --no-guess manua=
lly
> >> > each time, teach these commands the checkout.guess configuration
> >> > variable that gives users the option to set a default behavior.
> >> >
> >> > Teach the completion script to recognize the new config variable an=
d
> >> > disable DWIM logic if it is set to false.
> >> >
> >> > Signed-off-by: Denton Liu <liu.denton@gmail.com>
> >> > ---
> >>
> >> Asking for input from Dscho on how to futureproof the tests along
> >> the same line as js/default-branch-name-part-2 topic.
> >
> > Perhaps we could extract lists that are repeated often into common fil=
es
> > so that they only need to be changed in one place? Something like this=
:
>
> or we can feed a prefix that is not 'm' so that master, main, or
> maint branches are not involved at all in the completion?

While I appreciate the consideration, the issue should be easy enough to
address. I don't think we need to worry too much about that in the context
of this here patch series.

Ciao,
Dscho

>
> >
> > -- >8 --
> > diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
> > index 7b7bc6e4bd..86da44231d 100755
> > --- a/t/t9902-completion.sh
> > +++ b/t/t9902-completion.sh
> > @@ -1240,8 +1240,8 @@ test_expect_success '__git_complete_fetch_refspe=
cs - fully qualified & prefix' '
> >  	test_cmp expected out
> >  '
> >
> > -test_expect_success 'git switch - with no options, complete local bra=
nches and unique remote branch names for DWIM logic' '
> > -	test_completion "git switch " <<-\EOF
> > +test_expect_success 'prepare expect files for DWIM tests' '
> > +	cat >local-and-unique-remote <<-\EOF &&
> >  	branch-in-other Z
> >  	master Z
> >  	master-in-other Z
> > @@ -1249,6 +1249,10 @@ test_expect_success 'git switch - with no optio=
ns, complete local branches and u
> >  	EOF
> >  '
> >
> > +test_expect_success 'git switch - with no options, complete local bra=
nches and unique remote branch names for DWIM logic' '
> > +	test_completion "git switch " <local-and-unique-remote
> > +'
> > +
> >  test_expect_success 'git checkout - completes refs and unique remote =
branches for DWIM' '
> >  	test_completion "git checkout " <<-\EOF
> >  	HEAD Z
>
