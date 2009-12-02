From: Junio C Hamano <gitster@pobox.com>
Subject: Re: multiple working directories for long-running builds
Date: Tue, 01 Dec 2009 18:09:38 -0800
Message-ID: <7viqcqp1nh.fsf@alter.siamese.dyndns.org>
References: <m1NEaLp-000kn1C@most.weird.com>
 <7vskbxewti.fsf@alter.siamese.dyndns.org> <m1NFBAx-000kmgC@most.weird.com>
 <20091130211744.GA27278@dpotapov.dyndns.org> <m1NFGXS-000kn2C@most.weird.com>
 <20091201054734.GB11235@dpotapov.dyndns.org> <m1NFX19-000kn4C@most.weird.com>
 <20091201185114.GC11235@dpotapov.dyndns.org> <m1NFXvL-000kn2C@most.weird.com>
 <20091201211830.GE11235@dpotapov.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: The Git Mailing List <git@vger.kernel.org>
To: Dmitry Potapov <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 02 03:09:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NFef9-0005P5-BH
	for gcvg-git-2@lo.gmane.org; Wed, 02 Dec 2009 03:09:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754368AbZLBCJk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Dec 2009 21:09:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754283AbZLBCJk
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Dec 2009 21:09:40 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:40520 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753731AbZLBCJj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Dec 2009 21:09:39 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 660D3A3F85;
	Tue,  1 Dec 2009 21:09:45 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=CP25uNrB4Y2dJ1ZNKmvbtV8Nikw=; b=v/9ax/vf8K0HATTnKqvNSbX
	EKArQkXeB59gMoJViX1UYzDE2yVZPEJrzaehvGtFcDsy4cEdilTj/LwRPkPgpVcf
	6OrT21dhxJETXcI7rVDEAeKfT2g+3mc6Gt+NuaPEC0E1/K3fJPxYlcPUthATrDBq
	3n/F3fLzS/Zlk1MxD8eg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=UPlrsTmVzJ7gbHmFqedUsQRJVA6+nQMG23vzRi1caDZqs/dG3
	bY4vO9QlMu6AhKz+/qJnKxfethtH9d9HQd5+pmET5epsGIG1GZiO1g5RocGXnj72
	1NH4Ww1pBZcJW5+FAKTwkIoQ6ofjDGrC5FScJgH/ms6IQa3cqPSzqXK6tM=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 3F9F8A3F84;
	Tue,  1 Dec 2009 21:09:43 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id CDF4FA3F83; Tue,  1 Dec 2009
 21:09:39 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: C15D5ADA-DEE7-11DE-A448-EF34BBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134281>

Dmitry Potapov <dpotapov@gmail.com> writes:

> On Tue, Dec 01, 2009 at 01:58:05PM -0500, Greg A. Woods wrote:
>> 
>> > > I just disagreed that "git archive" was a reasonable alternative to
>> > > leaving the working directory alone during the entire time of the build.
>> > 
>> > Using "git archive" allows you avoid running long time procedure such as
>> > full clean build and testing in the working tree. Also, it is guaranteed
>> > that you test exactly what you put in Git and some other garbage in your
>> > working tree does not affect the result.
>> 
>> Sure, but let's be very clear here:  "git archive" is likely even more
>> impossible for some large projects to use than "git clone" would be to
>> use to create build directories.
>
> AFAIK, "git archive" is cheaper than git clone. I do not say it is fast
> for huge project, but if you want to run a process such as clean build
> and test that takes a long time anyway, it does not add much to the
> total time.

I do not understand people who advocate for "git archive" to be used in
this manner at all.

I do use a set of separate build directories, and I typically run 5 to 10
full builds (in each) per day, but I rarely if ever make fix in them.
Perhaps the usage pattern expected by people who want others to use "git
archive" to prepare separate build directories may be different from how I
use them for.

I see two downsides in using "git archive":

 - "archive" piped to "tar xf -" will overwrite _all_ files every time you
   refresh the build area, causing extra work on "make" and any build
   procedure based on file timestamps.  Sure, you can work it around by
   using ccache but why make your life complicated?

 - When a build in these separate build areas fails, you would want to go
   there and try to diagnose or even fix the problem in there, not in your
   primary working area (after all, the whole point of keeping a separate
   build area is so that you do not have to switch branches too much in
   the primary working area).  A directory structure prepared by "archive"
   piped to "tar xf -" however is not a work tree, and any experimental
   changes (e.g. "debugf()") or fixes you make there need to be reverted
   or taken back manually to be placed in the primary working area.

If your build area is prepared with new-workdir, then you share the
history and you even share the ref namespace, so that "reset --hard" will
remove all the debugf() added while diagnosing, and "diff" will give you
the patch you need to take home.

You could even make a commit from your build area, but this cuts both
ways.  You need to be aware that after committing on a branch in one
repository other repositories that have the same branch checked out will
become out of sync.  It is however less of an issue in practice, because
the build areas are typically used to check out integration branches
(e.g. 'master' and 'next' in git.git) that you do not directly commit
anyway, and you will get very aware of the tentative nature of the tree,
as the update procedure for such a build area prepared with new-workdir is
always:

    cd /buildfarm/<branch>/ && git reset --hard

This will not touch any file that do not have to get updated, so your
"make" won't get confused.
