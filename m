Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35B79309F00
	for <git@vger.kernel.org>; Mon, 15 Jun 2026 21:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781560394; cv=none; b=UnHiTPIXjwM5tHWnN0KhhruFpihCczMYu5cpK+GXuv+Hr0Vikiy4g/PFKfFPhjr9ykTf/NEHhjiZEzKRMc4AlauHsiUqKrWfvyM4ZSLjvahYCA0PgzU64t+FkOv76lfQSjk1W/g392IofyzEed97uYlHDZfYIW6fMqPe+w3qYhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781560394; c=relaxed/simple;
	bh=IWebSGn5CUg9BgXYOasPSlugtYH3G8YDarFTRJRxP3Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L/5u1bIrfJp6fsMnOiLi4fsyDF2x9Zmccp68HOZ4Rq9HdRHSN1XlD4SjwlukKUxSUMAa3C2c7FD6NIdqCyxhpzWzDM3rBsdo6SrZsRoVLlpjNBQzHUrtjt6uqWZMYWKWCEN30TAkpi541WjLAVfHi5MUXeDUJkodHZijP23OunA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=ctti7gmH; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="ctti7gmH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1781560390; x=1782165190; i=l.s.r@web.de;
	bh=kt/+79of1W5TalX7aNvRXWewcL5Rmfk17csoAxbjO+U=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=ctti7gmHTpFxEuiIalkjZfZA3JC+bNYGui7V/Bw9fvrJWdFcLP+IT4ANBdIAWo2m
	 UIMcCIpRIga+kISMiNvvAzj7qykBu+ogcBwU84Elrfd65KRrHEQ/0dxxj4HFmeQ6/
	 uwNdr8HCWJBvylwzNiYCO898ju/2c2wMQnlfwAqqwPwaCHBoV6HZ9aoN1LhkUYG7s
	 S2dAmVhJmIpR9+mPW6lDG+EUITJflxW362ifpLNvzdGX/Zz0SrZU/H6RXJXQUYknz
	 bdRZjII1e8ytICWOu/IczlBWSGoDycDH7zWXCnGEgTwMDg7r2rQZn+GJF/etzTyqC
	 jOk3QfWTDkyM8fFAWg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MidDH-1x65UP1Ccx-00cmDN; Mon, 15
 Jun 2026 23:53:10 +0200
Message-ID: <df933ffa-1be2-4401-a4ac-9d72c9c4cdcc@web.de>
Date: Mon, 15 Jun 2026 23:53:10 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cat-file: speed up default format
To: Jeff King <peff@peff.net>
Cc: Git List <git@vger.kernel.org>
References: <5a7ed929-6fe0-496c-83bd-65dee57c2241@web.de>
 <20260615165326.GA91269@coredump.intra.peff.net>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <20260615165326.GA91269@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:NcN65/Zkl8lZi3fIBImStSta4St5Qu3RoNs8+0garbHaITifwkP
 e2WaW6Q4nG+1YFBCnFtuOVlCB/TOtMS3fT1JYb8Erja8/kkg6eVPm1CsbzSq1rCt6F14YHS
 O02O2tOFuqz1cJavMmhxOyGMY00XzJLQqZ5v79ACwKXPmKbqQSz7QHcOn3xdlo1l+3dcwxx
 k7DsQJ3NIBGEAn0q0mrhg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:9LkJDL5Y61s=;yMw/PGHomDdCQ51EDqNuShDdj4s
 eWGS4nrxuptUTzunz8goBhOqCzRm/2aIhFVmuZxP7uxdmjHDfx1/mzMm1B28NaniI2G9jpa9y
 j7s0tfbZUzlBeNk23xCmBwNqvROXBl3eCcO15ncyOwdUqv7kJLxQdpNdhdlFp7g5sIl+W6Etz
 qSxT9P3CWx1CLuFFpqLp7QKrCPcwd4FeRqli6la6bxggUSXC5dW+j+xsJxylfqlhBJQFGK8LW
 6Fy4/dRPNdZ5KKGEeO24gxfRS5iheMZ1Nxs3ON+qqPAIzESW8RP9K/8CeBxqTBgO0FeQYoD4a
 gAMgouDESfBMg6m08S1Sjpmx5x2h+hunjWg9PV58pckY/GGLj/zBkZo51LF2XLF/0ZjlpF1dr
 n41twwgzo1oid2jPN/JuZSlJ4NtPeFZ3jXiu7q6RnmMPBVMRkbKba8gn+9RPmXKACDGjvjAVx
 TKhb7Aw+hLT8uvBRwtVeFgWVHe91pmH4xGqwObjHp5qJzb1MNOJqWrYR1u/BnBuF7suxaa+IX
 18W9E3tFhnMzKvRTsdsMqoi7wBI51oPwZiMK9ZCDXkxooi6vXr4PkF0KsdsdErUq2l+666f4B
 HW4LueCjVIw5xtlI9Y30pBTvIRTEX6RGg4h2oHj/RZs+CMhsQkAszQ2iaTW6d8auXkE3ArQWf
 eGEkzMX3TDE7dxXCbaYqKvf9/WZXdI7vqP/v+RWVcYIEwRTS7V0tiJkoiPJGXJRrAdGJOGOXw
 YdcFIzVsWx/F21p+aYXCSqbcmmsAHnZEntSoFXYaZylud83YY6kZp0LcFL0BsVkI/Tho16zjr
 ueD6sAB7iE6YVj5C/nbT0+5gv/6ZNl/26Li2OUeSA8L/6IHFHppe98NpdiiSVbJcR+K1y4j7U
 3pNi24+GVh5PWDmtExBBRg+7NLKnNkqO9mDxruajxh/OEC5PX9OIDCdnPM4gANecCywtQ/zcN
 cJSUbb7FpTtJIZZsBe52DqRAH7d+VofsaNokVeSAbMSBMhNY9zgHf5AdRNoXb7mTng0UlKhf2
 wmrEuTww1DYcPPhR2Fgraa634sIXOLiszRJXOcoRUheDlI7qk2SrhnVJZDwH2FHnEU3cBNfm9
 b1r++KdbSw79lYmm2QZYsW1Oh4scoAakZm511l1R1If343/BMz3jzwgKzo154S9+cfgLUXpRh
 bjSPb7D5ymEuf5BR6ZgmGNrHsDdLh0Z760UYkjNKb4+M0tLB1niulbbXvUgldEXr4pIU9Zvsq
 9NgtQpZu2z2CeWzEJ6eGXj5AeWVGYPZqxc/qvDsi2+egCzgzYkDBPhyggOGQr9wPfynEwNb4n
 6pSVjGsEmL/I48NJGqMqMDNg4u2SL+csScd7Xn7x7Y3ZGesOtxuDSJx5hY09d7O8QNCQqbWv6
 ThAC54011jODEfpYu16RJJnGrYVrMqImnqnYlNzD7CpNYq6Ju2LUJsoQq69p/clI7m8XE3HcA
 mG1vBj6MpUi7UWZoZXmlJi859RxvDTFrITyZaMbSRIoJNKhjATmmshAQ7sSjJd03cgX4SC29k
 Lka0dQYnlQlRyu+WaKkOpR+99QltGy7onbEER1fGVL23l7uPgMXXksV4qtWvujt7Gx2fCBMJM
 xKmwWx4so0PBaT/Eg6BiMCLbInpw6gpW+Tmjr8Fbg46FQfLM8yOAt0BffEIQdgLuCTZmUhOeQ
 LZIGSrU7JZlZwCDN+1fa03UgSiyNwtQjKSbaxRONS4WiHMthsYs94s/zLdS0gx1bchhkgjVxU
 Oj32NTycZgmAaVp9la6pt3ygKdo2GqYSPHZ+YuSRlezn369F00QT0vpCA+ybGwJbLsOfyrZpK
 UXmDQDRzdyq19BPaUdCY/xNpMS6UoiPZf3Y5FwWGmzovLyt4rsRdeMgQ4lRAWNWPcU1np9o1E
 afJPiUGyqBG7Gh5C30RQWyVHf7VgkywjBdBSbYfYHdH7L+YO0Y9nMA6I1S92AnorgTPL0SgZq
 ECEvGlh0yCujitOMyu55j2bBrXkwVZT9ukzDmHaXoqAYPRrnWcxCu9LHVIPsCbR7lh7ZbrrPu
 spe+/UNBJ7zeP6fq6PxbTdCRb/h90JWZWKR5d9bud2B/6w8y1b8tk3br3Bpsjb6X2V3eteTYD
 I77t61MHZCJGOipFovT0bvp2X9VlbRvl1NmntAE/JRG/E35ZfeA3SVYqJJwIBfHC4RTl6txDf
 kGA0YNxvpSEnQGfcBJoFQUn8ioPscygJwudORsnVBFpxifTdb8hIkMJOIhVmoOK630IB2csb1
 gJCY6vfSUdPJU9NJhO0Itkp+uo9jUiFNor9GI3Qi5ZQ8VIViZLaViTU7zbCmOA7mvft8XO8go
 LKO1Fwd5OqdQwkYdQuxKH94R7uQCOiGYSYhEbBOfPbdoMmKSgPPV2+abo4UvDjYbjdDun7FDW
 aPSK6/BChK6MQBlsYyEunUBXIQtnPgixyzi58C4GGs033L8FFOJf/XIzRaTpm7DdlXCMP1TVQ
 WvxZstvRKuPUw5TDgvFu716hnYUGQK0V7sWHgGV+lwBhLoayI2V6uPkxRjvCFJ2qYzt6nYqhw
 H3Z3T6ibeE2JZ9n4Oko+UoX9ExaGBtCcoXbhsi20/WnRaovsvPRN4Q6XrhhLB5a+UbYmaA6sp
 rIKxFOYegZULVZr+gHLOCH9ZzrGzAwuKejMq/B90haUOwI1ao8UMltZSLlQdo4RiUmzQCGDM8
 SRHfEQ2OciJWxb4EH8MfkT6Y/0C+yq/5muaV3Y7DD2GGLSaZmby2Z2Q1qfZVy5ojbW2O2ruWw
 8pk0CfBOnxSyQxuQR9tD/2LbbfR+KTV34NALNjgjrjhAw01SZOKishOqAthy8XmXXhpimFfNR
 oQ69/zdfk5T3dj1cS0TCKGykJEq+K6wYbDftSjspHJqKZzKhJjfedvPQR+l6agikQNIiSSTgT
 rTzZ37ihE6JSD54qva7k8R9C2hJyIsfF5Zn+LI82R1BdJfXTKGWrRKJdRvywxflLkYyTii4cQ
 ti3L0e79NQ6zf82ZEjLXH+VxmYwje3N2sHYtRE/g/S1L1nVm2UDWc+vMQ34WK9CG1bSXyMHIX
 O3CBCLw3EHriJ6ILuFOPumSpGFtZjVkbwJy6MdqUOfOKtfgtKf8R3bdvP5ultxgBwqI8YSIU0
 w6PL+MOg9BTT0q+7KaKIlRVPXTOMmxLUqslyXkyEGBylGm3i83yf1YCkU/R+VC1mg0Ueje+Fp
 9NS+fiTgX8Er9/wPESCbtS0/7gvbzHzHuYk9N35lRD1IZjDzp90SshdC0yiqD/rvDeWGLdO9a
 gxcGF8W4SedIc71kxnmyYQUISIwpb/6VlDw7U6XK3ibqBNdn88+bL1h/rrC0gvE4f73DgqOy0
 00iqrlLB3/CDQQyPId87X5IAv11CK91MyOAoxGgyWEe3RWbcrotIX4V2VZCjZlC/owuxSilac
 A4cwVp3GkExSyzwlJ1QpA4lFsOguFp1+L01NoeFXyO/TkxM+NEBSZbNkBeDH93vxiw+X6g3We
 R32ML5plm86hNaA3CBJiOPCjEnt9OCua4+/H1on3AdEkIyGzYuQBOlU0wdWCpywAXzdaGtkNJ
 rmOqze5/iIEQAu8XYrAAf0MNnmgBeIM0WCCZ4P/RufwAGlomcqpx/ZUaYWF2d18fTb/69v1YV
 gQpMSflfeha8Ba3671NG18Rxx+CJ5TT0tc743KInCKgPLiXwFgc3vUhiSXCtSOxu8mOsHEAos
 zOpUnQQwcUb8uIXOYv8PnjSmSsCHQPwYsusmwB+P6w1Vqm1qBpnFF50gslMZ7XPhjYeHKyPsp
 Abk87vQGNcX5Z09XjY9Qcdq0zl0batLFM3bTo1rCEoF/0m9LbDIfcLPCZOiK9U6jzWHSWe+Nc
 hNdrD/Y5YXsGeNtMW9WPBuCywC4x62YS00DugkGQ2joyL1LUVGXTUAjWvmzKc++yrXEscmhWt
 GM2bz1Qrk/TMunrYgLCiveu0E/14klO5HWxlqLecATZBMc1ZV5X3umpcbW2gfW1XasBXqxexJ
 8Zn181DvgnOEw8HCWLVP8HkaG++O8yaud49kvHtthy9P0fy5OuRLqcBf23KuD3UeZUJcsd0Cp
 JjSd8JE6VZcYn+motuKSr+9sOlY2h9WMw+ziTT3Rs96n2whavjNhnv0Pum1jCEy8eQU5HwcDH
 jXS6/CTwJ18jVmFmfEUhxdUEzJwWJhwJVAP1pdqIpNairsOn1bxRP1XG6Em8Gjn/goRaXJP6c
 XwCjyQTv9BpJyM9JTJ36E0dBGesfYyghEgMFGTjz+t8ocOkgr7SW7rpEXXgURYquTZtqTDzc1
 ZqtG4nUSBl8YzD6u5bbH02v2f5egptAY+R0ezXQC2GU/4dbMUj0heEUrBqLMjXXuFRaVhMfne
 O7DUz/GfXZlw72v+wzhLPu1egbWvczDUVxKSXstCDcJmcD2BnWjxmHTCyp4+yUFg5cQgctkhR
 q2aApfc40NwIPGPOzcS+q/IhVZXWPNCndxHK3lmytS7GJslKlejBvcnGD/piIa/1M1EeDuOX6
 2r+ika7Fh5YxKFDpsmV3yNdgM1tFfjjwR8s/ThhxAsS9aD1Q8AWT2HwxaJY39taEVpbniN1xX
 iGHofYcxuXfi3LtfEBV2BOI1WzabtmzAErMQpi7e5bjdskG4uLiUnxlggt8pyng5UBqeeSI7U
 5ju00JB+UfoDr3f55DkaB7dYILPnadsYOkXHUcYL/ZaD8pN5q9UQ43f8QyhbqG7FYxz7+lMjQ
 P7yR7KwQ37dtRe0LaW3jntgNU4clXMsbg+6ncrIEs7u5w7NimnNQEdWrsPiVVmXQ6mrbPjWOx
 QLBf4uLJ+sLQZ7S9w7O699oYU0Dh/LaQYluXica/6FnAbSQtFa609vhdfMx2BbABsj5FP1flH
 wKd6GIQwVJKW8ZhlqKAOyleEwamBZtenvJz+EuXJzg3ldi/ymUgVbvQPbJQ9LsSXyeAzoqfd5
 aaIZtvPtQYEhXUTAbMCoZYiP0i2YJd++PHWEKpEAbOaRxgof0w3ImrpiMIRCekZewTebOpSQ+
 8rlsd7qACSwbjs20HRVuWb3a+BYjScsRbzFc8oaQxgbM8Nte0Kb0SMarPbNPYfXFmqkMKpEdO
 XeyntffhL+ESTaod6P6ZIYLX6tBVAvsgLKVgxLHRd0zrigckOXC5dObFgDaoprACkwT11A7vE
 lRpSxZIqXgJU3mDPF/XhCByFi2ixYBwxQ8DME2UHIpve5C/PvnqYM5XYSPNiml5NZKLhmrcZ1
 KQX0CniOl/qKAbdtXNrVumUVDwtt/TL8/c1euStxJkyJWiMm/SqgRm6E3MzarpZrrDA8ENCrB
 AfIe274WqkKudcPnVVoZrmuKF3ak7rXkis7Ohq4n30VN/TzmiupW+zH5aR4OcVbWu9c4dRyO2
 EtKkeUykjEHDU+2Lb9Qv5agNX41QZs8PQE2wE7YoV5+0I8bOrdIfSwMnw8/qHSkRBg6qUc7X7
 IQNw84BJzFYCaRR9KMAUvr1duEGGaulRowvysQuweMvRlEEhKO55OKItCVFXSee8+pu81hXVw
 GJTG9tblO3/3O1DiMVefkwmKKE4+UUs4B49NkBBvgCJEyJc5oErihaSzW

On 6/15/26 6:53 PM, Jeff King wrote:
>=20
> +static void rest_add(struct format_item *item UNUSED,
> +		     struct strbuf *sb, struct expand_data *data)
> +{
> +	strbuf_addstr(sb, data->rest);
> +}

>  	} else if (is_atom("rest", atom, len)) {
> -		if (data->mark_query)
> -			data->split_on_whitespace =3D 1;
> -		else if (data->rest)

This removes support for rest being NULL, breaking t1006.381.

> -			strbuf_addstr(sb, data->rest);
> +		data->split_on_whitespace =3D 1;
> +		fmt->add =3D rest_add;
Ren=C3=A9

