From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Only print an error for the last connect() failure
Date: Thu, 09 Jun 2011 10:30:18 -0700
Message-ID: <7vhb7yykt1.fsf@alter.siamese.dyndns.org>
References: <13539E82-3E8D-4210-9A3A-DD83F0CA6F85@apple.com>
 <20110609163340.GD25885@sigill.intra.peff.net>
 <767D7D04-6089-4C7B-A532-C5EC9FE0CCC6@apple.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Dave Zarzycki <zarzycki@apple.com>
X-From: git-owner@vger.kernel.org Thu Jun 09 19:30:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUj47-00039e-2v
	for gcvg-git-2@lo.gmane.org; Thu, 09 Jun 2011 19:30:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754137Ab1FIRab (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jun 2011 13:30:31 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:35535 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754026Ab1FIRa1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jun 2011 13:30:27 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id B990B4B38;
	Thu,  9 Jun 2011 13:32:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=siFTiuS3cqrTtR7tP3xkiSK8DfM=; b=m6v6nV
	ZIwk8aWM0sMIoF2kqwnVTF8+pdaRQum2x080hnJ1JZ7XYlKXru15+/BHtvGtM8Bc
	4yrq8KeKjb4vdeqYbyy+1ZPjSzitUvV30ndIkTGMJR12l1a3K8FftJxGNGXESRpz
	kXjxGypXm+F6Vn+mTckC8+XsbKaJplfdihFsg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=sQaAXF3LwYsb7fQhh2ovPZfuWds87f35
	2aFvmmdJhilXJUMVa5x1zShfP4axRoTi4ajMFxdWVigsIpqyOr96vAcwa0F9J4Jb
	3qX/l068q0tnNRxIGA8tENHm0wJLs8mkuAyz+uF8YCheu77Q4Ih1kbBTqjAbV34S
	6yiorGobNWA=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 6B97A4B35;
	Thu,  9 Jun 2011 13:32:33 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 535344B2B; Thu,  9 Jun 2011
 13:32:29 -0400 (EDT)
In-Reply-To: <767D7D04-6089-4C7B-A532-C5EC9FE0CCC6@apple.com> (Dave
 Zarzycki's message of "Thu, 09 Jun 2011 09:49:28 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7579112C-92BE-11E0-9988-C8CFB7AE1C3C-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175558>

Dave Zarzycki <zarzycki@apple.com> writes:

> Personally speaking, I don't think we're masking failures any more than
> git is masking failures when it doesn't find a ref in .git/refs and it
> falls back to .git/packed-refs.

That is not even a fallback. If a loose ref is found, the corresponding
entry in packed-refs is *STALE* and should *NEVER* be looked at.

Back to the topic.

If a host advertises that it can be reached at any of these addresses,
then you can say these addresses are fall-back for each other.  It is fine
not to report about addresses we tried but didn't get connection as long
as we manage to reach it in one of the addresses.  We do not report other
addresses we didn't even try, and it is not useful to report earlier
addresses we tried but didn't get the dial tone in such a case.

As Peff said, if we failed to reach any connection, reporting all
failed addresses would give the user a better clue when diagnosing the
network problem.
