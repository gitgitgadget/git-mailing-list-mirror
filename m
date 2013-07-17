From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 00/19] Index-v5
Date: Wed, 17 Jul 2013 16:58:14 -0700
Message-ID: <7v7ggo68o9.fsf@alter.siamese.dyndns.org>
References: <1373650024-3001-1-git-send-email-t.gummerer@gmail.com>
	<CACsJy8AhmYBjzqPtF3f9Gk8hq2bk8-PtFCto9_4AkRePomvhAQ@mail.gmail.com>
	<87ehb0cgqt.fsf@gmail.com>
	<CACsJy8AiRCRvGmj4ZV+sc68d1z=S7YrRgPtPgEK+-zzNg7HcsA@mail.gmail.com>
	<87oba1siz6.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Thomas Rast <trast@inf.ethz.ch>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Robin Rosenberg <robin.rosenberg@dewire.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Thomas Gummerer <t.gummerer@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 18 01:58:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uzbby-0000V6-0z
	for gcvg-git-2@plane.gmane.org; Thu, 18 Jul 2013 01:58:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757617Ab3GQX6S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Jul 2013 19:58:18 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34811 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756209Ab3GQX6R (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Jul 2013 19:58:17 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5F80A31521;
	Wed, 17 Jul 2013 23:58:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=CQFlXdlDvQUgql0yntUmIcU+jdk=; b=NHtq6J
	9nXcstLK9T6TLUJMAeYAoUz3TxdqThz5HuwieEa1UEiWrZXixLyKdLKIYoBsgaU/
	IAJ0FjZ12G5IEtmiA6ikkQzmFOJ7B88WY1+pychf0/JxuQG4mr3mCq4QaS3RyIKi
	/4vPAfMoD6SuYgIIf5bzoRoQyttNTkmwOafhY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=NGRTDdu8l+nsWiorrSIpTH7BtlT6XuwE
	FzfGi/ovfNwbbDuoeLTXXDN9NwGZSr562QJZtv7mSBLOSgPfWUCG3V0fzeBKnhnL
	0QHlLWJFZ0xTdjS0nobwLfPdGgqja6XHICsktF1Sb3yqoNTlNtQiz8+JjUKJ7kih
	3k4b1ipPLI4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5293731520;
	Wed, 17 Jul 2013 23:58:16 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9FA213151F;
	Wed, 17 Jul 2013 23:58:15 +0000 (UTC)
In-Reply-To: <87oba1siz6.fsf@gmail.com> (Thomas Gummerer's message of "Wed, 17
	Jul 2013 10:12:29 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: BF08B266-EF3C-11E2-A9F6-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230664>

Thomas Gummerer <t.gummerer@gmail.com> writes:

> Ah ok, I understand.  I think it's best to add a GIT_INDEX_VERSION=x
> config option to config.mak, where x is the index version that should be
> tested.

Whatever you do, please do not call it GIT_INDEX_VERSION _if_ it is
only to be used while testing.  Have string "TEST" somewhere in the
name, and make t/test-lib-functions.sh take notice.

Currently, the way for the user to show the preference as to which
index version to use is to explicitly set the version once, and then
we will (try to) propagate it inside the repository.

I would not mind if we add a mechanism to make write_index() notice
the environment variable GIT_INDEX_VERSION and write the index in
that version.  But that is conceptually very different from whatever
you give "make VARIABLE=blah" from the command line when building
Git (or set in config.mak which amounts to the same thing).
