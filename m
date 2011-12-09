From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/7] refactor git_getpass into generic prompt function
Date: Fri, 09 Dec 2011 15:58:06 -0800
Message-ID: <7vzkf1b8mp.fsf@alter.siamese.dyndns.org>
References: <20111208082118.GA1507@sigill.intra.peff.net>
 <20111208083133.GD26409@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Erik Faye-Lund <kusmabite@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Dec 10 00:58:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RZAKV-0001Uu-1Y
	for gcvg-git-2@lo.gmane.org; Sat, 10 Dec 2011 00:58:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755135Ab1LIX6L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Dec 2011 18:58:11 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44846 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755076Ab1LIX6I (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Dec 2011 18:58:08 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 27FBD6C6D;
	Fri,  9 Dec 2011 18:58:08 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=fyxkjpcZS6ef4ZPEBKgBYm824X4=; b=Ink6VL9v//0+46fugOJX
	GvJBXNLzzefgTiN7kKBmzmsFz3ISuNwdCuLWF587/mbwVaFgufhn8CnUmt+U2BIF
	3t6PA7/bq5878SCVyCxK64wl4u4S5/yNmCirJYljaZiZoPvQpGbCmFFSvAv0yFMe
	LOUWPfm7R6NeIKcTHlyUbY8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=TNbCnenXsdz6T8qqPuuBuCz918IObChdeP/p9pqktygwrz
	KKU+8ddlCHJnZBWDg5re9hbNt3hyluLeeAEAkwkOSrO/n3r3cr2FR29vsI83EjTn
	kkWwIc5OPMPKN8yliDrIue/6X/9W3pfiJpjgcRQe0/psARnk7vgv+4Opnm+jM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1FCED6C6C;
	Fri,  9 Dec 2011 18:58:08 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A3C4D6C69; Fri,  9 Dec 2011
 18:58:07 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A4354CAE-22C1-11E1-AC77-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186712>

Jeff King <peff@peff.net> writes:

>  2. The first series had a special "name" parameter just for generating
>     error messages. This drops it in the name of simplicity, so error
>     messages have gone from (assuming you don't have a tty):
>
>       Could not read password: No such device or address
>
>     to:
>
>       Could not read 'Username for 'https://example.com': ': No such
>       device or address
>
>     which is verbose, yes, but contains a little more useful
>     information. The formatting is rather unfortunate,...

It also would be unpleasant to i18n it, I suspect. 

> +	r = getpass(prompt);
> +	if (!r)
> +		die_errno("could not read '%s'", prompt);

Taking advantage of the "prompt-string"-ness of the message, this might be
a cuter workaround:

    fatal: Password: <<could not be read>>

But I do not think it matters that much. Let's queue what you have, and
work out these details in-tree.
