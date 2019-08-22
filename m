Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 84BD91F461
	for <e@80x24.org>; Thu, 22 Aug 2019 22:38:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388038AbfHVWiC convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Thu, 22 Aug 2019 18:38:02 -0400
Received: from mga07.intel.com ([134.134.136.100]:4018 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731958AbfHVWiC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Aug 2019 18:38:02 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Aug 2019 15:38:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,418,1559545200"; 
   d="scan'208";a="378676876"
Received: from orsmsx108.amr.corp.intel.com ([10.22.240.6])
  by fmsmga005.fm.intel.com with ESMTP; 22 Aug 2019 15:38:01 -0700
Received: from orsmsx161.amr.corp.intel.com (10.22.240.84) by
 ORSMSX108.amr.corp.intel.com (10.22.240.6) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 22 Aug 2019 15:38:00 -0700
Received: from orsmsx121.amr.corp.intel.com ([169.254.10.57]) by
 ORSMSX161.amr.corp.intel.com ([169.254.4.172]) with mapi id 14.03.0439.000;
 Thu, 22 Aug 2019 15:38:00 -0700
From:   "Keller, Jacob E" <jacob.e.keller@intel.com>
To:     Junio C Hamano <gitster@pobox.com>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Jacob Keller <jacob.keller@gmail.com>
Subject: RE: [PATCH] git-submodule: fix expansion of depth for cmd_update
Thread-Topic: [PATCH] git-submodule: fix expansion of depth for cmd_update
Thread-Index: AQHVWSiQ3p+7c+StnkKDZgOFZGN2f6cHp0q5gAAaSzA=
Date:   Thu, 22 Aug 2019 22:38:00 +0000
Message-ID: <02874ECE860811409154E81DA85FBB5896860344@ORSMSX121.amr.corp.intel.com>
References: <20190822203114.18805-1-jacob.e.keller@intel.com>
 <xmqqh868oqxv.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqh868oqxv.fsf@gitster-ct.c.googlers.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiZmNhY2U5MjQtMTg0MS00MzRkLTlhMjctZjY0NjgwZDk0YmE0IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiSjQzWDdpSG12RFZzSTZcL0ptc0JxZUhUYWxnWFpVaEhBVUl5a3VqMUNYcDhPRTA1VWkzR3N4RktNU2ZXRHBOaGoifQ==
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-originating-ip: [10.22.254.140]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> -----Original Message-----
> From: git-owner@vger.kernel.org [mailto:git-owner@vger.kernel.org] On Behalf Of
> Junio C Hamano
> Sent: Thursday, August 22, 2019 2:01 PM
> To: Keller, Jacob E <jacob.e.keller@intel.com>
> Cc: git@vger.kernel.org; Jacob Keller <jacob.keller@gmail.com>
> Subject: Re: [PATCH] git-submodule: fix expansion of depth for cmd_update
> 
> Jacob Keller <jacob.e.keller@intel.com> writes:
> 
> > From: Jacob Keller <jacob.keller@gmail.com>
> >
> > The depth variable already contains "--depth=", so expanding it with an
> > additional --depth when invoking the update-clone git submodule--helper
> > is incorrect.
> >
> > Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
> > ---
> >
> > I'm *reasonably* sure this is correct, but I am not sure how to test it.
> > It's possible that it expands to "--depth --depth=N" and somehow this gets
> > handled properly?
> 
> I agree with your eyeballing of all the assignments to the variable,
> and other references to $depth take either one of these two forms:
> 
> 	git submodule--helper ... ${depth:+"$depth"} ...
> 	git submodule--helper ... $depth ...
> 
> As long as "git submodule ... --depth <depth> ..." gets called with
> <depth> that does not have $IFS, either would work fine, but the
> former is correct even when <depth> has problematic characters in it
> and your patch uses that form, too).
> 
> However.
> 
> The command line parser for update_clone() stuffs --depth as a
> string to suc.depth, and then the machinery ends up calling
> prepare_to_clone_next_submodule() with such an instance of suc
> (struct submodule_update_clone).  Then that function just pushes the
> suc->depth to an argv array used to spawn a "submodule--helper clone".
> 
> So passing "--depth --depth=23" would be "correct", sadly, in that
> codepath (I am not saying other codepaths would not call the same
> prepare_to_clone_next_submodule() with "--depth 23", as I didn't
> check, and if there is such a codepath, it would break).
> 

Ok, so it's technically correct, but weird. I had trouble understanding it.

> We may need to clean the mess up X-<.
> 

Yea, I got confused looking at this code. Though if I recall, we were working towards rewriting it in C anyways (which is what the submodule--helper is doing).

Thanks,
Jake

> > diff --git a/git-submodule.sh b/git-submodule.sh
> > index c7f58c5756f7..4e7fc8bf3652 100755
> > --- a/git-submodule.sh
> > +++ b/git-submodule.sh
> > @@ -547,7 +547,7 @@ cmd_update()
> >  		${update:+--update "$update"} \
> >  		${reference:+"$reference"} \
> >  		${dissociate:+"--dissociate"} \
> > -		${depth:+--depth "$depth"} \
> > +		${depth:+"$depth"} \
> >  		$recommend_shallow \
> >  		$jobs \
> >  		-- \
