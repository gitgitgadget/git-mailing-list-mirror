Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 807891F404
	for <e@80x24.org>; Thu, 19 Apr 2018 12:10:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752291AbeDSMK2 (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Apr 2018 08:10:28 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:52844 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751865AbeDSMK1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Apr 2018 08:10:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=ubUXlkQ4BMJckfpOYLRhadsgl8QuWMJnWgORlwSQBe0=; b=tQubQZ+7mha7MN4yKKvBGYdZgu
        HZ20xfangAHkzQWWmoxwaawML2kjcF+4GRkZ1pLw7QKh7HUGBKSjwt8RVNKXIW36vhOOMLa6Ixspi
        qoKF6Pc53Dqy7Tkvbg0JxjrDdRQgJyyyqVbxBPHyvns7tEx5RVnIywuNQE5Tmp6e2Kigye7gr7gWX
        E51dvLsbJN08pxlHbze3EYNMvAytVM5l6GVAbWSYxO6eXR+oa4T3DnSEXCKFjBjh24O746602wuM2
        tjS24mInWGpbjfkEpAPZnHuVoNeK9vZkPatGmD29Jf3nxeCRoaOSgsl3jDKAwJpEx8MvbGAP3/WqR
        AVvq0ojQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1f98OP-0008Sm-Pn; Thu, 19 Apr 2018 12:10:25 +0000
Date:   Thu, 19 Apr 2018 05:10:24 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Minchan Kim <minchan@kernel.org>
Subject: Re: [PATCH] git-send-email: Cc more people
Message-ID: <20180419121024.GD5556@bombadil.infradead.org>
References: <20180418140503.GD27475@bombadil.infradead.org>
 <87tvs8e174.fsf@evledraar.gmail.com>
 <xmqqr2ncgqhl.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqr2ncgqhl.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 19, 2018 at 06:21:42AM +0900, Junio C Hamano wrote:
> Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:
> 
> > But IMO this patch is really lacking a few things before being ready:
> >
> > 1. You have no tests for this. See t/t9001-send-email.sh for examples,
> > ...
> > 2. Just a few lines down from your quoted hunk we have this:
> > ... code about $supress_cc{<token>} ...
> >    Your change should at least describe why those aren't being updated,
> >    but probably we should add some other command-line option for
> >    ignoring these wildcards, e.g. --[no-]wildcard-by-cc=reviewed
> >    --[no-]wildcard-by-cc=seen etc, and we can make --[no-]signed-off-by
> >    a historical alias for --[no-]wildcard-by-cc=signed-off.
> > 3. Ditto all the documentation in "man git-send-email" about
> > ...
> 
> Thanks, I agree that 2. (the lack of suppression) is a showstopper.

I agree with that (and the lack of tests, obviously)

> I'd further say that these new CC-sources should be disabled by
> default and made opt-in to avoid surprising existing users.

But I disagree with this.  The current behaviour is surprising to
existing users, to the point where people are writing their own scripts
to replace git send-email (which seems crazy to me).

> One thing we also need to be very careful about is that some of the
> fields may not even have an e-mail address.  We can expect that
> S-o-b and Cc would be of form "human readable name <email@addre.ss>"
> by their nature, but it is perfectly fine to write only human
> readable name without address on random lines like "suggeted-by" and
> "helped-by".  There needs a way for the end-user to avoid using data
> found on such lines as if they are valid e-mail addresses.

I also agree with this.  I'll add some test-cases and make sure we only
add these if they're valid email addresses.
