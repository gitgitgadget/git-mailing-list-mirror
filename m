Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 224071F462
	for <e@80x24.org>; Mon, 20 May 2019 16:36:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389142AbfETQg0 (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 May 2019 12:36:26 -0400
Received: from thyrsus.com ([71.162.243.5]:50362 "EHLO snark.thyrsus.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731223AbfETQg0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 May 2019 12:36:26 -0400
Received: by snark.thyrsus.com (Postfix, from userid 1000)
        id 95F91470485F; Mon, 20 May 2019 12:36:25 -0400 (EDT)
Date:   Mon, 20 May 2019 12:36:25 -0400
From:   "Eric S. Raymond" <esr@thyrsus.com>
To:     Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
Cc:     Derrick Stolee <stolee@gmail.com>, Jason Pyeron <jpyeron@pdinc.us>,
        git@vger.kernel.org
Subject: Re: Finer timestamps and serialization in git
Message-ID: <20190520163625.GA99397@thyrsus.com>
Reply-To: esr@thyrsus.com
References: <20190515191605.21D394703049@snark.thyrsus.com>
 <ae62476c-1642-0b9c-86a5-c2c8cddf9dfb@gmail.com>
 <023b01d50b5c$cbd3cd90$637b68b0$@pdinc.us>
 <998895a9-cfbb-c458-cc88-fa1aabed4389@gmail.com>
 <20190516002831.GC124956@thyrsus.com>
 <3b8d6a78-bd88-770c-e79b-d732f7e277fd@gmail.com>
 <20190520170518.73ad912b@kitsune.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190520170518.73ad912b@kitsune.suse.cz>
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Michal Suchánek <msuchanek@suse.de>:
> On Wed, 15 May 2019 21:25:46 -0400
> Derrick Stolee <stolee@gmail.com> wrote:
> 
> > On 5/15/2019 8:28 PM, Eric S. Raymond wrote:
> > > Derrick Stolee <stolee@gmail.com>:  
> > >> What problem are you trying to solve where commit date is important?  
> 
> > > B. Unique canonical form of import-stream representation.
> > > 
> > > Reposurgeon is a very complex piece of software with subtle failure
> > > modes.  I have a strong need to be able to regression-test its
> > > operation.  Right now there are important cases in which I can't do
> > > that because (a) the order in which it writes commits and (b) how it
> > > colors branches, are both phase-of-moon dependent.  That is, the
> > > algorithms may be deterministic but they're not documented and seem to
> > > be dependent on variables that are hidden from me.
> > > 
> > > Before import streams can have a canonical output order without hidden
> > > variables (e.g. depending only on visible metadata) in practice, that
> > > needs to be possible in principle. I've thought about this a lot and
> > > not only are unique commit timestamps the most natural way to make
> > > it possible, they're the only way conistent with the reality that
> > > commit comments may be altered for various good reasons during
> > > repository translation.  
> > 
> > If you are trying to debug or test something, why don't you serialize
> > the input you are using for your test?
> 
> And that's the problem. Serialization of a git repository is not stable
> because there is no total ordering on commits. And for testing you need
> to serialize some 'before' and 'after' state and they can be totally
> different. Not because the repository state is totally different but
> because the serialization of the state is not stable.

Yes, msuchanek is right - that is exactly the problem.  Very well put.

git fast-import streams *are* the serialization; they're what reposurgeon
ingests and emits.  The concrete problem I have is that there is no stable
correspondence between a repository and one canonical fast-import
serialization of it.

That is a bigger pain in the ass than you will be able to imagine unless
and until you try writing surgical tools yourself and discover that you
can't write tests for them.
-- 
		<a href="http://www.catb.org/~esr/">Eric S. Raymond</a>


