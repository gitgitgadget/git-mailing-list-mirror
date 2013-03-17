From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] Introduce remote.pushdefault
Date: Sat, 16 Mar 2013 23:10:38 -0700
Message-ID: <7vobeisgip.fsf@alter.siamese.dyndns.org>
References: <7v1ucr43mk.fsf@alter.siamese.dyndns.org>
 <1360314123-1259-1-git-send-email-artagnon@gmail.com>
 <7v4nhm1s85.fsf@alter.siamese.dyndns.org>
 <CALkWK0m2N=D47WJLk1F4j1GsGGWHyfxVF_WGXBbG3vyrfQ-oLA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 17 07:11:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UH6oO-0002NY-SH
	for gcvg-git-2@plane.gmane.org; Sun, 17 Mar 2013 07:11:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751521Ab3CQGKl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Mar 2013 02:10:41 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60823 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750896Ab3CQGKl (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Mar 2013 02:10:41 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 54252A4CC;
	Sun, 17 Mar 2013 02:10:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=a2N+MSIf1MbSs/HSfWwhlYZNY3o=; b=VTlvnz
	CGooopFbwXCrTTre0a6kjfbszcZYL7FFjBaMk1vTinjPXNQHMm+0JW7IXE3l7rTZ
	Q6xSjdm8XlAru+Y/HIdgeqlPbsSDHCUR0/dIf7PWr4qg6fv9H/d4AHfIpEQ5CMVe
	ayCt73QuXPu/rJgw71eGT8f7fMA2xscTm2gQk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Ug5PCAUHuv7qC6UVZMPJNFaJik3EhMHv
	61tK54f31S2qRf7FGymNtsPLmcv1Dy8z7FgCeDS74vhlwhn4hCtVESYtzJVIQ+sW
	evuhVIDThKP9dxSSPCugRuHueaPpdbqZKeW9xS6XgEooWwTc9KCmdsLeFIrVU/0x
	AZZxKIee+To=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 49704A4CB;
	Sun, 17 Mar 2013 02:10:40 -0400 (EDT)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B1A67A4C8; Sun, 17 Mar 2013
 02:10:39 -0400 (EDT)
In-Reply-To: <CALkWK0m2N=D47WJLk1F4j1GsGGWHyfxVF_WGXBbG3vyrfQ-oLA@mail.gmail.com>
 (Ramkumar Ramachandra's message of "Sun, 17 Mar 2013 06:00:08 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6454B140-8EC9-11E2-BB0F-4AAA2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218339>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> How will adding remote.pushdefault have any
> impact, unless I explicitly remove this branch-specific remote
> configuration?  Besides, without branch.<name>.remote configured, I
> can't even pull and expect changes to be merged.

If the triangle topology is the norm for your project, I would
expect that it would be pretty common to have all of your branches
pull from one place and have all of them push to another place.  In
the central repository workflow, it is very common that all of your
branches pull from one place and all of them push to the same place.

In the bigger picture, forcing to set the branch specific remote is
a mistake in the first place; in the longer term, you should be able
to say "My project uses the central repository workflow" once and
you should be able to pull without branch.master.remote; just record
where the default "origin" for all branches is.

I think the per-branch branch.*.pushremote is actively making things
worse by repeating the same mistake for the triangle topology.  You
should be able to say "My project uses the triangle workflow" once
and specify two remotes, where you pull from and where you push to,
no?

A per-branch override, be it branch.*.remote or brnach.*.pushremote,
is useful to give an escape hatch in order to handle special cases
with additional flexibility.  But making it the sole mechanism and
forcing the user to repeat the same "which remote does it use" all
over the place does not sound like a solid engineering.
