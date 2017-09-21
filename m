Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B0B79202A5
	for <e@80x24.org>; Thu, 21 Sep 2017 01:13:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751894AbdIUBNQ (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Sep 2017 21:13:16 -0400
Received: from ns332406.ip-37-187-123.eu ([37.187.123.207]:40282 "EHLO
        glandium.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751681AbdIUBNP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Sep 2017 21:13:15 -0400
Received: from glandium by mitsuha.glandium.org with local (Exim 4.89)
        (envelope-from <mh@glandium.org>)
        id 1duq39-0004qJ-RP; Thu, 21 Sep 2017 10:13:07 +0900
Date:   Thu, 21 Sep 2017 10:13:07 +0900
From:   Mike Hommey <mh@glandium.org>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, git-for-windows@googlegroups.com
Subject: Re: [git-for-windows] Re: Revision resolution for remote-helpers?
Message-ID: <20170921011307.ktqwesbh5wuckl55@glandium.org>
References: <20170818064208.plkppke7efpucuwm@glandium.org>
 <20170818220637.GN13924@aiede.mtv.corp.google.com>
 <20170818221754.3rbh35aewj5xnu4z@glandium.org>
 <20170818223323.GO13924@aiede.mtv.corp.google.com>
 <alpine.DEB.2.21.1.1708222212320.19382@virtualbox>
 <20170824082350.6ed6jqkn6aeylvnv@glandium.org>
 <alpine.DEB.2.21.1.1708251258080.7424@virtualbox>
 <20170825120236.orf6wubxf6qlvouy@glandium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170825120236.orf6wubxf6qlvouy@glandium.org>
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 25, 2017 at 09:02:36PM +0900, Mike Hommey wrote:
> On Fri, Aug 25, 2017 at 12:58:52PM +0200, Johannes Schindelin wrote:
> > > > > Cc-ing the Git for Windows mailing list as an FYI.
> > > > > 
> > > > > I have faint memories that some developers on that project have had to
> > > > > delve deep into Msys path modification rules.  It's possible they can
> > > > > give us advice (e.g. about <helper>::<url> having been a bad choice of
> > > > > syntax in the first place :)).
> > > > 
> > > > I think it is safe to assume that :: is not part of any Unix-y path. That
> > > > is why the MSYS2 runtime does not try to play games with it by converting
> > > > it to a Windows path.
> > > > 
> > > > (And indeed, I just tested this, an argument of the form
> > > > "a::file://b/x/y/z" is not converted to a "Windows path")
> > > 
> > > Note that there are people out there using msys, *and* git for windows,
> > > although I don't know if such people exist outside Mozilla.
> > 
> > Note that I am maintainer of Git for Windows, not of any setup that uses
> > MSys. Please do not even try to put more stuff on my plate.
> 
> I'm not trying to do that. I'm just saying that there are setups where
> the current way of using remote helpers doesn't work out, and it's
> completely independent of git or git for windows, and there's not much
> git for windows can do about it except maybe unmangling what msys does,
> but it's about as horrible as not doing anything.
> 
> This does bring the question, though, whether there should be an
> alternative syntax, which there actually is, but it doesn't really allow
> to convey things with a protocol after the double colons (e.g.
> you can't really distinguish between hg::http://... and hg::http://...
> with the hg:// form ; git-cinnabar allows the protocol to appear as part
> of the port number, e.g. hg://host:http/... and hg:// defaults to https)
> 
> And this brings the question whether :: would be the right "trigger" for
> the feature that opened this thread originally.

(FYI, FWIW)

So, interestingly, I tried using the instructions on
https://github.com/git-for-windows/git/wiki/Install-inside-MSYS2-proper
today, and that led me to the same problem, being that the msys path
munging was breaking <helper>::<url> syntax.

It turns out, I had placed the git-for-windows section last in
pacman.conf, so msys2-runtime hadn't been updated. Once it is updated,
the <helper>::<url> syntax is not munged anymore, and everything works
as expected.

Meaning, in fact, that git-for-windows has addressed the problem on its
end, but the problem still exists when running git-for-windows from a
msys2 shell without the git-for-windows msys2 runtime.

Also, the munging happens at the caller side, so the shell needs to be
using git-for-windows's msys2 runtime, it's not enough that git itself
does.

Mike
