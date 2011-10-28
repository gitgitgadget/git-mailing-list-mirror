From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] define the way new representation types are encoded
 in the pack
Date: Fri, 28 Oct 2011 08:24:15 -0700
Message-ID: <7vsjmdta00.fsf@alter.siamese.dyndns.org>
References: <7v62j9veh3.fsf@alter.siamese.dyndns.org>
 <m3wrbp44kr.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Nicolas Pitre <nico@fluxnic.net>,
	"Shawn O. Pearce" <spearce@spearce.org>, Jeff King <peff@peff.net>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 28 17:24:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RJoIF-0002xc-BZ
	for gcvg-git-2@lo.gmane.org; Fri, 28 Oct 2011 17:24:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932418Ab1J1PYX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Oct 2011 11:24:23 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48896 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932381Ab1J1PYW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Oct 2011 11:24:22 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5C8E052E3;
	Fri, 28 Oct 2011 11:24:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=UvWy0tbmQd3Kpwa+Ju/JrA3SAlA=; b=Zxs/Th
	zKxjF5V8gyXVRPHFRGMvC9VoOb2FtDETZ+7Lw+xSHOV5VtVXd7vQB6w0uVYGAwTF
	eMTtzpgdSna3xeRd1bMQO+RtIqHdYXHBgsLwn/Sh6RinShtgYmNf6oxAtC3FN1bp
	fJ1lL/pblRQOnGHjUKRcf/0xcXO7WnokCDneA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=FgHbKtJ7MF76DUU0m9JW8zRg3QIZOzkO
	H1o3VgtZattYT/6bPnxGzqDs+MvwsSdZnVBOobe6IAB3ZMD6Ma6AMxNPoeXaDrSI
	zr9qfFROWjBgZdmRXmR2uyKtkaLylXjIjiVat+cHmqoGtNuXljisqbhU2TQ+UJ0U
	KHtz3YofvgI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5455952E2;
	Fri, 28 Oct 2011 11:24:21 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D3C3552DF; Fri, 28 Oct 2011
 11:24:20 -0400 (EDT)
In-Reply-To: <m3wrbp44kr.fsf@localhost.localdomain> (Jakub Narebski's message
 of "Fri, 28 Oct 2011 06:41:57 -0700 (PDT)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E8AAAC86-0178-11E1-B0DB-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184411>

Jakub Narebski <jnareb@gmail.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> When bit 4-6 encodes type 5, the first byte is used this way:
>> 
>>  - Bit 0-3 denotes the real "extended" representation type. Because types
>>    0-7 can already be encoded without using the extended format, we can
>>    offset the type by 8 (i.e. if bit 0-3 says 3, it means representation
>>    type 11 = 3 + 8);
>
> Why not use third byte for that instead?

Is it a good enough reason that there is no upside for doing so?
