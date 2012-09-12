From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-am: Handle "git show" output correctly
Date: Wed, 12 Sep 2012 15:19:43 -0700
Message-ID: <7vhar2c29s.fsf@alter.siamese.dyndns.org>
References: <1347472823.12986.3.camel@eddie.install.bos.redhat.com>
 <1347473304-21418-1-git-send-email-pjones@redhat.com>
 <7vtxv3atvu.fsf@alter.siamese.dyndns.org>
 <1347482918.21933.5.camel@eddie.install.bos.redhat.com>
 <7vpq5raqiq.fsf@alter.siamese.dyndns.org>
 <CAPBPrntHOpDaH3cSNiKKxVJDbZTpPrLc99TgPM_GdoXecUvs9w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Peter Jones <pjones@redhat.com>, git@vger.kernel.org
To: Dan Johnson <computerdruid@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 13 00:19:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TBvHn-0006e5-L5
	for gcvg-git-2@plane.gmane.org; Thu, 13 Sep 2012 00:19:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754695Ab2ILWTr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Sep 2012 18:19:47 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46149 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754628Ab2ILWTq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Sep 2012 18:19:46 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9267C8551;
	Wed, 12 Sep 2012 18:19:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=opP5Kbf2T/YqYoJyeasdilr42xM=; b=Gy0aC+
	UgfdVG1aWARfh6Dx6xcSJ1CPn3vmwWET7AUGBoRSjlfNvyRFOPr5v/cXs3tbB6dY
	SvicZbNPCpOpKnMmDfCggMKMcu3jjhkpFhpyeUGA8gl7p51lgBRj+WU0FSl4+nnd
	AzFhI3o1gXt1fG29IZZp7YLf/T+lx3adR+O+o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=dF8UtqGzfDjFplH33LGa3DxqtWH7lHFO
	jkxPTzhNmQM9aSpGbndMjkdx+PWxpXUmuUgzD8rYs3x6UJdOaJ22hK+PZdquqYj6
	7JZ82rB6HiGOs8zh4BJCL+nLXWeYCKUjsfV5ChSYr0b/UpRBBKfAzoV167qdt9Ms
	7Prg386QNxQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7EA598550;
	Wed, 12 Sep 2012 18:19:45 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DB2D4854F; Wed, 12 Sep 2012
 18:19:44 -0400 (EDT)
In-Reply-To: <CAPBPrntHOpDaH3cSNiKKxVJDbZTpPrLc99TgPM_GdoXecUvs9w@mail.gmail.com> (Dan
 Johnson's message of "Wed, 12 Sep 2012 17:26:39 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F4B7D96C-FD27-11E1-A1E3-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205344>

Dan Johnson <computerdruid@gmail.com> writes:

>> Not really.  If we start encouraging people to use "git show" output
>> as a kosher input to "am", we would have to support such use
>> forever, and we end up painting ourselves in a corner we cannot get
>> out of easily.
>
> If git am emitted a warning when accepting "git show" output, it seems
> like it would support Peter's use-case without encouraging bad
> behavior?

Are you seriously suggesting me to sell to our users a new feature
saying "this does not work reliably, we would not recommend using
it, no, really, don't trust it." from the day the feature is
introduced, especially when we know it will not be "the feature does
not work well yet, but it will, we promise" but is "and it may become
worse in the future"?

I do not see much point in doing that.

Besides, what bad behaviour do we avoid from encouraging with such
an approach?  As Peter said, the problem is not on the part of the
user who ended up with an output from "git show", when he really
wants output from "git format-patch".  Giving the warning to the
user of "git am" is too late.

I may be able to be pursuaded to swallow a new script somewhere in
the contrib/ hierarchy that takes a "git show" output and formats it
to look like "format-patch" output to be fed to "git am".  That way,
when a user has trouble with its parsing of "git show" output, at
least we can ask for the output of the format massaging step to help
us diagnose where the problem lies.
