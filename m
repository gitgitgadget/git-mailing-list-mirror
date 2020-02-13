Return-Path: <SRS0=eUpu=4B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10FBDC2BA83
	for <git@archiver.kernel.org>; Thu, 13 Feb 2020 14:46:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E32AC24649
	for <git@archiver.kernel.org>; Thu, 13 Feb 2020 14:46:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727655AbgBMOqb convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Thu, 13 Feb 2020 09:46:31 -0500
Received: from elephants.elehost.com ([216.66.27.132]:17356 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726282AbgBMOqb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Feb 2020 09:46:31 -0500
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.179.249])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id 01DEkSsT039938
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 13 Feb 2020 09:46:28 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "=?utf-8?Q?'Martin_Vejn=C3=A1r'?=" <vejnar.martin@gmail.com>,
        <git@vger.kernel.org>
References: <CAJFfRmt65DV5bZa5yTvg9sDb8SS8dFFyX7Zm23T7mAHL58v1Lw@mail.gmail.com>
In-Reply-To: <CAJFfRmt65DV5bZa5yTvg9sDb8SS8dFFyX7Zm23T7mAHL58v1Lw@mail.gmail.com>
Subject: RE: Calculating major.minor.patch from commit hash
Date:   Thu, 13 Feb 2020 09:46:22 -0500
Message-ID: <014f01d5e27c$5f5166d0$1df43470$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQJcNzEZq2VWhalgG1JF9nG67zoN26cMiZvQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On February 13, 2020 9:41 AM, Martin Vejnár wrote:
> To: git@vger.kernel.org
> Subject: Calculating major.minor.patch from commit hash
> 
> I'd like my releases to have major.minor.patch version number. While
> increments of major.minor are something one has to do manually, I don't
> want to do that for patch.
> 
> So I was thinking of having a VERSION file in the repo containing major.minor
> and then calculate patch at the given commit C automatically as the length
> of the longest path starting at C in the subgraph containing only commits in
> which VERSION is the same as C's.
> 
> I can do that pretty easily right now by
> 
> * identifying commits in which VERSION changes with `git log -- VERSION`
> and then
> * walking the graph in topo order with `git log --format=format:"%H %P"`.
> 
> The latter step can terminate early, so it doesn't have to walk the entire
> repo, but the latter walks everything and can be quite slow.
> 
> Is there a more efficient way to do this?
> 
> If not, would there be an interest in a new builtin (git-depth?) that would
> calculate the value?

You should consider using annotated tags and the git describe command to derive your release number. We do this for all of our products and it works very well. For example:

$ git tag -a 1.6.4 commit-hash

Then, when building your release:

$ git describe --long --first-parent

Good luck,
Randall

-- Brief whoami:
 NonStop developer since approximately 211288444200000000
 UNIX developer since approximately 421664400
-- In my real life, I talk too much.



