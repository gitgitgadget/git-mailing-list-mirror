From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Question about the revision walking API
Date: Tue, 06 Jan 2015 10:30:32 -0800
Message-ID: <xmqqpparpxrr.fsf@gitster.dls.corp.google.com>
References: <20150106020230.GA28274@glandium.org>
	<CAP8UFD0mZ4tSF-ZkZh8Z=GdkW4LNQAWuKJYyhyiA4RTGPLX_+g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Mike Hommey <mh@glandium.org>, git <git@vger.kernel.org>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 06 19:30:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y8Ytx-0001TC-CA
	for gcvg-git-2@plane.gmane.org; Tue, 06 Jan 2015 19:30:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932441AbbAFSak (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Jan 2015 13:30:40 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:63246 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932423AbbAFSaj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Jan 2015 13:30:39 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id EC11F2C364;
	Tue,  6 Jan 2015 13:30:38 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=EE56a+Sit0i1p709Hm1HkeK9gbs=; b=VaBAz4
	SIqdRtvQkVkn0V+DHKy3SjqLdIDOK9PYQ9BwGHMifnyJRJPG9GbAtYprx4A+FugG
	g5T+PihWXt5mcNEonAPhHQrxMCLQeiX9o34BfhSXCwCSJBSOTweKU1CrC/SEJ7nf
	SPJUlV72JQRcTMID8sMyGuCe+iOv7RTxqe/TU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=C+mr/JUYLa2Buv8Qpb12gwEEwssZX2SN
	pMzK3FbtzMGZtVc5IqODhYB/B3tfITQ3LAlktHD7qqxPrEbVM5lb8Xye6DAZpC2A
	xnrzgoTCvL7UBuSCLz40rtcbZr3+qBIZzbD4mq0FfVApS0TKKbu6hJqR1iGivioj
	HgtQWnzM43Q=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id DB3A92C363;
	Tue,  6 Jan 2015 13:30:38 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2837F2C35D;
	Tue,  6 Jan 2015 13:30:34 -0500 (EST)
In-Reply-To: <CAP8UFD0mZ4tSF-ZkZh8Z=GdkW4LNQAWuKJYyhyiA4RTGPLX_+g@mail.gmail.com>
	(Christian Couder's message of "Tue, 6 Jan 2015 14:37:07 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 1A1D9E7C-95D2-11E4-A7FE-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262084>

Christian Couder <christian.couder@gmail.com> writes:

> I am not sure what you describe above would work, but something like
> what is done in bisect.c should work, see check_ancestors() and
> bisect_next_all(). It might not be the most efficient solution though,
> so I am interested if you find something more efficient.

I do not think what bisect does is a correct solution for general
case; I didn't check too carefully when I applied your patch long
time ago, but I recall that you only clear flag bits from commits
that are still in the pending queue in that codepath.  That may be
sufficient if the subsequent traversal goes only outside the area
previous traversal walked, but the approach is inappropriate for
general cases, no?
