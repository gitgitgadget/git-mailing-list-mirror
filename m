Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8356FA3741
	for <git@archiver.kernel.org>; Tue,  1 Nov 2022 01:28:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229885AbiKAB2O (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 Oct 2022 21:28:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiKAB2M (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Oct 2022 21:28:12 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEAE5167DA
        for <git@vger.kernel.org>; Mon, 31 Oct 2022 18:28:11 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id g13so7132017ile.0
        for <git@vger.kernel.org>; Mon, 31 Oct 2022 18:28:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XlrwfIb77pA9vul8tXAkGQ8ZBskbs/cp4cFZt7Kc6dU=;
        b=zskUZnygucj5U6TzdMNhxsJp9LU2b5G4lQ/BCMlW8vYwCwkGHadQ1ZUQXqCGbZvP+D
         8FHmhq2mLlW3HWnoKYXYvDNrEXSIv3ZXzmxAOfRqHEyNklFh7U5nbzcPT1NqSah8RF4I
         4gphgCZ/lVXTup7Rq7KGadsDT6TBVI1Rp6z/OMZh9SlTJFFcIwls80GfwZv2ujBtaR/4
         y6qVROhvFdIQhaxNhkizW/pTqVIGQH65jfbRlNGYitWazHA5PHCEB05ShHWTw/CYA+AK
         K/mi0XX5+d3tcGE22EbIaTGPHD0EMIolI5hGoXXSKQtu1ujhyuu93joehSExi0nG3vai
         WV9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XlrwfIb77pA9vul8tXAkGQ8ZBskbs/cp4cFZt7Kc6dU=;
        b=0JR2jrqsxspKVUTWdbkD8KWeyXJtca9QBSQAWNtGXpuqhAP6MeyNP2ajIkQsWLUWbp
         Viogz6uzKiCgHa3T3Z3r6ebkRXOmHoh79IeC8oUstfdP86lYfdcZDyLqiH0yxYm1HdZN
         e3NX06kocud6mr4NsgbPyftNRrS/J2gN4io/4XaF174l14aSU2HDdJjKoVoTDlrx2j84
         VY1vY53MYbSHj+C3nlBdsjk9OoNSB3lHl6q0H5CDw8yS8ddS63cxEIOQG/AglBVqNXO+
         5a2U9ie0rMW7aTm+S6qs+0hc9NjqPh+UmF2kYwimEqvxf+6S+fVwEYiOKwQJM0Rf29Ok
         M68A==
X-Gm-Message-State: ACrzQf37KfOYUiusSMlT0hDyUHQ20xpvyPua1tbWwzUl9sG2vfX7eDzx
        kSnC8odZgDX/gFDbyfMaDSkSCJeJp2kNb8HY
X-Google-Smtp-Source: AMsMyM4oiyxlgrqxOQmcIR/Q/TCQYhqE4yCbQ7820+YzJGL9TN5UjdEmTaQIOZZxZ8QZM8TOB9ZjJA==
X-Received: by 2002:a05:6e02:604:b0:300:b868:6ccd with SMTP id t4-20020a056e02060400b00300b8686ccdmr3081797ils.275.1667266091183;
        Mon, 31 Oct 2022 18:28:11 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id w15-20020a0566022c0f00b006a514f67f38sm3423600iov.28.2022.10.31.18.28.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Oct 2022 18:28:10 -0700 (PDT)
Date:   Mon, 31 Oct 2022 21:28:09 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/2] receive-pack: use advertised reference tips to
 inform connectivity check
Message-ID: <Y2B2KeYX5X9vp+cf@nand.local>
References: <cover.1666967670.git.ps@pks.im>
 <006e89f384be1227b922fb6fdc8755ae84cac587.1666967670.git.ps@pks.im>
 <Y17L0IjELU5QlOPL@nand.local>
 <Y1/fm1prlAs3U1NE@ncase>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y1/fm1prlAs3U1NE@ncase>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 31, 2022 at 03:45:47PM +0100, Patrick Steinhardt wrote:
> On Sun, Oct 30, 2022 at 03:09:04PM -0400, Taylor Blau wrote:
> > On Fri, Oct 28, 2022 at 04:42:27PM +0200, Patrick Steinhardt wrote:
> > > This strategy has the major downside that it will not require any object
> > > to be sent by the client that is reachable by any of the repositories'
> > > references. While that sounds like it would be indeed what we are after
> > > with the connectivity check, it is arguably not. The administrator that
> > > manages the server-side Git repository may have configured certain refs
> > > to be hidden during the reference advertisement via `transfer.hideRefs`
> > > or `receivepack.hideRefs`. Whatever the reason, the result is that the
> > > client shouldn't expect that any of those hidden references exists on
> > > the remote side, and neither should they assume any of the pointed-to
> > > objects to exist except if referenced by any visible reference. But
> > > because we treat _all_ local refs as uninteresting in the connectivity
> > > check, a client is free to send a packfile that references objects that
> > > are only reachable via a hidden reference on the server-side, and we
> > > will gladly accept it.
> >
> > You mention below that this is a correctness issue, but I am not sure
> > that I agree.
> >
> > The existing behavior is a little strange, I agree, but your argument
> > relies on an assumption that the history on hidden refs is not part of
> > the reachable set, which is not the case. Any part of the repository
> > that is reachable from _any_ reference, hidden or not, is reachable by
> > definition.
> >
> > So it's perfectly fine to consider objects on hidden refs to be in the
> > uninteresting set, because they are reachable. It's odd from the
> > client's perspective, but I do not see a path to repository corruption
> > with thee existing behavior.
>
> Indeed, I'm not trying to say that this can lead to repository
> corruption.

I definitely agree with that. I have thought about this on-and-off since
you sent the topic, and I am pretty certain that there is no path to
repository corruption with the existing behavior. It would be worth
updating the commit message to make this clearer.

> But security-related or not, I think it is safe to say that any packfile
> sent by a client that does not contain objects required for the updated
> reference that the client cannot know to exist on the server-side must
> be generated by buggy code.

Maybe, though I think it's fine to let clients send us smaller packfiles
if they have some a-priori knowledge that the server has objects that it
isn't advertising. And that can all happen without buggy code. So it's
weird, but there isn't anything wrong with letting it happen.

> [snip]
> > Why do we see a slowdown when there there aren't any hidden references?
> > Or am I misunderstanding your patch message which instead means "we see
> > a slow-down when there are no hidden references [since we still must
> > store and enumerate all advertised references]"?
>
> I have tried to dig down into the code of `revision.c` but ultimately
> returned empty-handed. I _think_ that this is because of the different
> paths we use when reading revisions from stdin as we have to resolve the
> revision to an OID first, which is more involved than taking the OIDs as
> returned by the reference backend. I have tried to short-circuit this
> logic in case the revision read from stdin is exactly `hash_algo->hexsz`
> long so that we try to parse it as an OID directly instead of trying to
> do any of the magic that is required to resolve a revision. But this
> only speed things up by a small margin.
>
> Another assumption was that this is overhead caused by using stdin
> instead of reading data from a file, but flame graphs didn't support
> this theory, either.
>
> > If the latter, could we avoid invoking the new machinery altogether? In
> > other words, shouldn't receive-pack only set the reachable_oids_fn() to
> > enumerate advertised references only when the set of advertised
> > references differs from the behavior of `--not --all`?
>
> Yeah, I was taking a "wait for feedback and see" stance on this. We can
> easily make the logic conditional on whether there are any hidden refs
> at all.

Yeah, I think that this would be preferable. I'm surprised that your
data doesn't support the idea that the slowdown is caused by reading
from stdin instead of parsing `--not --all`. I'd be curious to see what
you have tried so far.

I'm almost certain that forcing rev-list to chew through a bunch of data
on stdin that is basically equivalent to saying `--not --all` is going
to be the source of the slowdown.

> > >  	if (check_connected(iterate_receive_command_list, &data, &opt))
> > >  		set_connectivity_errors(commands, si);
> > >
> > > @@ -2462,6 +2473,7 @@ int cmd_receive_pack(int argc, const char **argv, const char *prefix)
> > >  {
> > >  	int advertise_refs = 0;
> > >  	struct command *commands;
> > > +	struct oidset announced_oids = OIDSET_INIT;
> >
> > This looks like trading one problem for another. In your above example,
> > we now need to store 20 bytes of OIDs 6.8M times, or ~130 MiB. Not the
> > end of the world, but it feels like an avoidable problem.
>
> We store these references in an `oidset` before this patch set already,
> but yes, the lifetime is longer now. But note that this set stores the
> announced objects, not the hidden ones. So we don't store 6.8m OIDs, but
> only the 250k announced ones.

Hmm, OK. I wonder, could rev-list be given a `--refs=<namespace>`
argument which is equal to the advertised references? Or something that
implies "give me all of the references which aren't hidden?"

If we call that maybe `--visible-refs=receive` (to imply the references
*not* in receive.hideRefs), then our connectivity check would become:

    git rev-list --stdin --not --visible-refs=receive

or something like that. Not having to extend the lifetime of these OIDs
in an oidset would be worthwhile. Besides, having a new rev-list option
is cool, too ;-).

> > Could we enumerate the references in a callback to for_each_ref() and
> > only emit ones which aren't hidden? Storing these and then recalling
> > them after the fact is worth avoiding.
>
> Sorry, I don't quite get what you're proposing. `for_each_ref()` already
> does exactly that: it stores every reference that is not hidden in the
> above `oidset`. This is the exact set of advertised references, which in
> my example repository would be about 250k. This information is used by
> git-receive-pack(1) to avoid announcing the same object twice, and now
> it's also used to inform the connectivity check to use these objects as
> the set of already-reachable objects.

Yes, ignore me ;-).

Thanks,
Taylor
