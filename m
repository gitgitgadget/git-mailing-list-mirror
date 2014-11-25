From: Peter Wu <peter@lekensteyn.nl>
Subject: Re: [PATCH v3] remote: add --fetch and --both options to set-url
Date: Tue, 25 Nov 2014 23:53:56 +0100
Message-ID: <2086201.pfQdnB4m0z@al>
References: <1416916106-19892-1-git-send-email-peter@lekensteyn.nl> <CAPig+cS1rFpFO4YsNEi2Fjzfj+qH7Oat+PR+0GUo32=MFTNRiA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Cc: Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Tue Nov 25 23:54:09 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XtOzo-0007eM-B7
	for gcvg-git-2@plane.gmane.org; Tue, 25 Nov 2014 23:54:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751564AbaKYWyE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Nov 2014 17:54:04 -0500
Received: from lekensteyn.nl ([178.21.112.251]:37852 "EHLO lekensteyn.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751210AbaKYWyC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Nov 2014 17:54:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lekensteyn.nl; s=s2048-2014-q3;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From; bh=yR4YCh3NbhwmS8sPplBuY+4HwVc1+2QG+wj2oSWCuoM=;
	b=yW3iT81Kq3S14LAap3QZoR/nlGa7k7YgH1x9lIGTPSnTqnNUjDMVt78wU4KFD0QR4BCg3mZEV5V7/fQHrSSzbW8XZ4OcEG4Ti410TD8oSNl8FDBX8IsXNiuT3hxJFwyHslSdqdlbz2s5IrmRWOj7e2sgotoUl3sLJdCEuA0bbdoPB2EtSKx1HkIAB0OgSsloemTMRcxF0Czh/bnuikG33TA8XQJFTk2lVnSd933avO8g5VnYsXx/LhqBIS9AcHGZ1TXzKtvAAdoeKrocYRdCnMEVq9eldhOA8RXuHUFlCWQMdoeCwfwJCKeNbc7htP3fLqFUF5iicOTp6mRTaReBTg==;
Received: by lekensteyn.nl with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:256)
	(Exim 4.80)
	(envelope-from <peter@lekensteyn.nl>)
	id 1XtOzd-000317-PJ; Tue, 25 Nov 2014 23:53:58 +0100
User-Agent: KMail/4.14.3 (Linux/3.17.0-rc4-custom-00168-g7ec62d4; KDE/4.14.3; x86_64; ; )
In-Reply-To: <CAPig+cS1rFpFO4YsNEi2Fjzfj+qH7Oat+PR+0GUo32=MFTNRiA@mail.gmail.com>
X-Spam-Score: -0.0 (/)
X-Spam-Status: No, hits=-0.0 required=5.0 tests=NO_RELAYS=-0.001 autolearn=no autolearn_force=no
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260248>

On Tuesday 25 November 2014 17:09:04 Eric Sunshine wrote:
> On Tue, Nov 25, 2014 at 6:48 AM, Peter Wu <peter@lekensteyn.nl> wrote:
> > git remote set-url knew about the '--push' option to update just the
> > pushurl, but it does not have a similar option for "update fetch URL and
> > leave whatever was in place for the push URL".
> >
> > This patch adds support for a '--fetch' option which implements that use
> > case in a backwards compatible way: if no --both, --push or --fetch
> > options are given, then the push URL is modified too if it was not set
> > before. This is the case since the push URL is implicitly based on the
> > fetch URL.
> >
> > A '--both' option is added to make the command independent of previous
> > pushurl settings. For the --add and --delete set operations, it will
> > always set the push and/ or the fetch URLs. For the primary mode of
> > operation (without --add or --delete), it will drop pushurl as the
> > implicit push URL is the (fetch) URL.
> 
> I've read (though perhaps not fully digested) the other email thread
> which led up to this version of the patch, as well as the
> documentation update in this patch, but I still don't understand the
> need for the --both option. Intuitively, I would expect that
> specifying --fetch and --push on the command line would have the same
> effect as the proposed --both option. Thus, why is a separate (and
> exclusive) --both option needed? Is it to reduce typing? What am I
> missing?

The initial version just added --fetch and let --fetch --push behave
like the current --both. Here you can see the most recent discussion
leading to the --both option:
http://www.spinics.net/lists/git/msg242336.html

There was an overlapping discussion about the confusing historic
behavior (default vs. --fetch vs. --push --fetch), and an alternative
(less verbose form) of --push --fetch. The reason that --both is
introduced probably has something to do with it being less verbose.
I am not too attached to either option by the way.

> > The documentation has also been updated and a missing '--push' option
> > is added to the 'git remote -h' command.
> >
> > Tests are also added to verify the documented behavior.
> >
> > Signed-off-by: Peter Wu <peter@lekensteyn.nl>
> > ---
> >
> >  v2: fixed test case
> >  v3: added --both option, changed --fetch --push behavior, added more tests for
> >      --add/--delete cases, refactored to reduce duplication (not special-casing
> >      add_mode without oldurl, just skip initially setting oldurl).
> >
> > Translators note: the help text gained more translatable strings and some
> > strings got additional options.
> > ---
> > diff --git a/Documentation/git-remote.txt b/Documentation/git-remote.txt
> > index cb103c8..bdd0305 100644
> > --- a/Documentation/git-remote.txt
> > +++ b/Documentation/git-remote.txt
> > @@ -134,7 +134,16 @@ Changes URL remote points to. Sets first URL remote points to matching
> >  regex <oldurl> (first URL if no <oldurl> is given) to <newurl>. If
> >  <oldurl> doesn't match any URL, error occurs and nothing is changed.
> >  +
> > -With '--push', push URLs are manipulated instead of fetch URLs.
> > +With '--both', both the fetch and push URLs are manipulated.
> > ++
> > +With '--fetch', only fetch URLs are manipulated.
> > ++
> > +With '--push', only push URLs are manipulated.
> > ++
> > +If none of the '--both', '--fetch' or --push' options are given, then
> > +'--both' applies only if no push URL was set before. Otherwise '--fetch'
> > +is assumed for historical reasons. This default may change in the
> > +future to '--both' to avoid surprises depending on the configuration.
> 
> This explanation is somewhat tortuous. Assuming that the --both option
> is superfluous, perhaps this could be explained more clearly along
> these lines:
> 
> --- 8< ---
> `--fetch` changes fetch URLs, and --push changes push URLs. Specified
> together, both fetch and push URLs are changed.
> 
> For historical reasons, if neither --fetch nor --push is specified,
> then the fetch URL is changed, as well as the push URL if not already
> set.
> --- 8< ---

Excellent, short and concise. If this path is taken, I would still add
the note about the future change.

I am also interested in opinions about the suggested default behavior.
Should it become --both (--push --fetch)? In that case '--both' will be
a pretty useless option in the future (when it becomes the default).

> >  +
> >  With '--add', instead of changing some URL, new URL is added.
> >  +
