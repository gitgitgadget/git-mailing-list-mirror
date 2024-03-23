Received: from taslin.fdn.fr (taslin.fdn.fr [80.67.169.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DBFB1E522
	for <git@vger.kernel.org>; Sat, 23 Mar 2024 15:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.67.169.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711209493; cv=none; b=Q44ej3D4Rae2aO5IIgXOexToGGVH9lKOinCIZu+pi2rzp4leFRrQZnghSSza/TBlquDXXXERpkwjl8tnZNQOuJkWbdothHbW43UB4ArCb0TlzB7l+Km79AZutsNugs9Jc6quxhFt1GiRDSSn9M7DcBUN488AHAYFqc8P4fcpIaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711209493; c=relaxed/simple;
	bh=T8okGbkuprcR4cMPXHJMLwdO1IjguK9tViGka12yQR0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jCB9PD0PoDieQFghrQ9MA9M7GqqKfoPPvuGBMxQBq9hBbXlD19OQ1z4iUItqgaGeUKiPi1fLzItykDIibCDELhwIlqgVH3S+EfYivtr9xXIMXsaZLyeCEhLIoGUV3nvdi0/ZpveMNSm7RiKFQhll39iQQTPI0tcv3xfUa+eyACY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=max.gautier.name; spf=pass smtp.mailfrom=max.gautier.name; dkim=pass (2048-bit key) header.d=max.gautier.name header.i=@max.gautier.name header.b=JtbzgKnO; arc=none smtp.client-ip=80.67.169.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=max.gautier.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=max.gautier.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=max.gautier.name header.i=@max.gautier.name header.b="JtbzgKnO"
Received: from localhost (reverse-238.fdn.fr [80.67.176.238])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by taslin.fdn.fr (Postfix) with ESMTPSA id 319FC6038D;
	Sat, 23 Mar 2024 16:58:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=max.gautier.name;
	s=fdn; t=1711209485;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Cdl/IFaWnYg26h9vlFzbdNTuO1z1wXlWB9Qbs2Z4wFM=;
	b=JtbzgKnOEGIKy/8PlP6tC7dcsfTUbiZH4iJGAv2kgwNFsxa3Mpnf8UGGx3zTkCf6LRYkiA
	SsnXNun03ebbzoiYijmkDvR+EJUWaFDGpZ1urPqju8I4oQLdM5ob99UDu4N0EG9nIQX3TJ
	7Qhrevxr3RL01JjZgTQMAl/8RGqAqLsqM76/UUjC+WYzw89ZC2893EZkbqMnFB2sVFRCAW
	TlqceJ1indRgZy5wlrTB+mtibY3Ge6LzsJe+0YP/NfxomNzqq6xW0hIirR3SDgDZMkGBw9
	hWCcjgdyom1LYrdwpcCPl7aH2UzD2ovX3bzeB2v43FMiVDmGZPmjYucE+5JVdA==
Date: Sat, 23 Mar 2024 16:55:47 +0100
From: Max Gautier <mg@max.gautier.name>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Hans Jerry Illikainen <hji@dyntopia.com>
Subject: Re: [PATCH] editorconfig: add Makefiles to "text files"
Message-ID: <Zf77gyA28KsZdOUs@framework>
References: <20240322221813.13019-1-mg@max.gautier.name>
 <xmqqo7b5zy84.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqo7b5zy84.fsf@gitster.g>

On Fri, Mar 22, 2024 at 03:40:59PM -0700, Junio C Hamano wrote:
> A question out of curiosity (because the answer does not affect any
> conclusion): Does editorconfig attempt to cover any non-text files?

Apparently they it does not differentiate binary files:
https://github.com/editorconfig/editorconfig-core-js/issues/42
https://github.com/editorconfig/editorconfig/issues/285#issuecomment-267400370

> Two more questions that do affect the conclusions are:
> 
>  * Among the files we ship (i.e. "git ls-tree -r HEAD") and edit
>    with editors that honor .editorconfig settings, are there any
>    file that we do not want tab indentation other than *.py?

$ git ls-tree -r HEAD | cut -f 2 | \
    grep -vE '.*\.(c|h|sh|perl|pl|pm|txt)' | grep -v t/ \
    | rev | cut -d . -f -1 | rev | sort | uniq -c | grep -vE '\<1\>'
-> gives for a first approximation (much more if not filtering unique
occurrences)
      2 bash
      2 el
      8 gitattributes
     15 gitignore
      4 go
      2 in
      7 js -> git-gui + git-web
      8 md
      2 png
     41 po
      2 pot
     14 sample
     41 tcl -> git-gui
      5 xsl
      5 yml -> ci stuff
Not sure which one among those don't want the same tab-indent settings
though.


> 
>  * Does .editorconfig file allow possibly conflicting setting, with
>    a reliable conflict resolution rules?

Yeah it does: https://spec.editorconfig.org/#id8
TL;DR:
- from top to bottom, last matching section wins
- if multiple .editorconfig are found (up until one with the root key or
  in /) closest to the file wins.
> 
> What I am trying to get at is if it is possible to make something
> along this line to work:
> 
>     [*]
> 	charset = utf-8
> 	insert_final_newline = true
> 	indent_style = tab
> 	tab_width = 8
>     [*.py]
> 	indent_style = space
> 	indet_size = 4
> 
> I am assuming, without knowing, that the conflict resolution rule
> may be "for the same setting, the last match wins" so by default we
> always use "indent_style = tab", but if we are talking about a Python
> script, it is overruled with "indent_style = space".

So it looks like it's possible, if we also add judiciously .editorconfig
in subdirectory where we have other files which don't want the same
settings, probably:
- po/
- t/
- contrib/
- .github/
- ...

Not sure if that's easier than adding stuff to the to the root config
though.

-- 
Max Gautier
