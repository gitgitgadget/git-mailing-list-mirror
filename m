From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 01/10] Define a structure for object IDs.
Date: Thu, 12 Mar 2015 11:44:31 -0700
Message-ID: <xmqqa8zi2gz4.fsf@gitster.dls.corp.google.com>
References: <1425770645-628957-1-git-send-email-sandals@crustytoothpaste.net>
	<1425770645-628957-2-git-send-email-sandals@crustytoothpaste.net>
	<CEA07500-9F47-4B24-AD5D-1423A601A4DD@gmail.com>
	<20150311220825.GB46326@vauxhall.crustytoothpaste.net>
	<xmqqr3sv3vsf.fsf@gitster.dls.corp.google.com>
	<55016A3A.6010100@alum.mit.edu>
	<20150312104651.GF46326@vauxhall.crustytoothpaste.net>
	<CACsJy8AL0jGwzTfWDSszkvyqzNtPA7o7vQRT5NFaBYrVU02nOA@mail.gmail.com>
	<xmqqwq2m2hwf.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	"Kyle J. McKay" <mackyle@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Andreas Schwab <schwab@linux-m68k.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 12 19:44:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YW862-0007Dj-QE
	for gcvg-git-2@plane.gmane.org; Thu, 12 Mar 2015 19:44:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751384AbbCLSoe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Mar 2015 14:44:34 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:55035 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751295AbbCLSoe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Mar 2015 14:44:34 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 4DBBE3F724;
	Thu, 12 Mar 2015 14:44:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=L/dYHLfW+rCRHHEnl12mNrWSbtI=; b=ZehTsR
	DP7OLy0TIfPbL6zZm9BtQzwHH5nkubnga5fkZkdcbjfx8NVrlKaMLobjxqNr4Nev
	dEj7DnprseQA/3MNldCyK6WbaHnBKrynbZXjV/jH5twaBWz7y9zF+l//H4NDgFgf
	ZN/hP5EL2CoVa1ZikPIqZGEk7gl/wug49zbQE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=RpCqwmOZOEPYP0j5f0Tz3wwM1z0iwuqN
	NEYkr2UDeIjuzmO+4/AAcNufHspr0psOpfpuuBYKaYLYU9FemNzJAB3QChU3yJ2y
	V3YbNHIJ8TR/Cp+ZG4Xg80m6OtZn9ZC+0zFelXKTDi6l3oiuLG/DWAxGxrexkoAT
	4yCo7BZm1eQ=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 45B443F723;
	Thu, 12 Mar 2015 14:44:33 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9DB993F722;
	Thu, 12 Mar 2015 14:44:32 -0400 (EDT)
In-Reply-To: <xmqqwq2m2hwf.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Thu, 12 Mar 2015 11:24:32 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: D2C826F2-C8E7-11E4-ADC8-A2259F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265368>

Junio C Hamano <gitster@pobox.com> writes:

> Duy Nguyen <pclouds@gmail.com> writes:
>
>> This may or may not fall into the "mix different hash functions"
>> category. In pack files version 4, trees are encoded to point to other
>> trees or blobs by a (pack, offset) tuple. It would be great if the new
>> object_id could support carrying this kind of object id around because
>> it could help reduce object lookup cost a lot. (pack, offset) can be
>> converted back to SHA-1 so no info is lost and hashcmp() can compare
>> (pack, tuple) against an SHA-1 just fine.
>
> You mean "if it came in <pack, offset> format, convert it down to
> <sha1> until the last second that it is needed (e.g. need to put
> that in a tree object in order to compute the object name of the
> containing tree object)"?

Sorry, obviously I meant "do not convert until the last second".

> To me, <pack, offset> information smells to belong more to a "struct
> object" (or its subclass) as an optional annotation---when a caller
> is asked to parse_object(), you would bypass the sha1_read_file()
> that goes and looks the object name up from the list of pack .idx
> and instead go there straight using that annotation.
