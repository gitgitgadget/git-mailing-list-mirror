Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0563720EC
	for <git@vger.kernel.org>; Mon, 30 Oct 2023 09:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 795B0B3
	for <git@vger.kernel.org>; Mon, 30 Oct 2023 02:39:21 -0700 (PDT)
Received: (qmail 1698 invoked by uid 109); 30 Oct 2023 09:39:20 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 30 Oct 2023 09:39:20 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9652 invoked by uid 111); 30 Oct 2023 09:39:25 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 30 Oct 2023 05:39:25 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 30 Oct 2023 05:39:19 -0400
From: Jeff King <peff@peff.net>
To: Michal =?utf-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
Cc: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	Alexander Mills <alexander.d.mills@gmail.com>, git@vger.kernel.org
Subject: Re: please add link / url to remote - when - git push
Message-ID: <20231030093919.GF84866@coredump.intra.peff.net>
References: <CA+KyZp5mwGJ6YOvjKtfnDMDb9ci3vSq5KNUep6-8EfkHNaxREg@mail.gmail.com>
 <20231030063633.GA7451@tb-raspi4>
 <20231030085205.GF6241@kitsune.suse.cz>
 <20231030090626.GA84866@coredump.intra.peff.net>
 <20231030093023.GG6241@kitsune.suse.cz>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231030093023.GG6241@kitsune.suse.cz>

On Mon, Oct 30, 2023 at 10:30:23AM +0100, Michal Suchánek wrote:

> > > On the other hand, option to NOT display those remote messages is also
> > > missing. At least with git 2.35 they are displayed even when -q argument
> > > is given.
> > 
> > That is also up to GitHub to fix on the server side:
> > 
> >   https://lore.kernel.org/git/20230519090559.GA3515410@coredump.intra.peff.net/
> 
> If the server did not reject the push the messages it returns could be
> considered informational.

Hmm, yeah, I could perhaps buy that line of argument. Though it's
possible they are "warnings" of the sort that should still be emitted
with "--quiet"; really only the server knows. And note that even "reject
the push" is not necessarily all-or-nothing. The server may accept some
subset of the refs.

But...

> Not sure if the final status of the push is available or of the
> rejection is only noted in these messages, though.

Yes, this is a problem. Those messages are streamed out as we receive
them from the server, and before we get any status report back. I don't
think we'd want to buffer them, as they can be arbitrarily large (and
may even be progress reports that are meant to be shown in real-time).

-Peff
