Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16275237707
	for <git@vger.kernel.org>; Thu, 24 Apr 2025 12:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745497692; cv=none; b=Zz/TWalE6DPRZyX90Dqi8izalGsunnpGz5f3qZ6cG4DBkpnPvHKa/SMAr7h9r6zZ/pIu2pJoH1skfE3pdv4fyGM2twnnmVqNWXIu2jAv2tzxC8DTvIHcGH8fAs38N9MQsAUJnyE7lsityMcieOCFnsbMm2ceuOMFsTBCYDgJ7mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745497692; c=relaxed/simple;
	bh=AroYKK56pgU9pZb5ffiaiJL9FHGl1475rL81fVUOmoM=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=T2npQui2EHBInL2uICzaceRI+3POkQsDSCqCJkLkhr2WW7cyOgsNAiw7tKpRjJ7NhbPwejEX2vG1hadzx5zo9k6dI7BmuagQR6ie7+M/s3pbmjhzpdN9kdvJzHOok3LFO8n4zGDGwXpqO5PGfL0J4ZZv0MwQzMDjZFJSwzyOG0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swagemakers.org; spf=pass smtp.mailfrom=swagemakers.org; dkim=pass (1024-bit key) header.d=swagemakers.org header.i=@swagemakers.org header.b=KSUtc6q/; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swagemakers.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=swagemakers.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=swagemakers.org header.i=@swagemakers.org header.b="KSUtc6q/"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=swagemakers.org;
	s=key1; t=1745497686;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XFok0GjBD0qv/xE2tX/1UJms8FzyPP6+Xc9wgdi7dTU=;
	b=KSUtc6q/LEuBokmYSeV51LmPTZ0QOAnzdFPxvA1LlTA80Rluuuwt6vINIJ3vQ3PFJL8GIE
	hXIQL+kIFZ4f3D71uSNTPU+5o/foz0gZNDEohVcyQXqu8gm05PLxMZzWeJWxUT/hsfsJSH
	isuzP+ispCzu6Ixe4CncJzRXKrVbw6k=
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 24 Apr 2025 14:28:06 +0200
Message-Id: <D9EVAF38Q1KJ.24J34ET29VPTI@swagemakers.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Julian Swagemakers" <julian@swagemakers.org>
To: "Aditya Garg" <gargaditya08@live.com>, <git@vger.kernel.org>, "Junio C
 Hamano" <gitster@pobox.com>
Cc: "M Hickford" <mirth.hickford@gmail.com>, <sandals@crustytoothpaste.net>,
 "Shengyu Qu" <wiagn233@outlook.com>, "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>, "Erik Huelsmann" <ehuels@gmail.com>
Subject: Re: [PATCH v5 3/3] send-email: add option to generate passswords
 like OAuth2 tokens
References: <PN3PR01MB9597A83D537E3AE96144227EB8BA2@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM> <PN0PR01MB95884F106749628745FDFBB7B8852@PN0PR01MB9588.INDPRD01.PROD.OUTLOOK.COM> <PN0PR01MB958856EC9FB1E4F73A738746B8852@PN0PR01MB9588.INDPRD01.PROD.OUTLOOK.COM>
In-Reply-To: <PN0PR01MB958856EC9FB1E4F73A738746B8852@PN0PR01MB9588.INDPRD01.PROD.OUTLOOK.COM>
X-Migadu-Flow: FLOW_OUT

On Thu Apr 24, 2025 at 9:53 AM CEST, Aditya Garg wrote:
> Some email providers like outlook allow only OAuth2 tokens to be used
> for authentication. This commit adds an option to generate OAuth2 tokens
> using scripts like M365-IMAP[1]. This option is similar to passwordeval
> in msmtp.
>
> Example usage:
>
> [sendemail]
>     smtpEncryption =3D tls
>     smtpServer =3D smtp.office365.com
>     smtpUser =3D someone@outlook.com
>     smtpServerPort =3D 587
>     smtpauth =3D XOAUTH2
>     smtpPassEval =3D cd /workspaces/codespaces-blank/M365-IMAP && python3=
 ./refresh_token.py
>

Having the option `smtpPassEval` is a little more intuitive, but can't
this also be achieved using a custom credential helper[0]?

Something like:

    [credential "smtp://smtp.office365.com:587"]
        username =3D someone@outlook.com
        helper =3D "!f() { test \"$1\" =3D get && echo \"password=3D$(cd /w=
orkspaces/codespaces-blank/M365-IMAP && python3 ./refresh_token.py)\"; }; f=
"

Regards Julian

[0] https://git-scm.com/docs/gitcredentials.html#_custom_helpers
