Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2AFE21F4F8
	for <e@80x24.org>; Mon, 17 Oct 2016 16:11:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935925AbcJQQLT (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Oct 2016 12:11:19 -0400
Received: from mout.gmx.net ([212.227.17.21]:52292 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935723AbcJQQLN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Oct 2016 12:11:13 -0400
Received: from virtualbox ([37.24.142.40]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0LmfKJ-1cW3cM4BQh-00aFGM; Mon, 17 Oct 2016 18:11:02
 +0200
Date:   Mon, 17 Oct 2016 18:11:00 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Lars Schneider <larsxschneider@gmail.com>
cc:     git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        me@ttaylorr.com
Subject: Re: Merge conflicts in .gitattributes can cause trouble
In-Reply-To: <248A6E81-8D5C-4183-9756-51A0D5193E3E@gmail.com>
Message-ID: <alpine.DEB.2.20.1610171803400.197091@virtualbox>
References: <248A6E81-8D5C-4183-9756-51A0D5193E3E@gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:jWmg3RhLy+gNT2Tuhv/dfaUzlvn2fDkmzRsmCuf215nz6+rPjEI
 uI0ERZE/JRslwsWSTIxywtuQdNJU/c1lZV/Yutp2dQkT0IAv2ih0SOwBBlWR9cVp0fyfaaY
 nt3QU4f9L39XBAnyv9wok0HFVcCEY6BsxRncE1ONbSl1jFllHrZ89rMCxxZoQpt+gthMW2I
 An8HoD21ZsJVVci9zW58g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Vp3GI+BeWUw=:jP2ss9zDbHLG8IcArxe8qO
 u+l+cIhaRi6PmD9JO5qYFM7RGe33/eP3CaRV0QSpdyfzCp7dW8MpiUazMVWH8IeuM8foXgJ95
 6bxSLpgryzpxijoXDCvbTdole5u5QmFw5NYRWc4ozTQBdGeXdbjBfAi1OpRXH5wonJZGW2HtZ
 zUnsJEfODF0rDk9/sBGduqE3xhAHqqorsTu2S4LC+NZzbFNY8Q43cHPOfgN0mAnZJ4A7kofff
 Y3b5d6OwTVNCK1aM2x+Shv8eK8R2CIyElpd42ZGlTMN8dgrX9ZI8Lw61FvTJbjeCE1heRSqmO
 4qVYDvaQ574JEbkoXP5dnO8AcnZZeD8FbauWl3eNeaJXmKNNFwEf2cMjpGoVpc9BNswF0h85P
 K532z3z/0qq8ZRLuJhlryotyBn4bbpa4Sjac27HQq8uDQ/ZGZTRUEgR2/dg+Yz5hM79RA12Kn
 PoLEwmcohudbje7wgSIdc9uHIMm4QVeMeVXEXfo2dZtlhP696e1iAxzvmPcGt70k10RyIKfb1
 kaunpkJMlkDTAqCAESqtTilSacX26meW6m5q4BTAC/65RgRYZqDeUlBL7y7SEJgXQPuMQeIyc
 KuXnAQpFCLNw1rpRXi9YkFDKnxnwLPsqoB4w5eHwI39kOqJ/Y+Gy2sUoHhEjMsiHV1B7TBTAi
 2CF7lk1+qKJKVtsCpjvfVDBXq0uD0KDmioDp2Tr0ArIObGDW5H6y98osNdpK5jJH1iyMGnxTf
 2eSRwgLzdGzzE0ax2kSxr4xGhn4sHUUVH7TIoUbN04S5Pal2k0kMBbylBz8jrC4WNvc6MtGrY
 VMMl8N5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Lars,

On Tue, 4 Oct 2016, Lars Schneider wrote:

> If there is a conflict in the .gitattributes during a merge then it looks 
> like as if the attributes are not applied

I tried to replicate this behavior, to the point where I wrote a patch
that demonstrates the breakage so I could single-step in a debugger to
find out where things go wrong, and fix them.

Alas, I found out that the .gitattributes are read *before* any merge
conflict arises in the case you demonstrated. Which kind of makes sense,
because the gitattributes decide over which merge driver to use, among
other things.

So in your example:

> Consider this script on Windows:
> 
> $ git init .
> $ touch first.commit
> $ git add .
> $ git commit -m "first commit"
> 
> $ git checkout -b branch
> $ printf "*.bin binary\n" >> .gitattributes
> $ git add .
> $ git commit -m "tracking *.bin files"
> 
> $ git checkout master
> $ printf "binary\ndata\n" > file.dat # <-- Unix line ending!
> $ printf "*.dat binary\n" >> .gitattributes # <-- Tell Git to keep Unix line ending!
> $ git add .
> $ git commit -m "tracking *.dat files"
> $ git cat-file -p :file.dat | od -c
> 0000000   b   i   n   a   r   y  \n   d   a   t   a  \n 
>                                 ^^^^                ^^^^  <-- Correct!
> $ git checkout branch

At this point, the .gitattributes list only .bin files as binary. That is
the revision of the .gitattributes used by this command:

> $ git merge master # <-- Causes merge conflict!

And as a consequence, the .gitattributes do not tell Git that it should
handle .dat files as binary. Which means that...

> $ printf "*.bin binary\n*.dat binary\n" > .gitattributes # <-- Fix merge conflict!
> $ git add .
> $ git commit -m "merged"
> $ git cat-file -p :file.dat | od -c
> 0000000   b   i   n   a   r   y  \r  \n   d   a   t   a  \r  \n
>                                 ^^^^^^^^                ^^^^^^^^  <-- Wrong!

... this is actually expected! Why? Because the .gitattributes that were
in effect when the user asked to perform a merge said so.

If you adjust .gitattributes *before* merging `master`, it works as you
would expect: the line endings are not changed.

The reason to do it this way: we want to respect the .gitattributes as per
the current worktree. We go even so far that we respect uncommitted
changes to said file...

> Possible solutions:
> 
> 1. We could print an appropriate warning if we detect a merge conflict 
>    in .gitattributes
> 
> 2. We could disable all line ending conversions in case of a merge conflict
>    (I am not exactly sure about all the implications, though)
> 
> 3. We could salvage what we could of the .gitattributes file, 
>    perhaps by using the version from HEAD (or more likely, the ours stage of
>    the index) -- suggested by Peff on the related GitHub issue mentioned below

I would vote for:

4. We keep letting Git read in the *current* version of .gitattributes
   *before* the merge, and apply those attributes while performing the
   merge.

Ciao,
Dscho
