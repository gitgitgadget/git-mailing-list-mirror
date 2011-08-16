From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] update-index: add --swap to swap index and worktree
 content
Date: Tue, 16 Aug 2011 14:56:41 -0700
Message-ID: <7vbovpggva.fsf@alter.siamese.dyndns.org>
References: <1313158058-7684-1-git-send-email-pclouds@gmail.com>
 <7vippxgm6y.fsf@alter.siamese.dyndns.org>
 <20110816210108.GA13710@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Aug 16 23:56:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QtRcv-00035D-5K
	for gcvg-git-2@lo.gmane.org; Tue, 16 Aug 2011 23:56:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753086Ab1HPV4o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Aug 2011 17:56:44 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48334 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752826Ab1HPV4o (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Aug 2011 17:56:44 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 306A1519D;
	Tue, 16 Aug 2011 17:56:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=IgbM82d5ndzCIrJRzGrK22P5hM4=; b=hSZTmv
	l1wqcX7OagceOwaAi8ToFJxDIWnFdPgWqGJaf59nVNe9vmXy/g6M5ci7VKa7CnWl
	d/2784tIVcjinFqMoBuO3oAzHO7q1gAciKdpE2xmN4aQzSnM2E6vG1TwB5WBz3f+
	W8toaQ0dme4UiOqo4XWmaCwxUluWG1BVobhws=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rnPW9VDwlm5deGXtM7NmSGYWOr/xb9HO
	82WoRFjncK0LFYb+kks0L99uxjVAJOdopE9QjkYjcGFMlmfiDXiMR8Vgm/8CbJKu
	ChNH1zv/toe4iuH5BuXUAbIQMXjARAMehmJwqTqSZQUYXZTLlkmVtX/zXI554c8M
	m7caO0O5WFs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 26A27519C;
	Tue, 16 Aug 2011 17:56:43 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AE03E519B; Tue, 16 Aug 2011
 17:56:42 -0400 (EDT)
In-Reply-To: <20110816210108.GA13710@sigill.intra.peff.net> (Jeff King's
 message of "Tue, 16 Aug 2011 14:01:08 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A087B4A8-C852-11E0-B88A-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179479>

Jeff King <peff@peff.net> writes:

>   # add some content with an error
>   echo 'printf("hello word!\n")' >hello.c
>   git add hello.c
>
>   # work on it more, realizing the error
>   echo 'printf("goodbye world!\n") >hello.c
>
>   # now what? you want to stage the s/word/world/ fixup,
>   # but you want to keep the hello/goodbye thing as a separate change.
>   # Using anything line-based is going to conflate the two.
>   # The change is simple, though, so you can just as easily edit the
>   # index file, if only you could get to it. So you do:
>   git update-index --swap hello.c
>   sed -i s/word/world/ hello.c
>   git update-index --swap hello.c
>
> So the swap really functions as a toggle of "I would like to work on
> the index version for a minute", and then you toggle back when you're
> done.

And you have to redo what you did to the index version in the working tree
after the second "swap", no?
