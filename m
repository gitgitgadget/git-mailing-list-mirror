From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] bundle: rewrite builtin to use parse-options
Date: Thu, 08 Dec 2011 15:48:03 -0800
Message-ID: <7viplqhbgs.fsf@alter.siamese.dyndns.org>
References: <1323349817-15737-1-git-send-email-artagnon@gmail.com>
 <1323349817-15737-4-git-send-email-artagnon@gmail.com>
 <20111208163946.GB2394@elie.hsd1.il.comcast.net>
 <CALkWK0mmjKSzSbxq2i7=JvcB4LTro-MYDCwQLUUwqcf8qS0zPA@mail.gmail.com>
 <20111208170319.GD2394@elie.hsd1.il.comcast.net>
 <CALkWK0m89D02aku8J0OXbpyrovHCOpsYS4Qpx2jH-pFG4rOG2A@mail.gmail.com>
 <20111208175913.GK2394@elie.hsd1.il.comcast.net>
 <CALkWK0nCuFgS8PKkQLMzqpBsOWouSs5y=CEKS1r0x0=LkhqC9A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 09 00:48:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RYnhK-00033i-Mr
	for gcvg-git-2@lo.gmane.org; Fri, 09 Dec 2011 00:48:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751782Ab1LHXsI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Dec 2011 18:48:08 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45085 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751260Ab1LHXsH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Dec 2011 18:48:07 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4E85364F2;
	Thu,  8 Dec 2011 18:48:05 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=UegEAiD5+JZ8O9tsTmf7wINPJC4=; b=Us075h
	69EZQ2qd417GYReztKgxEGs2aULXo3XGlprRWMWZsdp1BlyWq7n9nOJafRmXNeeC
	FO33VdxMPlKHGTY5hNHHS9QW6kgXN3j6wtZ67lsy9bBg05Yh3c34McXlPJnEzbW/
	gPDURhTjHQpyhtDg6V5Ieeouhj4UQNm0RkRC8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ZjDBseMYs9n9gilueUrt5oPR3e0HkejT
	8eL4vxFF7gJbxAHqlbkyQHrKoynaDSgs9ppfQYkin8Yon3mN3rPZylG3IY1qULZP
	TBvCNC+vcs+iFuDrLBZkdipF6f9uVCvnJlUxNZdqvkON4ojwZgc8k21i/T65L2u6
	lbNs5dZsPCE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4593964F1;
	Thu,  8 Dec 2011 18:48:05 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CEACC64F0; Thu,  8 Dec 2011
 18:48:04 -0500 (EST)
In-Reply-To: <CALkWK0nCuFgS8PKkQLMzqpBsOWouSs5y=CEKS1r0x0=LkhqC9A@mail.gmail.com>
 (Ramkumar Ramachandra's message of "Fri, 9 Dec 2011 01:09:21 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 127C2A6E-21F7-11E1-AA58-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186600>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> That being said, do you see value in lifting the restriction on
> opts->long_name and PARSE_OPTS_NODASH not allowed together?  The
> restriction seems quite arbitrary, but I can't justify lifting it
> unless I can show some valid usecase.

True and true.

As to the first "true", it is because the nodash was introduced only to
parse "find ... \( ... \)" style parentheses as if they are part of option
sequence, and that use case only needed a single letter.

As to the second "true", it is because so far we didn't need anything
longer.

I do not think the name of a subcommand is not a good use case example for
it, by the way. Unlike parentheses on the command line of "find" that can
come anywhere and there can be more than one, the subcommand must be the
first thing on the command line and only one subcommand is given at one
command invocation.
