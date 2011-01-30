From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] Add --create-cache to repack
Date: Sun, 30 Jan 2011 00:05:35 -0800
Message-ID: <7vk4hmbyuo.fsf@alter.siamese.dyndns.org>
References: <1296201984-24426-1-git-send-email-spearce@spearce.org>
 <4D42878E.2020502@viscovery.net>
 <AANLkTim+AUY9SdeAFfkny2_a3qQ9SCDLUHR3s9Q3M98u@mail.gmail.com>
 <alpine.LFD.2.00.1101281304270.8580@xanadu.home>
 <AANLkTikPcp5CUTWfhy6FYbCEkNG6epGBAMNT5vTfSbvy@mail.gmail.com>
 <alpine.LFD.2.00.1101281502170.8580@xanadu.home>
 <AANLkTi=U7qRRij=BQXC1Goqa9toDFfaVKT=+-8zYxCcc@mail.gmail.com>
 <AANLkTimuW-7D4YA2jeF+y4DPE=CdqtL713MQK+1Gtp-d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@fluxnic.net>,
	Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org,
	John Hawley <warthog19@eaglescrag.net>
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sun Jan 30 09:06:06 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PjSIP-0003IY-8q
	for gcvg-git-2@lo.gmane.org; Sun, 30 Jan 2011 09:06:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751286Ab1A3IFx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Jan 2011 03:05:53 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:58703 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751186Ab1A3IFw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Jan 2011 03:05:52 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id E80712479;
	Sun, 30 Jan 2011 03:06:41 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=m+xlaRTeNa4hudeIZKnOswfNfZQ=; b=YQbE7B
	WaL3mPfA6Lb1ysCLBlnHsSINmGoAjD7HXsSyIQATPbD7fb/7nVjhjFjZbWh0Vji2
	07Y8PEgNG4Y2BH8htQ8I1UOsjJSW7U0DhiJBXd97SMP/LZ45vfItalIdAxYpokIZ
	G37d5DtQ8PUMmOzArMuQyjuo8UWClqTKsak4Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=M980dKHpqfU0qQk55lWPi++Sj7u7PS4E
	vBmMQNF9l9bw+Q5vExnXwK6pop/2SuoiceOnnMPO+UhwqU/NvVd7PMOa5qeVXpjt
	TBxXuB7bwR2D2vhM6MbQexh/cQzMnrTH/RkSSIa33VZD8CaZNXaMo4rsUYsJKNAZ
	FVtT+y3cB1k=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 941EB2478;
	Sun, 30 Jan 2011 03:06:36 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 6714A2474; Sun, 30 Jan 2011
 03:06:29 -0500 (EST)
In-Reply-To: <AANLkTimuW-7D4YA2jeF+y4DPE=CdqtL713MQK+1Gtp-d@mail.gmail.com>
 (Shawn Pearce's message of "Fri\, 28 Jan 2011 18\:34\:13 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: DBF46A9C-2C47-11E0-B838-BC4EF3E828EC-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165681>

Shawn Pearce <spearce@spearce.org> writes:

> Using this for object enumeration shaves almost 1 minute off server
> packing time; the clone dropped from 3m28s to 2m29s.  That is close to
> what I was getting with the cached pack idea, but the network transfer
> stayed the small 376 MiB.

I like this result.

The amount of transfer being that small was something I didn't quite
expect, though.  Doesn't it indicate that our pathname based object
clustering heuristics is not as effective as we hoped?
