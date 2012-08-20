From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC 1/5] GSOC: prepare svndump for branch detection
Date: Sun, 19 Aug 2012 23:57:23 -0700
Message-ID: <7v7gsum4oc.fsf@alter.siamese.dyndns.org>
References: <1345236010-1648-1-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <CACPE+fvkTNNHXbFTwhoH7=aQKoc9YqtfTBOkJDugUogni0sYww@mail.gmail.com>
 <5679616.CtEd2rlvlO@flomedio>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Michael Barr <b@rr-dav.id.au>, git@vger.kernel.org,
	Jonathan Nieder <jrnieder@gmail.com>
To: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 20 08:57:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T3LvX-0001a3-NT
	for gcvg-git-2@plane.gmane.org; Mon, 20 Aug 2012 08:57:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755303Ab2HTG51 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Aug 2012 02:57:27 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33086 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755014Ab2HTG5Z (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Aug 2012 02:57:25 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5603E4C11;
	Mon, 20 Aug 2012 02:57:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=AW5T4+E1z9s8+C7UsYVHh3gy4WE=; b=T9c2Hp
	gPu6i6D4GMTjCWU5gqiicu9VxY+IX2DPkUm5gopzlA4LEtMkbXQ8txsOcjpxzmPY
	n4IwZQmXFWjTqubc8RBTaXBH9MyCEUKc1BK5x+CN0HQihjscFUOSk5K2Km8bevib
	2tle8Qk7ONESAEDslgrzVkmcdYPqZCTz80wRc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ZYEFb/j7gwkSYO3yMKexsp1nL5+yoKEU
	Rrbx77Eb9/rvwnb7ycRq2v0xAt91C5KLA56+DqrAMUhoBme4o+Ia7vUOtTCMWLG/
	Mgr5ceMe/nvmhI7YaQP9NS4hu+lYL3WE+rf5jaG811dJ9N0GGMJEkmWaPnhPTQ6o
	8TShSBSMy+A=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 42C424C10;
	Mon, 20 Aug 2012 02:57:25 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 96D4A4C0F; Mon, 20 Aug 2012
 02:57:24 -0400 (EDT)
In-Reply-To: <5679616.CtEd2rlvlO@flomedio> (Florian Achleitner's message of
 "Sun, 19 Aug 2012 23:26:04 -0700 (PDT)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4BD6EA4A-EA94-11E1-9297-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203762>

Florian Achleitner <florian.achleitner.2.6.31@gmail.com> writes:

>> This change makes me uncomfortable.
>> We are doubling up on hashing with fast-import.
>> This introduces git-specific logic into vcs-svn.

IIUC, vcs-svn/fast-export is meant to produce a stream in the
fast-import format, and that format is meant to be VCS agnostic,
it would need a careful thinking to add anything Git specific to
it.  If you make other people's importers unable to read from you
because you tell them the contents of blob in Git's terms, that is
not very good.

> You have two choices of referencing that blobs later, by using a mark, or by 
> giving their sha1. Marks are already used for marking commits, and there is
> only one "mark namespace". So I couldn't use marks to reference the blobs in  
> a nice way. This allows for referencing them by their sha1.

Surely you can, by using even and odd numbers (or modulo 4 if you
may later want to mark trees and tags as well, but I doubt that is
needed), no?
