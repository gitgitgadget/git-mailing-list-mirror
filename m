From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-new-workdir: Don't fail if the target directory is empty
Date: Tue, 18 Nov 2014 11:32:38 -0800
Message-ID: <xmqq8uj8wbhl.fsf@gitster.dls.corp.google.com>
References: <1416073760.9305.174.camel@homebase>
	<xmqqy4r9yc5u.fsf@gitster.dls.corp.google.com>
	<s934mtwo0zv.fsf@mad-scientist.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Paul Smith <paul@mad-scientist.net>
X-From: git-owner@vger.kernel.org Tue Nov 18 20:32:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XqoW5-0003Yr-Ux
	for gcvg-git-2@plane.gmane.org; Tue, 18 Nov 2014 20:32:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754131AbaKRTcm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Nov 2014 14:32:42 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:58130 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753829AbaKRTcl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Nov 2014 14:32:41 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 2E55D1DD29;
	Tue, 18 Nov 2014 14:32:42 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ptOizAX5+j2Dy7mhjLiymGBMBMY=; b=SRpfNB
	byvIVmtjf3Rw5kStv2T3AyKc7iWfIcjVAl4o4ZXd1mSicSyACLMs0meSYcpuEji9
	cEFth5DDkzw+0jRowY2OiWQ2BOTyn2hlaYv2qTLotfj1XhCiZWcI1GQavldPDFsJ
	7E6vdIqtPdt3gVMXkesR4C51wwDvmLDnzFcC8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Zv8Lu+scxirH8i0nYqparQr4smbrSYnR
	hECj8kMAp1oCy5X7bmA9WgPDZnEwL3YwrShx+u4bT3h4uLqqF830iHkuBTfYezQG
	koBVoh3MttxxJ2i5rR17VQCXjd80awhTqVSxc6FmpX64/d6cf1rSG4W+3Az6UpGA
	UDcT72RYA8k=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 253C31DD28;
	Tue, 18 Nov 2014 14:32:42 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 97A0B1DD26;
	Tue, 18 Nov 2014 14:32:41 -0500 (EST)
In-Reply-To: <s934mtwo0zv.fsf@mad-scientist.net> (Paul Smith's message of
	"Tue, 18 Nov 2014 12:46:28 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: A99C4D18-6F59-11E4-A285-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Paul Smith <paul@mad-scientist.net> writes:

>>> +	if test $(ls -a1 "$new_workdir/." | wc -l) -ne 2
>
>> I wonder if this check is portable for all platforms we care about,
>> but that is OK, as it should be so for the ones I think of and care
>> about ;-)
>
> Do you mean "." and ".." representing an empty directory?  That will
> work on any system where /bin/sh works, for sure.

Even on network mounts from esoteric filesystems and such?  When

    http://pubs.opengroup.org/onlinepubs/9699919799/utilities/ls.html

mentions the "-A" option, it says:

    -A
        Write out all directory entries, including those whose names
        begin with a <period> ( '.' ) but excluding the entries dot
        and dot-dot (if they exist).

The "if they exist" part suggests, at least to me, that it is valid
for a POSIX filesystem to lack these two (I suspect that one may be
able to find a more definitive answer from other parts of the POSIX
but I didn't bother).
