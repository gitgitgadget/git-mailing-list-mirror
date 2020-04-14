Return-Path: <SRS0=cd4n=56=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ACB6C2BB1D
	for <git@archiver.kernel.org>; Tue, 14 Apr 2020 20:34:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E5F02076A
	for <git@archiver.kernel.org>; Tue, 14 Apr 2020 20:34:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nyu.edu header.i=@nyu.edu header.b="NQo8ulJn";
	dkim=pass (2048-bit key) header.d=nyu-edu.20150623.gappssmtp.com header.i=@nyu-edu.20150623.gappssmtp.com header.b="H1if2BfN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2633225AbgDNUez (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Apr 2020 16:34:55 -0400
Received: from mx0a-00256a01.pphosted.com ([148.163.150.240]:3578 "EHLO
        mx0b-00256a01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731386AbgDNUex (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 14 Apr 2020 16:34:53 -0400
X-Greylist: delayed 1064 seconds by postgrey-1.27 at vger.kernel.org; Tue, 14 Apr 2020 16:34:53 EDT
Received: from pps.filterd (m0142701.ppops.net [127.0.0.1])
        by mx0b-00256a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03EKGfHb060492
        for <git@vger.kernel.org>; Tue, 14 Apr 2020 16:17:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nyu.edu; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=20180315; bh=1xBHr9DSfh25GHxEC+E76/+7TIFbIAhArngvF6oKfjI=;
 b=NQo8ulJn7IaqH8pik9BF4FrPqwrMPXdp+aMzZ+ANGnMIyfeq4PNGM9aLoy3II940Vcsb
 zCFwsJdhZ99jQMP1ou1fxrmlL15Djgss1szRZX+t00P0wTofv28/eG6P6fwqOkHcabBp
 hYQ7bgZhSRD3d0HqjHNhXOEiTMH4cZ0bXsWBk5es32PdPaIU3QvWsQWZuNfbv6eHG9IO
 g9Pqb5P1A7SGn6F5PHAnS+NVmsXuO/lHcV1+25P6lttdbqr7ftqZsNwVgWOcVWVnZPCb
 j9Do2OfbPsOjZODJ/1osZKtFozmkQcVc/5V446N3nmDZsBve/cuijxg0FaXBVgo1HVRa /Q== 
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
        by mx0b-00256a01.pphosted.com with ESMTP id 30buhhqyys-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <git@vger.kernel.org>; Tue, 14 Apr 2020 16:17:05 -0400
Received: by mail-qk1-f200.google.com with SMTP id h186so12785088qkc.22
        for <git@vger.kernel.org>; Tue, 14 Apr 2020 13:17:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nyu-edu.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1xBHr9DSfh25GHxEC+E76/+7TIFbIAhArngvF6oKfjI=;
        b=H1if2BfNLi5TDX9fXVL4ii2Rh7Q1iSJ0Ung5Ml+AbrrGXlOrL9x8e7hM06btAy6twR
         wbDqSUAE+pVpeQd5EHqXkIA8L3ecMxZlBxp+939eFDfKC6AMC7br3K3GctX8tD5a5w1n
         dNH2L1LGgyyf75SbPrwmbLGhjwgJsH8E+/zh0/TdKJgtyrRdSsoerKLrl7JAPF5UnUTX
         AjcwEuLqEUl3N++kRhE1Sy0UHx/wvP5gy08e+eT0dPTdYUgv966+Aba8O6wTg6Fqj84L
         +/6xcsCLreB8qscBiWvKbxj0U1VQfsN8YvH4MKMEsxdmSHN5ewyCBE2Vhy2pCjVue2Z1
         QTlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1xBHr9DSfh25GHxEC+E76/+7TIFbIAhArngvF6oKfjI=;
        b=Ti0gxxDZ9bF/ddFqGCYGVwLt5af17qq2JrfXviKl1JdPi4JZjG9j3PExU1BpLbMyqC
         qotn+aQPKrpjTe9BczTAeJ0STgYWccC4NzTFViqiA1dkgbU1COR89uG7dMZUtE1slfz6
         Rd10F2C4dajK8mHlE5giiDbLMG5BmUVwkwgQN22pPyMBKb7K613vl3f+yKN89Tk17z4x
         fyevNXXJBG8eJHJKBi7qDQvbRRk3z9FVbG6wefjKjqJAH+8atjlem3izSNQpx3rb2WCy
         W4AYOthsMVfW+sfl0Wh6ADWu7RX+R7TmhtiiYBidqts5Wts/p/ygwX+E5sdCQjQLJrNi
         9a/g==
X-Gm-Message-State: AGi0PuYP1LWRUr8683OOHyeeHU0bVUMVjg8101M5zIioKsE5PSGfZR5H
        oXTCyhxLeOj1lqa3YhNsC/GEUqIjeo9dzz0cLzlSp+haJ8XmpOUCGg8R4kxF4wR38QA0oaf3Q4q
        hOMDQ/LQTrZI=
X-Received: by 2002:a0c:b442:: with SMTP id e2mr1854024qvf.34.1586895424027;
        Tue, 14 Apr 2020 13:17:04 -0700 (PDT)
X-Google-Smtp-Source: APiQypLgJdl1wCtA6M/D6g72czGgJxb99j0bPMBaycal/w7bo3qpqUBTsnuU0j7F4Kcx3Ho/Aw1zyg==
X-Received: by 2002:a0c:b442:: with SMTP id e2mr1854004qvf.34.1586895423742;
        Tue, 14 Apr 2020 13:17:03 -0700 (PDT)
Received: from LykOS.localdomain (ool-2f10876a.dyn.optonline.net. [47.16.135.106])
        by smtp.gmail.com with ESMTPSA id 39sm6169102qtg.94.2020.04.14.13.17.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2020 13:17:03 -0700 (PDT)
Date:   Tue, 14 Apr 2020 16:17:02 -0400
From:   Santiago Torres Arias <santiago@nyu.edu>
To:     "Robert P. J. Day" <rpjday@crashcourse.ca>
Cc:     Git Mailing list <git@vger.kernel.org>
Subject: Re: has anyone bothered to read this "Git is a security risk"?
Message-ID: <20200414201701.sacbvbgt6ajde7gp@LykOS.localdomain>
References: <alpine.LFD.2.21.2004141612580.6138@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="3xsx7sxq7jrrsa5d"
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.21.2004141612580.6138@localhost.localdomain>
X-Orig-IP: 209.85.222.200
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011
 lowpriorityscore=0 malwarescore=0 bulkscore=0 mlxscore=0 spamscore=0
 suspectscore=0 impostorscore=0 adultscore=0 mlxlogscore=856 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004140143
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--3xsx7sxq7jrrsa5d
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 14, 2020 at 04:13:39PM -0400, Robert P. J. Day wrote:
>=20
> https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__twitter.com_blubra=
cket_status_1250123442600513547&d=3DDwIBAg&c=3DslrrB7dE8n7gBJbeO0g-IQ&r=3Dy=
ZMPY-APGKyVIX7HgQFZJA&m=3Dk4RlH5EiWlU380Hq8LD-BPM9q79__emrQNq4FBNAbh8&s=3D7=
_aq2xl8ld0WDJk4yd_gefOvg47E8MdlXvcj5aZwjug&e=3D=20
>=20

Yeah,

Not entirely fond of the phrasing to what reads to me like a
static-analysis tool (from what I can grok) whitepaper.

I don't think there's much that can be done in this regard though, no?

-Santiago


> rday

--3xsx7sxq7jrrsa5d
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEkDurc2QOttZVM+/zRo8SLOgWIpUFAl6WGj0ACgkQRo8SLOgW
IpVTvw//bGsv4Zmr8gfWszZOjUwBG8l7KFWpVZYAY/ydPXYi3SsuKv6qLelCK6B4
7+G9hJjui623Er6HC3jQ2teqLPmUhMyBtoFSAh1Ufq5Bi7J6eFFQ78xdI9UnE1B6
lZpe1bQA7rG9f5fzzdzIVGVOOWP6UANOdB0fPPCjJEwm0NaTW+8zpKvZfKNA1z3b
qp3DCGLh7VX4BpXae0M5nOmv/cyhkU0bImtcMVMHgVIHSWdNkPHLwflin8ldki95
SBKKpZpPWOuuIpjP1WuYokq2sUABdR7+K7DZkGPXhL/SHg7n/n99Kl66ztLgrtES
fLL9wKpLdG3ekXQ3NBLxnQiywvOUA9TiUo564Cb9Aoo8BHYbWzpPddGvQEVgooPT
cJXku19IOEllpayhVBOOgCPj6XNG8+jbjXIZPXiPj1e60wyKNOYUOnjY3471mgMN
8D1oP+s72jjzU7fOx4WK/DcmFagWUY/eLCCQ6I+2VfbBABuvjtTYALWxsuYiIr6d
vT6lu6RUCiYVfy8HAFhZTAbghQUs/BAhMNyDRe9pC8IPjEax1AqtVWiSCGtqwJDT
vUBNaCTCrR0/Yld+rcRpyDh7+G1MyufF0hR1KikewAnL/CFXa3m6ery3g0diMYHm
YEEyA/8rdU+0oON+DRlhBVtV5RT570/npPakhUvPEf/p0W45gm0=
=BJV8
-----END PGP SIGNATURE-----

--3xsx7sxq7jrrsa5d--
