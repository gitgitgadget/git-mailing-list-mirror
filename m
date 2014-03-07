From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v7 00/11] Add interpret-trailers builtin
Date: Fri, 07 Mar 2014 13:49:05 -0800
Message-ID: <xmqq8uslu1bi.fsf@gitster.dls.corp.google.com>
References: <20140306220029.29150.64594.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Johan Herland <johan@herland.net>,
	Josh Triplett <josh@joshtriplett.org>,
	Thomas Rast <tr@thomasrast.ch>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Dan Carpenter <dan.carpenter@oracle.com>,
	Greg Kroah-Hartman <greg@kroah.com>, Jeff King <peff@peff.net>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Fri Mar 07 22:49:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WM2dn-0003xu-9G
	for gcvg-git-2@plane.gmane.org; Fri, 07 Mar 2014 22:49:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753658AbaCGVtL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Mar 2014 16:49:11 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37528 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753336AbaCGVtJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Mar 2014 16:49:09 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4856971F67;
	Fri,  7 Mar 2014 16:49:09 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=cTztanShXSkR5r8QUU+oPgG0Rlk=; b=SI0GsMBtjwLParMQ/pIZ
	55NaJKrnBejsRhdodwLRn0kkPSCZk2Gctk9uIo+umS48CJrUrWrVM4uYOuAs5rkP
	cx6DC5YvI/YoF9jWj0HLP9c5b8MIF+DaIp3URy953CDGKg3wUfp8LfUj7gT7um9A
	wKOUD7JMXx4kmb4IGDsNzvo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=Pp2SaolmV5SGP3esUyTqiN3Dhn6tFNBvd3hW/Yjd1z9Vnl
	Wmc3A+S6knAu9rj7EpuDfvWuiIox4a9TLttbZW+G+KI1slDKq/TWNdYBvq+XSFNh
	IopwiCimKw+uQp4F8Mop/7Hcd8yOoFlU7l8TQBkC/9q4KjTxo0ISDa5Z9PATo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2D76571F65;
	Fri,  7 Mar 2014 16:49:09 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C754971F5E;
	Fri,  7 Mar 2014 16:49:07 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 4F41F8EE-A642-11E3-8806-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243631>

Christian Couder <chriscool@tuxfamily.org> writes:

> * many style fixes

This round is readable ;-)  Thanks.

> * clearer and nicer setup tests

Those long lines that use "printf" with many embedded \n were harder
to read and also looked harder to maintain if we ever wanted to
change them.  Splicing a string with \n in the middle of a long
single line is far harder than adding an independent line, I would
think.  For example:

	... &&
	printf "Fixes: \nAcked-by= \nReviewed-by: \nSigned-off-by: \n" >>expected &&
	...

is easier to read and maintain if written like so (with using HT
properly---our MUAs may damage it and turn the indentation into
spaces):

	... &&
	sed -e "s/ Z$/ /" >>expect <<-\EOF &&
        Fixes: Z
        Acked-by= Z
        Reviewed-by: Z
        Signed-off-by: Z
	EOF
	...
