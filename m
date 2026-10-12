Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A4084C6EF7
	for <git@vger.kernel.org>; Mon, 12 Oct 2026 17:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791827802; cv=none; b=dz+wpOLtdqvHcieTT5BIUXAi4SAynG2S68LblC+MByrYbr3hiaIAj0djy1m8MSLcU3lBiCsyj3STTC6IgqJH9O0New2u18DXuvME90kBqTiIOKttV3+gwNyapM6PFYfAE9vZ6gV1DXNUV+t88yVPm1JTk0cDPfA6F8Qu+18/oIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791827802; c=relaxed/simple;
	bh=WahQw6OuVgwOj5l8Xuyy7Os0np/s+YvcE3ONc241vTc=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jwqiV99PftTr8alXS6B17xWZZ1+/NznExG3wML68ZcsNjzTZXq5P2ki8uzUziF+LFLFt//l5YVJHCmG7SJb5yxU52IsFXowEqd+37jnGxMeNisv5uN4VJpy998JlESkqg2810ompUn7P+C+fLZ92nVLT2KezmQsrnvAOrXhGkCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=tboegi@web.de header.b=T5os7NEu; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=tboegi@web.de header.b="T5os7NEu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1791827797; x=1792432597; i=tboegi@web.de;
	bh=ZA+1lFHtKQYAorB09jwN7QhmxGXFhyZnM+UrSCtOezg=;
	h=X-UI-Sender-Class:From:To:Subject:Date:Message-Id:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=T5os7NEu+o8AYVa5MMdfhNTHEqQ5T4IWIsInydZi7UcpPeFxzqjpKsz4zhIBgdi2
	 jDZ88dlVKR9/9E2EIN2bVJteI8gL2Aq83InMGj75tUUVq0jYdgIuUprEkpCelj2tn
	 k69bAFp0kRv56XcOalM6Qud5ZYbkP2ty57Rv+agOxz3wg4G7i4msh3wscNIlmT2oI
	 q8SPhkyoBHOGg6zmZgXWB5URuggaylL3R55CDFR10XJLBCv6UrWt6iYhzRhdK7gyR
	 gRTJcRS3zvzW5xp4mkLvhkXqWwFIUov/p2xdYyuEN/Q3Nc1olv0oZjoVOBV1cpLBA
	 MJ4GHdBYHsy5Pxw2WQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M8kAH-1xKQrM0EaX-002SoP; Mon, 12
 Oct 2026 19:56:37 +0200
From: tboegi@web.de
To: tboegi@web.de,
	git@vger.kernel.org,
	curtis.allen.smith@gmail.com
Subject: [PATCH v3/RFC 0/1] read-cache: do not trust a size change when conversion
Date: Mon, 12 Oct 2026 19:56:28 +0200
Message-Id: <20261012175628.3692-1-tboegi@web.de>
X-Mailer: git-send-email 2.34.0.rc0.25.ga000dc5aaa
In-Reply-To: <xmqqwm1no29m.fsf@gitster.g>
References: <xmqqwm1no29m.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:9NZbKAf8WXy46wKqjp1kg2U1UXLjveI9fh8AAW3/cElc7FjDMeD
 mfasFl+kru2qCoJz/xKX4+S8l8WY2ds/VJubXwH+3zmSSK5UfuD6zDcCPurvxoWChG8wkrC
 1Xo4N+5/elGx/6HC5Bo+wCqssij44s7CvEPj7Vnpnlcr5MitG0bCQZwIrtM7QLg7KeozoIX
 04sCMyCOhPloQ+wzDGyhQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:9FOb6Zz6X6g=;0f4zBJntfjMmzPlNO4uClJaDxzZ
 1XbJC4m9Tmvogoo74KCUq+vEQibZNYlgCiTsbfNS2SkDBXOcpRq2Y9A0+raUzcSaUjCQhARqr
 ODwjXd4eO7UkSi2eR+PlBsfLckTUd9UoFaQVyzMBGQUh4klnaJS6bJ1ZF+s0F9bVatuz2i/Bl
 CqoB1MnkBp/nS9GmpqupuRiAv0cOXubdMtp4lTW/E9R0hPF12P7Btucwi8tFJag0ovfWSnfYX
 ZGAX0/hoKmM5jUzFe5iLbjCndrKQvLe1L+bn65HKZXAHnob0O4iX1L8IbKTv/cgLjaqFsxi9A
 9bLV1PxEk2M047U+ZJeXI0rKloVZtIvUreMI8JUp5OBylR4G/FiHevJZK0UDvgusfuRrD7gBf
 mZxZiUvCiQtpZ0LwRZPCtnn4VuDke16wv36GvtXxlOkYh4pIxWcFoCKM9Ig4dyivPav0I+NIZ
 85reQoSlMVvjrP8E4pjQLmq9Jylce7l975FUPXk2Ppos05uvmAe/zn9D7HK4GVmeaDHpM4uZq
 DC+c3kKjhT4Rot/cwg7jBmm+2qgKDoLlt+2cMeQQ46l5TWGtlLM83XHidSGVAT3o82aNEiiFU
 f7Aij4ZK3/st7v0zkeTj0GTgRP45gwdftBJKMrcW4fiTm5RRzY1YmF8Am1f8Ce9yQ+qbmVFQ+
 /fSTlQ0cqnQdgAccUHf1Z9lZrUYdjB7o42GNL9Gs/vzh/24qUr/LucyaUc18H9XXt/ThSPwkS
 P23v2OfU19ZCK9m23Hr6ys3skEpccowcvPONH00IAiHQj5qEyEldZrmfzb4TDJRUYdlItMgOH
 SX8zTJaUtub6Xshf0ULlj+F+eYXj6B7aeFoZK13XrgzKKbmrnIVUJgGTxTtax4vINqJrM/r6r
 AGcfiiMgmHXQoc7EugBpubLA5/Uiyaw8YiW+1ilJKWiEc4uBplgihZtoUdRerEQRss+igPmuh
 ayvi9xRqJS2ySmPaDsRW9jMI/8Pm2gd8Vs04w8n+CHTcEdBXUR1sYW9bZe3W9RLTlgZKQ35dl
 ZGA/Ph/RCKPeu9X8TnxWqX1hpMilxPuAt0urANZdlPTDNOK/9bd1kVN1ZEat1V3ohax2shYQE
 sNUVdWU1NRsAAUGD09PkJkMcgerNYy7fNwoB/2dPAN4dI/9bJawfrxH7a+ZhB+vigRHOgFTpr
 crEC25VMElHqbR0DseTYVVG00BotQSIl+Irkx3p1z1MgXrMhA2yyaNDxfpMkUGUyg3EjMvYW1
 i95U61hKBZmNITQhdqmtahcrDfTXf/UCPdcRK32gTeJ2sW5/N47HhYbQ25uKd7gv8sX4WXVWh
 kuBGcWL9QRvPFV6BAwS12OOq7Xu9wVqo/++gaA04zmjyYB89nnvcFov6hzzKJfntLq4dJw/k+
 cs0Im/bQPUgETjLH4g1vaSyqO0osT7V9aQf44OHO2lZv5zahSdfvS9nl1w1DaZCCK37JbYfq+
 Lr6LEzM9CZGTM1dEgRz0qcaoGkjAe5yLpTG2p+afh6NTnqn8nUQJLzyWMROuruSScV3Mzf744
 nDM/w3QUXjRBMlXUXdxzq6SdGr3itL38NnPAdWKoHU1qjKD60VDmvrc8xHO/klFI7QpMrJJT9
 /VhGEWHQNKkoft/eqCta2QczDDWtPV6dPjniB9g+LYZTcO356nn42/kH7bcHav/z1d3uM9WIK
 hfR9MaLee+SasPv1xmUBQ/KG01YjAPlozDVbAN6TLjKtFy5Jv7ZJN2TVL2r1o3DKK41R11whW
 7LtV4L+zGd0eRE5OHyCstrkYV03YWh5EkDoaffJePVh+9IMCn2GJYklWKIWG1GQHLkgcAAY17
 h29jzXtuea2txJhDj6R0RYzclMPhNuq6wSb27xgkTYpgoUJxwuTqM0CpA0ZWwERvHKW9JlbP6
 60msoadWtSczWoLmU9vZqbT8iFLJfygjzlQdK1NWhxeCcAFJAcFzU2gXUWa1eZc2y+sR4lDkI
 kzoRD3QIUP0el3Phci3z9OGgckqybmOp2PQBKMRzm1dWGw8oPWd2qhj00VDO+0Qn+/a2Q95Ap
 z3sBchkQI+/8OUKStGWBhKX5WtZn4Vp5EaTqVnAZtmrWGsRFDhKfdCxqZtESCVaw7fBXHgm/W
 2iCPQHDhVKwWXwyWXnZMGPSYW8dmk4moQqTMhNGLDtX1XAuVttW3pUAHYPbEsnhszfDUMwWYH
 gmlL9dWIMGCQp2ZpfRC2wtpbP4y7Ju+Tz4YxbWLlYppPsvB9DaqtxTx2DSIi1aJuQWOahaIVN
 WBkfazIa5j8/m7xyRhOiLuV0s4ix38jV4M8g7mNjeUFSMiVGzkkaWWIWNIFFt5GE6VHgBftm3
 VDqkK+dHrsRtE8Uq6nZ+OCj3En7tUI5IerCIufea+71C7dorgx6AE/br5u0emqR2xN38DHVzn
 cREsgCe4+/LnUAqbdezZGZkPraqEPw+IEwmdZnFQoOzSHfPxtz+4iPTa3D7+ukI/20IW8VrNN
 bEovFjJzWrZinl988rxFtSbUSl/yQKtbWjPPb5SAJHkhc5VTZWaGBv1ALkbNmMPbyPXDd6iaQ
 eWeRxoGw7Dl2mx++qxlr7fmiRrJMH//zLdYmZ/0ziaSle+tvLgDW98VjSvfzZxKn2w3Hkm3Q4
 dFuzgH8/0797ZS67/brzCbs7cVerYe0Kt8qbcTMG1iblJ06dwcH6UezXLTiK7aO9MSDL5UFtW
 ejN4bvS5jYl9ucMi5QYutiMM5RH0syUTAZFPQQvbkJTVcLOCYBtkcUqbBwLMcEN16xqmZqROg
 PEZLtr2fPwgIps522S2R3eZN3+fsBgNL0KrLufGkXqTdvWEJEO7Q3HXzpAu35y9QgSdKiEuVX
 ntVMpdIkmePLA5k8zaTsLQ34N7zRtDQbQC7CJO0NFT9F+HX9QyPtRC1rnCKe0y0vRkbcxNB+g
 wQ9xYgX+I7V8ypeu2pVhLJ1Yqzy9qre1Xe70px8VM23WZNOzKRQTQgDCTTa6trzlzSB7rIBRX
 sDC8A7uzSJItARiylLzFDykxZ0a7ADia+gktsx+Xtxg4CvUKVYz9P9O1jyRKXDyqwNuxuGPhS
 GiVK3j8Eyafz0FLyaXsTbYmB+f87anTvy6M2LcRHwsRmpWiQ4lU8Q74mtNT5CcijI7yVB35Fu
 nH7CGpOQgQDNeeZycY3LmceYW/KB4CAs/AIkColDtx6dqyTaEAE6hIHDjoT6OsmclvP6M1d6j
 0bw+ArdSPoHQhYfAVnEjIZ1Y/BGAjAtMvjUIbbZMM2paSvX2tJJJgGhKfPmrBZKlTwv3SlgiC
 jpevWZo3z3zvYul/Bq0f4+Wz6Aeu5ZxVhnS4+IHcKHW577ArLtlID+0WOzDw4XLMuHhIn8l03
 L4LIOAnmiMH4STnCRUxKSTTfTtHj/Lfvoj45ar0MaAa3VCis3iPWPUkOiLdZ1TXj9XsuhsIL8
 /5mkn1Kkz8xl06XsMUla0uuPnR2muWH0FwvZ73j7ZsAnabT6aMs5gLa0XDqmHze7nFoShJV5M
 woM9rCfrXUvNwObjR8FPc53BiK+q8CIwDZLYXP2puMkfuwwN1ejKV/U4nTH8xxVYN+GTem6Q/
 1O0f4Jiu/PZUd0clxgLfk5hBauk1NHaXJzy4fggVors/Q1kqpWwpMpJZG9i0NLh4+vssbR/4P
 5glm9BhBBLsTT4vqcl/wo77xU4gL/iudRTWqvJaa4cOvV9K+iWYYqyQbmG28VHkIcJEKx0YZT
 uL/aRWdYP0owxeEmcxpeVB8MS/Kaqy91Wwxzdjf03ya2DzSKFZsxmqicJ6N/tTmZV+Mr3Bgk+
 G3lp8pCDhc4KHKuVW890ctPrsLmKk/bcfM/XYRvxBkeZcgufpWPspDG/JkZBmNRrLCV9kbeqX
 E1q0jlm3U8Wy1ik8l3ZoTgAczlIP6RBcNN64KibMQTrs3X54zaKPxIB6uOSOZGXrGbF73uDxp
 kU7mmYQ+T5v3GibD4mZsbZyEIc+2kihDK0/hMj8bkhErlqVrnA3kdYMst9fd7n8KqowmGaWZ3
 qHvE/WshmbZ8VUUfa2FvJhdjYS3HNOBUkKUmo7a1aW6AckrIfNznZd6U7Uskpgf87BaX0zjEy
 GDgOh3JYA0Ns81rXRXl4xe5OtTi/rKK73j0ce0LI4E3nW9Z//k4gn5Kr/HK49sS0ZgA1sRi7q
 upQEXCAVvKXcooi4Lp5UAKe4cMEiCbQEkWVkC7YrV8084rjeNXoFT1BZgTqofonn1J/or+TAC
 pLjqfEplMi9a6fS3uUQLZuwawt9aw2Hs5gqvNugOwIIaoYTI914WirocJPdtPCLm0g5NBWjpg
 2YRD30QKfwle9xJE2+4hdA0UfBb3badiA5TvHnaTZBFbxxBhTrwgYZO9NUSYGwJ62Qp7hCuVg
 nKfzLrS++A5v1z11QowiVNp5n6qjU/DmgU1RnrMypICZqkNhf06NyFR9Hcalih5tS6HufCEU4
 KBI4E86pLXA/UNmCB+2ujnw6vM2gJ8GkIdjOT8bbzUx8aQ4Lqav2nAZTn/PHAveampYPQqGl4
 M8kC/HTbuZlr0mGL5wkP/sVAulPlUVJmAYWsriFK4U3bBC8femk2zcF00zJ/JBio6GUC558LG
 L04bnD3r3x2VPlPsCv5ePBGXAfgsh+Rwt4Urr9OCctt3Sy7ZdShKXKdqlw+H3E4BHN0j270U8
 fjp1kmCMD1HUh8/iFKChh3FoQ+tXrDW2vcqHAlSHYlrscmlEtwLJoJKjI9HdPg04GAI3yDdke
 fdEap05HNtn/qdHyNgWKSpmAR3VkVjta0zztybkK114Md0REyAXi7p9/4of3qzdB+mt0kLBI3
 VdOB6I+ZmcW1/0zltLtzjOKwbwfwCuw/KHa9ZULo0sh6jFLelRfFgJfAX3XQMwdIW9QHQo4+q
 9cKNb2unbj7EHScYu301Q1WO1hbg+uFvP9mBvFE9PvLbzEOOXf1Vbi/2iGI53RDNfrK5nCkQ6
 lqr3Lyg4JLVpp7qtLY3dXZpC3Vu+TLfQQPn+G/bBF4xviMkLs7udFXKHlObr1uyeIXR+ToHjO
 EJXq/EZ6T06ktCkPdZvf3bT6rvrP8U7SpgpW/11K6zuKQAUnyg3XrDYk9MewV0410RmNvkbYH
 yQSh5cDI3VneyO+NKaL8s+Ub1nTPlvjqG3aNF25pJe/WUemta1IPvhnY+pPvG3EgJ7TvO5+ua
 ghRCxyC5hytHMPBbQ8ylQMYqzQ+8Yu0KfvNbtpAd57CGqIig/dW09IxcqO580eYVeVTy2NDyr
 blI095M3Nvd4S1illUIwTnLKRQYFr7TLbblVP8WOZ3YD0Nxxdu/aJRF8jXqC8PnpyjA0H/IEU
 4RipDa3oV50H+Fzo8+TDFJAo84hBOXmk6iFaCP0/v703UO/0DKUL5k8jQoWWkkyziJrjWObzs
 umoNpWUQV+Xkqmo+Rwll0CdKKa1g0eNa+5S4k8wSGlVDDNuqhj6+iNMOjiDnjA6xLVFT1+lU1
 5VAjdEjoNI+5ueRIhykrhGld63sLkdNjh56kYXN6sBpAM9S/a5S3iXgfH/CY1KVwjB4DKEwRF
 vT/F76UpexNk4D85471/l+NpswcNZxMMOz/bGki+aaz1rp62q+FtYtmypAY3yFHvAN7yC6NDh
 xIWZszT75yju3jSzUp7tlb7t89wugUzQ78IutZr0iHsq8OKlkDZFKEr9jktPlW3kixNEUMQ+4
 5h8ywBhA41jIiUDMS8TXXvnpuvml3YywTvMu8wteO4kbB0j/kgR3YyqePvp8RaxZr8xL/VK90
 UYtXMwer2l6pCqpPO6scmEbWdOn59nr6dKhgREe7M/8TBEQbzun2JimnxQSB3pcgj6YEk9qcO
 qjuMCZgRnNn5lqnWhwjvI7YjLmb2NG6laShoAviyX+Yedl3L5XvG0WmVRVMB2780N7upi3ATP
 g/kZunuxlw/ABWLqb26B0M53nojAqrIENATQtlyqsZP0qos7cnR0c4v5zrS2AgpRvCh2h15jY
 7cUOH9C4zenP7g+1CWQcuN3K7Keg3Ypft6lpjWwaixSmCK1GvXrxGHYW0jdubHzQ5bVCD0rg0
 rkV48C6sd9AJmHaskpEus69iGA+NquvnFhE0tNiF6hKgmTFoXNgwbwOhV3EnPW+D6vW1Q1ujJ
 dWMtEZOmqnQbu9S9PU4MzvVh0yZyzQ0E/X3TCadrHqVsw5kvilCnTBnmAPregeczqM4A+HK32
 qmBjFuqi3IkOQ86tj1D00bYl7wgwneYeSBLdfQH2/kzAnbuGvidKMBek6ro4Do2zxWL9Zba4s
 4LVNhEMqbXk7Kd0fBOmym8CVlk22fTGdgWwwbCvit7HUDTSd79AiaSYoorCbKWuLkZqsGl2L8
 ovNFMZ3fiWkZOQhe6cUsaqeobIRw/e20YSYZaVFjaBwj2LcJtsl7saUtYOK6Vl9ruVkvEbYRG
 AcPFdTmkxZmDW7GweBViNClRLccUCYn//K1JM+jIvpPCufOrq8Y9UvS+L0XV+FlB6Sr0G5WHj
 ErmId/0necfkjlybkj2QxeXUiEFGz11jKxQIQJruCGAjLgv65N8QndU7ezaw3L9nEx9QrUjBY
 bp3wzZizPimUc2Z3RfG1WoO5dTLOjmKqDeowR4=

From: Torsten B=C3=B6gershausen <tboegi@web.de>

- Pick up the patch from Curtis Allen Smith
- Reduce the commit message and especially the code changes
- All tests pass here.
- The commit message feels still somewhat bumpy - better suggestions welco=
me.
- The original series add a configuration switch - that is removed
- I took ownwership of this patch and add a Signed-Off Curtis Allen Smith,
  is this OK ?
- All in all this is not the final version, trying to move things forward

Torsten B=C3=B6gershausen (1):
  read-cache: do not trust a size change when conversion is active

 read-cache.c    | 25 ++++++++++++++++++++++++-
 t/t0020-crlf.sh | 45 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 69 insertions(+), 1 deletion(-)

=2D-=20
2.50.0.rc0.46.g7014b55638

