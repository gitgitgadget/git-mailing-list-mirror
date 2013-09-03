From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/3] Reject non-ff pulls by default
Date: Tue, 03 Sep 2013 10:21:04 -0700
Message-ID: <xmqqd2opu8hr.fsf@gitster.dls.corp.google.com>
References: <1377988690-23460-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Andreas Krey <a.krey@gmx.de>,
	John Keeping <john@keeping.me.uk>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 03 19:21:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VGuHz-0002RB-Rr
	for gcvg-git-2@plane.gmane.org; Tue, 03 Sep 2013 19:21:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756794Ab3ICRVM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Sep 2013 13:21:12 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48926 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754332Ab3ICRVL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Sep 2013 13:21:11 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 867F83EFF6;
	Tue,  3 Sep 2013 17:21:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/IZrZROWyDoCEdKrmGS+mXNlkFE=; b=YvVWW5
	9uMHy3y8pkqAGMfLfY2OPZmrzfJAyBFJPULagadgxn0hy891EttP8td9KTOLb00r
	FFifT4di4NIEVAiY/00LHb7Loy9WS2Bm6tCqOtAnHqKYU/Wt2FJXZ/YfhgDr2ISc
	YcrxehfbolynyXo+LTE0eO+ijk1p3tNWVf/WA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LxAaS49Q3fQuZtvXKBCJJ4R4QQaToRSU
	xNW8yd/t6H2QwZEiiHx3ZZOC7yNi926A2Jc0q6bMbEU95yH3iC0JtZutfweSSto8
	u3Oc1yBYdMjBMGotqMsm4TZeKye6YYaIw/gmnK3qbqVeasnKB/za9aK2eaV71AdF
	1CDizyitd+c=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9F1543EFEA;
	Tue,  3 Sep 2013 17:21:09 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A1C7D3EFDC;
	Tue,  3 Sep 2013 17:21:07 +0000 (UTC)
In-Reply-To: <1377988690-23460-1-git-send-email-felipe.contreras@gmail.com>
	(Felipe Contreras's message of "Sat, 31 Aug 2013 17:38:07 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 386A056A-14BD-11E3-8AE8-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233746>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> Junio already sent a similar patch, but I think this is simpler.

I agree that this is simpler, but I am not sure if the behaviour is
necessarily better (note that this is different from saying "I think
the behaviour of this patch is worse").  The motivation I read from
the original discussion was that new people did "git pull" (no other
parameters) to "sync my tree with the central repository" as if it
were SVN, and because we are not SVN, projects that prefer rebases
were unhappy, and the other one was to address *only* that use case.
I do not personally like that special casing (i.e. "only when no
'integrate with what from where' is given"), and applying the "you
must be explicit between rebase and merge" like this series does
uniformly might (or might not) be a good thing.  I dunno.

The difference in changes needed to the test suite is illustrative;
this series affects any use of "git pull" (with or without explicit
"what to integrate with and from where"), unlike the other one that
only affects the case where "git pull" was not given "what to
integrate with and from where".  I think an earlier draft I did for
the previous one did not special case "only when no 'integrate with
what from where' is given" and had to touch all the places in the
test in a similar way.
