Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9EEE21FCA5
	for <e@80x24.org>; Thu, 29 Dec 2016 15:37:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752883AbcL2PhR (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Dec 2016 10:37:17 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45324 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752863AbcL2PhP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Dec 2016 10:37:15 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 11C9C4E4CA;
        Thu, 29 Dec 2016 15:37:15 +0000 (UTC)
Received: from localhost (ovpn-116-25.gru2.redhat.com [10.97.116.25])
        by int-mx13.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id uBTFbDU0012021;
        Thu, 29 Dec 2016 10:37:14 -0500
Date:   Thu, 29 Dec 2016 13:37:09 -0200
From:   Eduardo Habkost <ehabkost@redhat.com>
To:     Pranit Bauva <pranit.bauva@gmail.com>
Cc:     Stefan Beller <sbeller@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Paul Tan <pyokagan@gmail.com>
Subject: Re: [PATCH v2] am: add am.signoff add config variable
Message-ID: <20161229153709.GA23595@thinpad.lan.raisama.net>
References: <20161228183501.15068-1-ehabkost@redhat.com>
 <CAGZ79kaBpC5ym2N_fMZHDmL4gGpU8pFAsupCE4aTdENh+=z72g@mail.gmail.com>
 <20161228191142.GF3441@thinpad.lan.raisama.net>
 <20161228191928.GH3441@thinpad.lan.raisama.net>
 <CAFZEwPOPMrCXTc+SMhjGSnPKLmefcde4MgJsz7n5rBApACZOug@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFZEwPOPMrCXTc+SMhjGSnPKLmefcde4MgJsz7n5rBApACZOug@mail.gmail.com>
X-Fnord: you can see the fnord
User-Agent: Mutt/1.7.1 (2016-10-04)
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.26
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Thu, 29 Dec 2016 15:37:15 +0000 (UTC)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 29, 2016 at 01:29:33PM +0530, Pranit Bauva wrote:
> Hey Eduardo,
> 
> On Thu, Dec 29, 2016 at 12:49 AM, Eduardo Habkost <ehabkost@redhat.com> wrote:
> >> test_expect_success '--no-signoff overrides am.signoff' '
> >>       rm -fr .git/rebase-apply &&
> >>       git reset --hard first &&
> >>       test_config am.signoff true &&
> >>       git am --no-signoff <patch2 &&
> >>       printf "%s\n" "$signoff" >expected &&
> >>       git cat-file commit HEAD^ | grep "Signed-off-by:" >actual &&
> >>       test_cmp expected actual &&
> >>       git cat-file commit HEAD | grep "Signed-off-by:" >actual &&
> >>       test_must_be_empty actual
> >> '
> >>
> >> The test fails because the second "grep" command returns a
> >> non-zero exit code. Any suggestions to avoid that problem in a
> >> more idiomatic way?
> >
> > I just found out that "test_must_fail grep ..." is a common
> > idiom, so what about:
> 
> Is there any particular reason to use "grep" instead of "test_cmp"? To
> check for non-zero error code, you can always use "! test_cmp".

The test code is checking only the "Signed-off-by" lines, not the
whole commit message. "test_cmp" would require recovering the
entire contents of the original commit message, which would add
complexity to the test code.

-- 
Eduardo
