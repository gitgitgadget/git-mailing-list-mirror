From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 2/2] blame: use a helper to get suitable blame_date_width
Date: Mon, 21 Apr 2014 12:19:39 -0700
Message-ID: <xmqq38h6a3sk.fsf@gitster.dls.corp.google.com>
References: <cover.1398059411.git.worldhello.net@gmail.com>
	<17454bdfbd4e0e1516a64f75deabddb427792e99.1398059411.git.worldhello.net@gmail.com>
	<xmqqfvl6a9ar.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Duy Nguyen <pclouds@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Brian Gesiak <modocache@gmail.com>,
	Git List <git@vger.kernel.org>
To: Jiang Xin <worldhello.net@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 21 21:19:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WcJkq-000506-Lk
	for gcvg-git-2@plane.gmane.org; Mon, 21 Apr 2014 21:19:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753943AbaDUTTp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Apr 2014 15:19:45 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43739 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750891AbaDUTTn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Apr 2014 15:19:43 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0BF417F2E6;
	Mon, 21 Apr 2014 15:19:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=YX+YGk5IIS3DpFLLojd95cR7ITA=; b=kblyxi
	WL3MEWRkFETdasmseATvR5Fcz8JTcuKlz0MxVgSTXFDZHDkt45KsV2FSRL5aBgim
	OY+Ny8nd2WfiFZhWR5mquJAY8+KXrqRBUglUvxbTp4pOy8Tybi+EywmxeiTUc4Un
	U07o5krXMwxU5Weq3Rr0OFu5+LMT5m51Zdk3c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=YM1JTlLg9BU93nTx6TByo33e9vHKVyru
	Xnj5coAcOTpRHP4OKCskp0txTtpyj9jvsfyx7x1PtfmAL2o6bFHYsaq3S8uKQ0+d
	dwgB1CtJrsyjuRRExiJSm8lCAzjTKiAV6Ak7krC5n8iHwo6pYqk5oO5UXqz1KfDj
	eH6kcHOfJMA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D74037F2E5;
	Mon, 21 Apr 2014 15:19:42 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4EB457F2E3;
	Mon, 21 Apr 2014 15:19:41 -0400 (EDT)
In-Reply-To: <xmqqfvl6a9ar.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Mon, 21 Apr 2014 10:20:44 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: E35E25E2-C989-11E3-A6FC-0731802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246622>

Junio C Hamano <gitster@pobox.com> writes:

> What I am wondering is if we can do something
> like this:
> ...

Nah, that is a lot more stupid than just doing

>     In code:
>
>         blame_date_width = strtoul(_("4 years, 11 months ago"), NULL, 10) + 1;
>
>     In git.pot:
>
>         #. This string is used to tell us the maximum display width for a
>         #. relative timestamp in "git blame" output.  For C locale, "4 years,
>         #. 11 months ago", which takes 22 places, is the longest among various
>         #. forms of relative timestamps, but your language may need more or
>         #. fewer display columns.
>         msgid "4 years, 11 months ago"
>         msgstr ""
>
>     In de.po:
>         #. This string is used to tell us the maximum display width for a
>         #. relative timestamp in "git blame" output.  For C locale, "4 years,
>         #. 11 months ago", which takes 22 places, is the longest among various
>         #. forms of relative timestamps, but your language may need more or
>         #. fewer display columns.
>         msgid "4 years, 11 months ago"
>         msgstr ""vor 4 Jahren, und 11 Monaten"

which is essentially how your very original looked like (modulo the
comments).  So let's not try to be clever or cute, and just have a
good instruction in the TRANSLATORS comments.

Sorry for flipping and flopping on this one.
