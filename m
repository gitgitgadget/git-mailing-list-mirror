From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6 2/3] branch: report invalid tracking branch as broken
Date: Thu, 15 Aug 2013 15:54:22 -0700
Message-ID: <7vzjsio99d.fsf@alter.siamese.dyndns.org>
References: <6bc0643a5fa0fae03be6fdb59f63075be1e4d983.1376590264.git.worldhello.net@gmail.com>
	<7vbo50uvty.fsf@alter.siamese.dyndns.org>
	<8db143908bc969bbe1d720479fb6214729f7b1ae.1376590264.git.worldhello.net@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Git List <git@vger.kernel.org>
To: Jiang Xin <worldhello.net@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 16 00:54:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VA6RE-0005YC-0B
	for gcvg-git-2@plane.gmane.org; Fri, 16 Aug 2013 00:54:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752565Ab3HOWy2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Aug 2013 18:54:28 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57501 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751767Ab3HOWyZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Aug 2013 18:54:25 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B94E939F6A;
	Thu, 15 Aug 2013 22:54:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ai3sWrah7rwlu7AMb+Lmcww8zGc=; b=DqXb6v
	2AYroRFG0Q4gYPI1mgch517BjMDt/3OjHoBspmQm5u68zZxcVnNdr5PLvw9Dy48A
	S/jzANeSWF/iolPObRkZgezv4k/zZ7Dn71pJ7Ox0mOYLWKAmzqYsJQZjxj9h0qIz
	5POMgtKf0GWLq/se32iiyy9IpPB3pfzg2wWOA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jzBqjcaRMd0VETLerzc5ud5hHAjxQJ/Y
	RQoL6D0KFUrt8ryDagQS44ULtfL7YJJUHVwNNhjkdJ9SK6xxxXdB9Bfw0ZIufyPW
	rZ05Aj7TqxutyrzsKsyhFRs3DV9GMKJmhiWQsetmi2a8O/BY0SN7xn+Gx7gU3PGq
	FTY9In1lSlk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AED4039F69;
	Thu, 15 Aug 2013 22:54:24 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id F353839F64;
	Thu, 15 Aug 2013 22:54:23 +0000 (UTC)
In-Reply-To: <8db143908bc969bbe1d720479fb6214729f7b1ae.1376590264.git.worldhello.net@gmail.com>
	(Jiang Xin's message of "Fri, 16 Aug 2013 02:11:22 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A12B1C70-05FD-11E3-B53F-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232385>

Jiang Xin <worldhello.net@gmail.com> writes:

>  /*
> - * Return false if cannot stat a tracking branch (not exist or invalid),
> - * otherwise true.
> + * Compare a branch with its tracking branch, and save their differences
> + * (number of commits) in *num_ours and *num_theirs.
> + *
> + * Return 0 if branch has no upstream, -1 if upstream is missing or invalid,
> + * otherwise 1.
>   */

What is the difference between a branch that has no upstream and
upstream being missing?  Or between missing and invalid?

I think you are trying to say the difference between
"branch.<name>.merge is not set at all" and "branch.<name>.merge is
in the configuration, but the named upstream ref does not exist".

You are calling the latter "missing or invalid", but how does one
tell missing ones from invalid ones?  I think there isn't a
distinction, so it would be better to just say "missing" (or "gone",
which is very much more likely reason why you still have
configuration without a ref).

I am not sure it is a good idea to label "missing" as "broken" or
"invalid", but it seems that your tests, in code comments and
variable names are full of these negative connotations.

Hmph...
