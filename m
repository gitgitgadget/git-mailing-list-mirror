Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 106F0219EA
	for <git@vger.kernel.org>; Fri, 26 Jul 2024 09:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721987755; cv=none; b=iyZrjRDQta2hRr+RT55kvHyGxk8v4M0uVrLriFD57daCVsjkKmLRSHlrQuKZoeWiW8AozcLk6c8QM0ltAlIlRMWjlfktDbhPQ5j5/kf7h+5BQ6i/HCPV/Y+OEmeJzEUrX+AyfY74SelPhSocbCa89vMxzYPzYYlZ807r51PuHuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721987755; c=relaxed/simple;
	bh=laSctBR2qTzyI7/i6yrgkbF6BH7KNgLg3UXq8W2Qazc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S/Kgu+useYhrEEmrPCYjnhVdGOn180jju5YJjK3LTPmkCwkuZdVcQhHux8AvtwJ6APfkYuOiOtcQtHE54vnpSd8mY6vjJ0wCLh0+Zd96KijBFqs0EomDWVm4Igy+o1MnMOOFniCmhTKMxAqKTire1Pbfa0YQ+kIcNKMobO5XYXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=tboegi@web.de header.b=o+biIxcC; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=tboegi@web.de header.b="o+biIxcC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1721987737; x=1722592537; i=tboegi@web.de;
	bh=N1BWaPxyCJm/09Kr1llejvQclVlsvO9pC5hlhHfWtq8=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:In-Reply-To:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=o+biIxcCPkBj2qwTcT0N80LeQm1oM1W008QtZoQTLw+xVmQAHCAcgMxlx6EqF8K2
	 Fpd90klFgs8Z1I5GVhpqkTjI5t6nUhmSpiunisExdOyAb0U9mUPSlFgnxwGIlRm8m
	 2zPsOJyFSjoFpLxh0sVtJcGOVTOy6gJacFzRn4KS4usxsss23gp2Du3g8mdqTLt9M
	 CfcPvV1uYglC5HrxFmK0yb7OWhUB4M181nyrpOi4hMK189wkfJ4+P7ias4Guls/yp
	 IoL33zpVLDw13tadd21wVFK7JJ+DnXV/vqNsw/vPUprCL6EMJcmQL4sKEdOkzoc33
	 Qg6TOUxNur2DETSO0w==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from localhost ([81.231.143.213]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MLzin-1soXZh3iJF-00M2mG; Fri, 26
 Jul 2024 11:55:36 +0200
Date: Fri, 26 Jul 2024 11:55:35 +0200
From: Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To: Haritha via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Haritha <harithamma.d@ibm.com>
Subject: Re: [PATCH v3] Fix to avoid high memory footprint
Message-ID: <20240726095535.GA32544@tb-raspi4>
References: <pull.1744.v2.git.git.1721821503173.gitgitgadget@gmail.com>
 <pull.1744.v3.git.git.1721975234873.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pull.1744.v3.git.git.1721975234873.gitgitgadget@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Provags-ID: V03:K1:w9duqz12AgUoDekGBU84dK3iH9fmqMr0/9Qg+7V8FoKDrZojq2O
 /UiYX5DryZd5ZoCXKCGaUA39xE6sTcBXgulISODo1InQJubtZVJgVK8W6f5V0onKKruMqmy
 ZlcuOuRo9nScAR14BMm6JdrXRIErJe45X/dgvy3Fk6VvdxfjoWLAvObWIDhFB5sLN/6CinS
 ZyJi3PEyOj5SIc11GNiiQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:NkuQV3bOYb8=;FXoELfs5AoTpCEUrbZ5iBTne3UC
 M21R7qRAXIlQSA70iNFn9mm3ROwuVs1ctYDQdB/Zwqiz9rsw1StRkVsA6b7+pwMTZayBF/SqM
 vaUU5nsV6wonQ8t9GCRaCTdT3n6x+gVDewIKkJnlo20pSTTC8wDBWtveYvnGVgQiSih8QLW9r
 Ljk0uJp9SmuG+EIe5vcCboZgK9PfC+38X0MQv2ihE9kEkUzK8AIsiQrabkLjtFHxUdKFB/tQ4
 0fQzmn5NpyEgBVqFcnjiOWMpp3MfAQGVac1wqxvaufeUEnFQhWEvWmtI24wV7JlylEpG6aroF
 xNQOiUpOsi95NmJolK6mtA1a5FNiZRHuOWa+vgp6pk78Gq2f8v4PUHHnCVvq42hUchraaIkO8
 2Y6sSlG5BnAoW+VxXl5YjgZsPA3gfZFXSHyrTAnNglhN+8Tsr9NpaU/P5PivQQLhG0LAlUHIU
 UScFPo7SQN5m+euvZAO2mOufKeKMwfSMkUmed7dsusf+vrGyf5fvdWo6vOHYDY7hb1HPuhi0O
 nSZ+1ROfwO3Fd0y5ULafkeaqmk1mqCxOs1HIMpiq3Vf/aRIDmsefBbn34ADNXK4ugaezM68Pz
 keRrb6sfG7MCC9kk9FBiNFzbH+eSFGlTAVWRWEugL5S49FRWOd6VfmXvV4bX332Bq2QBJq87u
 8n5HU7R60u63TbKX40SKqwyb2RZjoTyuGrboz9L0sGdquYAvfLGAfprhc2HS3Mw43cIAEr0QA
 8MbfJDkqlOH9a/0rekwAAMltTfYkmGriI19IK16NFrjxUQfhUw0Xn15Wbdw6MB2IiqGPZdF4P
 eO7XRYBTGapGhFJkUO7ivviQ==
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 26, 2024 at 06:27:14AM +0000, Haritha  via GitGitGadget wrote:
> From: D Harithamma <harithamma.d@ibm.com>
>
> When Git adds a file requiring encoding conversion and tracing of encodi=
ng
> conversion is not requested via the GIT_TRACE_WORKING_TREE_ENCODING
> environment variable, the `trace_encoding()` function still allocates &
> prepares "human readable" copies of the file contents before and after
> conversion to show in the trace. This results in a high memory footprint
> and increased runtime without providing any user-visible benefit.
>
> This fix introduces an early exit from the `trace_encoding()` function
> when tracing is not requested, preventing unnecessary memory allocation
> and processing.
>
> Signed-off-by: Harithamma D <harithamma.d@ibm.com>
> ---
>     Fix to avoid high memory footprint
>

This head line
> Fix to avoid high memory footprint
does not tell to much when and how it happens.
The word "fix" is not realy needed (in this project).

Something like
 "convert: avoid high memory footprint"

will tell the reader, that only the convert functionality is affected
by this patch.

Thinking about it, another suggestion may be:

convert: Reduce memory allocation when trace_encoding() is not used

If someone browses through the whole history of Git, this is easier to
follow.

The exact wording may be improved, important would be to have "convert:"

as the first keyword, and then "memory allocation" and "trace_encoding()"
give hints, what this is all about in one line.

And the rest looks good.
