Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A79AB27CCE2
	for <git@vger.kernel.org>; Tue,  4 Mar 2025 16:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741104729; cv=none; b=CQWobW34BBJ51amJk06GNTuVSYO+/tnmWFIERwOYDlJ2GUYF9iEARK0t0FA4WWY8I0AB3G/dmZvoF0hxo+0HYXakfzOWTLO6OxIcfp46v5Th+4VpoTIUpes9MlFb6G7YPS8d6oqTncElr31CR4WJhNmZgvkWgPfd1h9eltSDKco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741104729; c=relaxed/simple;
	bh=j6JoAcFwhcyMmc+ftqWuiUvf579ylN3cfbGvvlRFtZI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h9cpy3uQHzppe45ImfZXThGQBINW+rjihz0On0P55MJeyuUxsEskUS2zqnlx9Ao5kOIx6nbnpQOgsgBh5VyG7CiE9xvSxV8UUZSgt/SkusYGYku25Fg3pQfKIN6fE8cvDHGFNddc7z3iJRX9//SC+syomjV/k0ALnHdRvCVth/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=SlHRJtwc; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="SlHRJtwc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1741104715; x=1741709515; i=l.s.r@web.de;
	bh=iVSoFlWbLWZe4K6lg4GWN81iD0tfFh+mqg2zkKZKw2U=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=SlHRJtwcFQDR/X5mkAoaZrREgtcJIZN9JtH0J33/llfpVJkKpAfbM3ObMcAiTbqA
	 nQTca6qmrZyGEbidYupIQFK3sXodBaLg48Lm8sZzLdkcdgOOECds7nplHXTVJp+sX
	 52TmDmi4yJ0knbP4SVLk6vWOz9mVPfcSi3f+i6iF8zbzgvkw03AwssHLuthYCBuxS
	 vpy79zWTiHp2WsIn4dbTmSCzn+j/AjAPM6tkTwJJQpskmAJuMPf13xlaZ1BYI7TDY
	 SQN70Px9QEOp3ayzsuCqX3abjv441IKQ4Pnzd4mhusiB1ZcYmHTjuq6wIxpGIj/gY
	 Gk14D03+8b1rLfC6iQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.144.81]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MNORC-1te2Wv2S42-00KBsI; Tue, 04
 Mar 2025 17:11:55 +0100
Message-ID: <77e1fe2e-f652-4aea-bc12-4deae7bcd569@web.de>
Date: Tue, 4 Mar 2025 17:11:54 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v2] reftable: release name on reftable_reader_new() error
To: Jeff King <peff@peff.net>
Cc: Junio C Hamano <gitster@pobox.com>, H Z <shiyuyuranzh@gmail.com>,
 Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
References: <CAAJd+fZSUiiUm05D_eO3HS7p=WoxAWSZo51dUNjyGjUNJBvyGg@mail.gmail.com>
 <bca5c0ec-0995-421e-9745-330f729357d6@web.de>
 <20250304063329.GA1283445@coredump.intra.peff.net>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <20250304063329.GA1283445@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:CWNtTPyB2I3MgCicM4Lv+1zdfxF3vPl0ypINcCYnsZ9uCpfH6Bs
 L7YBEmeV3BD2fS9+dBYE0Tk3BqWMlmBFVYiT7nCb6bfBkXaD2yqvrSD9VJPXx2+VdUeLhp6
 lMbecmqEe3CkrslsUohd7+AQw7KZHyAj2nHMpLI//rbDu9budrwsxf1T+1emzlE7LQr2rW+
 k0YH5ZuwaV8QnoHKDA/WQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:BwX2REsoQmk=;YBl3qicfpOXS/cMT26f1PX5eIaQ
 UmzK8pyo7IDclKAW1GmbDI6fXSkCPJnajHvgw01Ywged7xl1z74LOkGFyXMSQx4pVXD45NLbB
 U9RTWnwVYpiq1A81xmjOj2mamK1arI+nAGr1LicFuQyRsClvQ/LwNW4JCdFEJOfSF5HkWfUIk
 kdYu3CBj3Tx2iFVX1vAfDgkMryfbnl8dSdPDTmsWfG4RpN5Ug0NimbPf0in5DWz7Hk7MxE8ek
 tG4S4vfnElsDZitf+d70ss16oFj32GQokp2XSF2usHEtmPxbm7ZHwVKtHP73iO/V9Jezi14dI
 J03d1uP4tOnQ3HuFTjcT3+mDcCbPPHmUzi1EMexjqtF4hWvAaeqCJ4sweTYvksXgaqGG3XoY+
 jQ71lptwKG5T3XgXyeapJp3fjaP/fC3Tg12+GrPJN4HUQd5dSF9NRvBMxxkb+KRt0fFhQ0gKV
 VIffLz4lds6+ZPvpeALjhcApgd+OhgiY8jSmacy/3kvQvc9Mo1c7+w5EbS++mgjYw80fPQtNv
 7LMpPoVH38PJdOu/dbcorxdGJoKUTnAJskboCLUoPUXB+idUNCa0BrH9j9MC/8wTDq4mwROlJ
 45eKl9QakvEvIqM9bSLRZbJIdwzB1hUKYF5HHiEdXwByd2rtw3XiKKVaR+Gvtr6fzV7ScjpAr
 9EucJM6uUwTu6KJN5ayqiazooDvalye3v1Iu8TOP+/fANZ9VEY8vbqbBnb5/74dylqmgUAz+U
 FhK/qGymzqtXzufmcJ9G5F7fk8/DhgROG7jWYKHUdWZQfFKTx2IKj9wF0OusNpdjUADDAMHgH
 8k0O1wSw+MJKXRsuOap10pbGNMF0jrT9CV1jKb+XVvbZ4HYXbh4aidF5uUeUmszCoSv6scfZq
 qynSJiflFfvH5vqqsSvJQ50V87zSG47ylYWVFNWUpAwkhjZ4t5NOAnnVyqsi1hDIRdwdJxZFs
 38ZZgiR8XKqKmXBWKLANo7pRay3utPP0bndI+gdjxTaQBIxRTVqdHCzA7Xcq1qHMy6WAbbiR9
 BTdOdkW3e8IPh3Wl2kqp4BM9XqhPbCoHgpcH1B6QTvKqVa0vaY/V7nlkR05qZ3Kbkn39oVFh+
 G6LnMRx3XWrISUfF449e7/TlIKzo5BDg8jsYqU+OYu2fUSq+lUMp7DaFuIuVKMS96HO0t2qvE
 p37l5/wrCf1D6niSwFtQWEAbomafA70voiETUfccn/RftHJ95cRh5gbtn1rjn8jI+w8xzDNJL
 mWqlIBsRce51sNtXl4dj/XFRLST+y3s+5UC8iCaOTWTVgmdm40S4RdbXLN0vkn4SxaEMYWnJG
 aHWIg+QFRxspfYFen514A89jefPKPzg92SgVulDQO7n331SEpNogZmmwcNLk7PoV+MqybOp/4
 C2WjOMG4Qpv824wN80lIPhO22y0RmoyI4eVfm4S4MsLeafdxXR1WfwLaq3

If block_source_read_block() or parse_footer() fail, we leak the "name"
member of struct reftable_reader in reftable_reader_new().  Release it.

Reported by: H Z <shiyuyuranzh@gmail.com>
Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
Change since v1: Avoid NULL pointer dereference.  Thank you, Peff!

 reftable/reader.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/reftable/reader.c b/reftable/reader.c
index 3f2e4b2800..24bae50ac2 100644
=2D-- a/reftable/reader.c
+++ b/reftable/reader.c
@@ -666,6 +666,8 @@ int reftable_reader_new(struct reftable_reader **out,
 	reftable_block_done(&footer);
 	reftable_block_done(&header);
 	if (err) {
+		if (r)
+			reftable_free(r->name);
 		reftable_free(r);
 		block_source_close(source);
 	}
=2D-
2.48.1
