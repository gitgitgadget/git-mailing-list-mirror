From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] Make git selectively and conditionally ignore certain
 stat fields
Date: Sun, 20 Jan 2013 12:30:21 -0800
Message-ID: <7v4niblhr6.fsf@alter.siamese.dyndns.org>
References: <7va9sa6f0h.fsf@alter.siamese.dyndns.org>
 <1999787368.3950248.1358711511739.JavaMail.root@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, j sixt <j.sixt@viscovery.net>,
	Shawn Pearce <spearce@spearce.org>
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Sun Jan 20 21:30:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tx1XV-00034q-3z
	for gcvg-git-2@plane.gmane.org; Sun, 20 Jan 2013 21:30:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752477Ab3ATUa0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Jan 2013 15:30:26 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33303 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752452Ab3ATUaZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Jan 2013 15:30:25 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id ABB00B821;
	Sun, 20 Jan 2013 15:30:24 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=tu72z24aNMVqUfaRHt5YGB59lH8=; b=T2fBhm
	xYQo2hDCSRFLFhFw1481wEPYD5V3zWUuIsoE4VmRJ6STpdt5KOIq/zDLj1Rdw1jx
	NWEbhp5Hi6o3DRDP5ymRlLeUykd0J4axWV6dhYT1DnsppFQum+ncXvqFkuVMX/mj
	eNcJZR7VLcqQD+9fmjwxHOMwdavNG1A8HV57Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=euPcz/xBTs1t8xU2ABQEYuJlAxZgUaxs
	O6kq4YgxhNeh66iVT9Lr3OG7wO+nMDhiPDUR1+uf8cMdGkZhUFxu43PtEgrerZh/
	HIkUKAnqvnAovLazle+J13PFxgjKwct1VQnv5dIg1qyFwrW6VUaUIrMSRSbY5aVZ
	VR61S3mXAWQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9EC96B81E;
	Sun, 20 Jan 2013 15:30:24 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id F3763B816; Sun, 20 Jan 2013
 15:30:22 -0500 (EST)
In-Reply-To: <1999787368.3950248.1358711511739.JavaMail.root@dewire.com>
 (Robin Rosenberg's message of "Sun, 20 Jan 2013 20:51:51 +0100 (CET)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 37D15ECA-6340-11E2-ADC6-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214047>

Robin Rosenberg <robin.rosenberg@dewire.com> writes:

> ----- Ursprungligt meddelande -----
>
>> That configurability is a slipperly slope to drag us into giving
>> users
>> more complexity that does not help them very much, I suspect.
>> 
>> Earlier somebody mentioned "size and mtime is often enough", so I
>> think a single option core.looseStatInfo (substitute "loose" with
>> short, minimum or whatever adjective that is more appropriate---I am
>> not good at picking phrases, it sounds to me a way to more loosely
>> define stat info cleanliness than we usually do) that makes us
>> ignore all fields (regardless of their zero-ness) other than those
>> two fields might not be a bad way to go.
>
> Would something like this be good?
>
> core.statinfo = 
> default = all fields
> minimal = whole seconds of mtime and size
> medium = seconds, nanos of mtime and size
> nonzero = all non-zero fields
>
> -- robin

If you mean to exclude ctime and other fields we already exclude as
useless from your "all", that may make sense, but do we really need
that much "flexibility", or do "more choices" just confuse users? I
have this suspicion that it may be the latter.

Wouldn't a single boolean that lets users choose between your
"minimal" and "default" be sufficient?
