From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] clone: introduce clone.submoduleGitDir to relocate $GITDIR
Date: Wed, 17 Apr 2013 10:18:03 -0700
Message-ID: <7vfvypf54k.fsf@alter.siamese.dyndns.org>
References: <1365881007-25731-1-git-send-email-artagnon@gmail.com>
	<CACsJy8D-5x5HXgpr2hHUHee6jcfj3++b961sJB_aKTZC1ZS+tw@mail.gmail.com>
	<CALkWK0kw69rMveDXpGEvV=fGxiQ7JoT_JE9ZU5cor0xD=BUbFQ@mail.gmail.com>
	<CACsJy8C9mrJzmg4FjqBMAZis7WQUpyhNH7TMTLbebWQE124YMg@mail.gmail.com>
	<CALkWK0nLamX1XKcg2t7VWJTPuFhX+ctEGE=4sjSSd7JqMmGzPA@mail.gmail.com>
	<CACsJy8DxspNbopJbSsvcCZZwMFees1JVV_iV5r7dXRJTngzmFA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 17 19:18:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1USW04-00029h-8q
	for gcvg-git-2@plane.gmane.org; Wed, 17 Apr 2013 19:18:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965861Ab3DQRSI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Apr 2013 13:18:08 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39010 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965456Ab3DQRSF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Apr 2013 13:18:05 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2475E17A37;
	Wed, 17 Apr 2013 17:18:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=lSk5uYplRBmxDCYPwrsfu1b2mA0=; b=XIN4VU
	6QKY/+fZk9WXqVZdPmLb/0nmxm9ZY45ocdfOuYZQppBQfJgodAKzjeOijRbjuKbB
	YVmShaHEUuNR6sjEPAgsixJCF94HS9vGK6AqqAWWtg9XJJqj6K2ArJolwE0fFG77
	wcTGXr/FNk4zjtwa3dvfuccR/KyGKNyvPYr2c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ta69+V22N5AOhCNeHphxFnWQQwImEgva
	XFdv7QN3C3lGd1FjeH4SFZrUDm3i+09YFdldLdBRxiDPaD4LmAJZ9uaIUnOMVmcE
	bdHR7KulRZ1z/2KqUHcHBnVCuXMDA5mdv90GqpCJ1sPauIigfHGitZlxtElBibKt
	54y+8sCKFTM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 18FC917A36;
	Wed, 17 Apr 2013 17:18:05 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7D86817A35;
	Wed, 17 Apr 2013 17:18:04 +0000 (UTC)
In-Reply-To: <CACsJy8DxspNbopJbSsvcCZZwMFees1JVV_iV5r7dXRJTngzmFA@mail.gmail.com>
	(Duy Nguyen's message of "Wed, 17 Apr 2013 21:36:35 +1000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C3B08746-A782-11E2-A1A0-BCFF4146488D-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221554>

Duy Nguyen <pclouds@gmail.com> writes:

> No, the point is people make mistakes. What do we do in that case? Or
> will you introduce yet another "gc" command for clean up ~/bare?

I do not know if it will be a "gc", but we would need a way for the
user to say "I no longer need the repository for this submodule kept
locally here (I may have to re-clone when I check out a version that
needs the submodule)" to free up the .git/modules/<name> directories
in the superproject.  We might want to allow "submodule deinit" to
also ask for it, but "deinit" will not be the only occasion the user
might want it.

It is already a problem that needs to be addressed in the current setup.
