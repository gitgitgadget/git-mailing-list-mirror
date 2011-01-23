From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] No color diff when redirecting to file
Date: Sun, 23 Jan 2011 15:32:12 -0800
Message-ID: <7voc77mc1v.fsf@alter.siamese.dyndns.org>
References: <201101231410.48528.saschpe@gmx.de>
 <201101231547.18529.j6t@kdbg.org> <vpq39oj4jfz.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j6t@kdbg.org>, Sascha Peilicke <saschpe@gmx.de>,
	git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Jan 24 00:32:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ph9Q8-0008Dv-5j
	for gcvg-git-2@lo.gmane.org; Mon, 24 Jan 2011 00:32:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752668Ab1AWXc0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Jan 2011 18:32:26 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:49293 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752194Ab1AWXcZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Jan 2011 18:32:25 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id CF27F419F;
	Sun, 23 Jan 2011 18:33:11 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=eHxlAtdCvQTAxRfUAiv3tVn8mcA=; b=g0mGBw
	3Md2D+s+1oZ0QAgMItvn+BpRG2cixV0C9U9Wy3apZ3LdXMLa0mOvAGrLqSp9+Yzf
	wVXaugxwWx24dNqAAkZK1dSAC3fhFHze0w2+xfM1uPD+zYiD5LRaBJQbYgRfMS0V
	KUPz2imFX8SBo65m6/48PEBoA8uFWuNbWEdOs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=VtaceQHB39SCCovabywOs2KQnAStHCPl
	HoU3tdkmQUhZiJNJO/XIzcqTM/hXMJvEGOnsws8sZGBcyRwadhvD0m8K7oSpFzTH
	qTt5musa8wMRU5IUpPzLUmk2CPjV++pRzSq0aOWAGQY+41aIjNOuCSqbQ21lm/s5
	/uz04XZCPX4=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 851BB419E;
	Sun, 23 Jan 2011 18:33:07 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 2C14D419D; Sun, 23 Jan 2011
 18:33:01 -0500 (EST)
In-Reply-To: <vpq39oj4jfz.fsf@bauges.imag.fr> (Matthieu Moy's message of
 "Sun\, 23 Jan 2011 18\:29\:52 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 21D8B1CA-2749-11E0-8BBA-BC4EF3E828EC-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165430>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Johannes Sixt <j6t@kdbg.org> writes:
>
>> That said, I cannot reproduce. Perhaps your configuration says 
>> color.ui=always? If so, then this is expected behavior and not a bug, IMO.
>
> I think you're right.
>
> I tested this (without the patch):
>
> git diff
> => I get color, because I have color.ui = auto
>
> git diff | cat
> => I don't get color
>
> git diff --color=auto | cat
> => no color
>
> git diff --color=always | cat
> => colors, because I've asked
>
> this seems to be just the right behavior.

Overall I agree with the above observation, but the original poster says
"redirecting into a _file_".

Another possibility is that the mysterious platform the original poster
did not mention has a broken istty() that mistakes a file descriptor going
to a file (instead of a pipe to another process) as connected to a tty.
