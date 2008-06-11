From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: [PATCH 2/2] git-gc: skip stashes when expiring reflogs
Date: Wed, 11 Jun 2008 18:25:23 -0500
Message-ID: <co7kgJpJNdIs2f8n_PwYKAS7MwV9t1G_P3BPr1eXTZ4ytUHcsPvVaw@cipher.nrlssc.navy.mil>
References: <OLvkESB0JjBNs9kF8Q2M5UFNBJqq4FjbgGeQVyWstGwcXqCOq16_oomM0y-utOBbV7BnndyrICE@cipher.nrlssc.navy.mil> <5vuJsx6Kidj7e8EABk_d63dLAYuWF-S880RrJKu83cJo_ejU3VN-VA@cipher.nrlssc.navy.mil> <20080611213648.GA13362@glandium.org> <alpine.DEB.1.00.0806112242370.1783@racer> <20080611230344.GD19474@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Mike Hommey <mh@glandium.org>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jun 12 01:27:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K6Zib-0006UC-HB
	for gcvg-git-2@gmane.org; Thu, 12 Jun 2008 01:27:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755154AbYFKX0L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Jun 2008 19:26:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754649AbYFKX0K
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Jun 2008 19:26:10 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:58004 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754978AbYFKX0J (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jun 2008 19:26:09 -0400
Received: by mail.nrlssc.navy.mil id m5BNPOow028795; Wed, 11 Jun 2008 18:25:24 -0500
In-Reply-To: <20080611230344.GD19474@sigill.intra.peff.net>
X-OriginalArrivalTime: 11 Jun 2008 23:25:23.0991 (UTC) FILETIME=[6C662A70:01C8CC1A]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84684>

Jeff King wrote:
> On Wed, Jun 11, 2008 at 10:44:17PM +0100, Johannes Schindelin wrote:
> 
>> FWIW I thought it was one of the clever designs of git-stash that it 
>> automatically expires together with the other reflogs.  A stash is only a 
>> temporary thing, that is not even meant to leave the local repository, 
>> after all.
> 
> I agree. If you are concerned about valuable stashes getting deleted, my
> guess is one of:
> 
>   - you would like reflog expiration to be longer
> 
>   - you are using stash as a long-term storage, which it was never
>     intended for. Use a branch.
> 
> The latter, of course, is based on my use and my impression of others
> use (I almost always apply a stash within 30 seconds of having stashed
> it). So maybe everyone is keeping stashes around for months, and this is
> a useful change.

Yes, I think usually stashes are used for very short term storage. At the
same time, I don't expect a stash (however old) to disappear without me
explicitly deleting it.

In particular, I don't want to experience this:

$ git stash list
stash@{0}: WIP on master: 8c372fb... git-cvsimport: do not fail when CVS is /
$ git pull
$ git stash apply
fatal: Needed a single revision
: no valid stashed state found

This would not _surprise_ me since I understand how stashes are implemented
_and_ that git-pull could cause git-gc to run which runs 'git-reflog expire'
which may remove entries from the stash reflog, but it is probably not
expected by most users and it would still irritate me if it did happen.

-brandon
