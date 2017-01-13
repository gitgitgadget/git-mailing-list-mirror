Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 32C4520756
	for <e@80x24.org>; Fri, 13 Jan 2017 21:39:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751442AbdAMVjC (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Jan 2017 16:39:02 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:58104 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751166AbdAMVjA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Jan 2017 16:39:00 -0500
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 464DB20756;
        Fri, 13 Jan 2017 21:39:00 +0000 (UTC)
Date:   Fri, 13 Jan 2017 21:39:00 +0000
From:   Eric Wong <e@80x24.org>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Pat Pannuto <pat.pannuto@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org
Subject: Re: [PATCH 2/2] Use 'env' to find perl instead of fixed path
Message-ID: <20170113213900.GA25890@starla>
References: <20170112055140.29877-3-pat.pannuto@gmail.com>
 <6fe462dd-929a-671b-a210-36ee38e99115@kdbg.org>
 <CAAnLKaGbf9-GAF19+61=7_RfCOBM0=Ounwf8KkL1jS6HX3pOag@mail.gmail.com>
 <alpine.DEB.2.20.1701121118170.3469@virtualbox>
 <xmqqbmvcj9le.fsf@gitster.mtv.corp.google.com>
 <CAAnLKaGvz4Wzs36gMSdoYCg+tzx6KFCe59FNnk5zNQ-L58ww1g@mail.gmail.com>
 <20170113024842.GA20572@starla>
 <xmqq4m12izmd.fsf@gitster.mtv.corp.google.com>
 <20170113185246.GA17441@starla>
 <xmqq37gmhgpn.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq37gmhgpn.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> wrote:
> Eric Wong <e@80x24.org> writes:
> > Junio C Hamano <gitster@pobox.com> wrote:
> >> Eric Wong <e@80x24.org> writes:
> >> > Pat Pannuto <pat.pannuto@gmail.com> wrote:
> >> >> You may still want the 1/2 patch in this series, just to make things
> >> >> internally consistent with "-w" vs "use warnings;" inside git's perl
> >> >> scripts.
> >> >
> >> > No, that is a step back.  "-w" affects the entire process, so it
> >> > spots more potential problems.  The "warnings" pragma is scoped
> >> > to the enclosing block, so it won't span across files.
> >> 
> >> OK, so with "-w", we do not have to write "use warnings" in each of
> >> our files to get them checked.  It is handy when we ship our own
> >> libs (e.g. Git.pm) that are used by our programs.
> >
> > Yes.  "use warnings" should be in our own libs in case other
> > people run without "-w"
> 
> Would it mean that we need both anyway?  That is, add missing "use
> warnings" without removing "-w" from she-bang line?

Yes, we keep "use warnings" other people may use, at least.
No harm in keeping that in top-level scripts, I guess.

> Speaking of Perl, I recall that somebody complained that we ship
> with and do use a stale copy of Error.pm that has been deprecated.
> I am not asking you to do so, but we may want to see somebody look
> into it (i.e. assessing the current situation, and if it indeed is
> desirable for us to wean ourselves away from Error.pm, update our
> codepaths that use it).

Agreed, I'd definitely prefer to move towards the basic eval/die
construct without relying on a bundled 3rd-party mechanism.
But we might need a migration path for out-of-tree users of
Git.pm (if any)...

I'm sure I've agreed this was a path we should be taking in the
past, but did something about it myself.  So yeah, maybe Pat or
somebody else interested can take care of this :)

Thanks.
