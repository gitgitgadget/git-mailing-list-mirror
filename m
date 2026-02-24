Received: from mail.delayed.space (delayed.space [195.231.85.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C371E36405C
	for <git@vger.kernel.org>; Tue, 24 Feb 2026 07:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.231.85.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771919007; cv=none; b=EyDWFGZERu6lZQlaQCGlh3v1RpA04DebvsEmwS7k//3IYZ0/sDDBjHvyT5+NMulVHZ+yq6g5NVd7RatCCbojyo26C43mQThlgYaipX/kPyUlmDBRsqoXG/V9J0jCGL9bxgQqZ3/dSGQByq9lntsXhBseWdLOaTc8IzJD/2SUygA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771919007; c=relaxed/simple;
	bh=3gaEDJl7OIC5GoG7hu/II7yQEdK1DFYGdVduISIAuyA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kJiQP0J1KTj3X4e4+UWjHDGBsNVVsepysmamyf+GfOUG8biymNQozrdofXVSKmT+0KYnkNghocnzmOIYwBuFlGkjacZ7FFVlDzboyvQsX1YrBgUxBCI+c/wCsdymXKNBqxkDYksWA1gjvF/F0JKnt0inMSb5oJEZe6Iw2V0Tez4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space; spf=pass smtp.mailfrom=delayed.space; dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b=WmJF4F1H; arc=none smtp.client-ip=195.231.85.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=delayed.space
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b="WmJF4F1H"
Date: Tue, 24 Feb 2026 08:43:22 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=delayed.space;
	s=dkim; t=1771919003;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8YyJ0U3QD1xUc+jTt+yU+ZYbgyda8GN1ptLY3WHfYmI=;
	b=WmJF4F1HhPfL9lAM2gkSJjCi/BUZI1Esvoh6+uFFa5gNorduvB39/TAAE4jpS6B6rZVT/T
	Ao+4tYJ4NtKkcGxwUUQgXZZAznLRnv6jjO82ob4g0AdyH66pZBWG6eclmhHlA+V7HZAr9B
	083yNQ7mIz7VrII72oPsUxyJkXKA5DR2Y4cqTSrLVzAw09GIaW0W4mLLKzpMzy7wqWoIfT
	DMQMMPU9QR11e+MtG/LwglOSNOpU7V95p1xUlwoqDSwSQs6IXUGlzaagbEKptGXoXZ5AdK
	MoMi3pn1AXLuB51mfE6sNXMGbswGcBGa3OiuoY1cGLDj7IXtiWMtIzjt2eU4Dw==
Authentication-Results: mail.delayed.space;
	auth=pass smtp.mailfrom=mroik@delayed.space
From: Mirko Faina <mroik@delayed.space>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Mirko Faina <mroik@delayed.space>, 
	Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/3] pretty.c: fix null pointer dereference
Message-ID: <aZ1VUDSc7LUDC-Ty@exploit>
X-Developer-Signature: v=1; a=openpgp-sha256; l=575; i=mroik@delayed.space;
 h=from:subject:message-id; bh=3gaEDJl7OIC5GoG7hu/II7yQEdK1DFYGdVduISIAuyA=;
 b=kA0DAAoBSHl+oZwZvtEByyZiAGmdVnyhY9ccOeXnMqi4OiztGslp03uGueAs/g6ENTV0x1Xj5
 YkCMwQAAQoAHRYhBP8rLfsrSlLCbCzJtkh5fqGcGb7RBQJpnVZ8AAoJEEh5fqGcGb7RFzUP/3Yy
 oTaFZDx/sqEWtOOwt8mz5ZrPn4tu50YQF6queTGw5qAdmXbIfTZIV1WVNwSGf1GF05FSxX1yQ6c
 Vl8QcgWrZB4Zv3EMJ5LP2KBjATyF51ebhcl4LdsesRSuNlJDI86QJjkzjbBZS9agNhKEmJnEf0U
 VzbLk2gxmqxdFuaeGgxD7YZtxUIZ8YHXvSYnki//qkAfYhRjkHTqY7xR3aOH8ZiB/D5b1C1fv7N
 PZUkZlRGnYDpNVhvd7v2qO+dC6AWLPg+2FMT3PhVLt33VXHvJKSmfLt0V8yVS1pDPgLNQHzrDOD
 7doddC/Y3FbZ9rppuwLJ1vvcwNH0X2ozIc8+XsiE4nWMSZOekv8cu19sD2OotCAmA+fYLAFc42r
 Di5/87ASfsvLBvU9QUF9TvNOYGmSXSZ8hyEZl5BlPzswpczdu1laI36EarCfteMj3zm1aQbTuXw
 9rMNS/wY+w11zCHlG9OQxN8viI38WgiuLWCaQfIkWY6QXeMuhpGmNQgTVda5nGstw5XpAALnq+/
 nY+JX89Y3h2RTMnN4oHCLwNnkm/MQDKiV653ukpkKFBDFjHxMqYQ14klRM0aAoVqey80gATuHyf
 Rt4iaSIZi6xd1nNO+xsJdM0uKusUGOxoq97VCe7JNQM1bxSpcCWLYmwM4l/OHba0Yku0Svg1sPW
 kLKM9
X-Developer-Key: i=mroik@delayed.space; a=openpgp;
 fpr=FF2B2DFB2B4A52C26C2CC9B648797EA19C19BED1
References: <20260220230633.132213-1-mroik@delayed.space>
 <20260224040400.751247-2-mroik@delayed.space>
 <xmqqcy1uk69o.fsf@gitster.g>
 <aZ1JND7sGspCJEoc@exploit>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aZ1JND7sGspCJEoc@exploit>
X-Spamd-Bar: ------

> void get_commit_format(const char *arg, struct rev_info *rev)
> {
> 	struct cmt_fmt_map *commit_format;
> 
> 	rev->use_terminator = 0;
> 	if (!arg) {
> 		rev->commit_format = CMIT_FMT_DEFAULT;
> 		return;
> 	}
> 	if (skip_prefix(arg, "format:", &arg)) {
> 		save_user_format(rev, arg, 0);
> 		return;
> 	}
> 
> 	if (!*arg || skip_prefix(arg, "tformat:", &arg) || strchr(arg, '%')) {

Seeing how "arg" is being handled here I am now unsure if it is actually
a bug.

CC'ing Jeff for clarifications

> 		save_user_format(rev, arg, 1);
> 		return;
> 	}

