Return-Path: <SRS0=DhGT=5Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28991C43331
	for <git@archiver.kernel.org>; Tue, 31 Mar 2020 07:27:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07D6A2072A
	for <git@archiver.kernel.org>; Tue, 31 Mar 2020 07:27:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729358AbgCaH05 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 Mar 2020 03:26:57 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:48877 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726488AbgCaH04 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Mar 2020 03:26:56 -0400
X-Originating-IP: 42.109.198.85
Received: from localhost (unknown [42.109.198.85])
        (Authenticated sender: me@yadavpratyush.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id A71DB20008;
        Tue, 31 Mar 2020 07:26:52 +0000 (UTC)
Date:   Tue, 31 Mar 2020 12:56:47 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     James Yeoman <james.yeoman@appsbroker.com>
Cc:     git@vger.kernel.org, Paul Mackerras <paulus@ozlabs.org>
Subject: Re: Fwd: Bug Report
Message-ID: <20200331072647.vprlkjczj5c7oo7p@yadavpratyush.com>
References: <CAJ+U58yrKi=4VHRCAw68yAste=j3vzrvd2DoEW6QL-_sRWO2Aw@mail.gmail.com>
 <20200327124140.643uxbt2kvjwfxri@yadavpratyush.com>
 <CAJ+U58wHszg6amZivFEh=08N0ZNTcLHVFVyaCv0nQrzi_nx-UA@mail.gmail.com>
 <CAJ+U58zvMCxuL6a8yfdNHCfsBkivybWxTioPU-p_PtekAAOWuA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJ+U58zvMCxuL6a8yfdNHCfsBkivybWxTioPU-p_PtekAAOWuA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi James,

On 30/03/20 09:18AM, James Yeoman wrote:
> Hi, of course
> 
> === File at commit 1 ===
> import java.util.List;
> 
> public class Foo {
>     private int id;
>     private String name;
>     private List<Programme> programmes;
> 
>     public Foo() {
> 
>     }
> 
>     public Foo(int id, String name, List<Programme> programmes) {
>         this.id = id;
>         this.name = name;
>         this.programmes = programmes;
>     }
> 
>     // getters and setters
> }
> 
> === File in working area ===
> 
> import java.util.List;
> 
> public class Foo {
>     private int id;
>     private String name;
>     private List<Programme> programmes;
> 
>     public Foo() {
> 
>     }
> 
>     public Foo(int id, String name) {
>         this.id = id;
>         this.name = name;
>     }
> 
>     public Foo(int id, String name, List<Programme> programmes) {
>         this(id, name);
>         this.programmes = programmes;
>     }
> 
>     // getters and setters
> }
> 
> === diff with default ===
> -    public Foo(int id, String name, List<Programme> programmes) {
> +    public Foo(int id, String name) {
>          this.id = id;
>          this.name = name;
> +    }
> +
> +    public Foo(int id, String name, List<Programme> programmes) {
> +        this(id, name);
>          this.programmes = programmes;
>      }

I see this diff with both the default and patience algorithms on the 
command line tool.

I ran:
  $ git diff --diff-algorithm=default
and
  $ git diff --diff-algorithm=patience

Both yield the above diff. In fact, all 4 of "default", "patience", 
"minimal", and "histogram" yield the above diff.  Which version of Git 
are you running? I am on v2.25.2.

PS: Please don't top post on the mailing list.
 
> === diff with patience ===
>     public Foo(int id, String name) {
> +        this.id = id;
> +        this.name = name;
> +    }
> +
>      public Foo(int id, String name, List<Programme> programmes) {
> -        this.id = id;
> -        this.name = name;
> +        this(id, name);
>          this.programmes = programmes;
>      }
> 
> 
> On Fri, 27 Mar 2020 at 12:59, Pratyush Yadav <me@yadavpratyush.com> wrote:
> >
> > Hi James,
> >
> > On 27/03/20 11:53AM, James Yeoman wrote:
> > > gitk and git-gui are both not respecting git config.
> > >
> > > When I set the diff.algorithm global config to patience, the command
> > > line git respects the config. However, both gitk and git-gui don't.
> > > When I use "git status -vv" to get a diff of the working directory,
> > > the diff produced respects the algorithm choice. The diff of the
> > > working directory in gitk and git-gui both still use the default diff
> > > algorithm, rather than the algorithm from the config.
> >
> > Thanks for reporting. Can you please send steps to produce a simple
> > scenario where the diff from two algorithms is different so I can test
> > why git-gui is not respecting the config. Make them as minimal as
> > possible.
> >
> > Also, +Cc Paul, the gitk maintainer.
> >
> > --
> > Regards,
> > Pratyush Yadav

-- 
Regards,
Pratyush Yadav
