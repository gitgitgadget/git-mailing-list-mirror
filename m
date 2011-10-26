From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git grep: be careful to use mutices only when they are
 initialized
Date: Wed, 26 Oct 2011 10:17:18 -0700
Message-ID: <7vvcrb3c69.fsf@alter.siamese.dyndns.org>
References: <alpine.DEB.1.00.1110251223500.32316@s15462909.onlinehome-server.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: msysgit@googlegroups.com, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Oct 26 19:17:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RJ76V-0006vm-42
	for gcvg-git-2@lo.gmane.org; Wed, 26 Oct 2011 19:17:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933618Ab1JZRRW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Oct 2011 13:17:22 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43342 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933584Ab1JZRRV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Oct 2011 13:17:21 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4F341422E;
	Wed, 26 Oct 2011 13:17:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+7BruijQXWSLeCieoPuTfq9xuhA=; b=DRZRBF
	EkVenub7q+KIAwETKI1o4fzlSo4XCHUBBFht6NZCEkr8eseNGvexw6pl7fXtfjpd
	UPnL+RVgRHpCDUX7q4IrAgpqNRH0S8iWbmDhNkqk09cndWQtah2F9YLnyv0Z0cXc
	bATBTTFZX4Kh+ty6J6ZYCbaZrKLtfNS1Jm9io=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ZOUxLxd9/qAlwQMcOnw3ecUhiN8nUt7T
	Mzz8pVCaYp/8LS/qIEWbILC3hqnOLmJZSmOtGHM5L+vk7DJISH4A3zqmUWVxQG45
	yPp+cOzKx5+ZA3V0V/I4Kd38D0CyOqcRPa6ahcAkx/9xtTQIKkH1+ODxo/0MMpKj
	1y4OsOtPEO0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 43E84422D;
	Wed, 26 Oct 2011 13:17:20 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CF140422C; Wed, 26 Oct 2011
 13:17:19 -0400 (EDT)
In-Reply-To: <alpine.DEB.1.00.1110251223500.32316@s15462909.onlinehome-server.info>
 (Johannes Schindelin's message of "Tue, 25 Oct 2011 12:25:20 -0500 (CDT)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5C69D7DE-FFF6-11E0-A6DD-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184267>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Rather nasty things happen when a mutex is not initialized but locked
> nevertheless. Now, when we're not running in a threaded manner, the mutex
> is not initialized, which is correct.

Thanks; I wonder why pack-objects does not have the same issue, though.
