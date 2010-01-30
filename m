From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] fast-import: Stream very large blobs directly to pack
Date: Fri, 29 Jan 2010 22:19:42 -0800
Message-ID: <7vmxzw15dt.fsf@alter.siamese.dyndns.org>
References: <20100129012350.GD20488@spearce.org>
 <fabb9a1e1001291035l5cd09cb6q1f12037f96dce8a1@mail.gmail.com>
 <20100129183705.GB22101@spearce.org>
 <7vockc45ut.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sverre Rabbelier <srabbelier@gmail.com>, git <git@vger.kernel.org>,
	Nicolas Pitre <nico@fluxnic.net>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat Jan 30 07:20:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nb6ga-0005g7-O5
	for gcvg-git-2@lo.gmane.org; Sat, 30 Jan 2010 07:20:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751095Ab0A3GT4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Jan 2010 01:19:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751027Ab0A3GTz
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Jan 2010 01:19:55 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:61015 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750847Ab0A3GTz (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jan 2010 01:19:55 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 4042395753;
	Sat, 30 Jan 2010 01:19:53 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5uHRfbyMkC1gNIShJVjyxP1Oog4=; b=T+z0Tc
	Pukpmk+zXMcUXOqBXthhJ3w16GIYeMFNqSHshFHQC/2/0+hYt8NPEW42/iiLKUtF
	ZWY/va0LBRrx8davtp52koI2G29EiOtH5AK74rYjeTJOvVH+Pf9U8qgi4es2rVOx
	PsG8bQJYdTCduSZ52vk8hlGFcALFa76mxuBFw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=kDI9GM2KSX7h3FPdAdv7ynJ0KnVqd+fG
	uI2YC6jvtOalh/S0HIIOkhhVtVXV1eclv+LWWTe6iaRY8S97rxK1uCAmfcZejvH5
	KBohjR4uQ7CSccdeFnVryaKk3NawayPk9YoGJ4ZJsiP1n1CHTzL01zH+C5QvRXk1
	jx+sf4PnPkU=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id F3BD89574F;
	Sat, 30 Jan 2010 01:19:48 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1A5D69574D; Sat, 30 Jan
 2010 01:19:43 -0500 (EST)
In-Reply-To: <7vockc45ut.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Fri\, 29 Jan 2010 19\:41\:14 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 77F3F33C-0D67-11DF-8589-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138453>

Junio C Hamano <gitster@pobox.com> writes:

> "Shawn O. Pearce" <spearce@spearce.org> writes:
>
>> I was intentionally slating this for maint, to fix a bug a user
>> reported when handling large streams.
>
> I personally see that as adding a new feature (especially with new option
> and config).

Sorry, but I take it back.  The new codepath triggers even without any
explicit request and _fixes_ the situation where old code simply failed,
so it is worth queuing for the maintenance track.

Do you want to do the deflatebound thing, or are we Ok without?
