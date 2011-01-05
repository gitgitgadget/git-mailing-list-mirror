From: Junio C Hamano <gitster@pobox.com>
Subject: Re: concurrent fetches to update same mirror
Date: Wed, 05 Jan 2011 15:29:47 -0800
Message-ID: <7vbp3vc4k4.fsf@alter.siamese.dyndns.org>
References: <ig2kjt$f2u$1@dough.gmane.org>
 <20110105204738.GA7629@sigill.intra.peff.net>
 <AANLkTini61q+NtDr6oytTcfA6QNGN74L60exdLrNmakd@mail.gmail.com>
 <20110105205324.GA7808@sigill.intra.peff.net>
 <20110105211313.GB7808@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Shawn Pearce <spearce@spearce.org>,
	Neal Kreitzinger <neal@rsss.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jan 06 00:30:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PacoK-0002zA-QN
	for gcvg-git-2@lo.gmane.org; Thu, 06 Jan 2011 00:30:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753081Ab1AEXa2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Jan 2011 18:30:28 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:62938 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752923Ab1AEXa1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Jan 2011 18:30:27 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 5250A4FD9;
	Wed,  5 Jan 2011 18:31:04 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=wuSc5/AAwPT6kZllEP3Lpumn5rM=; b=grWJJv
	1oadMacmoOlS9ZuBebBSdQSevs5gi1KjwSL61421bMD983WWH77bdt1CeU6WfdP+
	KkVFLaSBnAdHWuXa9NpMud9Pbp2sMcgXFCXZcnLh3/3qkjUYTEJ7u4DwXJBg2dwW
	ooucLxXBvUkrDTthJJalCnMqN/Ilg1Ba2lRuo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=a3JNXwz2OHglwOLqS8xMxTImWkneeRIB
	1tBk2QCQsuBnzHpTz5iTcVozIflaSHbW+cM9kJ3HyW32NTuEQ3JaPDjIZuYVoCEi
	oM0SmaAhGxqQgATT9GJEZthQ5GsnKrPGp8LQpgBbmVJusJIgI/lE4nwNgkJhF4vS
	nMPFZrpBHTo=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 11A5A4FD6;
	Wed,  5 Jan 2011 18:31:00 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id E72C94FC5; Wed,  5 Jan 2011
 18:30:27 -0500 (EST)
In-Reply-To: <20110105211313.GB7808@sigill.intra.peff.net> (Jeff King's
 message of "Wed\, 5 Jan 2011 16\:13\:14 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: D6B50B7C-1923-11E0-884D-CBB45B885003-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164609>

Jeff King <peff@peff.net> writes:

> Interestingly, in the case of ref _creation_, not update, like this:
>
>   mkdir repo && cd repo && git init
>   git remote add origin some-remote-repo-that-takes-a-few-seconds
>   xterm -e 'git fetch -v; read' & xterm -e 'git fetch -v; read'
>
> then both will happily update, the second one overwriting the results of
> the first. It seems in the case of locking a ref which previously didn't
> exist, we don't enforce that it still doesn't exist.

We probably should, especially when there is no --force or +prefix is
involved.
