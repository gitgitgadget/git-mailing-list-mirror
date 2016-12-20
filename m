Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C4B721FF76
	for <e@80x24.org>; Tue, 20 Dec 2016 15:06:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935808AbcLTPGn (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Dec 2016 10:06:43 -0500
Received: from smtp130.dfw.emailsrvr.com ([67.192.241.130]:36636 "EHLO
        smtp130.dfw.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751359AbcLTPGl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Dec 2016 10:06:41 -0500
X-Greylist: delayed 325 seconds by postgrey-1.27 at vger.kernel.org; Tue, 20 Dec 2016 10:06:41 EST
Received: from smtp25.relay.dfw1a.emailsrvr.com (localhost [127.0.0.1])
        by smtp25.relay.dfw1a.emailsrvr.com (SMTP Server) with ESMTP id 29209C0124;
        Tue, 20 Dec 2016 10:01:16 -0500 (EST)
X-Auth-ID: mbranchaud@xiplink.com
Received: by smtp25.relay.dfw1a.emailsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id CDA7CC00F1;
        Tue, 20 Dec 2016 10:01:15 -0500 (EST)
X-Sender-Id: mbranchaud@xiplink.com
Received: from [10.10.1.32] ([UNAVAILABLE]. [192.252.130.194])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA)
        by 0.0.0.0:465 (trex/5.7.12);
        Tue, 20 Dec 2016 10:01:16 -0500
Subject: Re: [PATCH 00/13] gitk: tweak rendering of remote-tracking references
To:     Michael Haggerty <mhagger@alum.mit.edu>,
        Paul Mackerras <paulus@samba.org>
References: <cover.1482164633.git.mhagger@alum.mit.edu>
Cc:     git@vger.kernel.org
From:   Marc Branchaud <marcnarc@xiplink.com>
Message-ID: <97d97bc6-54f1-2ef2-fe04-7e7f144d7e51@xiplink.com>
Date:   Tue, 20 Dec 2016 10:01:15 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.5.1
MIME-Version: 1.0
In-Reply-To: <cover.1482164633.git.mhagger@alum.mit.edu>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2016-12-19 11:44 AM, Michael Haggerty wrote:
> This patch series changes a bunch of details about how remote-tracking
> references are rendered in the commit list of gitk:

Thanks for this!  I like the new, compact look very much!

That said, I remember when I was a new git user and I leaned heavily on 
gitk to understand how references worked.  It was particularly 
illuminating to see the remote references distinctly labeled, and the 
fact that they were "remotes/origin/foo" gave me an Aha! moment where I 
came to understand that the refs hierarchy is more flexible than just 
the conventions coded into git itself.  I eventually felt free to create 
my own, private ref hierarchies.

I am in no way opposed to this series.  I just wanted to point out that 
there was some utility in those labels.  It makes me think that it might 
be worthwhile for gitk to have a "raw-refs" mode, that shows the full 
"refs/foo/bar/baz" paths of all the heads, tags, and whatever else.  It 
could be a useful teaching tool for git.

> * Omit the "remote/" prefix on normal remote-tracking references. They

If you re-roll, s:remote/:remotes/:.

>   are already distinguished via their two-tone rendering and (usually)
>   longer names, and this change saves a lot of visual clutter and
>   horizontal space.
>
> * Render remote-tracking references that have more than the usual
>   three slashes like
>
>       origin/foo/bar
>       ^^^^^^^
>
>   rather than
>
>       origin/foo/bar (formerly remotes/origin/foo/bar)
>       ^^^^^^^^^^^              ^^^^^^^^^^^^^^^^^^^
>
>   , where the indicated part is the prefix that is rendered in a
>   different color. Usually, such a reference represents a remote
>   branch that contains a slash in its name, so the new split more
>   accurately portrays the separation between remote name and remote
>   branch name.

*Love* this change!  :)

> * Introduce a separate constant to specify the background color used
>   for the branch name part of remote-tracking references, to allow it
>   to differ from the color used for local branches (which by default
>   is bright green).
>
> * Change the default background colors for remote-tracking branches to
>   light brown and brown (formerly they were pale orange and bright
>   green).

Please don't change the remotebgcolor default.

Also, perhaps the default remoterefbgcolor should be
	set remoterefbgcolor $headbgcolor
?

I say this because when I applied the series, without the last patch, I 
was miffed that the remote/ref colour had changed.

Plus I think there's utility in having local and remote branch names in 
the same colour, again especially for new users.  It helps emphasize 
their similarities, and demystify some of git's internal magic.

		M.


> I understand that the colors of pixels on computer screens is an even
> more emotional topic that that of bikesheds, so I implemented the last
> change as a separate commit, the last one in the series. Feel free to
> drop it if you don't want the default color change.
>
> Along the way, I did a bunch of refactoring in the area to make these
> changes easier, and introduced a constant for the background color of
> "other" references so that it can also be adjusted by users.
>
> (Unfortunately, these colors can only be adjusted by editing the
> configuration file. Someday it would be nice to allow them to be
> configured via the preferences dialog.)
>
> It's been a while since I've written any Tcl code, so I apologize in
> advance for any howlers :-)
>
> This branch applies against the `master` branch in
> git://ozlabs.org/~paulus/gitk.
>
> Michael
>
> Michael Haggerty (13):
>   gitk: when processing tag labels, don't use `marks` as scratch space
>   gitk: keep track of tag types in a separate `types` array
>   gitk: use a type "tags" to indicate abbreviated tags
>   gitk: use a type "mainhead" to indicate the main HEAD branch
>   gitk: fill in `wvals` as the tags are first processed
>   gitk: simplify regexp
>   gitk: extract a method `remotereftext`
>   gitk: only change the color of the "remote" part of remote refs
>   gitk: shorten labels displayed for modern remote-tracking refs
>   gitk: use type "remote" for remote-tracking references
>   gitk: introduce a constant otherrefbgcolor
>   gitk: add a configuration setting `remoterefbgcolor`
>   gitk: change the default colors for remote-tracking references
>
>  gitk | 114 ++++++++++++++++++++++++++++++++++++++++++++-----------------------
>  1 file changed, 76 insertions(+), 38 deletions(-)
>
