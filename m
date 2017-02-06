Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7E0131FAFC
	for <e@80x24.org>; Mon,  6 Feb 2017 17:13:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751694AbdBFRNV (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Feb 2017 12:13:21 -0500
Received: from smtp82.iad3a.emailsrvr.com ([173.203.187.82]:47474 "EHLO
        smtp82.iad3a.emailsrvr.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751281AbdBFRNU (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 6 Feb 2017 12:13:20 -0500
Received: from smtp11.relay.iad3a.emailsrvr.com (localhost [127.0.0.1])
        by smtp11.relay.iad3a.emailsrvr.com (SMTP Server) with ESMTP id AE39A5464;
        Mon,  6 Feb 2017 12:13:19 -0500 (EST)
X-Auth-ID: mbranchaud@xiplink.com
Received: by smtp11.relay.iad3a.emailsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id 67C0452D8;
        Mon,  6 Feb 2017 12:13:19 -0500 (EST)
X-Sender-Id: mbranchaud@xiplink.com
Received: from [10.10.1.32] ([UNAVAILABLE]. [192.252.130.194])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA)
        by 0.0.0.0:465 (trex/5.7.12);
        Mon, 06 Feb 2017 12:13:19 -0500
Subject: Re: [PATCH 00/13] gitk: tweak rendering of remote-tracking references
To:     Michael Haggerty <mhagger@alum.mit.edu>,
        Paul Mackerras <paulus@samba.org>
References: <cover.1482164633.git.mhagger@alum.mit.edu>
Cc:     git@vger.kernel.org
From:   Marc Branchaud <marcnarc@xiplink.com>
Message-ID: <19aa8a8f-6f5e-ac90-277c-94d2b0caaa9a@xiplink.com>
Date:   Mon, 6 Feb 2017 12:13:19 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.0
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

I don't see this series in git v2.12.0-rc0, nor in Paul's gitk repo.

I hope this is an oversight, and not that the series got dropped for 
some reason.

		M.



> * Omit the "remote/" prefix on normal remote-tracking references. They
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
>
> * Introduce a separate constant to specify the background color used
>   for the branch name part of remote-tracking references, to allow it
>   to differ from the color used for local branches (which by default
>   is bright green).
>
> * Change the default background colors for remote-tracking branches to
>   light brown and brown (formerly they were pale orange and bright
>   green).
>
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
