From: Neil Horman <nhorman@tuxdriver.com>
Subject: Re: [PATCH v8 4/4] git-rebase: add keep_empty flag
Date: Wed, 18 Jul 2012 08:17:58 -0400
Message-ID: <20120718121758.GA25563@hmsreliant.think-freely.org>
References: <1333136922-12872-1-git-send-email-nhorman@tuxdriver.com>
 <1334932577-31232-1-git-send-email-nhorman@tuxdriver.com>
 <1334932577-31232-5-git-send-email-nhorman@tuxdriver.com>
 <CAOeW2eEchYzRYYUBySKg5xYY3vBDy8GVcAd=ay-HoAGDLZtORw@mail.gmail.com>
 <5006614E.8090601@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	git@vger.kernel.org,
	Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,
	Clemens Buchacher <drizzd@aon.at>,
	Phil Hord <phil.hord@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Jul 18 14:18:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SrTCz-0004Dg-G1
	for gcvg-git-2@plane.gmane.org; Wed, 18 Jul 2012 14:18:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752577Ab2GRMSU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Jul 2012 08:18:20 -0400
Received: from charlotte.tuxdriver.com ([70.61.120.58]:50041 "EHLO
	smtp.tuxdriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751871Ab2GRMST (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jul 2012 08:18:19 -0400
Received: from hmsreliant.think-freely.org ([2001:470:8:a08:7aac:c0ff:fec2:933b] helo=localhost)
	by smtp.tuxdriver.com with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.63)
	(envelope-from <nhorman@tuxdriver.com>)
	id 1SrTCZ-0002fW-NN; Wed, 18 Jul 2012 08:18:06 -0400
Content-Disposition: inline
In-Reply-To: <5006614E.8090601@viscovery.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Score: -2.9 (--)
X-Spam-Status: No
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201681>

On Wed, Jul 18, 2012 at 09:10:06AM +0200, Johannes Sixt wrote:
> Am 7/18/2012 8:20, schrieb Martin von Zweigbergk:
> > On Fri, Apr 20, 2012 at 7:36 AM, Neil Horman <nhorman@tuxdriver.com> wrote:
> >>  pick_one () {
> >>         ff=--ff
> >> +
> >>         case "$1" in -n) sha1=$2; ff= ;; *) sha1=$1 ;; esac
> >>         case "$force_rebase" in '') ;; ?*) ff= ;; esac
> >>         output git rev-parse --verify $sha1 || die "Invalid commit name: $sha1"
> >> +
> >> +       if is_empty_commit "$sha1"
> >> +       then
> >> +               empty_args="--allow-empty"
> >> +       fi
> >> +
> >>         test -d "$rewritten" &&
> >>                 pick_one_preserving_merges "$@" && return
> >> -       output git cherry-pick $ff "$@"
> >> +       output git cherry-pick $empty_args $ff "$@"
> > 
> > The is_empty_commit check seems to mean that if $sha1 is an "empty"
> > commit, we pass the --allow-empty option to cherry-pick. If it's not
> > empty, we don't. The word "allow" in "allow-empty" suggests that even
> > if the commit is not empty, cherry-pick would not mind. So, can we
> > always pass "allow-empty" to cherry-pick (i.e. even if the commit to
> > pick is not empty)?
> 
> I don't think so. If the commit is not empty, but all its changes are
> already in HEAD, then it will become "empty" when cherry-picked to HEAD.
> In such a case, we usually do not want to record an empty commit, but stop
> rebase to give to user a chance to deal with the situation.
> 
> -- Hannes
> 

Yes, this is the meaning.  "Allow" was used in the sense of a filter, in that we
are allowing an empty commit to make it into the history, whereas a rebase or
cherry-pick would normally exclude it.
Neil
