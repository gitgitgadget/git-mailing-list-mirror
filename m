Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 09A5B20899
	for <e@80x24.org>; Fri, 11 Aug 2017 17:14:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753139AbdHKRN7 (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 Aug 2017 13:13:59 -0400
Received: from smtprelay05.ispgateway.de ([80.67.31.100]:31102 "EHLO
        smtprelay05.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752883AbdHKRN6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Aug 2017 13:13:58 -0400
X-Greylist: delayed 1199 seconds by postgrey-1.27 at vger.kernel.org; Fri, 11 Aug 2017 13:13:58 EDT
Received: from [46.91.38.38] (helo=book.hvoigt.net)
        by smtprelay05.ispgateway.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <hvoigt@hvoigt.net>)
        id 1dgDC7-0003iG-U0; Fri, 11 Aug 2017 18:53:56 +0200
Date:   Fri, 11 Aug 2017 18:53:54 +0200
From:   Heiko Voigt <hvoigt@hvoigt.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     Jens Lehmann <Jens.Lehmann@web.de>,
        Junio C Hamano <gitster@pobox.com>,
        Brandon Williams <bmwill@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 02/15] submodule: don't use submodule_from_name
Message-ID: <20170811165354.GA1472@book.hvoigt.net>
References: <20170725213928.125998-1-bmwill@google.com>
 <20170725213928.125998-3-bmwill@google.com>
 <CAGZ79kY9Pdk5C8=k-AQpCPwo3q9Jzfg9A93UQxGyyf_OyrMS_Q@mail.gmail.com>
 <xmqqwp6uq56s.fsf@gitster.mtv.corp.google.com>
 <a3650c9a-fa42-09e6-efcd-f912d5ffc042@web.de>
 <CAGZ79kZxprtLGOzURHaxc5YzviSj_2Kx23v=gjr2uFb+tbNfjw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGZ79kZxprtLGOzURHaxc5YzviSj_2Kx23v=gjr2uFb+tbNfjw@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

sorry for the late reply, just stumpled upon this.

On Mon, Jul 31, 2017 at 01:43:04PM -0700, Stefan Beller wrote:
> On Sun, Jul 30, 2017 at 6:43 AM, Jens Lehmann <Jens.Lehmann@web.de> wrote:
> > Am 26.07.2017 um 23:06 schrieb Junio C Hamano:
> >>
> >> Stefan Beller <sbeller@google.com> writes:
> >>
> >>> Rereading the archives, there was quite some discussion on the design
> >>> of these patches, but these lines of code did not get any attention
> >>>
> >>>      https://public-inbox.org/git/4CDB3063.5010801@web.de/
> >>>
> >>> I cc'd Jens in the hope of him having a good memory why he
> >>> wrote the code that way. :)
> >>
> >>
> >> Thanks for digging.  I wouldn't be surprised if this were a fallback
> >> to help a broken entry in .gitmodules that lack .path variable, but
> >> we shouldn't be sweeping the problem under the rug like that.
> >
> >
> > Sorry to disappoint you ;-) I added this in 7dce19d374 because
> > submodule by path lookup back then only parsed the checked out
> > .gitmodules file.
> 
> This is still the case AFAICT, as we never ask for a specific .gitmodules
> file identified by sha1 of the commit.

This was actually part of my original approach[1] but it seems I never got
around to implement that last part for which I originally started the
submodule config API: Proper recursive fetch.

I still have a patch for moved submodules lying around which pass a commit id
for a gitmodules file. That particular patch is quite simple and finished but
I was planning to include that in the finished fetch series. So I can have a
look if I can quickly update that to the current state, so we can at least have
one proper user of the submodule config API.

> > So looking for it by name was a good guess to
> > fetch a new submodule that wasn't present in the current HEAD's
> > .gitmodules, as the path is used as the default name in "git
> > submodule add".

I will have a look whether we can easily replace this hack with the proper
lookup now. Lets see how many low hanging fruits we have lying around
for recursive fetch. The full blown implementation including cloning of
new submodules might still take some time...

Cheers Heiko

[1] https://public-inbox.org/git/f5baa2acc09531a16f4f693eebbe60706bb8ed1e.1361751905.git.hvoigt@hvoigt.net/
