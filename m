From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 04/19] index-helper: new daemon for caching index and related stuff
Date: Wed, 09 Mar 2016 15:21:01 -0800
Message-ID: <xmqqpov3fdb6.fsf@gitster.mtv.corp.google.com>
References: <1457548582-28302-1-git-send-email-dturner@twopensource.com>
	<1457548582-28302-5-git-send-email-dturner@twopensource.com>
	<xmqqtwkffdus.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, pclouds@gmail.com
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Thu Mar 10 00:21:26 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1adnPx-0003LC-Pf
	for gcvg-git-2@plane.gmane.org; Thu, 10 Mar 2016 00:21:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965202AbcCIXVM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 9 Mar 2016 18:21:12 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:52742 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S964993AbcCIXVE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 9 Mar 2016 18:21:04 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 973A04A6A5;
	Wed,  9 Mar 2016 18:21:03 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=P7XRRzrFMTOD
	9AzLBEIV6zIBtG8=; b=G65JGwhaVnACJt3F7MkXqbozjE8oHplwa1nP9ddx/Gkq
	zfyZuzDD8jSr60AxEqy0Ol9C5pXkuzyjLYkSXOMIErfgp2iUb8RYSzSvq1Ec0XUt
	DxPSN7QBbHkiCUNzCn0mcOlNUzxCZnrm4Jafuz/AAC+81HNviQzit5FHT8BnM40=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=enaktT
	lwPqH7y1gE2dkeSXlNLI4lpcl2idHz3L60DPzWQc3I2gox0Wvs6N74EcAH2P+9SX
	Br5imA0k1MFvpLXFfzw4oV2eWzOUsfi2aQVOz7XwQPuupn/sElc+Ul3ebiv3lfsP
	SmWkfbG2ePF2E4PFPYLgij06J0Dxi3i8ObfV4=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 8DFCD4A6A4;
	Wed,  9 Mar 2016 18:21:03 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 149CB4A6A2;
	Wed,  9 Mar 2016 18:21:03 -0500 (EST)
In-Reply-To: <xmqqtwkffdus.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Wed, 09 Mar 2016 15:09:15 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 975C7922-E64D-11E5-8818-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288582>

Junio C Hamano <gitster@pobox.com> writes:

> David Turner <dturner@twopensource.com> writes:
>
>> From: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>
>>
>> Instead of reading the index from disk and worrying about disk
>> corruption, the index is cached in memory (memory bit-flips happen
>> too, but hopefully less often). The result is faster read. Read time
>> is reduced by 70%.
>>
>> The biggest gain is not having to verify the trailing SHA-1, which
>> takes lots of time especially on large index files.

Come to think of it, wouldn't it be far less intrusive change to
just put the index on a ramdisk and skip the trailing SHA-1
verification, to obtain a similar result with the same trade off
(i.e. blindly trusting memory instead of being paranoid)?

=20
