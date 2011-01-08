From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG] git rev-list --no-walk A B C sorts by commit date
 incorrectly
Date: Fri, 07 Jan 2011 17:00:41 -0800
Message-ID: <7v62u043ba.fsf@alter.siamese.dyndns.org>
References: <CEF26B82-4281-4B8F-A994-DE32EFB92BA7@sb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git list <git@vger.kernel.org>
To: Kevin Ballard <kevin@sb.org>
X-From: git-owner@vger.kernel.org Sat Jan 08 02:00:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PbNAv-0007AT-6u
	for gcvg-git-2@lo.gmane.org; Sat, 08 Jan 2011 02:00:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752340Ab1AHBAv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Jan 2011 20:00:51 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:33399 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751779Ab1AHBAu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Jan 2011 20:00:50 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 40C223C28;
	Fri,  7 Jan 2011 20:01:28 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=EFyMESAe4t7NklRewEu4tKayFlE=; b=iSyeMk
	gF/pGbHjICl9imHnJe3mM7suI/M+rUys+0BguHmoE7pJ37DEnTnHajEpRhsjoHZR
	uHcp+ibFFw/YaOAqWduoufKB5lgaDFNfQsrKbPwdpkrs0kiP4VBoVUAS7wtVVQX9
	KVaWsKS/cT3qmdY7RvaTcCEsvfVuvnTuhyR0A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=FiLs8eqF2TFN6ydJ0pMVrhUk8z4C5A9j
	98k7SApwNxoSNlo3CE5DCp+7A5eHiBsCB7X6nqwh5lQVUXX+tfbA92c4g0C+L+m7
	LSlJjuqvVzfanHaRn/eHA+ZFrW6mb+F9An4CoW176HMwjq7KmocdowvznnCXx17k
	9tqbHKA8EKA=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 135053C27;
	Fri,  7 Jan 2011 20:01:26 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 27BC53C24; Fri,  7 Jan 2011
 20:01:20 -0500 (EST)
In-Reply-To: <CEF26B82-4281-4B8F-A994-DE32EFB92BA7@sb.org> (Kevin Ballard's
 message of "Fri\, 7 Jan 2011 16\:19\:02 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: D168E986-1AC2-11E0-BF73-CBB45B885003-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164799>

Kevin Ballard <kevin@sb.org> writes:

> Is there any rationale for this behavior?

Not a rationale, but an explanation is that most of the time we walk the
history and sorting by date is the first thing that needs to be done, and
the --no-walk option was an afterthought that was tucked in.

I suspect that a three-liner patch to revision.c:prepare_revision_walk()
would give you what you want.  Instead of calling insert-by-date, you
append to the tail when revs->no_walk is given, or something.
