Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4D9701F461
	for <e@80x24.org>; Thu, 29 Aug 2019 00:53:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727059AbfH2AxW (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Aug 2019 20:53:22 -0400
Received: from ozlabs.org ([203.11.71.1]:58679 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726079AbfH2AxW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Aug 2019 20:53:22 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
        id 46Jkcc0MgJz9sN6; Thu, 29 Aug 2019 10:53:19 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ozlabs.org; s=201707;
        t=1567040000; bh=FdCHKTd5GhqKvfT/hUx4HcayORV+nDKtonE/6M5F52c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wKu6rqQ+D7lm25Q5GFTl7Y0JKH9Lm3yX9bSR2zN3enStykX0NtTsrGhICuBBDq9jB
         tKP1I97pHh1Ms2h2ojoFqb1xKUXJ5NWTvHqydPz9sgEKhGiafQg3Cnaviwzyql08mS
         gzBCiKGvj1iDjZj6Of65GO8OXf69MA9e7iL2/Xur1EvsJGORfZUckymaYO+ei8NC2X
         FpQqN0IcfQWR0/BIWq35Oq5Xc9h3M5N7X/snlSn1af/kEpKsPuY6IwXNVr048lyS5M
         mUZAXzgDIPCsCtai8FqygMzSjWG8NRcZWX6YLn+Yqxkpy2JkDUvjc739yOp1GyXSt7
         xaXlLK9t//UlQ==
Date:   Thu, 29 Aug 2019 10:50:11 +1000
From:   Paul Mackerras <paulus@ozlabs.org>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] gitk: Make web links clickable
Message-ID: <20190829005011.GA3297@blackberry>
References: <20190826221444.GB7402@blackberry>
 <xmqqimqi2vtt.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqimqi2vtt.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Tue, Aug 27, 2019 at 01:32:30PM -0700, Junio C Hamano wrote:
> Paul Mackerras <paulus@ozlabs.org> writes:
> 
> > This makes gitk look for lines in the commit message which start with
> > "Link:" or "BugLink:" followed by a http or https URL, and make the
> > URL clickable.  Clicking on it will invoke an external web browser with
> > the URL.
> >
> > The web browser command is by default "xdg-open" on Linux, "open" on
> > MacOS, and "cmd /c start" on Windows.  The command can be changed in
> > the preferences window, and it can include parameters as well as the
> > command name.  If it is set to the empty string then URLs will no
> > longer be made clickable.
> >
> > Signed-off-by: Paul Mackerras <paulus@ozlabs.org>
> > ---
> 
> >  gitk | 51 ++++++++++++++++++++++++++++++++++++++++++++++++++-
> >  1 file changed, 50 insertions(+), 1 deletion(-)
> >
> > diff --git a/gitk b/gitk
> > index a14d7a1..4577150 100755
> > --- a/gitk
> > +++ b/gitk
> > @@ -7016,6 +7016,7 @@ proc commit_descriptor {p} {
> >  
> >  # append some text to the ctext widget, and make any SHA1 ID
> >  # that we know about be a clickable link.
> > +# Also look for lines of the form "Link: http..." and make them web links.
> 
> FWIW, I personally hate those "Link:" that do not say what the links
> are for (IOW, I am OK with "BugLink:" or even "Bug:").
> 
> In any case, I polled your repository but I did not find anything to
> pull.  Do you want me to start my own gitk mirror, queue this patch
> there and pull from it myself, or is this meant to be a preview of
> what you'll tell me to pull in a few days?

I was expecting some comments and suggestions, so I didn't push it out
yet.  One suggestion which seems reasonable is to match any http or
https URL anywhere in the commit description, not just with Link: or
BugLink: at the start of the line.  What do you think of that?  It's
quite easy to do.  Also it should stop at whitespace rather than going
to the end of the line.

Paul.
