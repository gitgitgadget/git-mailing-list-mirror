From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 05/15] refs.c: update rename_ref to use a transaction
Date: Tue, 28 Oct 2014 12:07:58 -0700
Message-ID: <xmqqppdcj9m9.fsf@gitster.dls.corp.google.com>
References: <1413923820-14457-1-git-send-email-sahlberg@google.com>
	<1413923820-14457-6-git-send-email-sahlberg@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>
To: Ronnie Sahlberg <sahlberg@google.com>
X-From: git-owner@vger.kernel.org Tue Oct 28 20:36:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XjCZc-0002Uj-OM
	for gcvg-git-2@plane.gmane.org; Tue, 28 Oct 2014 20:36:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752138AbaJ1Tgx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Oct 2014 15:36:53 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:62532 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750857AbaJ1Tgw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Oct 2014 15:36:52 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B1C3019062;
	Tue, 28 Oct 2014 15:36:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=p3Cez4LARRznXky3m7H6VCQT+7c=; b=xu6zuQ
	BpTcW7UM5/j0zA0zNmjlyFK8vFD3W68W/aF8wmwIgW++ZQhx3g6XTB2GwcloMWbm
	hGnwyK86+QpiYqp8+iBLR07aturaI7e6G6LWGo8p48yQTM7rJhqR1IG5rwbV6Am5
	1StgHlq57V43IOesZEoXLjvYHbBJu8MMu0lkE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=COCxWR18eXbfUCI26J6gkN7t38bcXlxg
	qF1c5X3/OHu9OTRqPBhoesrQNmM84no1FdRCzuLJL7rCfCnmeTw567kIO+lOmHXJ
	dI6Br/qAgAESE85aKfYi0UNmLkrBcUMSJ1+0CIaPgv2vvnQJpLbn590WELvMbwi/
	Lzg7crx8K40=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A4F5619061;
	Tue, 28 Oct 2014 15:36:51 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 588BD18883;
	Tue, 28 Oct 2014 15:08:01 -0400 (EDT)
In-Reply-To: <1413923820-14457-6-git-send-email-sahlberg@google.com> (Ronnie
	Sahlberg's message of "Tue, 21 Oct 2014 13:36:50 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: BCA26ECC-5ED5-11E4-8986-855A93717476-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ronnie Sahlberg <sahlberg@google.com> writes:

> commit 0295e9cebc41020ee84da275549b164a8770ffba upstream.
>
> Change refs.c to use a single transaction to copy/rename both the refs and
> its reflog. Since we are no longer using rename() to move the reflog file
> we no longer need to disallow rename_ref for refs with a symlink for its
> reflog so we can remove that test from the testsuite.

Do you mean that we used to do a single rename(2) to move the entire
logfile, but now you copy potentially thousands of reflog entries
one by one?

Hmmmm,... is that an improvement?
