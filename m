Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8397C745EE
	for <git@vger.kernel.org>; Sun, 18 Feb 2024 21:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708293516; cv=none; b=otd1aY3IZ8nm80E6oIfpUbm9DiJ81PnTmkarb/hQzyjwopUWmOtMQfQr0k8HCkR3PvNcY4YsPdEDuVLqdDorwkykA2+oxr8XANSkwrZw72flokuj5dwOA/ikHONnBZvUFxSmO7ccOh/1CQlR6ma1XQSHedJByEnGwRLJo4YskI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708293516; c=relaxed/simple;
	bh=aryqtwSaqkqwubO6r06gevmyxTCtV4dP3nb75MEzHwg=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=udTk4xs9++q/QD9lrbJ1sn+MldOB/OcGQqtZBcJT8zFvXBtqB5SoGR8J8GOzaXo9PD0uyRpEYqBCc2euqL+FAGKpBoFSZO00O8lRe8iT9GwlMDU4KinHByuu/kBZ4MKCU7/fJO1BUDNYJ3sHMsRmdMdB8Q60V7wwoPP0a+ADWBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=aaXLfXLr; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="aaXLfXLr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1708293502; x=1708898302; i=johannes.schindelin@gmx.de;
	bh=aryqtwSaqkqwubO6r06gevmyxTCtV4dP3nb75MEzHwg=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:
	 References;
	b=aaXLfXLrBJB8IUUQ9dPhI25TeXaZkT+upAxxqG332VbEd+t9K0Xnb18/+1kJ91Ta
	 04LSfSQkIUyL9eQgJZRVLK8wQ+A1e7cVXySdOH54wU+8Ruxrqct2h5X7DzifiOtpJ
	 oH7KjS8/gTG97S+nnqqUFd5RN3HDomes2Fm7YElEBtdyaWU3fTZSTgIBaI6UrXFMU
	 5ViAwHuj11jFvXQDm0mnRxrdENkbSiF4PgVgzPuO2BVP1ItP7tbh6CwGL9kpzOiC0
	 M7PonqD+JGmTbNNYhCEUdEP5g8UfXIdqorMjz/zdv6BvIGkt6hkt7VQlfAmZZVFwa
	 0MHc8eFfjxBYKwg6eA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([213.196.214.170]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MIMfc-1rhGg60yPs-00ENv1; Sun, 18
 Feb 2024 22:58:22 +0100
Date: Sun, 18 Feb 2024 22:58:20 +0100 (CET)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Beat Bolli <dev+git@drbeat.li>
cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org, 
    Philippe Blain <levraiphilippeblain@gmail.com>, 
    =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= <avarab@gmail.com>
Subject: Re: [PATCH] completion: use awk for filtering the config entries
In-Reply-To: <4a1d3618-cebe-4c20-89ce-c5dab51af21a@drbeat.li>
Message-ID: <aa3e36a1-52d3-0c15-b70b-83c6664757f5@gmx.de>
References: <20240216171046.927552-1-dev+git@drbeat.li> <xmqqr0hcjorg.fsf@gitster.g> <4a1d3618-cebe-4c20-89ce-c5dab51af21a@drbeat.li>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:ASlGIBmazxc/XTwKgZUQpiy52fAlljnGfeNq3MwemfWElVMFR0d
 qFn1dfWiECF/4pX5F/7thc99PQPo/noH7/n+6LSsoRw4Ly8f+Pl9fZJrKtX2oeZHwbMsSZ9
 a5Y+qGnYYvmqiCFG4jubshXNIJOgyRvSwQx6NWzdHK2V7j6/OypZAtTrREghdcXP/zosxyp
 ZxeDhLbwVw7xBOwbVPqIg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:IB1/XgJBLuU=;MTyWmWo630QmwDDBbZl1HowFmv6
 7JvsmSA8MAWMEhJUnHMoTOabFjY6rHiKQtj+EMBzZtugx22eeKFApbQqw7mJ8PCMXXmpAVKXi
 QXW2QOX4n7yWVEl1N1cS9YbA9Iz3Ck2F/OXntgfjJwXAJSa07Gwb+gYJpmIFmw4A3HJ6xgkha
 gw0zQyipP9H5TwJ3zaYsfNYkpaj6RFUNZuM60DEgTaO+vfwFyi5Lt2u3ZLAHzrbvJqTrhJylJ
 lgjfpjW4fjTCctgRx6JUXccnrW7nb8SLkrfSFR0i9y2g+hVNFIoyqDZZyyY5tPV4aK15KxAAU
 E2EJKR5OMdFFGYES/ppWC73Qq7INjLnNdjmr9r1QFtXcnjl0ArcqGvuR4qlv+IFt4h3XTnhJ8
 i67bqQ2K9aWUWV1AUDd0dgAMEV1p7Jq0ak6TY9U5kuKBUgMLltckqLh7KTQT0R/O1+e8ZHt8u
 LRTUAjuQOuRF4wmABSFzkQKIq9383qb7wWNUEWkq4xiy70DMF0DFY8niZLMgwspLdIcYItkQn
 Ufrjn3ieCnXHeiy1oEHfjgR3XitfNAEJoAL6F8XIyKFwrEN+tCKLpw0WktieOM5NKDTaMPFQu
 +FPRafQGy4uQ94wNpkbnI9JTZ5mSz5O7roGTDreS5pKK7l2HEnp1J4CbrzJLgbxkXPkVyUA6W
 y915K/bL7RW1EStWus3lNAYp+uG4+yo7+QMDHWTR3G1M8gqc+W9QUL+61WXXsr7fia/h1VsYx
 5K5ILzfIkty9HgqVnDvAOeSDc0kri8KxWlXsH6Ca6w0BmLFUjJgXSEgZRA53TCgVd6pzFdguE
 GrGhI9jOu20eSOHZbj9OVxpBaOAfl/6HrhysRU7AgDGb0=
Content-Transfer-Encoding: quoted-printable

Hi Beat,

On Fri, 16 Feb 2024, Beat Bolli wrote:

> On 16.02.24 18:35, Junio C Hamano wrote:
> > Beat Bolli <dev+git@drbeat.li> writes:
> >
> > > Commits 1e0ee4087e (completion: add and use
> > > __git_compute_first_level_config_vars_for_section, 2024-02-10) and
> > > 6e32f718ff (completion: add and use
> > > __git_compute_second_level_config_vars_for_section, 2024-02-10)
> > > introduced new helpers for config completion.
> > >
> > > Both helpers use a pipeline of grep and awk to filter the list of co=
nfig
> > > entries. awk is perfectly capable of filtering, so let's eliminate t=
he
> > > grep process and move the filtering into the awk script.
> >
> > Makes sense.  I wonder if we can have some simple script sanity
> > checker that catches things like this, e.g., catting a single file
> > into pipe, grep appearing upstream of awk or sed, etc.
>
> Yes, there are quite a few cases of these in t/. I'm not sure if it's wo=
rth
> the churn, though. At least it would make the tests faster on Windows...

Thank you for caring about the speed on Windows!

Ciao,
Johannes
