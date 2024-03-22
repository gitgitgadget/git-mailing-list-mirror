Received: from mail-4321.protonmail.ch (mail-4321.protonmail.ch [185.70.43.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 775F9376
	for <git@vger.kernel.org>; Fri, 22 Mar 2024 00:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711066912; cv=none; b=QsHR2NdUfRr2LZhQV7nOdHRb+VXuJPsZoK20RvSeQuQel8d1e/BPTLH4IX/pXmJXBgvgLS6VpvUw+EB9TpK3njIYRq11KXvPrCrEIIvE49BOfIcOYI7GxGcar9kn0dCcdOiYqztfDRT4Z6AbSu3FpanMK3M1iwKZ10FvKGW8hdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711066912; c=relaxed/simple;
	bh=ga9K8jTD9Na6LXBHz0KndR1EMoS0ltF6BdfVgNVRZLU=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=cOZnAF+SmnclQntkh1V73VzbiB/aHRDQdDOcKzvjM+aNFcip2J5ARWsnBFG6i3KFGJ6W71QcTfbwMIq/U8VpZ/RvdaIMAnlvK4Bmfe6vUh4XpM9l3WEyKo+S8bCAXc8NHMCzrMBQYw+hddxP8P3tnTiZQ0nA17t7UBN9b7fgJ70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=archibald.dev; spf=pass smtp.mailfrom=archibald.dev; dkim=pass (2048-bit key) header.d=archibald.dev header.i=@archibald.dev header.b=A/VAD/8m; arc=none smtp.client-ip=185.70.43.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=archibald.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=archibald.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=archibald.dev header.i=@archibald.dev header.b="A/VAD/8m"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=archibald.dev;
	s=protonmail3; t=1711065800; x=1711325000;
	bh=ga9K8jTD9Na6LXBHz0KndR1EMoS0ltF6BdfVgNVRZLU=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=A/VAD/8mAU7yN9+yYzdsigvinGw9+GIsX0axKRutqDjbyyyIIHgfLlDPAmdKX4ATQ
	 ortGaI3XWyYt1qbFBoqoichZFhShu+QiufHfenxPOFONgC3WgBMkm6n4mF7vWmyrYZ
	 o5FGGJ47o9T7x/aE6B94aIpKLwc38p8UhZBLf65tGY4hbupkB3WCa7UIm/ENj14Pvm
	 BGe/sasjmh4QanA/lH8p8jYe0brUzP6wTCLekRsfsj2o2uj4DrqI//JEOaU3p4FDb2
	 a7xc3oHa6LMyxnqD3UwY98FQ58Aklqx0AGg64fbBzu41gTQuNGRWUOUS/W/I1K2qij
	 2SEdFsYokPNRA==
Date: Fri, 22 Mar 2024 00:03:10 +0000
To: git@vger.kernel.org
From: Thalia Archibald <thalia@archibald.dev>
Cc: Elijah Newren <newren@gmail.com>
Subject: [PATCH 0/6] fast-import: tighten parsing of paths
Message-ID: <20240322000304.76810-1-thalia@archibald.dev>
Feedback-ID: 63908566:user:proton
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

fast-import has subtle differences in how it parses file paths between each
occurrence of <path> in the grammar. Many errors are suppressed or not chec=
ked,
which could lead to silent data corruption. A particularly bad case is when=
 a
front-end sent escapes that Git doesn't recognize (e.g., hex escapes are no=
t
supported), it would be treated as literal bytes instead of a quoted string=
.

Bring path parsing into line with the documented behavior and improve
documentation to fill in missing details.

This patch series is patterned after 06454cb9a3 (fast-import: tighten parsi=
ng of
datarefs, 2012-04-07), which did similar fixes across the grammar, but for
marks.

This is my first contribution to Git, so please let me know if there's some=
thing
I've missed. I'm working on a tool for advanced repo transformations (like =
a
union of filter-repo and Reposurgeon workflows), so I've been living in
fast-import code and I have more parsing fixes planned.

Thalia


