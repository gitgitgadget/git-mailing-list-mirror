From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Geolocation support
Date: Thu, 23 May 2013 10:48:13 -0700
Message-ID: <7vhahtfuzm.fsf@alter.siamese.dyndns.org>
References: <87mwrncfkh.fsf@ethzero.com>
	<CALkWK0kHEDn4Wt3Y+XUE59_9ZDf504yopMp9QtBUk49Sd+EXbg@mail.gmail.com>
	<CALWbr2w3=DTAMkFtJoLF1_X46fefpEq2WtTb7HGiTiOExFHG3w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Alessandro Di Marco <dmr@ethzero.com>,
	git <git@vger.kernel.org>
To: Antoine Pelisse <apelisse@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 23 19:48:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UfZcj-0003JN-4Q
	for gcvg-git-2@plane.gmane.org; Thu, 23 May 2013 19:48:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758744Ab3EWRsR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 May 2013 13:48:17 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54818 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758699Ab3EWRsQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 May 2013 13:48:16 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B95EC20C87;
	Thu, 23 May 2013 17:48:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=pk0pjKWpc3z1LSE5jB6dOShMJ2I=; b=OyQ4+6
	sSX+N+7dA/eh+eoBuNoKPlSaA52XssSj3nxppv8f2JAkofyis9Lc6vb0SHIOSyYc
	a/b7lz6vzt78Zf3KRBnfp7JJmsI+RLSt/FLd91evCGZ4cfjFYExwvMvdcmZH/6qI
	00RNaA5XR6z67OHUXYNC+4aEdXlDtTFZvkolo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=MT5srTum3pYm3Z2+ZUWmtzzf8a2ZkZup
	ybmH0f9PANNY9FChPZLpc3cbRjrEtqcGS6dYSw51qmSFEhI4csSpZNqQA6vL5PrH
	IrQm20bi5fJQNGoL+gH5q7KJk1sENqpGzKR920VEbnebiKLDxhrM/JMLlZGEYmIb
	u09Ek0pp5PA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B0FF820C86;
	Thu, 23 May 2013 17:48:15 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id ACF0B20C84;
	Thu, 23 May 2013 17:48:14 +0000 (UTC)
In-Reply-To: <CALWbr2w3=DTAMkFtJoLF1_X46fefpEq2WtTb7HGiTiOExFHG3w@mail.gmail.com>
	(Antoine Pelisse's message of "Thu, 23 May 2013 11:52:52 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F1850006-C3D0-11E2-8D1E-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225275>

Antoine Pelisse <apelisse@gmail.com> writes:

> I'm really not convinced this kind of changes should make it into
> Junio's tree (of course, he's the only one to decide). I really
> believe this is a very specific solution to a very specific problem
> (that is not for me to judge if the problem is real). Bloating the
> commit object with this kind of information doesn't feel like a good
> idea.
>
> I think it could be nice to provide a simple shell script to build the
> location, callable from a post-commit hook, to construct a
> "geolocation" note. Gitk could be programmed to read the notes to get
> the location, but once again, I'm not sure it should be mainlined.

I would personally find the "feature" cute, but

 - I think a note is an overkill for that; and

 - I also think that adding cruft to commit object header in a
   backward incompatible way, with the only possible escape-hatch
   being "if you want to keep being compatible with other people,
   you can choose not to use this feature", is a slipperly slope to
   fragmentation we do not want to go nearby.

Wouldn't it be sufficient to treat this in a similar way as
references to tracker entries and references to other commit objects
in the text of the commit message body are treated by gitk and
friends?  Just embed the information in the log text somewhere and
teach the UI how they look like and what to do with them.
