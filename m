From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git stash data loss
Date: Fri, 14 Sep 2012 16:04:03 -0700
Message-ID: <7vtxv01a1o.fsf@alter.siamese.dyndns.org>
References: <55831343358368@web1e.yandex.ru>
 <20120727132953.GA8263@sigill.intra.peff.net>
 <20120727135051.GA10303@sigill.intra.peff.net>
 <7vy5lew5xz.fsf@alter.siamese.dyndns.org>
 <20120821065527.GC3238@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Aleksandr Pryimak <tramsmm-mirror@yandex.ru>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Sep 15 01:04:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TCevu-0000WZ-AX
	for gcvg-git-2@plane.gmane.org; Sat, 15 Sep 2012 01:04:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760130Ab2INXEI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Sep 2012 19:04:08 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52454 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752155Ab2INXEG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Sep 2012 19:04:06 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 036108502;
	Fri, 14 Sep 2012 19:04:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=P5pTF7moNokhA2mbXM8SHa+M58E=; b=EibHbY
	2cYru52Y+2WiAo4EspRNzagYJvbYTr16HadJl7SSTkG5UGt8axPHYEk4wxoZVwzw
	3gjSKK86IuM2vtpcjKbstlNK4fAa8slUQ2+BDeJMwUdTl2qtjMDrY7HgHOf34J8F
	CLC3/HPlv8+zda4sf1K5uUtp8qaKEUOnY3mFA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Ir1H3y2X5I7uY8K6WDxImrwp4oBL6bEO
	bUkhoPCLr6GCkPgbdv0ymeLf0mGr1YUoUGEharzUlXiL9p38IV/aDvwB7KXRncQ4
	x7AGq/XkK3FrVCDUnDTjIyyTsQOj6eWuxXH6teGcVrzI3Xsr0LYKvkQVmJmbne4w
	2bO3yN4uBpw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CBC0284FF;
	Fri, 14 Sep 2012 19:04:05 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4434684FD; Fri, 14 Sep 2012
 19:04:05 -0400 (EDT)
In-Reply-To: <20120821065527.GC3238@sigill.intra.peff.net> (Jeff King's
 message of "Tue, 21 Aug 2012 02:55:27 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7B412454-FEC0-11E1-A412-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205540>

Jeff King <peff@peff.net> writes:

>> > Hrm. The problem is that after creating the stash, we then run "git
>> > reset --hard" to drop the changes that we just stashed. But that is not
>> > always accurate. It will not usually touch untracked files, but it might
>> > if they have D/F conflicts with tracked files. So we need to replace
>> > that "git reset --hard" with some safer command that will notice we are
>> > about to overwrite untracked files. But I am not sure what that command
>> > would be.
>> 
>> Is this something we still want to keep track of?
>
> Yeah, I think it is worth fixing. It's a somewhat rare case, but data
> loss is bad. I was hoping you would respond with "...and here is the
> magical incantation of git commands to make the working directory look
> like we want". I couldn't come up with one. We may need a new option to
> reset or read-tree.

ls-files has an ancient option to show the files "killed"; perhaps
that is the closest thing to what you are looking for.
