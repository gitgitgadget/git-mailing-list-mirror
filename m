From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 9/9] fetch: allow explicit --refmap to override configuration
Date: Thu, 05 Jun 2014 11:36:56 -0700
Message-ID: <xmqqy4xbrynr.fsf@gitster.dls.corp.google.com>
References: <1401833792-2486-1-git-send-email-gitster@pobox.com>
	<1401833792-2486-10-git-send-email-gitster@pobox.com>
	<538F34E1.6010704@xiplink.com>
	<xmqqbnu8tim1.fsf@gitster.dls.corp.google.com>
	<539090AD.9040100@xiplink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Marc Branchaud <marcnarc@xiplink.com>
X-From: git-owner@vger.kernel.org Thu Jun 05 20:37:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WscXG-0003Y8-E3
	for gcvg-git-2@plane.gmane.org; Thu, 05 Jun 2014 20:37:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751619AbaFEShE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Jun 2014 14:37:04 -0400
Received: from smtp.pobox.com ([208.72.237.35]:65259 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750866AbaFEShC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jun 2014 14:37:02 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id B11621D17E;
	Thu,  5 Jun 2014 14:37:01 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=IssteLHTIkrIWuFlu5Bi8+9sNoE=; b=Dy3jUt
	TkWb3w2l+tPMoLftZKazrbRI4okLmPv0YW+9Ei6ZMxAuL3eR1NbZJ/Q2ynAtagKe
	oSn7rTcCUyqZ74hyYL5v1gd/JnaK+w3p5/0BBJjTclmdu5+A50xrTQcWfNL78AC+
	GYTI+k02I2rczPKE8C6Qw7ROPigPlgtGR7Zt4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=RyOSBzXf3cjYICPJClDhkp8/utl0d/kC
	I259GE+M5zwyCqmLm/WG0oA3HGEFPm424MHHsXfpDoId28zp3ACQms0PZlU1faZQ
	vRG/wCHfFXGdvYHag7WtdJPxZdbbeOYqzgdkflGejql1ceaSmS9+PHkfpRJo+yo5
	xx7eFZoSO8o=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 9B0091D17D;
	Thu,  5 Jun 2014 14:37:01 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id BDEB41D178;
	Thu,  5 Jun 2014 14:36:57 -0400 (EDT)
In-Reply-To: <539090AD.9040100@xiplink.com> (Marc Branchaud's message of "Thu,
	05 Jun 2014 11:45:49 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 5FF3F6B2-ECE0-11E3-AEE1-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250855>

Marc Branchaud <marcnarc@xiplink.com> writes:

> I don't have any objection to the option per se.  But I do wonder if there's
> a need to add yet another knob to git just for completeness.  Has anyone ever
> needed this?

It is not a good yardstick, as everybody has survived without it
since Git's inception.  The right question to ask is: would it help
new use patterns, or improve existing use patterns?

Two possible scenarios I can think of offhand are

 * using an empty refmap to ensure that your "fetch" this time is
   really ephemeral without affecting the longer-term configured
   remote-tracking branches

 * grabbing only a few selected branches out of hundreds, e.g.

   $ git fetch https://github.com/gitster/git \
       --refmap=refs/heads/*:refs/remotes/jch/* maint master next +pu

   instead of having to spell its long-hand

   $ git fetch https://github.com/gitster/git \
       refs/heads/maint:refs/remotes/jch/maint \
       refs/heads/master:refs/remotes/jch/master \
       refs/heads/next:refs/remotes/jch/next \
       +refs/heads/pu:refs/remotes/jch/pu

but there may be more useful scenarios other people can come up
with ;-).
