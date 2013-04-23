From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add .gitconfig variable commit.gpg-sign
Date: Tue, 23 Apr 2013 07:01:51 -0700
Message-ID: <7v4nexmjlc.fsf@alter.siamese.dyndns.org>
References: <CAASwCXf3YHmdQ_eSkShyzn5VniO=ufm3VTqV1JVOUN610bzE_A@mail.gmail.com>
	<7vip3em8rs.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Joel Jacobson <joel@trustly.com>
X-From: git-owner@vger.kernel.org Tue Apr 23 16:02:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UUdnI-0002Kn-GN
	for gcvg-git-2@plane.gmane.org; Tue, 23 Apr 2013 16:02:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755138Ab3DWOB4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Apr 2013 10:01:56 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42608 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755093Ab3DWOBz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Apr 2013 10:01:55 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 35C4C16B4D;
	Tue, 23 Apr 2013 14:01:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=nkXdRn8lAnHSeYzJ0gjwgB21y1U=; b=PB/4+k
	FAadpH77JhE69iDt5QuKLln7OZvRrRx97LrjamOeDxypFfUa9GmZMOD8P/OO38kR
	J2pgtBcBqHwO3l2IHLrn4LoTgp0A+JufKXIZbiTgf6i1NR9n3QHubKUFn2rXWJ5H
	z4aYf8w98ihyrLXXkM2B5KVPYY2YlT9O8UgyY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=KxG/tiYTIcW4yVvAiTqawmdkKJckcmPN
	GJR5G6qiYkm3eq2QFlNXJ33bSRptQ3SiEsZNhTSQ7JJkF25mH1P5ZuC2ypmORDmg
	7rTq/PztD6Nzhq/aNRubILwKt+X6kZBhYKS2y0BnYx50cCEZXGwO8Pp/TUkCB/xP
	0ewjFMrSt0Q=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2B6AD16B4B;
	Tue, 23 Apr 2013 14:01:54 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9075816B42;
	Tue, 23 Apr 2013 14:01:53 +0000 (UTC)
In-Reply-To: <7vip3em8rs.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Mon, 22 Apr 2013 16:43:19 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5A264C48-AC1E-11E2-8213-BCFF4146488D-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222165>

Junio C Hamano <gitster@pobox.com> writes:

> Joel Jacobson <joel@trustly.com> writes:
>
>> Signed-off-by: Joel Jacobson <joel@trustly.com>
>> ---
>>  builtin/commit.c | 4 +++-
>
> No docs?  No tests?
>
> As to the design, any regular configuration variable settings must
> be overridable from the command line for a single invocation. Please
> design an escape hatch in, for somebody who has this configuration
> variable set, but does not want to sign this commit he is about to
> make.
>
> Also do we generally use dash in the configuration variable names?
> I thought the norm was section.CamelCase.

Another design issue you would need to consider before deciding to
add such a configuration is how it interacts with "git rebase -i".

The command internally runs "git commit --amend", etc. and I do not
know if _all_ users who set this configuration want to unconditionally
always re-sign all these commits.

There may be other commands that internally use "git commit" that
may be affected with such a configuration variable.
