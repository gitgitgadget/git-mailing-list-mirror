From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Jan 2010, #01; Mon, 04)
Date: Tue, 05 Jan 2010 23:47:53 -0800
Message-ID: <7vzl4r7jyu.fsf@alter.siamese.dyndns.org>
References: <7vljgei7rs.fsf@alter.siamese.dyndns.org>
 <4B421766.4040506@kdbg.org> <7vhbr1bagk.fsf@alter.siamese.dyndns.org>
 <4B43A5CA.7090104@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Wed Jan 06 08:48:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NSQco-0004wd-Aq
	for gcvg-git-2@lo.gmane.org; Wed, 06 Jan 2010 08:48:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754477Ab0AFHsJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Jan 2010 02:48:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754246Ab0AFHsI
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Jan 2010 02:48:08 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:41432 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750910Ab0AFHsG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jan 2010 02:48:06 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id E92C7ADB25;
	Wed,  6 Jan 2010 02:48:00 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=DVLJa/ciQf1HBX7fcHom6ptW7+g=; b=vfoLP0
	KalrtSnifyyyhNJz676rjKzgLz9rYFlDqGFgJ02o2GrhnCW+7Gr/Aoc6N2hKemcU
	Sf2LVEuRTDcNW7DijwgTsxRcJl65LTLTd2+I4B0yvH0N6lFLhOd5+meNdepWjwZ9
	JWhr3O1wQfXxrHoXMORVITp1L3UDkFrJOpc44=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=iycYa+yHXsFJfs3pllZseKrjzmJJxO9J
	SPIy1rpfqEqsgEaTjlbYRAQtGAEjOW55ZQTLKUts80uwpqYyhzGsfpgQeBvY4ric
	5baKv5cDV6vLsD91QppX0l9K+Li9wpJenwHn/d07LRp3VfaPNGZfEC+4u6TE6/1r
	X0K99UaJNZ4=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id C6163ADB24;
	Wed,  6 Jan 2010 02:47:58 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id AB53FADB23; Wed,  6 Jan 2010
 02:47:55 -0500 (EST)
In-Reply-To: <4B43A5CA.7090104@kdbg.org> (Johannes Sixt's message of "Tue\,
 05 Jan 2010 21\:49\:14 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: CF01A21A-FA97-11DE-B220-465EBBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136243>

Johannes Sixt <j6t@kdbg.org> writes:

> Junio C Hamano schrieb:
>> While you are technically correct that the change you made in t4030 is not
>> justified by the commit log message in the sense that the "hexdump" script
>> will go through run_command() interface and is not subject to the special
>> rules filter writers need to keep in mind, the patch text itself is a good
>> change, isn't it?
>
> The patch text is good, but since it will not make a difference (and
> there are a ton of other places that use /bin/sh successfully), the
> change is not warrented at this time, IMO.

You are right (and Peff also corrected me).

>> As "run-command: convert simple callsites to use_shell" is the one that
>> changes the filter_buffer(), do you want to have t0021 patch before that
>> one, to prepare the test for the coming change?
>
> Well, the test will break on Windows only after "run-command: optimize
> out useless shell calls", and I wrote the commit message
> accordingly. If you move it before that one (and if you are picky) the
> commit message should be changed as well.

Yeah, I've reworded that one with a phrase "futureproof".

Regarding your "[PATCH 8/6] t4030, t4031", I have two questions:

    Recall that MSYS bash converts POSIX style absolute paths to Windows style
    absolute paths. Unfortunately, it converts a program argument that begins
    with a double-quote and otherwise looks like an absolute POSIX path, but
    in doing so, it strips everything past the second double-quote[*]. This
    case is triggered in the two test scripts. The work-around is to place the
    Windows style path between the quotes to avoid the path conversion.

(1) Does "Windows style path" here mean what $(pwd) returns as opposed to
    what is in $PWD?

(2) The patch reads like this:

-	git config diff.foo.textconv "\"$PWD\""/hexdump &&
+	git config diff.foo.textconv "\"$(pwd)\""/hexdump &&

    Does "strips everything past the second dq" mean "drops '/hexdump'"?
    If so, would this also work (I am not suggesting to change it, just
    asking for information)?

-	git config diff.foo.textconv "\"$PWD\""/hexdump &&
+	git config diff.foo.textconv "\"$PWD/hexdump\"" &&


Thanks.
