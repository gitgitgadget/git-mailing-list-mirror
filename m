From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-send-email: handle email address with quoted comma
Date: Sat, 20 Dec 2008 12:09:44 -0800
Message-ID: <7v3agiwquv.fsf@gitster.siamese.dyndns.org>
References: <1229658012-9240-1-git-send-email-fengguang.wu@intel.com>
 <7vej04d5wy.fsf@gitster.siamese.dyndns.org>
 <20081219081010.GA12494@localhost> <loom.20081219T162504-25@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Matt Kraai <kraai@ftbfs.org>
X-From: git-owner@vger.kernel.org Sat Dec 20 21:11:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LE8AM-0001sA-4H
	for gcvg-git-2@gmane.org; Sat, 20 Dec 2008 21:11:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753348AbYLTUJv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Dec 2008 15:09:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753345AbYLTUJu
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Dec 2008 15:09:50 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:36445 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753318AbYLTUJu (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Dec 2008 15:09:50 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id C45C61ABD1;
	Sat, 20 Dec 2008 15:09:49 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 5477F1AB81; Sat,
 20 Dec 2008 15:09:45 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 27D83C34-CED2-11DD-97B9-F83E113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103662>

Matt Kraai <kraai@ftbfs.org> writes:

> Howdy,
>
> Wu Fengguang <fengguang.wu <at> intel.com> writes:
>> +sub split_addrs {
>> +	return parse_line('\s*,\s*', 1, @_);
>> +}
>> +
>
> I'm not sure it's still a good idea to use parse_line.  It should work OK for
> now, since split_addrs is only passed one string.  If anyone ever tries to pass
> it a list of strings, however, parse_line will ignore all but the first.

Yikes, I should have caught this.  As you point out, this is a breakage
waiting to happen until somebody restructures the callers.  We should
futureproof it by using quotewords() instead.
