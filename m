From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/4] describe: use argv-array
Date: Tue, 09 Jul 2013 07:55:13 -0700
Message-ID: <7vip0jwzou.fsf@alter.siamese.dyndns.org>
References: <1373236424-25617-1-git-send-email-gitster@pobox.com>
	<1373236424-25617-4-git-send-email-gitster@pobox.com>
	<20130709045151.GE27903@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jul 09 16:55:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UwZKG-0006St-3H
	for gcvg-git-2@plane.gmane.org; Tue, 09 Jul 2013 16:55:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754085Ab3GIOz2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Jul 2013 10:55:28 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51207 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753864Ab3GIOz0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jul 2013 10:55:26 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B93C92E995;
	Tue,  9 Jul 2013 14:55:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=csWmQ2VF/dPQ1BZMSCvWTwAcNnE=; b=M558xg
	z+th+Enc75rmY63KxKZVqz7XFD+vqW9VuLAEE1HQRtHDV2xfoYyrFG1q4JDYuBLH
	QRyDbiNZpBKYOyUbUSW9aq9+pn+qNNejF1rKaExk2pKxdwvGRoVXgKNRPDTDvwMa
	+iumLyFSdE7kk3gQ9rHFx4dZ48ztdDz96yvBc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=VgRiZLlyDi79TZ2NdRoTMnop3TET6bP/
	2CdNku9TLrTndHEwwYo2dH2lb/jc7F2jyRBhkDs37Ck2kX7EqM+nwbH8c3eA2+lI
	HmKVGq+HLJ3fpoNebPwZynXerktL+KLE4kAY4pNgFBHqPLgadfR5aEtyyoTx844I
	06cp8p2pJGU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id ADACB2E994;
	Tue,  9 Jul 2013 14:55:16 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 167232E991;
	Tue,  9 Jul 2013 14:55:16 +0000 (UTC)
In-Reply-To: <20130709045151.GE27903@sigill.intra.peff.net> (Jeff King's
	message of "Tue, 9 Jul 2013 00:51:51 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 90CC31DE-E8A7-11E2-AA09-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229958>

Jeff King <peff@peff.net> writes:

> On Sun, Jul 07, 2013 at 03:33:43PM -0700, Junio C Hamano wrote:
>
>> +		argv_array_init(&args);
>> +		argv_array_push(&args, "name-rev");
>> +		argv_array_push(&args, "--name-only");
>> +		argv_array_push(&args, "--no-undefined");
>> [...]
>> -		memcpy(args + i, argv, argc * sizeof(char *));
>> -		args[i + argc] = NULL;
>> -		return cmd_name_rev(i + argc, args, prefix);
>> +		return cmd_name_rev(args.argc, args.argv, prefix);
>
> This leaks the memory allocated by "args". The original did, too, and it
> is probably not that big a deal (we exit right after anyway). The fix
> would be something like:
>
>   rc = cmd_name_rev(args.argc, args.argv, prefix);
>   argv_array_clear(&args);
>   return rc;

Yes; this was meant as a straight rewrite and I did not bother, but
I should have cleaned it up as I meant to build on top.

Will amend, even though I do not think we need to build anything on
top.
