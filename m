From: Kevin Ballard <kevin@sb.org>
Subject: Re: [BUG] git rev-list --no-walk A B C sorts by commit date incorrectly
Date: Fri, 7 Jan 2011 19:12:20 -0800
Message-ID: <BB84A2F6-E6B0-49E4-9DC7-6BA8860623E6@sb.org>
References: <CEF26B82-4281-4B8F-A994-DE32EFB92BA7@sb.org> <7v62u043ba.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v1082)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 08 04:12:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PbPEE-0000Rf-4j
	for gcvg-git-2@lo.gmane.org; Sat, 08 Jan 2011 04:12:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752259Ab1AHDMX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Jan 2011 22:12:23 -0500
Received: from mail-pz0-f46.google.com ([209.85.210.46]:59685 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751682Ab1AHDMX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Jan 2011 22:12:23 -0500
Received: by pzk35 with SMTP id 35so2056497pzk.19
        for <git@vger.kernel.org>; Fri, 07 Jan 2011 19:12:22 -0800 (PST)
Received: by 10.142.193.8 with SMTP id q8mr432458wff.308.1294456342626;
        Fri, 07 Jan 2011 19:12:22 -0800 (PST)
Received: from [10.8.0.89] ([69.170.160.74])
        by mx.google.com with ESMTPS id w14sm3543067wfd.6.2011.01.07.19.12.21
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 07 Jan 2011 19:12:21 -0800 (PST)
In-Reply-To: <7v62u043ba.fsf@alter.siamese.dyndns.org>
X-Mailer: Apple Mail (2.1082)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164805>

On Jan 7, 2011, at 5:00 PM, Junio C Hamano wrote:

> Kevin Ballard <kevin@sb.org> writes:
> 
>> Is there any rationale for this behavior?
> 
> Not a rationale, but an explanation is that most of the time we walk the
> history and sorting by date is the first thing that needs to be done, and
> the --no-walk option was an afterthought that was tucked in.
> 
> I suspect that a three-liner patch to revision.c:prepare_revision_walk()
> would give you what you want.  Instead of calling insert-by-date, you
> append to the tail when revs->no_walk is given, or something.

It almost works, but not quite. My inclination is to say
`git rev-list --no-walk A B C` should emit A B C in that order. Implemented
this way, `git rev-list --no-walk ^HEAD~3 HEAD` emits commits in the wrong
order, and I can't figure out how to change that. If I implement
`git rev-list --no-walk A B C` to emit C B A instead, then the test for
`git cherry-pick --stdin` fails (t3508), and I don't know why.

-Kevin Ballard
