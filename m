From: Jonathan Nieder <jrnieder@uchicago.edu>
Subject: Re: [PATCH 3/3] git-add --intent-to-add (-N)
Date: Fri, 22 Aug 2008 01:38:02 -0500 (CDT)
Message-ID: <Pine.GSO.4.62.0808220119250.12851@harper.uchicago.edu>
References: <4b6f054f0808171702q10d89dfey98afa65634d26e91@mail.gmail.com>
 <alpine.LNX.1.00.0808181512160.19665@iabervon.org> <7vfxp2m5w8.fsf@gitster.siamese.dyndns.org>
 <alpine.LNX.1.00.0808181628420.19665@iabervon.org> <7viqtukbec.fsf@gitster.siamese.dyndns.org>
 <7v3akykb96.fsf_-_@gitster.siamese.dyndns.org>
 <Pine.GSO.4.62.0808211608020.26161@harper.uchicago.edu>
 <Pine.GSO.4.62.0808212304200.9108@harper.uchicago.edu>
 <alpine.LNX.1.00.0808220023170.19665@iabervon.org>
 <Pine.GSO.4.62.0808220015190.11259@harper.uchicago.edu>
 <7vtzddd1z5.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 22 08:39:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWQIk-0008Jd-MT
	for gcvg-git-2@gmane.org; Fri, 22 Aug 2008 08:39:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754277AbYHVGiJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Aug 2008 02:38:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754341AbYHVGiJ
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Aug 2008 02:38:09 -0400
Received: from smtp00.uchicago.edu ([128.135.12.76]:42309 "EHLO
	smtp00.uchicago.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754277AbYHVGiI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Aug 2008 02:38:08 -0400
Received: from harper.uchicago.edu (harper.uchicago.edu [128.135.12.7])
	by smtp00.uchicago.edu (8.13.8/8.13.8) with ESMTP id m7M6c5OK011912;
	Fri, 22 Aug 2008 01:38:05 -0500
Received: from localhost (jrnieder@localhost)
	by harper.uchicago.edu (8.12.10/8.12.10) with ESMTP id m7M6c30F013366;
	Fri, 22 Aug 2008 01:38:03 -0500 (CDT)
X-Authentication-Warning: harper.uchicago.edu: jrnieder owned process doing -bs
In-Reply-To: <7vtzddd1z5.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93261>

Hi,

Junio C Hamano wrote:

> Didn't I already tell you that you seem to have picked only one out of
> _three_ patch series?

I am using all three patches.  If you try ">a && git add -N a && git
commit" in an empty repo, you should get the same behavior (I checked
with commit 038a213^2, which is three commits ahead of master).  And
yes, I do understand where your suspicion came from.

But the reason for the behavior is that update_one in cache-tree.c
contains the test

	if (mode != S_IFGITLINK && !missing_ok && !has_sha1_file(sha1))

which fails for the empty blob in a new repo because, as I said, we
don't have that sha1 file.

I still wonder, do we want to pretend we have that object on disk
and proceed with the commit, or are the hardcoded objects only
supposed to be sufficient for in-core use?  If the former, I will
have to make some tests to be comfortable: are the objects properly
transfered to older clients without the hardcoded objects, etc.  But
I don't want to bother if that is not the intent.

Hoping that is clearer,
Jonathan
