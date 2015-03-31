From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: Allowing weak references to blobs and strong references to commits
Date: Tue, 31 Mar 2015 20:55:29 +0100
Organization: OPDS
Message-ID: <1E05987AFD4A4ABCB5515905B517C021@PhilipOakley>
References: <20150331100756.GA13377@glandium.org>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
To: "Mike Hommey" <mh@glandium.org>, <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Mar 31 21:58:07 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yd2IW-0000PS-NR
	for gcvg-git-2@plane.gmane.org; Tue, 31 Mar 2015 21:58:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753379AbbCaT56 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Mar 2015 15:57:58 -0400
Received: from out1.ip06ir2.opaltelecom.net ([62.24.128.242]:11804 "EHLO
	out1.ip06ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753714AbbCaTzk (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 31 Mar 2015 15:55:40 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: A2DGKABu+xpVPLG4BlxcgwZSXIcuvlWFaQQEgUdNAQEBAQEBBgEBAQE4IBtBAYNNBQEBAQECAQgBAS4eAQEmBgIDBQIBAw4HDCUUAQQaBgcDFAYBEggCAQIDAYgWDAm7P5JIHASLKYQvg2eBFgWKbYV1YoMQhyCGDYlJg0iEET0xgQOBQAEBAQ
X-IPAS-Result: A2DGKABu+xpVPLG4BlxcgwZSXIcuvlWFaQQEgUdNAQEBAQEBBgEBAQE4IBtBAYNNBQEBAQECAQgBAS4eAQEmBgIDBQIBAw4HDCUUAQQaBgcDFAYBEggCAQIDAYgWDAm7P5JIHASLKYQvg2eBFgWKbYV1YoMQhyCGDYlJg0iEET0xgQOBQAEBAQ
X-IronPort-AV: E=Sophos;i="5.11,503,1422921600"; 
   d="scan'208";a="674178381"
Received: from host-92-6-184-177.as43234.net (HELO PhilipOakley) ([92.6.184.177])
  by out1.ip06ir2.opaltelecom.net with ESMTP; 31 Mar 2015 20:55:28 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266550>

From: "Mike Hommey" <mh@glandium.org>
[...]

> So I thought, since commits are already allowed in tree objects, for
> submodules, why not add a bit to the mode that would tell git that
> those commit object references are meant to always be there aka strong
> reference, as opposed to the current weak references for submodules.
> I was thinking something like 0200000, which is above S_IFMT, but I
> haven't checked if mode is expected to be a short anywhere, maybe one 
> of
> the file permission flags could be abused instead (sticky bit?).
>
> I could see this used in the future to e.g. implement a fetchable 
> reflog
> (which could be a ref to a tree with strong references to commits).
>
> Then that got me thinking that the opposite would be useful to me as
> well: I'm currently storing mercurial manifests as git trees with
> (weak) commit references using the mercurial sha1s for files.
> Unfortunately, that doesn't allow to store the corresponding file
> permissions, so I'm going through hoops to get that. It would be 
> simpler
> for me if I could just declare files or symlinks with the right
> permissions and say 'the corresponding blob doesn't need to exist'.
> I'm sure other tools using git as storage would have a use for such
> weak references.
>
The "weak references" idea is something that's on my back list of 
Toh-Doh's for the purpose of having a Narrow clone.

However it's not that easy as you need to consider three areas - what's 
on disk (worktree/file system), what's in the index, and what's in the 
object store and how a coherent view is kept of all three without 
breakage.

The 'Sparse Checkout' / 'Skip Worktree' (see `git help read-tree`) 
covers the first two but not the third (which submodules does) [that's 
your 'the corresponding blob doesn't need to exist' aspect from my 
perspective]


> What do you think about this? Does that seem reasonable to have in git
> core, and if yes, how would you go about implementing it (same bit 
> with
> different meaning for blobs and commits (or would you rather that were
> only done for commits and not for blobs)? what should I be careful
> about, besides making sure gc and fsck don't mess up?)
>
> Cheers,
>
> Mike
>
> 1. a git-remote-hg tool, https://github.com/glandium/git-cinnabar/
> --
Philip 
