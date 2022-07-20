Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 323C0C43334
	for <git@archiver.kernel.org>; Wed, 20 Jul 2022 19:30:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230442AbiGTTaS (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Jul 2022 15:30:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229923AbiGTTaQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Jul 2022 15:30:16 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87D50DEA3
        for <git@vger.kernel.org>; Wed, 20 Jul 2022 12:30:13 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 9E01434F14;
        Wed, 20 Jul 2022 19:30:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1658345411; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Y+DKKA/brM/b9CK0HrB4qHQ8ipxpV7IMEepIiqY7F48=;
        b=CpBMmgmiaMYCMZuJewZiHCxbO1srpNoHakqSRP4jiHb5uB2CnV/E3ss7FuNi1IQneCITVk
        hFA08eu2z7TvhV9zQQOkqbYAljQdyThaj9gHMA80YpY8WPsdUkXcszp2NksJNKh5CWcqCb
        TzJ4g+EYLV1DsoVXk+lHj3aswriyI8o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1658345411;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Y+DKKA/brM/b9CK0HrB4qHQ8ipxpV7IMEepIiqY7F48=;
        b=EpTdj0W3p3tvQC5S9w3ZSMLLYV2dTxk5xQvDWJZ9hu9afyC9RwPYrGvPlq8NP3vaHIq/5H
        BtLejQP+jAsxrUBg==
Received: from kitsune.suse.cz (kitsune.suse.cz [10.100.12.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 7B08E2C141;
        Wed, 20 Jul 2022 19:30:11 +0000 (UTC)
Date:   Wed, 20 Jul 2022 21:30:10 +0200
From:   Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc:     Glen Choo <chooglen@google.com>,
        Stephen Finucane <stephen@that.guru>, git@vger.kernel.org
Subject: Re: Feature request: provide a persistent IDs on a commit
Message-ID: <20220720193010.GZ17705@kitsune.suse.cz>
References: <bdbe9b7c1123f70c0b4325d778af1df8fea2bb1b.camel@that.guru>
 <20220718173511.rje43peodwdprsid@meerkat.local>
 <kl6lo7xmt8qw.fsf@chooglen-macbookpro.roam.corp.google.com>
 <20220720192144.mxdemgcdjxb2klgl@nitro.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220720192144.mxdemgcdjxb2klgl@nitro.local>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 20, 2022 at 03:21:44PM -0400, Konstantin Ryabitsev wrote:
> On Mon, Jul 18, 2022 at 02:24:07PM -0700, Glen Choo wrote:
> > > I just started working on this for b4, with the notable difference that the
> > > change-id trailer is used in the cover letter instead of in individual
> > > commits, which moves the concept of "change" from a single commit to a series
> > > of commits. IMO, it's much more useful in that scope, because as series are
> > > reviewed and iterated, individual patches can get squashed, split up or
> > > otherwise transformed.
> > 
> > My 2 cents, since I used to use Gerrit a lot :)
> > 
> > I find persistent per-commit ids really useful, even when patches get
> > moved around. E.g. Gerrit can show and diff previous versions of the
> > patch, which makes it really easy to tell how the patch has evolved
> > over time.
> 
> The kernel community has repeatedly rejected per-patch Change-id trailers
> because they carry no meaningful information outside of the gerrit system on
> which they were created. Seeing a Change-Id trailer in a commit tells you
> nothing about the history of that commit unless you know the gerrit system on

Unless you happen to see another patch with the same ID, and for that to
happen the ID needs to be generated when the commit is created (not when
it's uploaded to gerrit or sent to a mailing list), and preserved by
default in all processing of the commit.

Then you can actually track the commit as it evolves in tools like
patchwork, in theory.

Thanks

Michal
