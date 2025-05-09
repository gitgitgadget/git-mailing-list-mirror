Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A5F31D7E41
	for <git@vger.kernel.org>; Fri,  9 May 2025 07:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.92.39.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746776161; cv=none; b=FnePhq6UmwABMJHKK+LyWpadVeyNm1eKN0y/qNY6RlpjdSYj7+7ov4elOK9StI/MZ2qcbVRdQcR05kV2XXfOidoR5JFHrvSsoU7Z3c9o0v7CBwW3gKkbjoTaXTD25w1s7Z9RyiGDQT2w5t65zsT/qSOJIyFOTDdjawJvFQCq0YQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746776161; c=relaxed/simple;
	bh=Fe36ONOX+x39C4MasyX0oa7tD6W0dKpE6DVj33sA3sA=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=anRJjucvJEFVoRFHigwbB/Z7mcfao5wV5dsydsCk2+lQzCYqqC/HxT+SxEYmRAo+6dVjvc4OoxtclkZDxE3goiq9DEvJQqUfIj/XjV1+Jpakq3nQSEV3hFBmKWuieZ7v4LfwuDi0pTKozPwjkP3ez20zRasxRpn3uW+NsOCP3cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn; spf=pass smtp.mailfrom=smail.nju.edu.cn; arc=none smtp.client-ip=54.92.39.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smail.nju.edu.cn
X-QQ-mid: esmtpsz16t1746776130t5ebafedf
X-QQ-Originating-IP: LRvmMe5vyDP9djQL2ohygDbBsVz7STrj2vQGxvHEpAQ=
Received: from smtpclient.apple ( [36.152.24.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 09 May 2025 15:35:28 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 12614574274519910953
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.500.181.1.5\))
Subject: Re: [PATCH v2] parse-options: fix xstrdup leak in parse_options_step
 parse-options:984
From: lidongyan <502024330056@smail.nju.edu.cn>
In-Reply-To: <aB2ejA1tCK9DR1Nq@pks.im>
Date: Fri, 9 May 2025 15:35:18 +0800
Cc: Lidong Yan via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <CC653689-3047-4DFD-9893-46D08F948C10@smail.nju.edu.cn>
References: <pull.1954.git.git.1746585203.gitgitgadget@gmail.com>
 <pull.1954.v2.git.git.1746624294017.gitgitgadget@gmail.com>
 <aB2ejA1tCK9DR1Nq@pks.im>
To: Patrick Steinhardt <ps@pks.im>
X-Mailer: Apple Mail (2.3826.500.181.1.5)
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:smail.nju.edu.cn:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: MIAHdi1iQo+zOJPpvkLEbyl0wfr4aDl0JGRmDMsBHKjee/IAoBOBjMYy
	/vut8WjV+NzlVsLJhG2vuwaWTqSwoXXhtm9IVzM58iazADsp0L7n+1tDTdG8BF/SnGxykdE
	HXMNtzgTcHIjkaokSD2iAbze4mjclatqTvHWos4RSa4sasYaWxAaFvjOmSRsOXBSFy7WB8H
	R+vOAIczuXQUeMYYE0NNvDH0b20mZQ/4m110velD1LU7dLdtqq9iHJMmw0lLgWXkhfJn3xO
	kU7ZTu+inplS62XJBu+sIDfMPfGlfZPr63aVhI1kVWWUHeeBvoqYvurOpStZBLfZEHUDhQE
	Z0t9qMekLxq1+Dl3is1xFsZqbGlChbbFRrLVyZgGLVtVrAw3awcRJDGB9JmDlwVdWa9QQxL
	zBTQsFIKyVxWF7Gi8TqhT9zwr0lap2Q2mskEbq2RMLJfo0yZTZGtqG1ZyyO5XWeQqMPtZuB
	UPoDLXB+BZhDbDdj14v7voraIiraNuyWvuPkOlyfRRGUVOfgmbLPmwPtEG0O9Oc/qw8PyXG
	kkpFLRROlvqHsqV8z+3XYdLv56F1mX9PEe9viAJCyJe/geNvxL8Fgmt/SBknglE7ARXaURp
	ycBNBye+/QTZbdsFD57tEnSri2FZcD3auD0nlZqhJPUUMa51XyMPN6ryu+4W5i57JcKIBhk
	Yo6qKl5N7Mn8D55Zjsk+zGu/L9dU0MDsmLkr5VbTdkJuXl4kTwYhpvezVkFYX9Qu/s1bi9R
	eAoM29mfdHjRLY6QEsAWpgGpsYCLATbCZ97FXui0K6q2/G6qiGYbPVEzFbw7QJoc5ftAlF3
	4oSaTxZmZuQXWs+EAWDE1mORrl/xj6RxT2mtDiWXeYnDyVDGcA6tsJR2cdOnGrAl6BjdAMP
	vJZy+RMEjgYSSA9hQY+cgo17T/q4kCtIHfUAfJW2H43uG+peXUwsycLhdOatbYZtyUs5zVt
	ASWvWAs0HsYMSJetxVBWhY4uripmGElauDUNwgKnCIdIzjGZ38khztd01YfKw0gHeH3A=
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
X-QQ-RECHKSPAM: 0

2025=E5=B9=B45=E6=9C=889=E6=97=A5 14:19=EF=BC=8CPatrick Steinhardt =
<ps@pks.im> =E5=86=99=E9=81=93=EF=BC=9A
> So does that mean that _every_ user of the "parse-options" interfaces
> now has to explicitly plug this memory leak when facing unknown =
options?
> That sounds rather undesirable, as there are so many users out there.

Since the lifetime of `argv` last until the program terminates, a memory =
leak
can only occur if parse_option is called multiple times and at least two =
of=20
those calls use the `PARSE_OPT_KEEP_UNKNOWN` flag. In the other
words, the memory leak only occurs when the statement `ctx->argue[0] =3D =
xstrdup`
overwrites the result of a previous `xstrdup` call.

> Hm. Is there any other usecase for the `strdup_fn` field that you can
> think about in the future? Otherwise it feels a bit overengineered =
from
> my perspective.

I think a simple approach is to add a marker to the string allocated by =
`xstrdup`
, and before the next potential leaking `ctx->argv[0] =3D xstrdup`, =
check whether the
string needs to be freed. Like we could allocate one more byte in the =
end of the
string to store the marker.

