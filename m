Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 58D131F803
	for <e@80x24.org>; Thu, 10 Jan 2019 16:19:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728781AbfAJQTJ (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Jan 2019 11:19:09 -0500
Received: from mail-wr1-f41.google.com ([209.85.221.41]:39420 "EHLO
        mail-wr1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728148AbfAJQTJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Jan 2019 11:19:09 -0500
Received: by mail-wr1-f41.google.com with SMTP id t27so12044783wra.6
        for <git@vger.kernel.org>; Thu, 10 Jan 2019 08:19:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=h7SrLn8A6trnIdGD/nBN0/1VOzRnRSlFtRTF4PjSIaE=;
        b=JvNQFZDXSPJvG5Tu9ScgsWrIqZLRdhDBvrxUdum4uKli/oYB93BfygA7Rnyrm2IvdB
         sf5lBzGRZ5UTEdNNNttCWIKcqS0I7N1xXYF8nruo5B036SayJUmtmL8fO/tJsRvsL9uO
         bsNbBhPZBCBjt5jcgc/Zvs2p5uG2s25bJzbW1o4wfgB9CwgB3M57ImT7IE8sL4nJFBRO
         FqNUsyPdJjMOmLyYTFkvAva0uCZCM+GeMDtematqPRhhbDaj+sxnGBUReZFLFdgSu6RG
         USfPTmhNhMILWJ4dnvjFpDVeI/inLIOAXAnFxPefR11rzNVar/i9//n/SAmECOLG1/Y9
         k8eQ==
X-Gm-Message-State: AJcUukeGXYeUaRK/j/zQy4SigUjWto1hKcV5vSCFELefmlgTT0tlj8fs
        5nOCYkZpSpM5Ho4KddY/LmwHmE9/
X-Google-Smtp-Source: ALg8bN7PlB3WRlc3t+sQfL3oBrc2sPwXJNMWvYivdZLU7Uf8jonhZ74c3xBZ1SiGfpQW/3t5ii6Ouw==
X-Received: by 2002:adf:dd06:: with SMTP id a6mr10423736wrm.2.1547137146781;
        Thu, 10 Jan 2019 08:19:06 -0800 (PST)
Received: from localhost (186.9-252-62.static.virginmediabusiness.co.uk. [62.252.9.186])
        by smtp.gmail.com with ESMTPSA id 125sm24962836wmm.26.2019.01.10.08.19.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 10 Jan 2019 08:19:05 -0800 (PST)
Date:   Thu, 10 Jan 2019 16:19:04 +0000
From:   Samir Benmendil <me@rmz.io>
To:     git@vger.kernel.org
Subject: Git rebase --exec cannot run git commands affecting other repos
Message-ID: <20190110161904.23fwbrgg7blyx3nj@uh-nuc001>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wxevdrr3bbxp4e3n"
Content-Disposition: inline
X-Clacks-Overhead: GNU Terry Pratchett
User-Agent: NeoMutt/20180716
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--wxevdrr3bbxp4e3n
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

It is impossible to run git commands affecting a different repo from=20
within a `git rebase --exec` because in that environment the `GIT_DIR`=20
and `GIT_WORK_TREE` variables are set and inherited by any commands run=20
as part of `git rebase --exec`.

A minimal reproduction is shown below:

    git init
    touch file
    git add file
    git commit -m"Commit"
    git rebase --root --exec=3D"git clone . subrepo"

It is a bit convoluted for the sake of being self contained. But any git=20
command in `--exec` acting on a different repo than the one being=20
rebased will fail. See my ticket on CMake [0] for a more real usecase.

As mentioned in the other ticket, unsetting these variables will work=20
around the issue.

    git rebase --root --exec=3D"env -u GIT_DIR -u GIT_WORK_TREE git clone .=
 subrepo"


[0] https://gitlab.kitware.com/cmake/cmake/issues/18778

Regards

--wxevdrr3bbxp4e3n
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEO8iRpJat6BxHTtT0gmAAVevIWpMFAlw3cHYACgkQgmAAVevI
WpOUvg//X13q7A5dnZwdmorIHGZmGqG0JVJzYUAKTbciiYgUfaL1I06+v5BwasNJ
QUzk0SgKlHai2/tO4bg2Fs6YczfDfnryZEo28dJtdN1uSf+ON88+J18VywzqMHkj
eWwyjnUEwAYF177PCgQH+aYbxIIwmEsI+vRzKOZBehgfi14KdBqbYwmsQh1LEQkR
w0rQAFBPCimncGRCGu+YFe2xqKR5WsJCJImYrP/pVGbNlsQC6X48UiEP5sarc2uC
CS1mM42h0h0I3Nf+9KPicVmgs6Kurf6I8dCSPSGMTNul88+WRoYVnSOiwZFhhvmn
NDL8aNGpbzyxzrLPm5xSp4oHE11ywGMst0Zz0OOcflpdlRAG1r4sYKsaocq4Esuk
zWVajjLVx6J93ehV9m/HEy7QdHAfzwQ7sarOhvIQ43+l68xRzfDKg7woEZjng/WU
br2NXQcMsOhjGBcVQfV32sdqS9kYaOwts6/QzSE3dhBhHV+J0PHmJ5OKvaTN2dUT
arP4jfXSjn57SSRMt98gYgSbCYAcyQXZTFtH9QB+FlwNiXpYUs0B9fXu2XaKTVHA
2wabpXe0ErKMNZRGbmlCxwc/s9v2quCaRqHBQJbyhOb8ubaG0zylmP77GD24OjB6
nh13sB6POg/+pJ8Nq4XOvPWCCkeXApFkIb6+I5pmkkGCUF12oHA=
=Zh+C
-----END PGP SIGNATURE-----

--wxevdrr3bbxp4e3n--
