Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62EB2186A
	for <git@vger.kernel.org>; Mon, 12 May 2025 07:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747035974; cv=none; b=NeJVDj279BZ2r/jaFzVeRu8wuYLeE9cf6KFqayAapy/wV7F9oMrxOzylv+dPmIGVAkEy8tXTfeU0Vh5ocWD1ia/+4fz7bqS1vFmgfUZz3Rb+iIyh+PsN2zVDMEqqZ4QYpXYf0iIRbE8awAz4ttgRywbhFNi1vfhVI2N2vy6x3sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747035974; c=relaxed/simple;
	bh=KORKBsVDLXt5munp7HDEtqf8FhtiumKVyUYNEB1SX3Q=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=MyElZv/2m3g1oieGNCQCmQjKSnqL90P4B6imTWO8jpA//K2dSeimK0rhEyqmxGTkkd3iEhViiiUpNPEP/R/3NHowahcN89vUDeoqipMhLCamfwBDrhUBR3bjKouySQEYT0AVuRdJUhjnCzG6QIdIgs7ekB5+RRfrtcFTQefxf0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swagemakers.org; spf=pass smtp.mailfrom=swagemakers.org; dkim=pass (1024-bit key) header.d=swagemakers.org header.i=@swagemakers.org header.b=io4YzqpZ; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swagemakers.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=swagemakers.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=swagemakers.org header.i=@swagemakers.org header.b="io4YzqpZ"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=swagemakers.org;
	s=key1; t=1747035964;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v9/gS4aHFnrfNUE+j3xMQ3pGuQ7KbUNX/iz/LfbKo+g=;
	b=io4YzqpZDGhK1LihUBjC89CvChz8GcFkBmmDKj8U5ZdRBpRt9+MBrAdYdVcvY7B4orVa9z
	w8tkc1lFkoo4JkDf5xRJP056ssjB4rrP6VcTm4Tge5G8+S8FClSf9M2NSRDuMYfVKfZ1SM
	S1ll8OteOGttPi2MSFZSKiuEmAViKsk=
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 12 May 2025 09:46:05 +0200
Message-Id: <D9U0KAX6KVXK.WCY7YGX2Q0A5@swagemakers.org>
Cc: "Eric Sunshine" <sunshine@sunshineco.com>,
 <sandals@crustytoothpaste.net>, "Zi Yao" <ziyao@disroot.org>, "Kristoffer
 Haugsbakk" <kristofferhaugsbakk@fastmail.com>
Subject: Re: [PATCH v2] send-email: try to get fqdn by running hostname
 --fqdn on Linux and macOS
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Julian Swagemakers" <julian@swagemakers.org>
To: "Aditya Garg" <gargaditya08@live.com>, <git@vger.kernel.org>, "Junio C
 Hamano" <gitster@pobox.com>
References: <PN3PR01MB9597C419019DC28E489D2AF9B88AA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM> <PN3PR01MB9597BC2E1B526A11D21BAB24B895A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
In-Reply-To: <PN3PR01MB9597BC2E1B526A11D21BAB24B895A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
X-Migadu-Flow: FLOW_OUT

On Sat May 10, 2025 at 9:37 AM CEST, Aditya Garg wrote:
> `hostname` is a popular command available on both Linux and macOS. As
> per the man-page[1], `hostname --fqdn` command returns the fully
> qualified domain name (FQDN) of the system.

There are multiple implementations of the hostname command, and they
don't all support `--fqdn`. For example this will not work on Alpine
Linux as well as macOS.

macOS:

    $ hostname --fqdn
    hostname: illegal option -- -
    usage: hostname [-f] [-s | -d] [name-of-host]

Alpine:

    $ hostname --fqdn
    hostname: unrecognized option: fqdn
    BusyBox v1.37.0 (2025-01-17 18:12:01 UTC) multi-call binary.

    Usage: hostname [-sidf] [HOSTNAME | -F FILE]

    Show or set hostname or DNS domain name

        -s	Short
        -i	Addresses for the hostname
        -d	DNS domain name
        -f	Fully qualified domain name
        -F FILE	Use FILE's content as hostname

All seem to support `-f` though, maybe that would be the better option.

Regards Julian
