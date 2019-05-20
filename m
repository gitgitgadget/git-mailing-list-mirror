Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DACA21F461
	for <e@80x24.org>; Mon, 20 May 2019 15:05:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730766AbfETPFW (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 May 2019 11:05:22 -0400
Received: from mx2.suse.de ([195.135.220.15]:59238 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387871AbfETPFU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 May 2019 11:05:20 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 22339AD8F;
        Mon, 20 May 2019 15:05:19 +0000 (UTC)
Date:   Mon, 20 May 2019 17:05:18 +0200
From:   Michal =?UTF-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     esr@thyrsus.com, Jason Pyeron <jpyeron@pdinc.us>,
        git@vger.kernel.org
Subject: Re: Finer timestamps and serialization in git
Message-ID: <20190520170518.73ad912b@kitsune.suse.cz>
In-Reply-To: <3b8d6a78-bd88-770c-e79b-d732f7e277fd@gmail.com>
References: <20190515191605.21D394703049@snark.thyrsus.com>
        <ae62476c-1642-0b9c-86a5-c2c8cddf9dfb@gmail.com>
        <023b01d50b5c$cbd3cd90$637b68b0$@pdinc.us>
        <998895a9-cfbb-c458-cc88-fa1aabed4389@gmail.com>
        <20190516002831.GC124956@thyrsus.com>
        <3b8d6a78-bd88-770c-e79b-d732f7e277fd@gmail.com>
Organization: SUSE Linux
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.31; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 15 May 2019 21:25:46 -0400
Derrick Stolee <stolee@gmail.com> wrote:

> On 5/15/2019 8:28 PM, Eric S. Raymond wrote:
> > Derrick Stolee <stolee@gmail.com>:  
> >> What problem are you trying to solve where commit date is important?  

> > B. Unique canonical form of import-stream representation.
> > 
> > Reposurgeon is a very complex piece of software with subtle failure
> > modes.  I have a strong need to be able to regression-test its
> > operation.  Right now there are important cases in which I can't do
> > that because (a) the order in which it writes commits and (b) how it
> > colors branches, are both phase-of-moon dependent.  That is, the
> > algorithms may be deterministic but they're not documented and seem to
> > be dependent on variables that are hidden from me.
> > 
> > Before import streams can have a canonical output order without hidden
> > variables (e.g. depending only on visible metadata) in practice, that
> > needs to be possible in principle. I've thought about this a lot and
> > not only are unique commit timestamps the most natural way to make
> > it possible, they're the only way conistent with the reality that
> > commit comments may be altered for various good reasons during
> > repository translation.  
> 
> If you are trying to debug or test something, why don't you serialize
> the input you are using for your test?

And that's the problem. Serialization of a git repository is not stable
because there is no total ordering on commits. And for testing you need
to serialize some 'before' and 'after' state and they can be totally
different. Not because the repository state is totally different but
because the serialization of the state is not stable.

Thanks

Michal
