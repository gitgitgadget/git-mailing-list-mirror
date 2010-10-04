From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 7/7] commit-tree: free commit message before exiting
Date: Sun, 03 Oct 2010 17:31:39 -0700
Message-ID: <7vlj6edcic.fsf@alter.siamese.dyndns.org>
References: <wes62zknmki.fsf@kanis.fr>
 <7v1va760ip.fsf@alter.siamese.dyndns.org> <20100810032647.GA2386@burratino>
 <20101002082752.GA29638@burratino> <20101002084100.GH29638@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 04 02:32:05 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2YyI-0008Ni-9C
	for gcvg-git-2@lo.gmane.org; Mon, 04 Oct 2010 02:32:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751630Ab0JDAbs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Oct 2010 20:31:48 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:49436 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751425Ab0JDAbr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Oct 2010 20:31:47 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 82E4BDB742;
	Sun,  3 Oct 2010 20:31:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=cujnG2WOdzlfoMD7nL/2pGYDDYs=; b=JePoAX
	O0UrFk4T6NDY+BaQUv/Pl51FPu78tzdhKAMKZ3Hi/p12ARvrWV2xxHAYs6I6MlzU
	KtvM+lofy1zYw/MpXV9TeweYBcnEoDk2QUdpeJ1Ez7MM6hZB0vvdxK6h/FB3cJ8K
	ueDH9SuAdRbx21BEY9NX9Fb2Cnmi/ATKVyiGg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=axhYGYkrFhaGzCekghQT1Qb/Cgcrgc8j
	D1iaHII8182icYKqX8CoLL2lnKXT2UUr3S9CblIOf43VmwNvdItxsDEXGR02kWBy
	pyQKatgbo7KyXZIY9BWEIxkOJ49V1clygLIsliq9VQYrgKMoqi+cEcjxpLeaKmU9
	6qgG8CTcFIM=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 5FB2DDB741;
	Sun,  3 Oct 2010 20:31:44 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BF3B5DB740; Sun,  3 Oct
 2010 20:31:41 -0400 (EDT)
In-Reply-To: <20101002084100.GH29638@burratino> (Jonathan Nieder's message of
 "Sat\, 2 Oct 2010 03\:41\:00 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: C3CAAD7E-CF4E-11DF-AE20-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157955>

Jonathan Nieder <jrnieder@gmail.com> writes:

> This buffer is freed by the C runtime when commit-tree exits moments
> later, but freeing it explicitly should hopefully make this code
> easier to reuse (in addition to making valgrind quieter).

I'd agree this is a change in a good direction because it will reduce
false positives from valgrind.  I do not believe it would make it any
easier to reuse, though.  Read what the code does (e.g. calling
git-config, showing usage or dying on sick arguments, etc.).  So I have to
say that the proposed commit log message advertises a benefit that it does
not bring.

By the way, is there an easy and concise way to tell valgrind to

 (1) treat allocations made in main() that are not freed as non-issues;
     and

 (2) treat functions whose name begin with cmd_ as if they are all their
     own main(), and apply the above special casing to them?
