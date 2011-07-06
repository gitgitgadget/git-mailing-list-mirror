From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 10/14] revert: Persist data for continuation
Date: Wed, 06 Jul 2011 14:20:57 -0700
Message-ID: <7vsjqjjebq.fsf@alter.siamese.dyndns.org>
References: <1309938868-2028-1-git-send-email-artagnon@gmail.com>
 <1309938868-2028-11-git-send-email-artagnon@gmail.com>
 <20110706100119.GG15682@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 06 23:21:06 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QeZWs-0001jr-30
	for gcvg-git-2@lo.gmane.org; Wed, 06 Jul 2011 23:21:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756531Ab1GFVVA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Jul 2011 17:21:00 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:47627 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756500Ab1GFVU7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jul 2011 17:20:59 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 540A569EA;
	Wed,  6 Jul 2011 17:20:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=ZlT58XqpaBYkAM2jLQeihZpBWzY=; b=fXrXGwLagh86OFD1rNB5
	HLBhsxMEmmfxx8x8RYBZIoaAqhCYgzreMktkNAqukVugETDNhzbc+AeUqLXibFwZ
	tk57idMetxPWHBMWx8QxfjB/BQfpF2SNqU2g+VT5zvUTqyrDHJNDf199b7GxdMkb
	tVTBnit8KO33UbRAhLkONcE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=Q7S5lPopFxSb9TfhnbUDF8F2CZzbrWCGYDAIZUm10iOJdf
	EtTFIhYDYpjSvG2Xbof2xwTm3np1oW1gU2To8OHUFiTYW39rIxB7B81+YKKbFJ/+
	etu8mtOy81W2/3ZV6MqUoHVli/L0cLxyWH6yIC0r/Oy9avK26wS8SwaQGc4VE=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 4DE3F69E9;
	Wed,  6 Jul 2011 17:20:59 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 9044669E8; Wed,  6 Jul 2011
 17:20:58 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D798BFC6-A815-11E0-8B5C-5875C023C68D-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176731>

Jonathan Nieder <jrnieder@gmail.com> writes:

>  /*
>   * Example:
>   *
>   *	struct commit_list *list;
>   *	struct commit_list **next = &list;
>   *
>   *	next = commit_list_append(c1, next);
>   *	next = commit_list_append(c2, next);
>   *	*next = NULL;
>   *	assert(commit_list_count(list) == 2);
>   *	return list;
>   *
>   * Don't forget to NULL-terminate!
>   */

I wonder if the optimization to allow omitting unnecessary NULL
termination inside a tight loop by the caller is really worth the
potential trouble, though.
