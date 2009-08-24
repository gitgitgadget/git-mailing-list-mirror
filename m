Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=0.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,LIST_MIRROR_RECEIVED,RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: (qmail 6959 invoked by uid 107); 24 Aug 2009 08:42:07 -0000
Received: from vger.kernel.org (HELO vger.kernel.org) (209.132.176.167)
    by peff.net (qpsmtpd/0.40) with ESMTP; Mon, 24 Aug 2009 04:42:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751782AbZHXIlp (ORCPT <rfc822;peff@peff.net>);
	Mon, 24 Aug 2009 04:41:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751263AbZHXIlp
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Aug 2009 04:41:45 -0400
Received: from mx2.imag.fr ([129.88.30.17]:53461 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751167AbZHXIlo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Aug 2009 04:41:44 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id n7O8dolW005260
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 24 Aug 2009 10:39:50 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1MfV7L-0005XA-3v; Mon, 24 Aug 2009 10:41:31 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1MfV7L-00082H-2a; Mon, 24 Aug 2009 10:41:31 +0200
To:	skillzero@gmail.com
Cc:	Sanjiv Gupta <sanjiv.gupta@microchip.com>,
	Kai Blin <kai@samba.org>,
	Nanako Shiraishi <nanako3@lavabit.com>, git@vger.kernel.org
Subject: Re: Pulling one commit at a time.
References: <F536B7C316F9474E9F7091239725AC9A02FA7F44@CHN-CL-MAIL01.mchp-main.com>
	<20090824060710.6117@nanako3.lavabit.com>
	<4A92318F.6050105@microchip.com> <200908240946.52813.kai@samba.org>
	<4A92476A.4060205@microchip.com>
	<2729632a0908240133t12eaafd5oe8d50af6d6eec566@mail.gmail.com>
From:	Matthieu Moy <Matthieu.Moy@imag.fr>
Date:	Mon, 24 Aug 2009 10:41:31 +0200
In-Reply-To: <2729632a0908240133t12eaafd5oe8d50af6d6eec566@mail.gmail.com> (skillzero@gmail.com's message of "Mon\, 24 Aug 2009 01\:33\:46 -0700")
Message-ID: <vpqfxbhd2o4.fsf@bauges.imag.fr>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.1.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Mon, 24 Aug 2009 10:39:51 +0200 (CEST)
X-IMAG-MailScanner-Information:	Please contact MI2S MIM  for more information
X-MailScanner-ID: n7O8dolW005260
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check:	1251707992.18217@4k5MIqScgY2s6vVlLcwNvg
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

skillzero@gmail.com writes:

> On Mon, Aug 24, 2009 at 12:55 AM, Sanjiv
> Gupta<sanjiv.gupta@microchip.com> wrote:
>
>> What I would like is to "test *every* commit" available in the public
>> master. There would be no local changes or commits that aren't pushed in the
>> private copy.
>> So I just want to clone one copy from the public master and then just keep
>> pulling commits from the public master one by one and run regressions on
>> each one.
>>
>> It's a damn simple thing in SVN world.
>> $ svn info will give you the current version you are at, assume it is
>> "cur_rev"
>> $ svn update -r `expr $cur_rev + 1`
>> $ build
>> $ test
>
> I'm not sure if this is the best way, but you can use git fetch to get
> the latest stuff from the server without merging it then you can merge
> from origin/master (i.e. the server) into your local master, one
> commit at a time, and verify at each step:

See my other reply, but I really don't think you want to _merge_ one
commit at a time. This would not mean "test each commit" but "test the
interaction between any two commits", which few people would care
about.

The example above in SVN doesn't merge each commit, it just walks
history (assuming the history is linear, the example wouldn't be as
simple if it had to walk /branches/* too). To continue the analogy,
merging commits one by one in Git would be more or less the equivalent
in SVN of:

$ svn status
# Hmm, OK, I have stuff to commit.
$ test
# Yes, it works. But do my changes work too on top of the previous
# commits?
$ while ...; do
    svn update $(($cur_rev - 1))
    build
    test
  done
# If so, then
$ svn update
$ svn commit

That is: test the interaction between your new change with any other
changes in the repository. 'never seen anyone interested by such
thing, but why not ;-).

-- 
Matthieu
