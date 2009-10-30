From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Bug#553296: gitignore broken completely
Date: Fri, 30 Oct 2009 12:41:27 -0700
Message-ID: <7vaaz8lleg.fsf@alter.siamese.dyndns.org>
References: <20091029233458.GA32764@ikki.ethgen.de>
 <20091030162857.26604.qmail@67b7e3b41a17c8.315fe32.mid.smarden.org>
 <20091030165903.GA10671@ikki.ethgen.de>
 <20091030173838.GB18583@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Klaus Ethgen <Klaus@Ethgen.de>, 553296@bugs.debian.org,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Oct 30 20:42:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N3xMI-0004wz-L5
	for gcvg-git-2@lo.gmane.org; Fri, 30 Oct 2009 20:42:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757223AbZJ3Tlm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Oct 2009 15:41:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757181AbZJ3Tlk
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Oct 2009 15:41:40 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:37935 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757010AbZJ3Tlh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Oct 2009 15:41:37 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 651478B0EC;
	Fri, 30 Oct 2009 15:41:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=7ibdbIPrmytrcJSykUOUc3TiHRA=; b=MebMfM
	YeP+X8qClRQlHQHYy2bcrijo8t3NU8l/XMe95iTDa0cw66hlpJ+H92krPnWYOB3y
	voGN+pQTUkDaFKR9pH+8Ij7ynEL44Ybx3jmyqXgSudBzG95Grk84w4IV+dLzH6gT
	1+CrhC72oiCeAHryEJFzmtDe7O9p+I09kF1Lc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=oluuowYctVyZBMts6HGV94pqXcJA7XB6
	zoCmN0bmTYfvFBbDTLOQu+BUVEX/EJBNnz+An70QViohi6O73jxs0JYaVoCoAz81
	n8e1NXs8iJTM1Rxl682tuFXu9x29WZbp4y4SDM5DRs4+RoRhQLppOLNJ6uA3qV65
	y69Fjv49LTk=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 261EA8B0EB;
	Fri, 30 Oct 2009 15:41:36 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 3D1EF8B0E8; Fri, 30 Oct 2009
 15:41:28 -0400 (EDT)
In-Reply-To: <20091030173838.GB18583@coredump.intra.peff.net> (Jeff King's
 message of "Fri\, 30 Oct 2009 13\:38\:38 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 3C099552-C58C-11DE-AD01-A67CBBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131737>

Jeff King <peff@peff.net> writes:

> I am not sure simply reverting is the best choice; the patch does do
> something useful. And while it strictly breaks backwards compatibility
> on the output without "-i", the old behavior was considered a bug. But
> the "-i" behavior is useless now, so we need to figure out how to
> proceed. We can:
>
>   1. Revert and accept that the behavior is historical. Callers need to
>      work around it by dropping --exclude* when invoking ls-files.
>
>   2. Declare "-i" useless, deprecate and/or remove. Obviously this is
>      also breaking existing behavior, but again, I don't think that
>      using "-i" actually accomplishes anything.
>
>   3. Revert for now, and then reinstate the patch during a major version
>      bump when we are declaring some compatibility breakages.
>
>   4. Re-work "-i" to show tracked but ignored files, but still show all
>      files when "-i" is not given at all.
>
> I think (4) preserves the benefit of the patch in question, but still
> allows your usage ("git ls-files -i --exclude-standard"). I do question
> whether that usage is worth supporting. Certainly I wouldn't implement
> it if I were writing git-ls-files from scratch today, but we do in
> general try to maintain backwards compatibility, especially for plumbing
> like ls-files.
>
> Junio, what do you want to do?

I've never understood the use of "ls-files -i" without -o, so in that
sense, I have done 2. myself already long time ago.

In other words, I do not really care that much, and the choice would be
between "0. do not do anything---the patch in question was a bugfix for
longstanding insanity" and your "4. -i without -o didn't make much sense
but now it does and here is the new meaning".
