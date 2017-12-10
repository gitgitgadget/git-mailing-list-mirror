Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5921E1F404
	for <e@80x24.org>; Sun, 10 Dec 2017 10:50:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751659AbdLJKuT (ORCPT <rfc822;e@80x24.org>);
        Sun, 10 Dec 2017 05:50:19 -0500
Received: from mout.web.de ([212.227.15.3]:57562 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751435AbdLJKuS (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Dec 2017 05:50:18 -0500
Received: from tor.lan ([195.198.252.176]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MPaxV-1eS5n42hpR-004huC; Sun, 10
 Dec 2017 11:50:15 +0100
From:   tboegi@web.de
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
Subject: [PATCH v1 1/1] check-non-portable-shell.pl: Quoted `wc -l` is not portable
Date:   Sun, 10 Dec 2017 11:50:13 +0100
Message-Id: <20171210105013.3984-1-tboegi@web.de>
X-Mailer: git-send-email 2.15.1.271.g1a4e40aa5d
In-Reply-To: <xmqqh8t2ckgw.fsf@gitster.mtv.corp.google.com>
References: <xmqqh8t2ckgw.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:KEMZASi2s4aD1qmGUB0UHxovJCKWycUoc4S/H3gAQitBZFdmxQ3
 ua/8CPAxBf7xFcG3FcLpqgWR+RayaOXyK1KujazigyaAnBTH6L5fqQ1Ybpp359yqob0fIjN
 Yw+u8rv34Bbf85ScVvRwQ7fITf8nNe6h4wS5GdGm9Zh/Z05K0lKZGvvalAwsdjUJzUIuFVx
 Pz0BTt0CIDxwBjb/r1LNA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ekRRVkoDq3Q=:SqNrq0QBs8IRlgjaaWTgJi
 3YVFyJOqjOiRnsGCF9zJ0yu8lwQPZYKGXbJdVKjNuMnVCDT6cuqT5pMAmFPjuNQyjjnX/ZD0l
 aAJotuPg8AU//eq5RO0PkJntVl3U41/GYQkmX43cid6M0X2rD/9G0aKQ0RArvjVavirE19UfB
 mPDcNpI6sBDQD8nr6Gd2zyB7dm5hHaJ9mynHonQBmyADM37LNrY8PBhwYALggUqAd/dQW5xs7
 rZutLFEah6XT3TX5C6nUFWQ3DSEXFvyZELtp8Rv0D6np7I1hvFPiO6467NpXJ9RHboUMoVbrh
 vFul8Typ25EVIBnZBXxZihJDi32QEeXdt1Y9keQvvH7hAqbeVtgT39xSguISSVQU/UHsQM8/h
 BAjD30Jou2XvfGLbhBoxVSZliFv/2jWRAcNaWbGrBX0mDMtQ/n+e15XPhBOI/yLo3q6pinOZ8
 LeGDLcfNFrLpVPI8vZQYzAfqsUPJCkNdJ3v1L0gsM1YSkiX2YHk7EKIRKLfHYhtkKqztjiIWF
 WbDbpGfFr6RvfrXaip4w6+YPQApiSLjWaqfLIQlTZe9bbRjp1Z3n2uQp2ExZdEZe6SSJQmGP2
 2wGnAQXz/WjeRsbsu32dHF+nd5MCooiSYyHZ/gCzQ1SjOcA9cJuQ5+mjZlmRNDE9RGuiQAYL6
 R523LJvqpszxOk4WIWeJabCk3nJP1yKv4M8yvvVmda0dt/T4GP7ztPrr9vFQb/7cdPf19asrM
 y3yQRK4YNy7E8mj7kFuHvdvJZyrQoslUlptq9dxzh5IDkN7xYxhokqAvsWxjQChyV/uMa+zqD
 QGftNGNxVANnxara7PlgEoc/1QHIg7fs7X10Gep7GQxH8c0+u0=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Torsten Bögershausen <tboegi@web.de>

wc -l is used to count the number if lines in test scripts.
$ wc -l Makefile
gives a line like this:
105 Makefile
while Mac OS has 4 leading spaces:
     105 Makefile

And this means that shell expressions like
test "$(wc -l <expect)" = "4" don't work under Mac OS,

A portable way to use `wc -l` is to omit the '"':
test $(wc -l <expect) = "4"

Add a check in check-non-portable-shell.pl to find '"' between
`wc -l` and '='

Signed-off-by: Torsten Bögershausen <tboegi@web.de>
---
 t/check-non-portable-shell.pl | 1 +
 1 file changed, 1 insertion(+)

diff --git a/t/check-non-portable-shell.pl b/t/check-non-portable-shell.pl
index 03dc9d2852..9ebf65c26f 100755
--- a/t/check-non-portable-shell.pl
+++ b/t/check-non-portable-shell.pl
@@ -21,6 +21,7 @@ while (<>) {
 	/^\s*declare\s+/ and err 'arrays/declare not portable';
 	/^\s*[^#]\s*which\s/ and err 'which is not portable (please use type)';
 	/\btest\s+[^=]*==/ and err '"test a == b" is not portable (please use =)';
+	/\bwc -l.*"\s*=/ and err '`"$(wc -l)"` is not portable, please use `$(wc -l)`';
 	/\bexport\s+[A-Za-z0-9_]*=/ and err '"export FOO=bar" is not portable (please use FOO=bar && export FOO)';
 	# this resets our $. for each file
 	close ARGV if eof;
-- 
2.15.1.271.g1a4e40aa5d

