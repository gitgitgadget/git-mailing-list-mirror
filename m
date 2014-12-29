From: Junio C Hamano <gitster@pobox.com>
Subject: Re: GIT_PUSH_CERT* env vars and update/post-update hooks...
Date: Mon, 29 Dec 2014 08:36:46 -0800
Message-ID: <xmqqa9261kgx.fsf@gitster.dls.corp.google.com>
References: <549A1D8A.3020106@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>
To: Sitaram Chamarty <sitaramc@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 29 17:38:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y5dKe-0004dN-J3
	for gcvg-git-2@plane.gmane.org; Mon, 29 Dec 2014 17:38:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752053AbaL2QiH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Dec 2014 11:38:07 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:62290 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751321AbaL2QiF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Dec 2014 11:38:05 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 66B9F290B3;
	Mon, 29 Dec 2014 11:38:04 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=tKRoVnr7NxOdRUaZ6L6XBMaa5W8=; b=j0V3c0
	G9CZWNHEyUAlUSyk8xPNDIe01w7W0jH06eIo17Yx+C7GeBHohxqd5N2dMQagjC5O
	dODuCDGvOPqt/kf9otIA+d+l8vp/hUFmk3fkZNhBAdYrD0CmuY9217EigKA4AFEW
	XzrZ4XYQ9hAmfQ6ZbqQoGdbzAahscRAgK+b4o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=vEL1XPjjAxpm647DRT0wG44pcgMFvpZr
	zIMvUUgFkBL6jLB7+wnqssrvO4ul6ISM99MFudxWn/ma8jbedpLahWpDJPQ6LjY6
	8oOYvq6TYpp/uXDAA8qNCMnC7TJmts73/LdnTtqIc5d9ufXPdWR7kkXLVhfnM2dp
	S/huqHKZLMU=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 5B414290AF;
	Mon, 29 Dec 2014 11:38:04 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2D71029003;
	Mon, 29 Dec 2014 11:36:48 -0500 (EST)
In-Reply-To: <549A1D8A.3020106@gmail.com> (Sitaram Chamarty's message of "Wed,
	24 Dec 2014 07:27:30 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: E2357EC6-8F78-11E4-8CA6-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261864>

Sitaram Chamarty <sitaramc@gmail.com> writes:

> Any chance I could persuade you to set the GIT_PUSH_CERT* environment
> variables for the update (and post-update) hooks also?

I do not think of a fundamental reason why we shouldn't give these
environment variables to update or other hooks.  It should just be
the matter of calling prepare_push_cert_sha1() on the child_process
struct used to run the hooks you want.

> [1]: because it's nice to *selectively* reject refs when more than one
> ref is pushed at the same time; pre-receive is "all or none".

It cuts both ways; inside "update", your "selective" rejection
cannot make the decision with the whole picture (you only have a
peephole into individual changes).  "post-receive" sees the whole
picture, but it has to say all-or-none.  Neither is ideal if you
truly want a useful "selective".
