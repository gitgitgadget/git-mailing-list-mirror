Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AA6AD1F609
	for <e@80x24.org>; Tue, 28 May 2019 01:58:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727857AbfE1B6A (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 May 2019 21:58:00 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:49372 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727654AbfE1B6A (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 May 2019 21:58:00 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id EF16F1F462;
        Tue, 28 May 2019 01:57:59 +0000 (UTC)
Date:   Tue, 28 May 2019 01:57:59 +0000
From:   Eric Wong <e@80x24.org>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Todd Zullinger <tmz@pobox.com>, Chris Mayo <aklhfex@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>,
        git@vger.kernel.org
Subject: Re: [PATCH] send-email: remove documented requirement for
 Net::SMTP::SSL
Message-ID: <20190528015759.GA13521@dcvr>
References: <20190526172242.13000-1-aklhfex@gmail.com>
 <20190527193517.GA22013@dcvr>
 <20190528000544.GX3654@pobox.com>
 <20190528013128.ynvvci4ul2exiyef@dcvr>
 <87h89fmjzc.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87h89fmjzc.fsf@evledraar.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> wrote:
> On Tue, May 28 2019, Eric Wong wrote:
> > Todd Zullinger <tmz@pobox.com> wrote:
> >> Something like:
> >>
> >> diff --git i/git-send-email.perl w/git-send-email.perl
> >> index 24859a7bc3..84ac03994d 100755
> >> --- i/git-send-email.perl
> >> +++ w/git-send-email.perl
> >> @@ -1465,7 +1465,7 @@ sub send_message {
> >>  		}
> >>
> >>  		require Net::SMTP;
> >> -		my $use_net_smtp_ssl = version->parse($Net::SMTP::VERSION) < version->parse("2.34");
> >> +		my $use_net_smtp_ssl = Net::SMTP->can('starttls') ? 0 : 1;
> >>  		$smtp_domain ||= maildomain();
> >>
> >>  		if ($smtp_encryption eq 'ssl') {
> >
> > Looks much better to me.
> 
> Same, but to bikeshed a bit, at this point we can just do:
>     
>     diff --git a/git-send-email.perl b/git-send-email.perl
>     index 24859a7bc3..4ad2091a49 100755
>     --- a/git-send-email.perl
>     +++ b/git-send-email.perl
>     @@ -1468 +1467,0 @@ sub send_message {
>     -               my $use_net_smtp_ssl = version->parse($Net::SMTP::VERSION) < version->parse("2.34");
>     @@ -1485 +1484 @@ sub send_message {
>     -                       if ($use_net_smtp_ssl) {
>     +                       if (Net::SMTP->can('starttls')) {
>     @@ -1507 +1506 @@ sub send_message {
>     -                               if ($use_net_smtp_ssl) {
>     +                               if (Net::SMTP->can('starttls')) {

Higher probability of a typo slipping through the cracks, though :)

(I was just bit by a similar case with hashes that would've been
 caught by "use fields")
