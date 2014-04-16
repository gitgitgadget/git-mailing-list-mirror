From: Junio C Hamano <gitster@pobox.com>
Subject: Re: wrong handling of text git attribute leading to files incorrectly reported as modified
Date: Wed, 16 Apr 2014 09:50:19 -0700
Message-ID: <xmqqob01i5h0.fsf@gitster.dls.corp.google.com>
References: <E8A9F28E-FF68-4899-B02C-DB7A2C66F38A@ammeter.ch>
	<534852D4.5070608@web.de>
	<D552B854-59FB-406A-8CDE-3A1269CD0F6E@ammeter.ch>
	<CANUGeEYoS+t57jfpEoZE-2u_cD1uOD5pdp=yF--Rhpb9z91qxQ@mail.gmail.com>
	<xmqqob02jnhk.fsf@gitster.dls.corp.google.com>
	<B3DF4E4A-F740-4588-AFD5-74D99E5299F5@ammeter.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brandon McCaig <bamccaig@gmail.com>,
	Torsten =?utf-8?Q?B=C3=B6gershau?= =?utf-8?Q?sen?= 
	<tboegi@web.de>, git@vger.kernel.org
To: Frank Ammeter <git@ammeter.ch>
X-From: git-owner@vger.kernel.org Wed Apr 16 18:50:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WaT2i-00077u-Tf
	for gcvg-git-2@plane.gmane.org; Wed, 16 Apr 2014 18:50:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754400AbaDPQu2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Apr 2014 12:50:28 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34618 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754391AbaDPQuX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Apr 2014 12:50:23 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EBA687BF45;
	Wed, 16 Apr 2014 12:50:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=77zOQcWhIkaryO+o/WAxMFGr20w=; b=Vc24Qv
	iXdaY5D6caQqGFtxD+OGlL7DtadVq6tZ0leQ4dHTFShw3RxwCRKwmR8B11XgC6pi
	QGcEZ8jS/xbM1RBOxS2S8Lqgq72CJ2qasbP8M7bk/bLzOk0Lz6u2szwqZshMj4Hk
	MomPKEcQRUSfriEtvfu9NCrhE2sx3PJV67ZnM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=eoQm6APdbSDoLiwHKb7NRrjnkJOixz9m
	VF5N/dih7xPydb6CX/HrtBC/ROPPO3tQHmX3pAo4hlcW5Dhcd6s+2zV68EOH45rH
	NMyARuq3ZMcummzAeDKo4u6b75mIBKWbcBGTS4tZmjVNWwTkePLETIOJgQEeKmjX
	Laho/mdLJ1Q=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D3EF87BF44;
	Wed, 16 Apr 2014 12:50:22 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2A52C7BF43;
	Wed, 16 Apr 2014 12:50:21 -0400 (EDT)
In-Reply-To: <B3DF4E4A-F740-4588-AFD5-74D99E5299F5@ammeter.ch> (Frank
	Ammeter's message of "Wed, 16 Apr 2014 13:49:02 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 32A21746-C587-11E3-B970-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246343>

Frank Ammeter <git@ammeter.ch> writes:

> Am 15.04.2014 um 23:23 schrieb Junio C Hamano <gitster@pobox.com>:
>
>> Brandon McCaig <bamccaig@gmail.com> writes:
>> 
>>> That is for your benefit, and for easily sharing that configuration
>>> with collaborators. Git only cares that the file exists in your
>>> working tree at run-time.
>> 
>> It is a lot more than "for sharing".  If you made .gitignore only
>> effective after it gets committed, you cannot test your updated
>> version of .gitignore is correct before committing the change.
>
> Ok, I can follow that logic for .gitignore, but I was talking about .gitattributes...

They are conceptually the same thing, so if you can follow the logic
for .gitignore, you already can follow the logic for .gitattributes.

The only two readons we have a separate .gitignore are because other
SCMs had a similar mechanism, and because it came before attributes.
If we didn't have these two constraints, it would have made a lot
more sense to express "this path is to be ignored" by setting
"ignored" attribute.
