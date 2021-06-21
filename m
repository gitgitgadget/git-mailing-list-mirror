Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78BCCC48BE5
	for <git@archiver.kernel.org>; Mon, 21 Jun 2021 12:51:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5999161026
	for <git@archiver.kernel.org>; Mon, 21 Jun 2021 12:51:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbhFUMxU (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Jun 2021 08:53:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbhFUMxU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Jun 2021 08:53:20 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD349C061756
        for <git@vger.kernel.org>; Mon, 21 Jun 2021 05:51:04 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id he7so28566675ejc.13
        for <git@vger.kernel.org>; Mon, 21 Jun 2021 05:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=klerks-biz.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9QRPwka/+eB2F/TGjXg0aWn1DBz6PeDhIIXeS4FBuvQ=;
        b=J+eTinDyIQdIDplB442A1FkGN0N094/wtkypBhqjSXjbWptQaLsDipKmfp1EF4NRwa
         7OHRlSTUQ42W5MAngRxjgUV2OTfhVSROVXxfvG+bDQO0NSEGbHFjeDJYnkhcFe+UEOUM
         UEZwnrwDHLbAgB6T4IesGMWzEfhS0wExDdi51bhD92207EtyuaJClbq1uAGQ7D9vzbIA
         Kp37qXCrDNxP0kssXUyIEWtVH6zje6ZnHpDeFukT+QZVTKfbXTuSQEtOgSrQukhqmZEW
         pXMKxDePlIg4enj7LiD/2zhMvyzKds25bTmE6BQFkXTQWOThSc1VrWWZ6YFXFuTjcVHq
         yK5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9QRPwka/+eB2F/TGjXg0aWn1DBz6PeDhIIXeS4FBuvQ=;
        b=nP2ldDL1ZkK814flZAhKjvWklczSMRSBO0IGjszRStwOENE4f2dQ/XwCU27MtMYE4H
         AcVvDtPzHGEu1d4efRyemWUqgsa1Od+KuLbCf1/x5JxVOvov4JyHCDogpL2PgCu1jvnr
         LJURXOKhDIKsARkeDN0UiVYbOkZg8m9ECdjwjSkxrTYh3Wo1mOiPkAIPobPUbYjLdCKB
         HfvFc1lU3i/MS8kD/WRIRIHvxbcjLRGmYq4uxL1QGy/YoIz3xcwLcB73VhyqyJNywh62
         8sun0c4NxbbthZILAr70CDwsE83PKSdUsR5N7wEFY3tFSMh9N0Q6EpgjJTxijPujfw30
         aaCQ==
X-Gm-Message-State: AOAM5334/TbvytM5OYDOyLPmi9A9kZDup6FUyptzIy/JqM0o+NKtKsNH
        LH2pmdJAXNGdAelADjo8pbNv3lciho5HDyZ9otsa0g==
X-Google-Smtp-Source: ABdhPJyC6vRSpeAN2pZtxg0MUOCqnNIncx02eD5z9+eQKoH/B/LeZ2inUFp4UywIjzP9gmjPS5pRAW48BcPhV/rrR8g=
X-Received: by 2002:a17:907:960e:: with SMTP id gb14mr25156986ejc.231.1624279863248;
 Mon, 21 Jun 2021 05:51:03 -0700 (PDT)
MIME-Version: 1.0
References: <CAPMMpog7bNNPm3suZKu6OppHA+KDYgCfmaxW4HqTAr7_tTVAPQ@mail.gmail.com>
 <nycvar.QRO.7.76.6.2106111122010.57@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.2106111122010.57@tvgsbejvaqbjf.bet>
From:   Tao Klerks <tao@klerks.biz>
Date:   Mon, 21 Jun 2021 14:50:52 +0200
Message-ID: <CAPMMpogeWeQujG0UL80REOsaBJipxhQyOpBTuWD9U9_jg=FMMA@mail.gmail.com>
Subject: Re: Windows: core.useBuiltinFSMonitor without core.untrackedcache -
 performance hazard?
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git <git@vger.kernel.org>, Jeff Hostetler <jeffhost@microsoft.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: multipart/mixed; boundary="00000000000043f1e005c54620fe"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

--00000000000043f1e005c54620fe
Content-Type: text/plain; charset="UTF-8"

Hi Johannes,

Thanks for the detailed reply!

My apologies for the subsequent delay - I've been trying to understand
the behavior so that I can describe it in more detail, and that
required me to learn a little C along the way :)

On Fri, Jun 11, 2021 at 11:49 AM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> _sometimes_, the mtime of a directory seems not to
> be updated immediately after an item in it was modified/added/deleted. And
> that mtime is precisely what the untracked cache depends on.
>
> The funny thing is: while the output of `git status` will therefore at
> first fail to pick up on, say, a new untracked file, running `git status`
> _immediately_ afterwards _will succeed_ to see that untracked file.

(I have nothing to add here - I don't understand what
synchronous-acknowledgement or ordering guarantees we rely on to
determine when we *expect* a change to be available to the fsmonitor,
nor to I have any familiarity with the underlying APIs we use)

> On Thu, 10 Jun 2021, Tao Klerks wrote:
> >  - There is also a lingering "problem" with "git status -uall", with
> > both "core.useBuiltinFSMonitor" and "core.fsmonitor", but that seems
> > far less trivial to address
>
> Interesting. I guess the untracked cache might become too clunky with many
> untracked files? Or is there something else going on?

I think I understand this now, but I don't think I can explain it
particularly well/succinctly.

I've attached a sort of "truth table" of performance data for a
particular repository, running *warm* git status calls (no cold-cache
testing at all) with various config and command-line options, and
reporting the durations of various phases/processes captured using
GIT_TRACE2_PERF=1.

The claimed "problem" with "git status -uall", when both
"core.useBuiltinFSMonitor" and "core.fsmonitor" are enabled, only
exists from the perspective of someone who's got core.fscache enabled
all the time:
* core.fscache works (in the Windows port only) by doing slightly more
expensive work up-front on first directory query within a
request/process lifetime, and then intercepting subsequent filesystem
"queries"/operations
* The context within which most of this more-expensive work typically
occurs, in a "git status" request, is an explicitly and intentionally
multi-threaded filesystem "lstat"-checking process in preload-index.c
(always 20 threads, for a large repo)
* There are two sets of filesystem-iteration in a simple/naive git
status call with core.preloadindex enabled as by default - the
lstat-checking multithreaded loops for files in the index, and the
recursive directory scanning for untracked files that happens later
* That second (not-multithreaded) set of work, with fscache enabled,
gets to reuse a bunch of cached fs data from the first one. A walk
that cost 7s without fscache now costs only 2.5s, for example.
* With fsmonitor enabled (and warm), the first walk simply doesn't
happen, so fscache stops making any difference to that
untracked-file-searching directory walk; it goes back to taking 7s;
every directory is queried once in series, so fscache has no impact at
all.
* Because the preload-index lstat-querying loop is parallelized, with
fscache the initial cache population happens fast-ish - the total time
taken for git status is eg 5s (2.5s of parallelized & accelerated
lstat-querying and 2.5s of
untracked-folder-iterating-and-processing-from-fscache)
* So, with fscache enabled, turning on fsmonitor actually makes "git
status" *slower* - it changes the "lstat + untracked" time from "2.5s
+ 2.5s" to "0s + 7s"
* We can hide/mitigate that by enabling the untracked cache - but that
"fails out" in all sorts of conditions specified in dir.c
validate_untracked_cache(), including specifying "-uall"/"-u" to "git
status
* -> it is only in the context of fscache being enabled, and already
speeding up the filesystem work, that fsmonitor can make things worse
by making the first directory-querying loop happen in a non-parallel
area of code, and thereby cancel fscache's impact.
* -> fsmonitor never makes things worse on linux, since there is no
fscache and so untracked folder iteration never benefits from any
multithreading
* -> when the untracked cache does apply, fsmonitor can *help* it,
avoiding the need for any sort of directory walk at all, on the basis
that "nothing in the filesystem appears to have changed"

Based on this understanding, it looks like there are at least three
possible directions to be explored:

1. Making the untracked cache less sensitive to configuration in
dir.c#validate_untracked_cache(), at the cost of doing more work in
the cold cases & saving more data in the index file (specific
untracked files, and .git folder names or something)
 ** This would result in peak performance, with no
filesystem-iterating at all in the ideal case
 ** This would apply / add substantial value in Windows and Linux
 ** This is probably the most complex change - dir.c is not easy to
understand/navigate

2. Making the untracked directory-search happen in a multithreaded way
 ** This would raise the performance with "-uall" to approximately the
same as it was before fsmonitor was introduced on windows, and speed
it up slightly on linux
 ** This change would probably not be worthwhile, - its impact would
not be huge except in very specific cases, and it would still
introduce non-trivial complexity

3. Forcing preload-index to actually "do its multithreaded work", even
when fsmonitor is there, if we know that the untracked cached cannot
be used and fsmonitor is enabled
 ** This would raise the performance with "-uall" to approximately the
same as it was before fsmonitor was introduced on windows
 ** This change would probably be pretty easy - the main challenge is
how to get untracked-cache-applicability information at preload-index
time, since these happen in completely different parts of the codebase

I mocked up a local hack for the third option, and confirmed that
forcing preload-index to ignore it does indeed bring "git status
-uall"  performance back to the same level as before enabling
fsmonitor.

> > I just started testing the new "core.useBuiltinFSMonitor" option in
> > the new installer, and it's amazing, thanks Ben, Alex, Johannes and
> > Kevin!
>
> Not to forget Jeff Hostetler, who essentially spent the past half year on
> it on his own.

Argh, thank you for the correction, and thank you Jeff also for all
your work on this.

> > For context, this is in a repo with 200,000 or so files, within 40,000
> > folders (avg path depth 4 I think?), with a reasonably-intricate set
> > of .gitignore patterns.

> My `.gitignore` consists of only ~40 heavily commented lines (containing
> five lines with wildcards), but I do have a `.git/info/exclude` that
> contains a set of generated file/directory lists, i.e. without any
> wildcards. This `exclude` file is ~26k lines long.
>
> My guess is that the amount of work to match the untracked vs ignored
> files is dominating the entire operation, by a lot.

In my case, as per the "truth table" referenced above, there are two
kinds of things in play:
1. Filesystem operations are the main thing that matters in Windows
2. Some smaller amount of overhead (0.5-1s in my case) is associated
with other work (pattern-matching etc) during untracked file
detection, even with untracked cache enabled. The only way to avoid
that work altogether is to have fsmonitor *and* untracked cache
working, so that untracked cache can "trust" the fsmonitor results to
avoid having to do any work at all. In this ideal situation fscache
makes no difference, as there is no fs iteration.

> > I don't know whether this is the right place to report Windows-centric
> > concerns, if not, my apologies.
>
> I would not necessarily call them "Windows-centric", even if yes, at the
> moment the built-in FSMonitor is most easily enabled on Windows (because I
> added that experimental option in Git for Windows' installer, after
> integrating the experimental feature).

Right - now that I understand the situation better, there are three
specific ways in which I consider these to be windows-centric
concerns:
* In my experience / in my context at least, the "naive" impact of
file operation performance differences results in a more than 10X "git
status" reduction in performance for large repos (over linux); various
optional and/or windows-specific strategies significantly close that
gap
* core.fscache is a windows-specific strategy for dealing with this,
and interacts with other features/strategies in potentially-surprising
ways
* The built-in FSMonitor is still only *easily* available in Windows

But, to your point, most of the *solutions* need not be
windows-centric at all. The "best" one, making untracked cache a
little more forgiving, would definitely have tangible performance
benefits on linux (and presumably OSX).

Thanks,
Tao

--00000000000043f1e005c54620fe
Content-Type: text/csv; charset="US-ASCII"; 
	name="Git status timing comparison, large repo, different OSes, fscache, untrackedcache, fsmonitor, and uall.csv"
Content-Disposition: attachment; 
	filename="Git status timing comparison, large repo, different OSes, fscache, untrackedcache, fsmonitor, and uall.csv"
Content-Transfer-Encoding: base64
Content-ID: <f_kq6lybgw0>
X-Attachment-Id: f_kq6lybgw0

SW5wdXQ6IE9TLElucHV0OiBGU0NhY2hlLElucHV0OiBVbnRyYWNrZWRDYWNoZSxJbnB1dDogRlNN
b25pdG9yLElucHV0OiAtdWFsbCxJbjogUHJlbG9hZEluZGV4LEluOiBDb21tYW5kLFRpbWluZzog
cmVhZCBpbmRleCxUaW1pbmc6IHF1ZXJ5IGZzbW9uaXRvcixUaW1pbmc6IHByZWxvYWQgbHN0YXQg
MjA3ayBmaWxlcyxUaW1pbmc6IHJlZnJlc2gsVGltaW5nOiB0cmF2ZXJzZSB0cmVlcyxUaW1pbmc6
IE5hbWUtaGFzaC1pbml0LFRpbWluZzogdW50cmFja2VkLEFwcHJveCBUb3RhbCBUaW1pbmcKTGlu
dXgsKE4vQSksZmFsc2UsZGlzYWJsZWQsKGlycmVsZXZhbnQpLHRydWUsZXhwb3J0IEdJVF9UUkFD
RTJfUEVSRj0xICYmIGdpdCAtYyBjb3JlLnVudHJhY2tlZGNhY2hlPWZhbHNlIC1jIGNvcmUuZnNt
b25pdG9yPSAtYyBjb3JlLnByZWxvYWRpbmRleD10cnVlIHN0YXR1cywwLjA0LDAsMC4wNywwLDAs
MC4wNiwwLjgyLDAuOTkKTGludXgsKE4vQSksdHJ1ZSxkaXNhYmxlZCxmYWxzZSx0cnVlLGV4cG9y
dCBHSVRfVFJBQ0UyX1BFUkY9MSAmJiBnaXQgLWMgY29yZS51bnRyYWNrZWRjYWNoZT10cnVlIC1j
IGNvcmUuZnNtb25pdG9yPSAtYyBjb3JlLnByZWxvYWRpbmRleD10cnVlIHN0YXR1cywwLjA1LDAs
MC4wNywwLDAsMC4wNiwwLjMyLDAuNQpMaW51eCwoTi9BKSx0cnVlLGRpc2FibGVkLHRydWUsdHJ1
ZSxleHBvcnQgR0lUX1RSQUNFMl9QRVJGPTEgJiYgZ2l0IC1jIGNvcmUudW50cmFja2VkY2FjaGU9
dHJ1ZSAtYyBjb3JlLmZzbW9uaXRvcj0gLWMgY29yZS5wcmVsb2FkaW5kZXg9dHJ1ZSBzdGF0dXMg
LXUsMC4wNCwwLDAuMDcsMCwwLDAuMDcsMC43OCwwLjk2CkxpbnV4LChOL0EpLGZhbHNlLGRpc2Fi
bGVkLChpcnJlbGV2YW50KSxmYWxzZSxleHBvcnQgR0lUX1RSQUNFMl9QRVJGPTEgJiYgZ2l0IC1j
IGNvcmUudW50cmFja2VkY2FjaGU9ZmFsc2UgLWMgY29yZS5mc21vbml0b3I9IC1jIGNvcmUucHJl
bG9hZGluZGV4PWZhbHNlIHN0YXR1cywwLjA0LDAsMCwwLjM3LDAsMC4wNywwLjg3LDEuMzUKTGlu
dXgsKE4vQSksdHJ1ZSxkaXNhYmxlZCxmYWxzZSxmYWxzZSxleHBvcnQgR0lUX1RSQUNFMl9QRVJG
PTEgJiYgZ2l0IC1jIGNvcmUudW50cmFja2VkY2FjaGU9dHJ1ZSAtYyBjb3JlLmZzbW9uaXRvcj0g
LWMgY29yZS5wcmVsb2FkaW5kZXg9ZmFsc2Ugc3RhdHVzLDAuMDUsMCwwLDAuMzksMCwwLjA2LDAu
MzEsMC44MQpMaW51eCwoTi9BKSx0cnVlLGRpc2FibGVkLHRydWUsZmFsc2UsZXhwb3J0IEdJVF9U
UkFDRTJfUEVSRj0xICYmIGdpdCAtYyBjb3JlLnVudHJhY2tlZGNhY2hlPXRydWUgLWMgY29yZS5m
c21vbml0b3I9IC1jIGNvcmUucHJlbG9hZGluZGV4PWZhbHNlIHN0YXR1cyAtdSwwLjA1LDAsMCww
LjM4LDAsMC4wNywwLjc4LDEuMjgKTGludXgsKE4vQSksZmFsc2UsZW5hYmxlZCwoaXJyZWxldmFu
dCksKGlycmVsZXZhbnQpLGV4cG9ydCBHSVRfVFJBQ0UyX1BFUkY9MSAmJiBnaXQgLWMgY29yZS51
bnRyYWNrZWRjYWNoZT1mYWxzZSAtYyBjb3JlLmZzbW9uaXRvcj0vaG9tZS90YW8vYnVpbGQtZ2l0
Ly5naXQvaG9va3MvZnNtb25pdG9yLXdhdGNobWFuLnNhbXBsZSBzdGF0dXMsMC4wNCwwLjA0LDAs
MC4wMiwwLDAuMDYsMC44MSwwLjk3CkxpbnV4LChOL0EpLHRydWUsZW5hYmxlZCxmYWxzZSwoaXJy
ZWxldmFudCksZXhwb3J0IEdJVF9UUkFDRTJfUEVSRj0xICYmIGdpdCAtYyBjb3JlLnVudHJhY2tl
ZGNhY2hlPXRydWUgLWMgY29yZS5mc21vbml0b3I9L2hvbWUvdGFvL2J1aWxkLWdpdC8uZ2l0L2hv
b2tzL2ZzbW9uaXRvci13YXRjaG1hbi5zYW1wbGUgc3RhdHVzLDAuMDQsMC4wNCwwLDAuMDIsMCww
LjA3LDAuMjYsMC40MwpMaW51eCwoTi9BKSx0cnVlLGVuYWJsZWQsdHJ1ZSwoaXJyZWxldmFudCks
ZXhwb3J0IEdJVF9UUkFDRTJfUEVSRj0xICYmIGdpdCAtYyBjb3JlLnVudHJhY2tlZGNhY2hlPXRy
dWUgLWMgY29yZS5mc21vbml0b3I9L2hvbWUvdGFvL2J1aWxkLWdpdC8uZ2l0L2hvb2tzL2ZzbW9u
aXRvci13YXRjaG1hbi5zYW1wbGUgc3RhdHVzIC11LDAuMDUsMC4wNCwwLDAuMDIsMCwwLjA3LDAu
NzgsMC45NgpXaW5kb3dzLGZhbHNlLGZhbHNlLGRpc2FibGVkLChpcnJlbGV2YW50KSx0cnVlLGV4
cG9ydCBHSVRfVFJBQ0UyX1BFUkY9MSAmJiB0aW1lIC91c3Ivc3JjL2dpdC9naXQuZXhlIC1jIGNv
cmUuZnNjYWNoZT1mYWxzZSAtYyBjb3JlLnVudHJhY2tlZGNhY2hlPWZhbHNlIC1jIGNvcmUudXNl
QnVpbHRJbkZTTW9uaXRvcj1mYWxzZSAtYyBjb3JlLnByZWxvYWRpbmRleD10cnVlIHN0YXR1cyww
LjA3LDAsMy4zNiwwLDAuMzIsMC4wMyw1Ljg5LDkuNjcKV2luZG93cyxmYWxzZSx0cnVlLGRpc2Fi
bGVkLGZhbHNlLHRydWUsZXhwb3J0IEdJVF9UUkFDRTJfUEVSRj0xICYmIHRpbWUgL3Vzci9zcmMv
Z2l0L2dpdC5leGUgLWMgY29yZS5mc2NhY2hlPWZhbHNlIC1jIGNvcmUudW50cmFja2VkY2FjaGU9
dHJ1ZSAtYyBjb3JlLnVzZUJ1aWx0SW5GU01vbml0b3I9ZmFsc2UgLWMgY29yZS5wcmVsb2FkaW5k
ZXg9dHJ1ZSBzdGF0dXMsMC4wNSwwLDMuMSwwLDAuMzIsMC4wMywyLjQ2LDUuOTYKV2luZG93cyxm
YWxzZSx0cnVlLGRpc2FibGVkLHRydWUsdHJ1ZSxleHBvcnQgR0lUX1RSQUNFMl9QRVJGPTEgJiYg
dGltZSAvdXNyL3NyYy9naXQvZ2l0LmV4ZSAtYyBjb3JlLmZzY2FjaGU9ZmFsc2UgLWMgY29yZS51
bnRyYWNrZWRjYWNoZT10cnVlIC1jIGNvcmUudXNlQnVpbHRJbkZTTW9uaXRvcj1mYWxzZSAtYyBj
b3JlLnByZWxvYWRpbmRleD10cnVlIHN0YXR1cyAtdSwwLjA1LDAsMy4wNSwwLDAuMzEsMC4wMyw1
Ljk1LDkuMzkKV2luZG93cyxmYWxzZSxmYWxzZSxkaXNhYmxlZCwoaXJyZWxldmFudCksZmFsc2Us
ZXhwb3J0IEdJVF9UUkFDRTJfUEVSRj0xICYmIHRpbWUgL3Vzci9zcmMvZ2l0L2dpdC5leGUgLWMg
Y29yZS5mc2NhY2hlPWZhbHNlIC1jIGNvcmUudW50cmFja2VkY2FjaGU9ZmFsc2UgLWMgY29yZS51
c2VCdWlsdEluRlNNb25pdG9yPWZhbHNlIC1jIGNvcmUucHJlbG9hZGluZGV4PWZhbHNlIHN0YXR1
cywwLjA1LDAsMCwxMi4xMiwwLjMxLDAuMDMsNS45NSwxOC40NgpXaW5kb3dzLGZhbHNlLHRydWUs
ZGlzYWJsZWQsZmFsc2UsZmFsc2UsZXhwb3J0IEdJVF9UUkFDRTJfUEVSRj0xICYmIHRpbWUgL3Vz
ci9zcmMvZ2l0L2dpdC5leGUgLWMgY29yZS5mc2NhY2hlPWZhbHNlIC1jIGNvcmUudW50cmFja2Vk
Y2FjaGU9dHJ1ZSAtYyBjb3JlLnVzZUJ1aWx0SW5GU01vbml0b3I9ZmFsc2UgLWMgY29yZS5wcmVs
b2FkaW5kZXg9ZmFsc2Ugc3RhdHVzLDAuMDUsMCwwLDEyLjE3LDAuMzEsMC4wMywyLjI2LDE0Ljgy
CldpbmRvd3MsZmFsc2UsdHJ1ZSxkaXNhYmxlZCx0cnVlLGZhbHNlLGV4cG9ydCBHSVRfVFJBQ0Uy
X1BFUkY9MSAmJiB0aW1lIC91c3Ivc3JjL2dpdC9naXQuZXhlIC1jIGNvcmUuZnNjYWNoZT1mYWxz
ZSAtYyBjb3JlLnVudHJhY2tlZGNhY2hlPXRydWUgLWMgY29yZS51c2VCdWlsdEluRlNNb25pdG9y
PWZhbHNlIC1jIGNvcmUucHJlbG9hZGluZGV4PWZhbHNlIHN0YXR1cyAtdSwwLjA1LDAsMCwxMi4x
MywwLjMxLDAuMDMsNi4xLDE4LjYyCldpbmRvd3MsZmFsc2UsZmFsc2UsZW5hYmxlZCwoaXJyZWxl
dmFudCksKGlycmVsZXZhbnQpLGV4cG9ydCBHSVRfVFJBQ0UyX1BFUkY9MSAmJiB0aW1lIC91c3Iv
c3JjL2dpdC9naXQuZXhlIC1jIGNvcmUuZnNjYWNoZT1mYWxzZSAtYyBjb3JlLnVudHJhY2tlZGNh
Y2hlPWZhbHNlIC1jIGNvcmUudXNlQnVpbHRJbkZTTW9uaXRvcj10cnVlIHN0YXR1cywwLjA0LDAs
MCwwLjAyLDAuMzMsMC4wMyw2LjQzLDYuODUKV2luZG93cyxmYWxzZSx0cnVlLGVuYWJsZWQsZmFs
c2UsKGlycmVsZXZhbnQpLGV4cG9ydCBHSVRfVFJBQ0UyX1BFUkY9MSAmJiB0aW1lIC91c3Ivc3Jj
L2dpdC9naXQuZXhlIC1jIGNvcmUuZnNjYWNoZT1mYWxzZSAtYyBjb3JlLnVudHJhY2tlZGNhY2hl
PXRydWUgLWMgY29yZS51c2VCdWlsdEluRlNNb25pdG9yPXRydWUgc3RhdHVzLDAuMDUsMCwwLDAu
MDEsMC4zMywwLjAzLDAuNDgsMC45CldpbmRvd3MsZmFsc2UsdHJ1ZSxlbmFibGVkLHRydWUsKGly
cmVsZXZhbnQpLGV4cG9ydCBHSVRfVFJBQ0UyX1BFUkY9MSAmJiB0aW1lIC91c3Ivc3JjL2dpdC9n
aXQuZXhlIC1jIGNvcmUuZnNjYWNoZT1mYWxzZSAtYyBjb3JlLnVudHJhY2tlZGNhY2hlPXRydWUg
LWMgY29yZS51c2VCdWlsdEluRlNNb25pdG9yPXRydWUgc3RhdHVzIC11LDAuMDUsMCwwLDAuMDEs
MC4zMiwwLjAzLDYuMTksNi42CldpbmRvd3MsdHJ1ZSxmYWxzZSxkaXNhYmxlZCwoaXJyZWxldmFu
dCksdHJ1ZSxleHBvcnQgR0lUX1RSQUNFMl9QRVJGPTEgJiYgdGltZSAvdXNyL3NyYy9naXQvZ2l0
LmV4ZSAtYyBjb3JlLmZzY2FjaGU9dHJ1ZSAtYyBjb3JlLnVudHJhY2tlZGNhY2hlPWZhbHNlIC1j
IGNvcmUudXNlQnVpbHRJbkZTTW9uaXRvcj1mYWxzZSAtYyBjb3JlLnByZWxvYWRpbmRleD10cnVl
IHN0YXR1cywwLjA1LDAsMS44LDAsMC4zMSwwLjAzLDIuMSw0LjI5CldpbmRvd3MsdHJ1ZSx0cnVl
LGRpc2FibGVkLGZhbHNlLHRydWUsZXhwb3J0IEdJVF9UUkFDRTJfUEVSRj0xICYmIHRpbWUgL3Vz
ci9zcmMvZ2l0L2dpdC5leGUgLWMgY29yZS5mc2NhY2hlPXRydWUgLWMgY29yZS51bnRyYWNrZWRj
YWNoZT10cnVlIC1jIGNvcmUudXNlQnVpbHRJbkZTTW9uaXRvcj1mYWxzZSAtYyBjb3JlLnByZWxv
YWRpbmRleD10cnVlIHN0YXR1cywwLjA2LDAsMS41LDAuMDEsMC4zNSwwLjAzLDAuOTgsMi45MwpX
aW5kb3dzLHRydWUsdHJ1ZSxkaXNhYmxlZCx0cnVlLHRydWUsZXhwb3J0IEdJVF9UUkFDRTJfUEVS
Rj0xICYmIHRpbWUgL3Vzci9zcmMvZ2l0L2dpdC5leGUgLWMgY29yZS5mc2NhY2hlPXRydWUgLWMg
Y29yZS51bnRyYWNrZWRjYWNoZT10cnVlIC1jIGNvcmUudXNlQnVpbHRJbkZTTW9uaXRvcj1mYWxz
ZSAtYyBjb3JlLnByZWxvYWRpbmRleD10cnVlIHN0YXR1cyAtdSwwLjA1LDAsMS42OCwwLjAxLDAu
NDIsMC4wMywyLDQuMTkKV2luZG93cyx0cnVlLGZhbHNlLGRpc2FibGVkLChpcnJlbGV2YW50KSxm
YWxzZSxleHBvcnQgR0lUX1RSQUNFMl9QRVJGPTEgJiYgdGltZSAvdXNyL3NyYy9naXQvZ2l0LmV4
ZSAtYyBjb3JlLmZzY2FjaGU9dHJ1ZSAtYyBjb3JlLnVudHJhY2tlZGNhY2hlPWZhbHNlIC1jIGNv
cmUudXNlQnVpbHRJbkZTTW9uaXRvcj1mYWxzZSAtYyBjb3JlLnByZWxvYWRpbmRleD1mYWxzZSBz
dGF0dXMsMC4wNCwwLDAsMy4zNCwwLjMzLDAuMDMsMi4wOSw1LjgzCldpbmRvd3MsdHJ1ZSx0cnVl
LGRpc2FibGVkLGZhbHNlLGZhbHNlLGV4cG9ydCBHSVRfVFJBQ0UyX1BFUkY9MSAmJiB0aW1lIC91
c3Ivc3JjL2dpdC9naXQuZXhlIC1jIGNvcmUuZnNjYWNoZT10cnVlIC1jIGNvcmUudW50cmFja2Vk
Y2FjaGU9dHJ1ZSAtYyBjb3JlLnVzZUJ1aWx0SW5GU01vbml0b3I9ZmFsc2UgLWMgY29yZS5wcmVs
b2FkaW5kZXg9ZmFsc2Ugc3RhdHVzLDAuMDUsMCwwLDMuNDYsMC4zNCwwLjAzLDAuODQsNC43MgpX
aW5kb3dzLHRydWUsdHJ1ZSxkaXNhYmxlZCx0cnVlLGZhbHNlLGV4cG9ydCBHSVRfVFJBQ0UyX1BF
UkY9MSAmJiB0aW1lIC91c3Ivc3JjL2dpdC9naXQuZXhlIC1jIGNvcmUuZnNjYWNoZT10cnVlIC1j
IGNvcmUudW50cmFja2VkY2FjaGU9dHJ1ZSAtYyBjb3JlLnVzZUJ1aWx0SW5GU01vbml0b3I9ZmFs
c2UgLWMgY29yZS5wcmVsb2FkaW5kZXg9ZmFsc2Ugc3RhdHVzIC11LDAuMDUsMCwwLDMuMzgsMC4z
MiwwLjA0LDEuODUsNS42NApXaW5kb3dzLHRydWUsZmFsc2UsZW5hYmxlZCwoaXJyZWxldmFudCks
KGlycmVsZXZhbnQpLGV4cG9ydCBHSVRfVFJBQ0UyX1BFUkY9MSAmJiB0aW1lIC91c3Ivc3JjL2dp
dC9naXQuZXhlIC1jIGNvcmUuZnNjYWNoZT10cnVlIC1jIGNvcmUudW50cmFja2VkY2FjaGU9ZmFs
c2UgLWMgY29yZS51c2VCdWlsdEluRlNNb25pdG9yPXRydWUgc3RhdHVzLDAuMDQsMCwwLjAxLDAu
MDEsMC4zMywwLjAzLDQuOSw1LjMyCldpbmRvd3MsdHJ1ZSx0cnVlLGVuYWJsZWQsZmFsc2UsKGly
cmVsZXZhbnQpLGV4cG9ydCBHSVRfVFJBQ0UyX1BFUkY9MSAmJiB0aW1lIC91c3Ivc3JjL2dpdC9n
aXQuZXhlIC1jIGNvcmUuZnNjYWNoZT10cnVlIC1jIGNvcmUudW50cmFja2VkY2FjaGU9dHJ1ZSAt
YyBjb3JlLnVzZUJ1aWx0SW5GU01vbml0b3I9dHJ1ZSBzdGF0dXMsMC4wNSwwLDAuMDEsMC4wMSww
LjM0LDAuMDMsMC41LDAuOTQKV2luZG93cyx0cnVlLHRydWUsZW5hYmxlZCx0cnVlLChpcnJlbGV2
YW50KSxleHBvcnQgR0lUX1RSQUNFMl9QRVJGPTEgJiYgdGltZSAvdXNyL3NyYy9naXQvZ2l0LmV4
ZSAtYyBjb3JlLmZzY2FjaGU9dHJ1ZSAtYyBjb3JlLnVudHJhY2tlZGNhY2hlPXRydWUgLWMgY29y
ZS51c2VCdWlsdEluRlNNb25pdG9yPXRydWUgc3RhdHVzIC11LDAuMDYsMCwwLjAxLDAuMDEsMC4z
MSwwLjAzLDUuMTQsNS41Ngo=
--00000000000043f1e005c54620fe--
