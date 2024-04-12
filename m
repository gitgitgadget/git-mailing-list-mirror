Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 669EF5491F
	for <git@vger.kernel.org>; Fri, 12 Apr 2024 17:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712942708; cv=none; b=hwq45VEI4YneeWblsRFQ42J6ngS78LTap4NYUMa3mzu8JOOohAxGlQcaN0pPOlg2gA+Pbeav+re8G10lx8Nq9Dg7jAWqvZcR9Suks36GNWHmow8VATJ+ZxBdL7JMfOeB3U+jobin66so8HknfGbnoaNnrSmHxQfB0UDfvVgLi3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712942708; c=relaxed/simple;
	bh=hkxSUi4UDBP4/lNolL7SnSTXR03dL86YBYromDiNjhs=;
	h=From:To:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=qXFU7ChQeHzFor8L3JzdOboa3oFBzVrZrN1jYNeueT/krekopwdOMkhoDfJMNWfNOa+oyI7Pp0IVY+QFRNgPjsp7hGo8n7LEmNvzkzD86Phu32qJy4ZUS97dKm/rNsiLrVZ/Z6cjW0l4PwYcLJZxERsX0/kmn21SM1vDzPV2oWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-228-251-108.cpe.net.cable.rogers.com [99.228.251.108])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 43CHP0FB494405
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Apr 2024 17:25:01 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "=?UTF-8?Q?'Rub=C3=A9n_Justo'?=" <rjusto@gmail.com>,
        "'Git List'" <git@vger.kernel.org>,
        "'Junio C Hamano'" <gitster@pobox.com>
References: <e60c1217-aeb6-48ce-9aa5-7c0b13396e33@gmail.com> <96bef5f9-1286-4938-99ec-6beed13ee68d@gmail.com> <0258a583-a90a-4434-bb4e-a1672d574b9c@gmail.com> <ccbd77a1-d334-4d8f-8de0-b542c79330fd@gmail.com> <83b34572-498b-438c-8437-dfbb837e60ba@gmail.com>
In-Reply-To: <83b34572-498b-438c-8437-dfbb837e60ba@gmail.com>
Subject: RE: [PATCH v3 1/2] launch_editor: waiting for editor message
Date: Fri, 12 Apr 2024 13:24:55 -0400
Organization: Nexbridge Inc.
Message-ID: <02b701da8cfe$59be3370$0d3a9a50$@nexbridge.com>
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
Thread-Index: AQJ5znJicP7/r7WF7TWn+2Qyh8E06QI4NrTtAi73sdsCvVkxHgEhAYqZr+QyEfA=
Content-Language: en-ca

On Friday, April 12, 2024 1:15 PM, Rub=C3=A9n Justo wrote:
>Subject: [PATCH v3 1/2] launch_editor: waiting for editor message
>
>We have a hint shown when we are waiting for user's editor since
>abfb04d0c7 (launch_editor(): indicate that Git waits for user input, =
2017-12-07).
>
>After showing the hint, we call start_command() which can return with =
an error.
>Then we'll show "unable to start editor...", after having said "Waiting =
for your
>editor...", which may be confusing.
>
>Move the code to show the hint below the start_command().

My thought on this move is for esoteric (but commonly used) terminal =
emulators. If one is on a t6530, tn3270, or w3270/9 emulator, for =
example, the emulator switches modes from text on the POSIX side to =
block/full screen mode when the editor is launched. Printing a message =
after the editor has launched has the potential to dump the message into =
the terminal emulation buffer and get caught in the commit text comment. =
This is not desirable. This change could have seriously undesirable =
side-effects.

On the other side, if the message is not displayed in the emulation =
buffer, it is deferred until after the editor closes, which makes the =
message a bit pointless.
--Randall


