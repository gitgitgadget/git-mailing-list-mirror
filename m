From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] cvsimport: rewrite to use cvsps 3.x to fix major bugs
Date: Sun, 13 Jan 2013 15:27:24 -0800
Message-ID: <7v38y4hder.fsf@alter.siamese.dyndns.org>
References: <1357875152-19899-1-git-send-email-gitster@pobox.com>
 <50F17DB0.2050802@alum.mit.edu> <20130112182649.GC4624@elie.Belkin>
 <7v8v7wiv3a.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	"Eric S. Raymond" <esr@thyrsus.com>, git@vger.kernel.org,
	Chris Rorvick <chris@rorvick.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 14 00:27:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TuWxw-0002pQ-54
	for gcvg-git-2@plane.gmane.org; Mon, 14 Jan 2013 00:27:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756195Ab3AMX12 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Jan 2013 18:27:28 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39444 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754615Ab3AMX11 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Jan 2013 18:27:27 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C9CECB27E;
	Sun, 13 Jan 2013 18:27:26 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=WcNbLQGjsW7nMjSR7d8DeUZth18=; b=OCFsXw
	/ml5OyafghzxGPrpjUPQ3DCYJ64536rJiHDJqCR3YIQlb3UmSBRqDKfkCh0i2YkP
	GKSwQVmWruzzvxgY5wvR/WPJeOkhldlbU1L3qvnrlxmwzjaVdDjM7C8Jbi8EOtYK
	wSH2at9Qwj/2v9elJFH2Fku/PsedNpPFiKcm0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=dW0y9eS5MJl3fTD2j7J42YrAXy4lg1gz
	X5zh/ijqsW3ajRKmdlOWiSR7EidKDEP/BD2sRL2Z45w2oLjlmOZ0b9cB+ZxsYjdb
	foO0HIY0an0mY4AkmpW1z1XvsYn6t1FFGB3vS96RRIqRbofSxjtq28bPlCXflGB4
	dXpsIzB3yCo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BD8DAB27D;
	Sun, 13 Jan 2013 18:27:26 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 02DDCB27B; Sun, 13 Jan 2013
 18:27:25 -0500 (EST)
In-Reply-To: <7v8v7wiv3a.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Sun, 13 Jan 2013 14:20:09 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: CA2400F6-5DD8-11E2-8B17-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213410>

Junio C Hamano <gitster@pobox.com> writes:

> Jonathan Nieder <jrnieder@gmail.com> writes:
>
>> Michael Haggerty wrote:
>>
>>> Regarding your claim that "within a few months the Perl git-cvsimport is
>>> going to cease even pretending to work": It might be that the old
>>> git-cvsimport will stop working *for people who upgrade to cvsps 3.x*.
>>> But it is not realistic to expect people to synchronize their git and
>>> cvsps version upgrades.  It is even quite possible that this or that
>>> Linux distribution will package incompatible versions of the two packages.
>>
>> Moreover, I feel an obligation to point the following out:
>>
>> In a hypothetical world where cvsps 3.x simply breaks "git cvsimport"
>> it is likely that some distributions would just stick to the existing
>> cvsps and not upgrade to 3.x.  Maybe that's a wrong choice, but that's
>> a choice some would make.  An even more likely outcome in that
>> hypothetical world is that they would ship it renamed to something
>> like "cvsps3" alongside the existing cvsps.  Or they could rename the
>> old version to "cvsps2".  If we were the last holdout, we could even
>> bundle it as compat/cvsps.
>>
>> So please do not act as though the cvsps upgrade is a crisis that we
>> need to break ourselves for at threat of no longer working at all.
>> The threat doesn't hold water.
>>
>> Luckily you have already written patches to make "git cvsimport" work
>> with cvsps 3.x, and through your work you are making a better
>> argument: "The new cvsimport + cvsps will work better, at least for
>> some users, than the old tool."
>>
>> Just don't pretend you have the power to force a change for a less
>> sensible reason than that!
>
> After a quick survey of various distros, I think it is very unlikely
> that we will see "distros move on to newer cvsps, leaving cvsimport
> broken" situation. If anything, it is more like "distros decide to
> ignore the new cvsps, until it is made to work with cvsimport" [*1*].
>
> I think it is probably sensible to rename the current cvsimport to
> cvsimport-2, write a small wrapper git-cvsimport.sh which is
> something like this:
>
> ----- >8 -----
> #!/bin/sh
>
> if test -z "$GIT_CVSPS_VERSION"
> then
> 	case "$(cvsps -h 2>&1 | grep 'cvsps version')" in
>         2.*)
> 		GIT_CVSPS_VERSION=2
>                 ;;
> 	3.*)
> 		GIT_CVSPS_VERSION=3
>                 ;;
> 	esac
> fi
>
> if test -z "$GIT_CVSPS_VERSION" 
> then
> 	echo >&2 "No supported cvsps available"
> 	exit 1
> fi
>
> exec git cvsimport-$GIT_CVSPS_VERSION "$@"
> ----- 8< -----
>
> and put Eric's one as git-cvsimport-3 (after ripping out the code to
> fallback to the old cvsimport).  The longer term trend will be to
> move away from cvsimport-2, as it is unlikely cvsps-2.x will gain
> improvements, if any; keeping fallback code outside cvsimport-3 will
> be a better first step in the healthier long term code evolution.
>
> We will keep the current t96xx series of tests, and have them export
> GIT_CVSPS_VERSION=2 at the beginning, protect them with test prereq
> that requires presence of cvsps 2.x; this will still make sure that
> the current cvsimport users will not see any regressions.
>
> Eric's one should be polished enough to produce good results on the

s/should be polished enough/should be in a polished enough state/
that is.  Also "if not right now" may better convey what I meant if
written "if not already".

> simpler sample CVS histories t96xx deal with soonish if not right
> now, so we can use a method similar to how we shared tests between
> blame and annotate while both were _different_ implementations to
> make sure the newer blame did not inroduce regression by running the
> same set of tests.  Where the result _ought_ to differ, we should
> also add tests that work only with the new cvsimport, of course.
>
> I could help getting the ball rolling on this, if everybody agrees
> that the above is a sensible direction to go, given the real world
> constraints of distro inertia.
>
> Agreed?
>
>
> [References]
>
> *1* Fedora, Debian and Ubuntu do not even have cvsps 3.x in their
> bleeding edges, OpenBSD and NetBSD do not seem to have it either,
> and Gentoo and ArchLinux have the cvsps 3.x blocked due to
> incompatiblity.
>
> http://pkgs.fedoraproject.org/cgit/cvsps.git/
> http://packages.debian.org/search?keywords=cvsps
> http://packages.ubuntu.com/search?keywords=cvsps
>
> http://packages.gentoo.org/package/dev-vcs/cvsps
> https://bugs.gentoo.org/show_bug.cgi?id=450424
>
> https://bugs.archlinux.org/task/33363?project=1&cat%5B0%5D=2&string=cvsps
