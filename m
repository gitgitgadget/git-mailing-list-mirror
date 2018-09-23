Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AA1EC1F453
	for <e@80x24.org>; Sun, 23 Sep 2018 20:43:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726957AbeIXCm0 convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Sun, 23 Sep 2018 22:42:26 -0400
Received: from elephants.elehost.com ([216.66.27.132]:23232 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726467AbeIXCm0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 23 Sep 2018 22:42:26 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from pangea ([64.141.110.67])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id w8NKhZp4055036
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sun, 23 Sep 2018 16:43:35 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'John Austin'" <john@astrangergravity.com>
Cc:     "=?UTF-8?Q?'=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason'?=" 
        <avarab@gmail.com>, <id@joeyh.name>,
        "'Taylor Blau'" <me@ttaylorr.com>, <git@vger.kernel.org>,
        "'brian m. carlson'" <sandals@crustytoothpaste.net>,
        "'Lars Schneider'" <larsxschneider@gmail.com>,
        <pastelmobilesuit@github.com>
References: <CA+AhR6fWpzL1ozt2H=y8TaQrgT-6dvkkK_K_P-pXniXT+xcMuQ@mail.gmail.com> <20180914190025.GJ55140@syl> <CA+AhR6fH4=VbuMPasbaH9u52Y=tgJJzhgxosPOb3819ivCVJOg@mail.gmail.com> <20180915164052.GA88932@syl> <878t41lcfi.fsf@evledraar.gmail.com> <20180917135525.GF71477@syl> <874leokw3p.fsf@evledraar.gmail.com> <20180917164705.GA28056@kitenet.net> <8736u8kpgu.fsf@evledraar.gmail.com> <CA+AhR6doYuwoucdcN9aKw7-HxgR-qa6OiN4Dnzcy5rifL8PYvg@mail.gmail.com> <000501d45366$cf437060$6dca5120$@nexbridge.com> <CA+AhR6c+D84sHhABRm4xf=5RWnpVEBXMXzdQxipYMS5bmkw9iQ@mail.gmail.com>
In-Reply-To: <CA+AhR6c+D84sHhABRm4xf=5RWnpVEBXMXzdQxipYMS5bmkw9iQ@mail.gmail.com>
Subject: RE: Git for games working group
Date:   Sun, 23 Sep 2018 16:43:21 -0400
Message-ID: <000801d4537e$19351180$4b9f3480$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQJCK+yvnEb5QI/ikbJlwoBcKKGxtwJ84Xf9AsGEat8CU8XVTAJ6d6v5Avvgq9ICrS113AHKd7YBAfgV/8YBqRD4eAH1JzJmAva467WjUjabUA==
Content-Language: en-ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On September 23, 2018 3:54 PM, John Austin wrote:
> On Sun, Sep 23, 2018 at 10:57 AM Randall S. Becker
> <rsbecker@nexbridge.com> wrote:
> >  I would even like to help with your effort and have non-unixy platforms I'd
> like to do this on.
> > Having this separate from git LFS is an even better idea IMO, and I would
> suggest implementing this using the same set of build tools that git uses so
> that it is broadly portable, unlike git LFS. Glad to help there too.
> 
> Great to hear -- once the code is in a bit better shape I can open it up on
> github. Cross platform is definitely one of my focuses. I'm currently
> implementing in Rust because it targets the same space as C and has great,
> near trivial, cross-platform support. What sorts of platforms are you
> interested in? Windows is my first target because that's where many game
> developers live.

I have looked at porting Rust to my two mid-to-large platforms which do not have a Rust port. I would prefer keeping within what git currently requires without adding dependencies, but I'd be happy to take a Rust prototype and translate it. My need is actually not for gamers, but in similar processes that gamers use. The following dependences are not available on the two platforms I have in mind: g++ or clang; 
And cmake (despite efforts by people on the platform to do ports). This puts me in a difficult spot with Rust. I understand you might want to use Rust's implied threating, so I would be willing to do the pthread work to make it happen in C.

> > I would suggest that a higher-level grouping mechanism of resource groups
> might be helpful - as in "In need this directory" rather than "I need this file".
> Better still, I could see "I need all objects in this commit-ish", which would
> allow a revert operation to succeed or fail atomically while adhering to a lock
> requirement.
> > One bit that traditional lock-brokering systems implement involve forcing
> security attribute changes - so an unlocked file is stored as chmod a-w to
> prevent accidental modification of lockables, when changing that to chmod
> ?+w when a lock is acquired. It's not perfect, but does catch a lot of errors.
> 
> Agreed -- I think this is all up to how the query endpoint and client is
> designed. A couple of different types of clients could be implemented,
> depending on the policies you want in place. One could have strict security
> that stored unlocked files with a-w, as mentioned. Another could be a
> weaker client, and simply warn developers when their current branch is in
> conflict.

Regards,
Randall

