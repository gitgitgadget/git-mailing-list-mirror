Received: from smtpbg154.qq.com (smtpbg154.qq.com [15.184.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31F581E485
	for <git@vger.kernel.org>; Fri, 11 Jul 2025 12:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=15.184.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752238055; cv=none; b=awBPeZcLpLwYqOnvYjJcqVsuj91S/8o5fV+pOwjQAUvBxIo5QXFQMZEFhlE6sFBQl20XcoumD3sNOyMEqVQpKI3Jj63zQfibvRIoxsjcNaFwAKzSQJ/7VIy8GhMEk+rtU2hp/ySKST2BFiZmmjcubQEONJ6MtZLmLFpuHvxvOxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752238055; c=relaxed/simple;
	bh=mJQRD3RJN4tPvKCp0c/jukXttez4DpETx/+8XM52LJw=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=oNdU53VcL3vWkv4eCSFzzcJ1OXNMK31bIDvi7Ixp8SrT2yosHUM9wHlVJM8tlyng2rJD1WMpKSrZnCvO1wAvsKN7SPxfV8/WBCE2MqB6Jajpueqt0nlodr5Ef1J3XH9/eD+VbfichlflaCw8KyMKV3Y/hrcEI0cf+2yEsUrn1rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn; spf=pass smtp.mailfrom=smail.nju.edu.cn; arc=none smtp.client-ip=15.184.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smail.nju.edu.cn
X-QQ-mid: zesmtpgz7t1752237994t66e02d5e
X-QQ-Originating-IP: HORAhplYCZOn8a9PEQpNlEG8Rv66hNw1YNxJegS3TGI=
Received: from smtpclient.apple ( [171.116.160.7])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 11 Jul 2025 20:46:32 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 11985850768328319089
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: [PATCH v5 3/4] bloom: replace struct bloom_key * with struct
 bloom_keyvec
From: Lidong Yan <502024330056@smail.nju.edu.cn>
In-Reply-To: <xmqqv7o06mw2.fsf@gitster.g>
Date: Fri, 11 Jul 2025 20:46:27 +0800
Cc: git@vger.kernel.org,
 toon@iotcl.com
Content-Transfer-Encoding: 7bit
Message-Id: <1B012532-E1B3-43CE-871B-B850D86419B1@smail.nju.edu.cn>
References: <20250704111437.2660251-1-502024330056@smail.nju.edu.cn>
 <20250710084829.2171855-1-502024330056@smail.nju.edu.cn>
 <20250710084829.2171855-4-502024330056@smail.nju.edu.cn>
 <xmqqv7o06mw2.fsf@gitster.g>
To: Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3826.600.51.1.1)
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:smail.nju.edu.cn:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: NnUe5RRjRaP4MEOL3ZEsc9uzP8Xhdk1XpyzH+UFfreC7KXyXJGuM0Xjo
	DKxeBXWluZKHl2ItFYl+IAmE3vn3K+mCspjK8GNDdZpdDgR1+TuOwp88J12n9Xyv93IKhms
	9f1Dthv0GD7Y3zD41je/hW20QI0TiUzMHeso78uBZi9dZDI+6rUyznQapre3cQ9IfkkV6YD
	emoPcyFRqBWq6/Lb5/GbfBOpvLkIPZeKvcMR4XnjlLgJtdKCuas2c9nBPqX8vE9cFLXUr4V
	Yf/4KabJhH8ygXKbw96E7GwKXVEqmoe5er18hULq8Ei5DasXblLpOrlYXcb9zSOvzSaJL5/
	lWpv7iL4zF3oJQ/d26E2bPeBHPJeMyI1+zxxGOB5S4BHaI4svW92fzkssd2rn8fjEn8jK+O
	CpvBbSGvHbfgQ25oWvi7mcKaUec1NlcM+xdupvK+aQ1KxkFjXyfQmwfIJjmeYptuvSXOubw
	lW+eORxC7fnWM+OFasXUgap/ShKYVY1w3B04GWP744weJ2GYnL418ha/J+xl5F2+rRnTUte
	LsaOAYpPLrKqofRs+bRvsDRbWVgMq1C0QPuj+v2QS980xILTTehpOYMmtJ2//NA5xm4wQ1Y
	UV0C0BTGh9H8iD2OYbt0eW/iRC+vTjmM/hIz1X3Xw38wkNSFVc3+nViLkwHYfNHB2ndaNk7
	8VFJnX6aA2eRIKHW/ohUsOO6Hp3HgAUGpIQHwuPPygCPPbB+RVxL4utGfre8WvJ2pvs+9xR
	uNAm8oixwEDGbmo+q6Ts6XRfpCbZIj2o8CF/CgkVh7Ny0mdL4KEPNQYGdzsqRI+apE8bOyX
	jVOInudTKuZBixTc77fKxK6JN2UJ0ww3ODZNTWqXbbvUP6R5oxt4vY9npq+t5EjV+viHdQh
	2L70kW3EAgtiEsHApNZ+YGdtd0qsNWFqQ1u1o0hcIC/Xg3s8Ezjum3JWFunjHruArNFVey6
	toETiChV77xBq8rWHAgAbgTvVN7UCvpVnqJEcNuCkONQhSGDpCrE2BG1S
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
X-QQ-RECHKSPAM: 0

Junio C Hamano <gitster@pobox.com> write:
> 
> Lidong Yan <yldhome2d2@gmail.com> writes:
> 
>> static void prepare_to_use_bloom_filter(struct rev_info *revs)
>> {
>> struct pathspec_item *pi;
>> + struct bloom_keyvec *bloom_keyvec;
> 
> This new variable is no longer used, since the code to create a new
> keyvec is in a helper function and its return value is directly
> stored in the array of keyvecs.
> 
>> char *path_alloc = NULL;
>> const char *path, *p;
> 
> And the "p" variable no longer is used, because the logic it used to
> create a new keyvec is moved elsewhere.

Will fix in v6, Thanks,
Lidong

