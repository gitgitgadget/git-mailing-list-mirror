Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EABE220A26
	for <e@80x24.org>; Sun, 17 Sep 2017 03:38:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751370AbdIQDiH (ORCPT <rfc822;e@80x24.org>);
        Sat, 16 Sep 2017 23:38:07 -0400
Received: from mail.wilcox-tech.com ([45.32.83.9]:55298 "EHLO
        mail.wilcox-tech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751310AbdIQDiH (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Sep 2017 23:38:07 -0400
Received: (qmail 31120 invoked from network); 17 Sep 2017 03:38:04 -0000
Received: from 107-131-85-42.lightspeed.tulsok.sbcglobal.net (HELO ?192.168.1.157?) (awilcox@wilcox-tech.com@107.131.85.42)
  by mail.wilcox-tech.com with ESMTPA; 17 Sep 2017 03:38:04 -0000
Subject: Re: Git 2.14.1: t6500: error during test on musl libc
To:     Junio C Hamano <gitster@pobox.com>
References: <59BB3E40.7020804@adelielinux.org>
 <20170915063740.GB21499@alpha.vpn.ikke.info>
 <20170915113011.emko6q5utb7x4bvu@sigill.intra.peff.net>
 <59BCAF81.3090206@adelielinux.org>
 <xmqqpoaqupo5.fsf@gitster.mtv.corp.google.com>
 <59BDD6AF.5090604@adelielinux.org>
 <xmqq60ciui8o.fsf@gitster.mtv.corp.google.com>
Cc:     musl@lists.openwall.com, Jeff King <peff@peff.net>,
        Kevin Daudt <me@ikke.info>, git@vger.kernel.org
From:   "A. Wilcox" <awilfox@adelielinux.org>
Organization: =?UTF-8?Q?Ad=c3=a9lie_Linux?=
Message-ID: <59BDEE1A.3000005@adelielinux.org>
Date:   Sat, 16 Sep 2017 22:38:02 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.0
MIME-Version: 1.0
In-Reply-To: <xmqq60ciui8o.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

On 16/09/17 22:16, Junio C Hamano wrote:
> Subject: gc: call fscanf() with %<len>s, not %<len>c, when reading
> hostname
> 
> Earlier in this codepath, we (ab)used "%<len>c" to read the
> hostname recorded in the lockfile into locking_host[HOST_NAME_MAX +
> 1] while substituting <len> with the actual value of
> HOST_NAME_MAX.
> 
> This turns out to be incorrect, as it an instruction to read
> exactly

it -> it is

> the specified number of bytes.  We are trying to read at most that 
> many bytes, we should be using "%<len>s" instead.
> 
> Helped-by: A. Wilcox <awilfox@adelielinux.org> Signed-off-by: Junio
> C Hamano <gitster@pobox.com> --- builtin/gc.c | 2 +- 1 file
> changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/builtin/gc.c b/builtin/gc.c index
> 3c78fcb9b1..bb2d6c1fb2 100644 --- a/builtin/gc.c +++
> b/builtin/gc.c @@ -258,7 +258,7 @@ static const char
> *lock_repo_for_gc(int force, pid_t* ret_pid) int should_exit;
> 
> if (!scan_fmt) -			scan_fmt = xstrfmt("%s %%%dc", "%"SCNuMAX,
> HOST_NAME_MAX); +			scan_fmt = xstrfmt("%s %%%ds", "%"SCNuMAX,
> HOST_NAME_MAX); fp = fopen(pidfile_path, "r"); memset(locking_host,
> 0, sizeof(locking_host)); should_exit =
> 

Ack.  This is what I used in my testing; looks great.  Thanks so much
for your time and patience.


Sincerely,
- --arw

- -- 
A. Wilcox (awilfox)
Project Lead, Adélie Linux
http://adelielinux.org
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZve4WAAoJEMspy1GSK50UruQP/3rca4kZp/mootkcgJrNwlSc
5SvFETaBMYb9M6CewOIgDWtQVqdGmkX+vhlyz/fO1aMUzed9JNgoYD0Fj8S+8RL/
aan96+Om94znlWydSlU48ZaR69sbj012TSJBvQdAs9K9Nfi40lMVGi8BvI5vsAG0
PCMyAUB4N6b9FYUNb6zO73JjmQSYzYV2TFOvACFgHwZ7ailyeyGI3LIP5Yd4OiF1
ERyJIKDoBjf0ns95xjox+HYFzG3VFDriM6GdEG1w25sLG+nvWxy/XV1Dv/K1/LiV
VzSJ3FEdNdOoO5SLcX4uRMYzRKLt3ihwnwIS6SC44Xd7XaqaWpfpueGxilQCI3Yn
FNWB3mX9oeXICIvM6PscJTzRLJd+gp3RbyLfavaQ2cNakrL9z+Qm5v6a52ufCqvP
SGdruVLGLDCR0qPWokKa64+uSfi6QNNmVgzVx4fRIwbMSUm1+sEh0uIjqgTQPBTq
Jyn6og/T234punjBI+GuEXhsb3FEbJh2xGyOQbmhW4l/DPzerUpXJAgCPC2JT93+
Z1s0aeDqC0n/dMHofVd8ZRFKt/ImVT0ywg7A9bJahhaJwmtkh0Xgb2hLgO5FGeuI
zY+9FI+doH6Al+KgxqSduKfxDOsEoxYRLCRYO2QnNjE7iYLIdUYRXEucw3Z/VQA1
b44AES8+WthuxQKsRstE
=Zwpa
-----END PGP SIGNATURE-----
