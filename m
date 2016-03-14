From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC/GSoC 07/17] rebase-common: implement refresh_and_write_cache()
Date: Mon, 14 Mar 2016 14:10:06 -0700
Message-ID: <xmqqshzs9369.fsf@gitster.mtv.corp.google.com>
References: <1457779597-6918-1-git-send-email-pyokagan@gmail.com>
	<1457779597-6918-8-git-send-email-pyokagan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git List <git@vger.kernel.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Duy Nguyen <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>, sam.halliday@gmail.com
To: Paul Tan <pyokagan@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 14 22:10:22 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1afZko-0007sG-ED
	for gcvg-git-2@plane.gmane.org; Mon, 14 Mar 2016 22:10:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933929AbcCNVKO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Mar 2016 17:10:14 -0400
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:62333 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S933521AbcCNVKJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Mar 2016 17:10:09 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id BB9C44CC00;
	Mon, 14 Mar 2016 17:10:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=0o8wfI3IOTC4sMqExqp2ASOoCvk=; b=aAUcZg
	euz+B1Po9FXEjSk3OuqdXAcFtaQnKBIotEIrXG4QiD0U6tDWi5pTUlieXcRpBzsf
	d6hxCQ85W4N9S6nzUD4oHoS1mLGhGz+on+z8ee4F7T5JgMYFygK94KU/xAw/T24n
	uE2EvQTVQCJZVMo7lgC4IBY+TdFCxVfZoCcyg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=aGOb+cMCoSuxWMI6HJw5lJv41XWTeT42
	BMxlargh2K4njWBC72umBSbY5OHd5PSyr9XYE70EuzQ5qmrItDIq80dQJptV4TF1
	Enhdz2M9gCYJB4G8bnWwr+mIdTfcUH7nyXgQJ5ylUC9zTrzJGVOSYn5nixT40z5G
	U52XoTsjnYg=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id B309C4CBFE;
	Mon, 14 Mar 2016 17:10:08 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 1A35B4CBFC;
	Mon, 14 Mar 2016 17:10:08 -0400 (EDT)
In-Reply-To: <1457779597-6918-8-git-send-email-pyokagan@gmail.com> (Paul Tan's
	message of "Sat, 12 Mar 2016 18:46:27 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 2189C210-EA29-11E5-8CAC-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288813>

Paul Tan <pyokagan@gmail.com> writes:

> In the upcoming git-rebase to C rewrite, it is a common operation to
> refresh the index and write the resulting index.
>
> builtin/am.c already implements refresh_and_write_cache(), which is what
> we want. Move it to rebase-common.c, so that it can be shared with all
> the rebase backends, including git-am.

Your rebase-am might be one of the rebase backends, but git-am is
not, so it is misleading to count it among "all the rebase
backends".

I would think that a better home for refresh_and_write_index() is
right next to write_locked_index(), with #define in cache.h for
refresh_and_write_cache(), just like others.
