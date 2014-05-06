From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Apr 2014, #09; Tue, 29)
Date: Tue, 06 May 2014 10:59:16 -0700
Message-ID: <xmqqeh06g557.fsf@gitster.dls.corp.google.com>
References: <xmqq7g67iwxc.fsf@gitster.dls.corp.google.com>
	<20140505184546.GB23935@serenity.lan>
	<5367e1ac39571_5977e7531081@nysa.notmuch>
	<20140505195525.GC23935@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Tue May 06 22:10:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WhjeK-00061A-JB
	for gcvg-git-2@plane.gmane.org; Tue, 06 May 2014 19:59:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753428AbaEFR7X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 May 2014 13:59:23 -0400
Received: from smtp.pobox.com ([208.72.237.35]:55751 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751981AbaEFR7V (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 May 2014 13:59:21 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 897821309E;
	Tue,  6 May 2014 13:59:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=S0o8Y1SN6vy9b7F58Lt6Y6/HxK4=; b=F/9QE8
	Cvg5e3PoF2LbOqqs/Lq0QXyu4iFRuhV1X616MWidcc3ScDkcHKxGVndPbiIbIrEM
	zNtwxLQzCtjOV6RbcWqhSH0CEEV0PE8UXUP0BdI22tfTS0u7S3pSwaQ2RpNjSvf3
	C9xXT1DHXouoS2iJ437kVOMpobbHuyASr6mRo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=wwbpgAJfvZyJqxKwEwjLSBKyMBwVArRP
	0TpHRLaF2oFcHxFoGSi/VRf2v3XbuQ42NTOCdq65JrpmlrocbTU1SUqls3e8fkLB
	ibxuovc/NPs4iXIz3yA3wF1QtpuXewHvbaLENrdAsmKqxUdscczzoDeBR7SMK85w
	jP+lI2mpsSM=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 7F0481309D;
	Tue,  6 May 2014 13:59:20 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 1204F1309A;
	Tue,  6 May 2014 13:59:18 -0400 (EDT)
In-Reply-To: <20140505195525.GC23935@serenity.lan> (John Keeping's message of
	"Mon, 5 May 2014 20:55:25 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 24ABD674-D548-11E3-B0F4-9CEB01674E00-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248233>

John Keeping <john@keeping.me.uk> writes:

> And it is now probably too late for that to make Git 2.0,...

Anything with end-user visible changes in the core part that is not
a fix to a regression introduced between v1.9.0..master is too late
for the upcoming release.  We are way past -rc1.

>> So I think these are the two options:
>> 
>>   1) Include git-remote-hg/bzr to the core and distribute them by
>>      default (as is the current intention)
>> 
>>   2) Remove git-remote-hg/bzr entirely from the Git tree. And do the
>>      same for other tools: git-p4, git-svn, git-cvs*. Given the huge
>>      amount of people using Subversion, we might want to defer that one
>>      for later, but eventually do it.

Isn't there a middle ground?  The option 1.5 may be like this:

 - Eject tools in contrib/ that would benefit the users better if
   they were outside my tree.  There are a few points to consider
   when judging "benefit better if outside":

   * Their release cycle requirements are better met outside my tree
     (the "remote-hg depends not just on Git but Hg internal" issue
     we have discussed).

   * They are actively maintained.  The overall Git maintainer would
     merely be being a bottleneck than being a helpful editor with
     respect to these tools if we keep them in my tree, and we
     expect that the tool maintainer would do a much better job
     without me.

 - Keep tools that are not actively maintained but still used by the
   users widely in my tree, but when their external dependencies
   become baggage to Git as a whole, demote them to contrib/ and
   stop installing them by default.

 - I would not mind having install.contrib-frotz target in the
   top-level Makefile for each of the remaining contrib/frotz
   hierarchies for those users and distro packagers who know their
   platform meets the dependency requirements.

> I'm not sure it needs to
> wait for a major Git release since most of the impact is on package
> maintainers and not end users.

Removal of features is a big deal, I would think, though.
