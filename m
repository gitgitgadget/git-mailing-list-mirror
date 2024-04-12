Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4895414B065
	for <git@vger.kernel.org>; Fri, 12 Apr 2024 17:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712944047; cv=none; b=I+fe+TpcAp+A+1Yieg5ztClT3nXa/4wRff52lEPgzaOtEWL3ngB7RE7f101y5EAWnzi+UZcwP7/FAj35baHyJHbII9ZT4MUxBvsm822bIlwObSRvtMQGmJxmd+AjikNIMwMmwdrCbYnxAaA/iuC9FO6eQHxReszb+I6t43JT6ZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712944047; c=relaxed/simple;
	bh=rITUJNNj4eN058eWmC6aQa43VCSGkfDNO2J2NAPeouQ=;
	h=From:To:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=KMc5V40VICWH0wX/pQPeJsJVy8TK3CovI0jEE7B9LVT8RFu00Su9lXDAfOQmTJrJWJL6iNS2MNHLPWMWL65lG+8mKEJHR9OPsN/HdjX+KdibSvphe+qD6zWo5SoajcATgREXTMagzASbsKa2KG4Ml5D7hk7TmF2yeUpvHu1EWaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-228-251-108.cpe.net.cable.rogers.com [99.228.251.108])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 43CHlLGe499345
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Apr 2024 17:47:21 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "=?UTF-8?Q?'Rub=C3=A9n_Justo'?=" <rjusto@gmail.com>,
        "'Git List'" <git@vger.kernel.org>,
        "'Junio C Hamano'" <gitster@pobox.com>
References: <e60c1217-aeb6-48ce-9aa5-7c0b13396e33@gmail.com> <96bef5f9-1286-4938-99ec-6beed13ee68d@gmail.com> <0258a583-a90a-4434-bb4e-a1672d574b9c@gmail.com> <ccbd77a1-d334-4d8f-8de0-b542c79330fd@gmail.com> <83b34572-498b-438c-8437-dfbb837e60ba@gmail.com> <02b701da8cfe$59be3370$0d3a9a50$@nexbridge.com> <f473894d-caf9-4a50-962e-dc884f29e174@gmail.com>
In-Reply-To: <f473894d-caf9-4a50-962e-dc884f29e174@gmail.com>
Subject: RE: [PATCH v3 1/2] launch_editor: waiting for editor message
Date: Fri, 12 Apr 2024 13:47:16 -0400
Organization: Nexbridge Inc.
Message-ID: <02ba01da8d01$78bd5a50$6a380ef0$@nexbridge.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQJ5znJicP7/r7WF7TWn+2Qyh8E06QI4NrTtAi73sdsCvVkxHgEhAYqZAg+Z2FcBfH6gCa/H17dA
Content-Language: en-ca

On Friday, April 12, 2024 1:37 PM, Rub=C3=A9n Justo wrote:
>On Fri, Apr 12, 2024 at 01:24:55PM -0400, rsbecker@nexbridge.com wrote:
>> On Friday, April 12, 2024 1:15 PM, Rub=C3=A9n Justo wrote:
>> >Subject: [PATCH v3 1/2] launch_editor: waiting for editor message
>> >
>> >We have a hint shown when we are waiting for user's editor since
>> >abfb04d0c7 (launch_editor(): indicate that Git waits for user input, =
2017-12-07).
>> >
>> >After showing the hint, we call start_command() which can return =
with an error.
>> >Then we'll show "unable to start editor...", after having said
>> >"Waiting for your editor...", which may be confusing.
>> >
>> >Move the code to show the hint below the start_command().
>>
>> My thought on this move is for esoteric (but commonly used) terminal
>> emulators. If one is on a t6530, tn3270, or w3270/9 emulator, for
>> example, the emulator switches modes from text on the POSIX side to
>> block/full screen mode when the editor is launched. Printing a =
message
>> after the editor has launched has the potential to dump the message
>> into the terminal emulation buffer and get caught in the commit text
>> comment. This is not desirable. This change could have seriously
>> undesirable side-effects.
>
>That's a good point.  Thanks for bringing it up.
>
>Of course, in such a situation the user has the opportunity to disable =
the hint.
>
>However, can you think of a way in which we could do this, not showing =
the
>"Waiting..." before the "unable to start", better?

I do not have a good solution. One thought was to run the Waiting =
message in a separate thread, but that is dangerous. Terminal I/O APIs =
are generally not thread aware and random results are frequent when =
writing from two threads, particularly in different processes. Polluting =
stdout is never a good idea, and in this case the encoding and terminal =
type could also change between git and editor, even in Linux. The only =
potential way to do this is with an editor aware mutex (there isn't a =
portable on) that would block the editor, poll the terminal state, =
change to UTF-8 or US-ASCII or... and write the Waiting message, switch =
back, then release the mutex.

