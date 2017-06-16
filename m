Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9474120401
	for <e@80x24.org>; Fri, 16 Jun 2017 01:00:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751845AbdFPBAj (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Jun 2017 21:00:39 -0400
Received: from resqmta-po-11v.sys.comcast.net ([96.114.154.170]:38762 "EHLO
        resqmta-po-11v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751761AbdFPBAi (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 15 Jun 2017 21:00:38 -0400
X-Greylist: delayed 488 seconds by postgrey-1.27 at vger.kernel.org; Thu, 15 Jun 2017 21:00:38 EDT
Received: from resomta-po-15v.sys.comcast.net ([96.114.154.239])
        by resqmta-po-11v.sys.comcast.net with SMTP
        id LfUjd73w0dLOFLfUzdkFYa; Fri, 16 Jun 2017 00:52:29 +0000
Received: from vm-fedora21.eagercon.com ([IPv6:2601:647:4d04:5190:20c:29ff:fe70:d3be])
        by resomta-po-15v.sys.comcast.net with SMTP
        id LfUyd9yF9HYoLLfUzdL671; Fri, 16 Jun 2017 00:52:29 +0000
To:     git@vger.kernel.org
From:   Michael Eager <eager@eagerm.com>
Subject: Best practices for updating old repos
Message-ID: <59432BCC.2040901@eagerm.com>
Date:   Thu, 15 Jun 2017 17:52:28 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.1.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfMxrU54piaqjPbbGkhXVOLaVLo5GMYot2x6G7IJ+SCQVxnr9O80TQmhLu+TqQOl2duIR5bwW3Cw1/5DOhR80s6HKc+icRd7ac/+xkDjS8llp47XHfDCa
 11QBMYJcZ12Z5DjNKpc7Q8BQOsDXwIywvvClkLNBkQl3wLrMPO7jeBob
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi All --

I'm working with code that is based on a five year old repository.
There are 130 local commits since the repo was forked.  Naturally,
the upstream project has moved on significantly.

I'm wondering about best approaches to updating the repo to the
current upstream version.  Here are the approaches I've considered:

- Rebase from upstream.  Likely almost every patch will fail with
   multiple merge conflicts.

- Merge local branch into upstream.  Likely many merge failures, but
   fewer than with rebase.

- Apply individual patches from the old repo to the upstream repo.
   Fix merge conflicts, rebuild, fix build failures.  There may be
   some duplication and additional merge problems created, where a
   later patch from the old repo fixes the same conflict or build
   failure.

I've tried each of these approaches on various projects.  Each has
problems. After resolving merge issues there are build failures which
need to be resolved and additional patches created.  The result is
that the patch history is a bit chaotic, where there are later patches
which fix problems with early patches.  I've tried to sort the fix
patches to follow the patch they correct, so that the fixes were
together and I could merge them, but that can be difficult.

I've used Stacked Git a little, but don't know if it will make
any of this easier.

On some projects, I've reimplemented changes in the upstream repo,
abandoning the patch history from the old repo:

- Create diff of old repo and upstream.  Apply only the changes
   to add new functionality, which are in the patches to the
   old repo.   Fix problems caused by API changes, renamed files, etc.

- Re-implement the changes on the upstream repo.  Some of the old
   code would be re-used, but modified to fit in the current upstream.
   Some new code would be written.

One other variant of the rebase approach I've thought of is to do
this incrementally, rebasing the old repo against an upstream commit
a short time after the old repo was forked, fixing any conflicts,
rebuilding and fixing build failures.  Then repeat, with a bit
newer commit.  Then repeat, until I get to the top.  This sounds
tedious, but some of it can be automated.  It also might result in
my making the changes compatible with upstream code which was later
abandoned or significantly changed.

Anyone have a different approach that I should consider?  Or maybe
offer advice on how to make one of these approaches work better?
What is best practice to update an old repo?

-- 
Michael Eager	 eager@eagercon.com
1960 Park Blvd., Palo Alto, CA 94306  650-325-8077
