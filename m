From: Junio C Hamano <gitster@pobox.com>
Subject: Re: bug? 'git log -M100' is different from 'git log -M100%'
Date: Mon, 17 Dec 2012 17:25:28 -0800
Message-ID: <7vfw34jgmv.fsf@alter.siamese.dyndns.org>
References: <20121217233446.GA5987@sita-lt.atc.tcs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Sitaram Chamarty <sitaramc@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 18 02:25:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TklwL-0003w4-4i
	for gcvg-git-2@plane.gmane.org; Tue, 18 Dec 2012 02:25:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753532Ab2LRBZb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Dec 2012 20:25:31 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47880 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752817Ab2LRBZb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Dec 2012 20:25:31 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 53CE1AFF5;
	Mon, 17 Dec 2012 20:25:30 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=2l8ofa4dTZbR680gz44p1omfkwY=; b=ph64m1
	xBCz7OjvVt2ZCGAoBS3yDRAZu0R/EHuIAHXlDs0nTolBteB+dnYbntUfe68ByZKq
	saz8fx0V5DuKL9CLpnPvNiad4xMmck/cny4fbVMD8DBFmSZiH1f2DROZatBSvzIu
	Mm8dntsY4KBRtrrL9xmYoCJ308EY4MRmapnBI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=pufOgAtKS1BdDqaCpCkZRWahK2+Voxd1
	GVibidW5QU/vWd7NPbxnlAqIJVkF777h7U8CyE8bniFgioqY4GtK0/UWdBOHfRk0
	2R7qwEP1ebQquZPoLpWSj5lrIWTJeISSuAff+XKEYBCTrLZAyX+PDyRllGtUzKpe
	0QwawZ5JZio=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 419F9AFF4;
	Mon, 17 Dec 2012 20:25:30 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AB363AFF3; Mon, 17 Dec 2012
 20:25:29 -0500 (EST)
In-Reply-To: <20121217233446.GA5987@sita-lt.atc.tcs.com> (Sitaram Chamarty's
 message of "Tue, 18 Dec 2012 05:04:46 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: CF31AB5C-48B1-11E2-9E37-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211725>

Sitaram Chamarty <sitaramc@gmail.com> writes:

> When using -M with a number to act as a threshold for declaring
> a change as being a rename, I found a... quirk.  Any 2-digit
> number after the M will work,...

That is not 2-digit number.

A few historical trivia may help.

Originally we said "you can use -M2 to choose 2/10" (like "gzip"
taking compression levels between "-0" to "-9").  Then Linus came up
with a clever idea to let people specify arbitrary precision by
letting you say "-M25" to mean 25/100 and "-M254" to mean 254/1000.

Read the numbers without per-cent as if it has decimal point before
it (i.e. -M005 is talking about 0.005 which is 0.5%).  Full hundred
per-cent has to be spelled with per-cent sign for obvious reasons
with this scheme but that cannot be avoided.  It is a special case.
