From: Junio C Hamano <gitster@pobox.com>
Subject: Re: diff --break-rewrites for just a part of a file
Date: Tue, 10 May 2016 12:16:59 -0700
Message-ID: <xmqq1t59pvtg.fsf@gitster.mtv.corp.google.com>
References: <toea8jx3mt1.fsf@mimosa.sascha.silbe.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <git@vger.kernel.org>
To: Sascha Silbe <sascha-ml-reply-to-2016-2@silbe.org>
X-From: git-owner@vger.kernel.org Tue May 10 21:17:14 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0D9e-0000M6-4m
	for gcvg-git-2@plane.gmane.org; Tue, 10 May 2016 21:17:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751406AbcEJTRK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 May 2016 15:17:10 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51194 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750955AbcEJTRI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 May 2016 15:17:08 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 2D35919025;
	Tue, 10 May 2016 15:17:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Crrq4K5B+V6+LpoKlPMGsiT8luY=; b=wDGQJl
	EGW5yb2VEUQeqYjABPElPIXT3SNR3U99Cl7s8DNNVWyVdsU14jtPU1ST6V9hWYKF
	DXIphKG7DnAw+k1CQvOrdq5avbmmvX2Akcknt0TIZOAffZRmTOI1OrLJHwh6Z5YR
	i8NNjskF/oTNsvEz6YfVIZNbOOGt1Nd28AiWE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=FEbxzvEn7BuX8g6/xvCgU6lSQk52WO34
	YFHoZC/f37C1XY66J0iwcASc4c4MeQDnK7NqI7kEB1FD0TJqYPOWuVlYbavJDZno
	X8kWGxdPdpASrciCge8QoHBSoheF7UpsyoU9uDZAKfeBkVaA2GnBmG2o8lxCvV2D
	VGH0ijdLt/M=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 2476F19024;
	Tue, 10 May 2016 15:17:02 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8C81C19020;
	Tue, 10 May 2016 15:17:01 -0400 (EDT)
In-Reply-To: <toea8jx3mt1.fsf@mimosa.sascha.silbe.org> (Sascha Silbe's message
	of "Tue, 10 May 2016 18:22:34 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: C5F54EDC-16E3-11E6-819C-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294176>

Sascha Silbe <sascha-ml-reply-to-2016-2@silbe.org> writes:

> A combination of --break-rewrites and --inter-hunk-context that merges
> changes with less than the given number of unchanged lines between them
> into a single delete/insert change would be even better. But just
> ignoring the unchanged header and footer of a file for --break-rewrites
> would already go a long way.

That's interesting.  Break-rewrites as originally designed and
implemented is only about "When the entire file been rewritten
completely, it is easier to read when the diff did not pay any
attention to those accidentally common lines".

We recently had a discussion on tweaking the logic used to merge and
minimize hunks; the topic was about where to start the hunk boundary
for maximum readability when the beginning and end of a hunk can be
shifted around, but this smells like a similar issue.
