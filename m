From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/2] fix status_printf_ln calls "zero-length format" warnings
Date: Tue, 11 Mar 2014 12:25:45 -0700
Message-ID: <xmqq38ior0zq.fsf@gitster.dls.corp.google.com>
References: <1394479647-22361-1-git-send-email-benoit.pierre@gmail.com>
	<20140310195121.GB24568@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Benoit Pierre <benoit.pierre@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Mar 11 20:25:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WNSJG-00014s-Qc
	for gcvg-git-2@plane.gmane.org; Tue, 11 Mar 2014 20:25:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754318AbaCKTZu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Mar 2014 15:25:50 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44975 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753449AbaCKTZt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Mar 2014 15:25:49 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 84DE474A80;
	Tue, 11 Mar 2014 15:25:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=kRMFDbSvymtOTVGrxHZpUSfEVok=; b=vBMfRY
	PnKksbE+xIUm/O3UgyoCBahHoGnniHGnJLJ1kEYPa3gpveZs6BzkVaUPnYm/mF5T
	iweqX5rBH0KMWRPFhaDh4WQkjJoVzRqDEW6Ma3uyA/VVlnf0DaHacXs7//EqLI9O
	YOp6Oxf7htybtQpjkjV7LfmX3m/hOhyBy2m8s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=H5LQLH4AGRvmtA0mgpljFJC038uJQSWh
	GD8btjigsxwIjvssLX3mNqVYR/EeF7Rt1Gdv5YmF+991DF6AmFhQf4YNQulfqxoE
	Y5DKy961cW6b7fBVU9FxK0LNKJ/xhiOhFEKke/KHzJg7idqBQ+mAIkWigB/ED3uQ
	8iqUhM/c7+I=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6E10D74A7F;
	Tue, 11 Mar 2014 15:25:48 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BD4BD74A7E;
	Tue, 11 Mar 2014 15:25:47 -0400 (EDT)
In-Reply-To: <20140310195121.GB24568@sigill.intra.peff.net> (Jeff King's
	message of "Mon, 10 Mar 2014 15:51:21 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: F2D72066-A952-11E3-A52F-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243881>

Jeff King <peff@peff.net> writes:

> Most of us who compile with -Wall decided a while ago to use
> -Wno-format-zero-length, because it really is a silly complaint (it
> assumes there are no side effects of the function besides printing the
> format string, which is obviously not true in this case).
>
> It would be nice to compile out of the box with "-Wall -Werror", and I
> think your solution looks relatively clean. But I am slightly concerned
> about the assumption that it is OK to pass a NULL fmt parameter to a
> function marked with __attribute__((format)).  It certainly seems to be
> the case now, and I do not know of any plans for that to change, but it
> seems like a potentially obvious thing for the compiler to check.

Yes, exactly.
