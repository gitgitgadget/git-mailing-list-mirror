From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 3/3] git-push: make git push --dry-run --porcelain
 exit with status 0 even if updates will be rejected
Date: Mon, 08 Feb 2010 12:59:12 -0800
Message-ID: <7vpr4figv3.fsf@alter.siamese.dyndns.org>
References: <214a0317f2e4707a866b2f5d10509296bc1479c1.1265661033.git.larry@elder-gods.org> <032264a40d15cb9f4a86885947ffa23a603bfb0e.1265661033.git.larry@elder-gods.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Larry D'Anna <larry@elder-gods.org>
X-From: git-owner@vger.kernel.org Mon Feb 08 21:59:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NeahZ-0004lt-2C
	for gcvg-git-2@lo.gmane.org; Mon, 08 Feb 2010 21:59:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752700Ab0BHU7U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Feb 2010 15:59:20 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:59114 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751992Ab0BHU7T (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Feb 2010 15:59:19 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 97D4798B32;
	Mon,  8 Feb 2010 15:59:18 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=m1mrkjxCVmuekfrAvsZXdQ0uWo0=; b=gCnLwI
	z/8XxQzf638va+ThCumj+NKgR5rMLdsJDaYvYUuEh82txdG+MkYHY8KBE6mcmd8M
	H3UCqOQh55z0HJbQHGo1qcN93Fis/XAtKeGuvVuG5PuzovZ80p+xlICw6RJw3w1E
	HWwQ2IAsxFGTtQ987h1SSDd0yCbTp14SVNZ8M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Kof3vwUiCqZIvxz6Nk7V8Nkl8/U/2tVW
	iBlDp8qdqANOgcwZbOjTy4edRgz/SE5G9B3V1tF5MGFVnPven7lAKz9hCEo1RCFi
	h6jf8uWy8b73z79qN7UECOm62GI2mQcfIQWRYHXaY+F1L/Hf70VSj5uLyxVy5zAM
	PgqPnj1Z8jI=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 7044898B30;
	Mon,  8 Feb 2010 15:59:16 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D2A0D98B2B; Mon,  8 Feb
 2010 15:59:13 -0500 (EST)
In-Reply-To: <032264a40d15cb9f4a86885947ffa23a603bfb0e.1265661033.git.larry@elder-gods.org> (Larry D'Anna's message of "Mon\,  8 Feb 2010 15\:31\:24 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: D1877F74-14F4-11DF-9338-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139319>

Larry D'Anna <larry@elder-gods.org> writes:

> The script calling git push --dry-run --porcelain can see clearly from the
> output that the updates will be rejected.  However, it will probably need to
> distinguish this condition from the push failing for other reasons, such as the
> remote not being reachable.

I am not sure about this reasoning.  If you are telling the script writers
to decide what happened by reading from the output, shouldn't the program
say "I fail because I cannot reach the other side" to its standard output
so that the script can read it as well?

Having said that, I don't think it matters either way.  If a script wants
to know if push would fully succeed or not, it will run without
--porcelain (perhaps while discarding the standard error) and check the
status.  Even without this patch, if a script runs with --porcelain and
gets non-zero status, it can inspect the output and if it got rejection,
that is a sure sign that it at least reached the other end to get enough
information to decide that it will be rejected, no?
