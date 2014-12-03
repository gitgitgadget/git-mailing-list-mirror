From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] rerere: error out on autoupdate failure
Date: Wed, 03 Dec 2014 09:41:32 -0800
Message-ID: <xmqqppc0iqb7.fsf@gitster.dls.corp.google.com>
References: <20141203042049.GI6527@google.com>
	<xmqqy4qoiqmu.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 03 18:41:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XwDvm-0002N1-JY
	for gcvg-git-2@plane.gmane.org; Wed, 03 Dec 2014 18:41:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751153AbaLCRlf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Dec 2014 12:41:35 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:64831 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750815AbaLCRle (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Dec 2014 12:41:34 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C4A8C2212B;
	Wed,  3 Dec 2014 12:41:33 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=absA4AjLhLJsVvKruKE84Ps0s9Q=; b=UOkMBV
	XWZU9slVqccQW1uhejdqXqVgNW7ApbdIVhTNqvEUO28061Lw3g7psucaX4SrPRhV
	8/B9JOvx55Q0IcsZ5YCSaZsSoWDsKyKPQ4i9k5Jxt/EoXMjDBvTLuXNgJkm361J2
	kymgtspccI84ikD53BV3bIKiwFeNsY+KEF268=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mcOPe1soIJx5SHYeMc2CCPMiZU+hKovH
	uGAYrlfFKalP6EWeo+AFQqg9WQjLIziChONwqQ3hMgGmhDt3DvNtqWgwkdMhEoJc
	KZCVj6cvdwzEekgVl37SmZuq+8L+MDftqWJRRlyRmnSBzRZGIatyv+3XUZmJf5Aj
	7pyyxIIspis=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id BB5C72212A;
	Wed,  3 Dec 2014 12:41:33 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 435B422123;
	Wed,  3 Dec 2014 12:41:33 -0500 (EST)
In-Reply-To: <xmqqy4qoiqmu.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Wed, 03 Dec 2014 09:34:33 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 9F296558-7B13-11E4-9F31-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260670>

Junio C Hamano <gitster@pobox.com> writes:

> Instead of crafting a new message, why not just stop passing IGNORE_ERRORS
> and have add_file_to_cache() report the failure?  That is:
>
> 	if (add_file_to_cache(item->string, 0))
>         	return -1;

Err, that should be exit(128) to mimic die().

> That way, the user will get more useful diagnosis because there are
> different reasons why an "add" may fail and we give different error
> messages to them.
