From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC v2 08/16] Make in-memory format aware of stat_crc
Date: Sun, 05 Aug 2012 18:46:51 -0700
Message-ID: <7vobmo23n8.fsf@alter.siamese.dyndns.org>
References: <1344203353-2819-1-git-send-email-t.gummerer@gmail.com>
 <1344203353-2819-9-git-send-email-t.gummerer@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, trast@student.ethz.ch, mhagger@alum.mit.edu,
	pcouds@gmail.com, robin.rosenberg@dewire.com
To: Thomas Gummerer <t.gummerer@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 06 03:47:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SyCPM-0003xj-Pk
	for gcvg-git-2@plane.gmane.org; Mon, 06 Aug 2012 03:47:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755430Ab2HFBq4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Aug 2012 21:46:56 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33753 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755286Ab2HFBqz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Aug 2012 21:46:55 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3B9058F10;
	Sun,  5 Aug 2012 21:46:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=NtfltfTkMI21mOExjVycp4+LTAM=; b=AIV54u
	Ihha/YP93pcwvXBnJmrU4DyQbrP/XtkovH4wFTF3RXKXD6AlZEwWXCFcUpIwdPY+
	lGpTDVF96S+i/+vuIx6lZ98Ume4LA9mMPFU0HZJukkC3ksSYI8+qmNdOQn/puOUs
	mVQ3GIkvKgnyfxbvMRmcIkA6tNKnXPb7gdy0c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=tl7PQhMBmHUs0XXe0HVU5VArd9p2c5Rm
	Exgg67TQ5DP8VtPJgU1orZk7kmniL2jSW6JIOfX46u559XR5ivF2J0dm7f6sbNbV
	5eRSKIvvUZxaeE10PsMVWx2JiVZsCjwmxT14p8PCITqDzBT6Di9F7uFrHRjrpWaX
	bWFFvstSY6M=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 27CD58F0E;
	Sun,  5 Aug 2012 21:46:55 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 30FED8F0B; Sun,  5 Aug 2012
 21:46:54 -0400 (EDT)
In-Reply-To: <1344203353-2819-9-git-send-email-t.gummerer@gmail.com> (Thomas
 Gummerer's message of "Sun, 5 Aug 2012 23:49:05 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 998C5144-DF68-11E1-9024-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202948>

Thomas Gummerer <t.gummerer@gmail.com> writes:

> +	stat_crc = crc32(stat_crc, (Bytef*)&stat, 4);
> +	stat = htonl(ce->ce_ino);
> +	stat_crc = crc32(stat_crc, (Bytef*)&stat, 4);
> +	stat = htonl(ce->ce_size);
> +	stat_crc = crc32(stat_crc, (Bytef*)&stat, 4);
> +	stat = htonl(ce->ce_dev);
> +	stat_crc = crc32(stat_crc, (Bytef*)&stat, 4);
> +	stat = htonl(ce->ce_uid);
> +	stat_crc = crc32(stat_crc, (Bytef*)&stat, 4);
> +	stat = htonl(ce->ce_gid);
> +	stat_crc = crc32(stat_crc, (Bytef*)&stat, 4);
> +	return stat_crc;

What are these (Bytef *) casts are about?  We do not use it in any
of our existing calls to crc32().
