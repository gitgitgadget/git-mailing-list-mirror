From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: Command-line interface thoughts
Date: Thu, 09 Jun 2011 20:03:06 +0200
Message-ID: <4DF10ADA.5070206@alum.mit.edu>
References: <BANLkTikTWx7A64vN+hVZgL7cuiZ16Eobgg@mail.gmail.com> <m339jps1wt.fsf@localhost.localdomain> <BANLkTinidLbQ_FcVEiGSK91uXYWaKk7MKA@mail.gmail.com> <201106051311.00951.jnareb@gmail.com> <BANLkTik+xhd5QQ09QiPSH1bFAndzipKtrw@mail.gmail.com> <7vwrgza3i2.fsf@alter.siamese.dyndns.org> <4DF08D30.7070603@alum.mit.edu> <20110609161832.GB25885@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Scott Chacon <schacon@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>,
	Michael Nahas <mike@nahas.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jun 09 20:03:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUjZn-0008BH-Va
	for gcvg-git-2@lo.gmane.org; Thu, 09 Jun 2011 20:03:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752168Ab1FISDX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jun 2011 14:03:23 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:59220 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751353Ab1FISDW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jun 2011 14:03:22 -0400
X-Envelope-From: mhagger@alum.mit.edu
Received: from [192.168.100.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id p59I36Hm004829
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 9 Jun 2011 20:03:06 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.17) Gecko/20110424 Lightning/1.0b2 Thunderbird/3.1.10
In-Reply-To: <20110609161832.GB25885@sigill.intra.peff.net>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175563>

On 06/09/2011 06:18 PM, Jeff King wrote:
> On Thu, Jun 09, 2011 at 11:06:56AM +0200, Michael Haggerty wrote:
> 
>> My naive understanding is that in the case of a merge commit, the index
>> contains information equivalent to *multiple* trees:
>>
>> NEXT -- HEAD plus the files that have been resolved
>> BASE -- the contents of the common ancestor
>> OURS -- equivalent to the tree from HEAD
>> THEIRS -- equivalent to the tree from MERGE_HEAD
> 
> Almost. Remember that as part of the merge resolution process,
> higher-level stages will collapse down to 0. So the "theirs" stage of
> the index is equivalent to MERGE_HEAD only if you have a conflict in
> every file and have resolved nothing. Otherwise, any resolved entries
> will not have a "theirs" entry at all.

Thanks for the correction.  So one interesting pseudo-tree would be

OURS -- The NEXT version of any file that has been resolved; and the
stage 2 version of any file that has not yet been resolved.  The name
seems consistent with what is meant by, e.g., "git checkout --ours".

Another interesting pseudo-tree would be

THEIRS -- The NEXT version of any file that has been resolved; and the
stage 3 version of any file that has not yet been resolved.  The name
seems consistent with "git checkout --theirs".

The other trees HEAD and MERGE_HEAD are already accessible under those
names, and so there is no need to make a special provision to access them.

BASE should presumably be something like the NEXT version of any file
that has been resolved and the stage 1 version of any file that has not
been resolved.

> So the index is not quite simply a set of four trees. The presence of
> various stages for each entry tells us the progress of resolution.

Wouldn't the four trees described above contain information equivalent
to the contents of the index?  For example, the resolution work that
remains to be done that can be inquired using old-fashioned "git diff"
(3-way diff) could also be accessed via

    git diff NEXT OURS
    git diff NEXT THEIRS

or even

    git diff NEXT WTREE

if you want to see the remaining conflicts in <<<<<======>>>>>> format.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
