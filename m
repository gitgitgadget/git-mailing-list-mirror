From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/7] submodule update --init: test path handling in recursive submodules
Date: Mon, 28 Mar 2016 22:48:23 -0700
Message-ID: <xmqq1t6t25so.fsf@gitster.mtv.corp.google.com>
References: <1459207703-1635-1-git-send-email-sbeller@google.com>
	<1459207703-1635-4-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Jens.Lehmann@web.de, jacob.keller@gmail.com
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue Mar 29 07:48:33 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1akmW1-0007Lw-4p
	for gcvg-git-2@plane.gmane.org; Tue, 29 Mar 2016 07:48:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752116AbcC2Fs2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Mar 2016 01:48:28 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:56693 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751822AbcC2Fs0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Mar 2016 01:48:26 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id C0F3B4563C;
	Tue, 29 Mar 2016 01:48:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=TDeCY0MLQwN1WDG3QXKePCX5cPM=; b=BMc1Eo
	AyPdahrneRrhHToAZ+qBA8dju5yg1QGmdzxHFw3/+NOMIqQo9BkU8IICj+KPKWz/
	lV3ciVpJVaNHkILEgFEdiBzUvnPa/0+XOHSQJ8HomeQYnM0+x97RAciQTryzjAzs
	l7FoZzMSouY/0v9SCmaPYDpMq0rfC9qeaKvv8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ED+3F1S1AQKOsKdM9P9ZQgAAFszW8UkQ
	7Bvv1BENbTdPBS7l7covf657qaC7Ut8grQy+Fit+keKGmDksaiFP6KOt/tCZSP3Y
	QeijbzBAfKK6iZcD9+M03hseG00iiR/Ha+wogW7ht024jCNMeQospZil6L7xBPZH
	RTVqICMBf6o=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id B7ECE4563A;
	Tue, 29 Mar 2016 01:48:25 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 3606E45639;
	Tue, 29 Mar 2016 01:48:25 -0400 (EDT)
In-Reply-To: <1459207703-1635-4-git-send-email-sbeller@google.com> (Stefan
	Beller's message of "Mon, 28 Mar 2016 16:28:19 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: DA9AC008-F571-11E5-BC5B-45AF6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290102>

Stefan Beller <sbeller@google.com> writes:

> @@ -95,6 +99,35 @@ test_expect_success 'submodule update from subdirectory' '
>  	)
>  '
>  
> +supersha1=$(cd super && git rev-parse HEAD)

"supersha1=$(git -C super rev-parse HEAD)" perhaps?

> +cat <<EOF >expect
> +Submodule path '../super': checked out '${supersha1}'
> +Submodule 'merging' (${pwd}/merging) registered for path '../super/merging'
> +Submodule 'none' (${pwd}/none) registered for path '../super/none'
> +Submodule 'rebasing' (${pwd}/rebasing) registered for path '../super/rebasing'
> +Submodule 'submodule' (${pwd}/submodule) registered for path '../super/submodule'
> +Submodule path '../super/merging': checked out '${mergingsha1}'
> +Submodule path '../super/none': checked out '${nonesha1}'
> +Submodule path '../super/rebasing': checked out '${rebasingsha1}'
> +Submodule path '../super/submodule': checked out '${submodulesha1}'
> +EOF

Why all these {curly braces}?
