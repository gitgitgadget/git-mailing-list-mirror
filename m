From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC-PATCH 1/2] send-email: new option to quote an email and reply to
Date: Wed, 25 May 2016 08:40:06 -0700
Message-ID: <xmqqwpmi16zt.fsf@gitster.mtv.corp.google.com>
References: <1464031829-6107-1-git-send-email-tom.russello@grenoble-inp.org>
	<1464031829-6107-2-git-send-email-tom.russello@grenoble-inp.org>
	<vpq60u4bl4e.fsf@anie.imag.fr>
	<b1752a59-af2b-6e18-fc69-0650440939e3@grenoble-inp.org>
	<vpqh9dmfy5k.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Samuel GROOT <samuel.groot@grenoble-inp.org>,
	Tom Russello <tom.russello@grenoble-inp.org>,
	git@vger.kernel.org, erwan.mathoniere@grenoble-inp.org,
	jordan.de-gea@ensimag.grenoble-inp.fr,
	Tom Russello <tom.russello@ensimag.grenoble-inp.fr>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed May 25 17:40:19 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b5aux-0003NK-6v
	for gcvg-git-2@plane.gmane.org; Wed, 25 May 2016 17:40:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754317AbcEYPkM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 May 2016 11:40:12 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58368 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752758AbcEYPkL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 May 2016 11:40:11 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 1D3451C02B;
	Wed, 25 May 2016 11:40:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=zXqxBhiokdpIllBj6TM70Euof6k=; b=ZvuuZw
	7roF6lM/qOjlI4ayJ9x+HyCQ0sipIlY+34XxOuWkcg8K/vnkIp0el4yb6+1GyhXH
	mQ335D9fVTWWPcceRUP8lYsjUBG1vMJJpfuBSzosxdd0HbOs+ZnlLKIu6254C3Vq
	7aXr6zDn0rmgz4e/ZyvpjlQvKtmJuB7QxEx2k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=EVW7cmJBKvroNPi6K0FRE9IJyHFUlFub
	vQfj+oaKSdWyGs93jMsFXYRNmLhFKmDSVo+WFWxBhWWq32qYzhJWHeGEaq29rHXD
	TkivJYkVIV0n3lsUFTKZWoBBEVnZIM48IQof9z7DPelnIknZeJ583TjQW23Q+oEg
	WEHl9TjkVLI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 1419E1C02A;
	Wed, 25 May 2016 11:40:10 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 616451C027;
	Wed, 25 May 2016 11:40:09 -0400 (EDT)
In-Reply-To: <vpqh9dmfy5k.fsf@anie.imag.fr> (Matthieu Moy's message of "Wed,
	25 May 2016 08:29:43 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: F653F798-228E-11E6-B3B5-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295575>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Actually, I'm not sure what the ideal behavior should be. Perhaps it's
> better to distinguish 1) and 2) above, and have two options
> --reply-to-email=<file> doing 1), and --quote doing 2), implying
> --compose and requiring --reply-to-email.

I tend to agree that sounds like a better way to structure these
features.

I wonder if we can safely repurpose existing --in-reply-to option?
That is, if the value of --in-reply-to can be reliably determined as
a filename that has the message (as opposed to a message-id), we
read the "Message-Id:" from that file to figuire out what message-id
to use, and figure out To/Cc: to use for the purpose of your (1) at
the same time.  In the future, you might even teach send-email,
perhaps via a user configurable hook, a way to get to the message
header and text given a message-id, and when it happens, the same
logic can be used when --in-reply-to is given a message-id (i.e. you
go from the id to the message and find the addresses you would
To/Cc: your message).

> In any case, quoting the message without replying to it does not make
> sense (especially if you add instructions to trim it: the user would not
> even see it). So it its current form, I'd say --quote-email should imply
> --annotate.
