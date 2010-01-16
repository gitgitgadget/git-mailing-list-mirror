From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 8/9] gitweb: Convert output to using indirect file handle
Date: Fri, 15 Jan 2010 17:41:37 -0800
Message-ID: <7v8wbyn7vy.fsf@alter.siamese.dyndns.org>
References: <1263432185-21334-1-git-send-email-warthog9@eaglescrag.net>
 <m3ljfydgmt.fsf@localhost.localdomain>
 <7vmy0eoogx.fsf@alter.siamese.dyndns.org>
 <201001160214.58167.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "John 'Warthog9' Hawley" <warthog9@eaglescrag.net>,
	git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 16 02:41:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NVxfl-0000sE-W7
	for gcvg-git-2@lo.gmane.org; Sat, 16 Jan 2010 02:41:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758665Ab0APBlu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jan 2010 20:41:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758664Ab0APBlu
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Jan 2010 20:41:50 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:59014 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758372Ab0APBlt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jan 2010 20:41:49 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id DE4CE9169E;
	Fri, 15 Jan 2010 20:41:45 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=cV+E8sNAx1CHXx8FJoogxzNdGW8=; b=wqaiAj
	lGHgxB4KHeSsVlSeqk2wVg3ht6ooXQJnerexZuom2SNVaqXx9yVMok3t3aXBQ81j
	Gs3HH/zB5RXWSfed67FLP/U0x/17hK4NwcFoF01hMisli/JKR8LnoeRQKQz1VJBK
	n2VTq51Ba0ElCzUEZda5kA16Hik08i0s4K4gA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=AuzwMmmjIWvrpPx+IEGkGDzUmPwQKE8D
	Q+c9Ob3jL2RDLmkf+5Ib9kZDhkjlzyoRjLbBOhI/ackK1R7n9/2I+4rfxsPTo8eD
	ZTD022LqLfFDKrI2jtbkRaoE/4GdMim8h9+gLyDGjIR2zmJRlOiNXG2+IdDWrL9B
	L8Zk7BfFgIc=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id ABB9C9169D;
	Fri, 15 Jan 2010 20:41:42 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D94B591699; Fri, 15 Jan
 2010 20:41:38 -0500 (EST)
In-Reply-To: <201001160214.58167.jnareb@gmail.com> (Jakub Narebski's message
 of "Sat\, 16 Jan 2010 02\:14\:55 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 4C5D045C-0240-11DF-B40C-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137190>

Jakub Narebski <jnareb@gmail.com> writes:

> I have thought however (but I might be mistaken) that "print {$fh} <sth>"
> is idiomatic Perl.
>
> 'perldoc -f print' says:
>     Note that if you're storing FILEHANDLES in an array or other expression,
>     you will have to use a block returning its value instead:

Note that "in an array or other expression".  I've always thought the
intention of this phrase was "you _could_ help the parser by doing this,
if you have expression more complex than a simple scalar variable
reference".

IOW, I know that {} _can_ be used there, but I haven't seen people write
{$a_single_variable}, especially without a space around the "expression"
(technically, a single variable is an expression), when

	print $fh <stuff>

suffices, and I was curious why you chose to use the syntax when it wasn't
necessary.  Besides, {$fh} looks so eh... (hesitates to mention a dirty
word ^W^W^Wthe name of a different language, but bleeps it out)...
