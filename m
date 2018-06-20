Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A0F981F403
	for <e@80x24.org>; Wed, 20 Jun 2018 18:42:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754269AbeFTSl6 (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Jun 2018 14:41:58 -0400
Received: from ao2.it ([92.243.12.208]:50640 "EHLO ao2.it"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753760AbeFTSl6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Jun 2018 14:41:58 -0400
Received: from localhost ([::1] helo=jcn.localdomain)
        by ao2.it with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ao2@ao2.it>)
        id 1fVi2m-0004D3-NZ; Wed, 20 Jun 2018 20:41:24 +0200
Date:   Wed, 20 Jun 2018 20:41:55 +0200
From:   Antonio Ospite <ao2@ao2.it>
To:     Stefan Beller <sbeller@google.com>
Cc:     git <git@vger.kernel.org>, Brandon Williams <bmwill@google.com>,
        Daniel =?ISO-8859-1?Q?Gra=F1a?= <dangra@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Richard Hartmann <richih.mailinglist@gmail.com>
Subject: Re: [RFC PATCH 02/10] submodule: factor out a config_gitmodules_set
 function
Message-Id: <20180620204155.3e56a2fdcf3c1d70284da1a7@ao2.it>
In-Reply-To: <CAGZ79kbx-xsmOFLoi7dkarkwdgZcXwzBfnqo5Hd7bu_veiQOBQ@mail.gmail.com>
References: <20180514105823.8378-1-ao2@ao2.it>
        <20180514105823.8378-3-ao2@ao2.it>
        <CAGZ79kbx-xsmOFLoi7dkarkwdgZcXwzBfnqo5Hd7bu_veiQOBQ@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
X-Face: z*RaLf`X<@C75u6Ig9}{oW$H;1_\2t5)({*|jhM<pyWR#k60!#=#>/Vb;]yA5<GWI5`6u&+
 ;6b'@y|8w"wB;4/e!7wYYrcqdJFY,~%Gk_4]cq$Ei/7<j&N3ah(m`ku?pX.&+~:_/wC~dwn^)MizBG !pE^+iDQQ1yC6^,)YDKkxDd!T>\I~93>J<_`<4)A{':UrE
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, 14 May 2018 18:20:21 -0700
Stefan Beller <sbeller@google.com> wrote:

> On Mon, May 14, 2018 at 3:58 AM, Antonio Ospite <ao2@ao2.it> wrote:
> > Introduce a new config_gitmodules_set function to write config values to the
> > .gitmodules file.
> >
> > This is in preparation for a future change which will use the function
> > to write to the .gitmodules file in a more controlled way instead of
> > using "git config -f .gitmodules".
> >
> > Signed-off-by: Antonio Ospite <ao2@ao2.it>
> > ---
> >
> > Not sure about the name, and maybe it can go in config.c for symmetry with
> > config_from_gitmodules?
> 
> What is the function about (in the end state and now) ?
> is it more of a
> * configure_submodules_config()
>   which would convey it is a generic function to configure submodules
>   (i.e. it may not even write to *the* .gitmodules file but somewhere else,
>   such as a helper ref)
>   This doesn't sound like it as we make use of the function in
>   update_path_in_gitmodules() that is used from git-mv, which would want
>   to ensure that the specific .gitmodules file is changed.
> * gitmodules_file_set()
>   that focuses on the specific file that we want to modify?
> * ...
> 
> Let's continue reading the series to see the end state for
> a good name.
> 

OK, that helped to clarify one point: eventually there will be some
asymmetry between reading the submodule config and writing it.

1. reading will be either form .gitmodules or HEAD:.gitmodules;
2. writing will be only to .gitmodules.

I'll try to consider that when naming the functions.

If a more generic mechanism to write the submodules configuration is
added in the future (e.g. the special ref you were mentioning) the
functions can always be renamed accordingly.

Thanks,
   Antonio

-- 
Antonio Ospite
https://ao2.it
https://twitter.com/ao2it

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?
