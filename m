Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E466A1F42D
	for <e@80x24.org>; Thu, 31 May 2018 16:30:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755594AbeEaQaW (ORCPT <rfc822;e@80x24.org>);
        Thu, 31 May 2018 12:30:22 -0400
Received: from mout01.posteo.de ([185.67.36.65]:35808 "EHLO mout01.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755557AbeEaQaW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 May 2018 12:30:22 -0400
Received: from submission (posteo.de [89.146.220.130]) 
        by mout01.posteo.de (Postfix) with ESMTPS id 4DBB921103
        for <git@vger.kernel.org>; Thu, 31 May 2018 18:30:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.de; s=2017;
        t=1527784220; bh=Hu2LcT5a5LJYQJqq7xoetwvfMHLUS1k9+kXF7cXP24w=;
        h=Date:From:To:Subject:From;
        b=JDDf6DLCNtwH1+4nahHR5PjayEMLeGX4HW+XoBpCxgdznJvj/37SBbALC6Q0hYX4g
         QpNfKH7vFowgEbODH8RlKyRKLd3XMunMg/FrF9Fo7z+fFD7nfI/LAJJ5UvH/fVi/ZI
         iL6xX3bUNMS6oawrUCBdRx1U8cvZu0KG9ODahQYzSpOTr/DH9PUj+reGiJxtOpYoxM
         R0sRy0IwRw9DLFkr1g5XaAljYPeeYvnSashKYVt9bzGD8nEZ42ALNRHHM0/feaWxVH
         pISnPOMf75z0zbyPKzweKJFJ/u9L8DB7dOXVIW8UDvuEx2blanUFgLfIVqNOBg9Ksp
         kFWp6blUiH+6A==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 40xXxk70M4z9rxM
        for <git@vger.kernel.org>; Thu, 31 May 2018 18:30:18 +0200 (CEST)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 31 May 2018 18:30:18 +0200
From:   mlell@posteo.de
To:     git@vger.kernel.org
Subject: Bug: Install from .tar.xz fails without write permission on
 /usr/local/share/man/man3
Message-ID: <d464115b7c2ee5f9084ae9bd33cebea1@posteo.de>
X-Sender: mlell@posteo.de
User-Agent: Posteo Webmail
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I was trying to build git 2.9.5 as a normal user, as I have no root 
access on a cluster with outdated software.

The build fails, unless I change the PREFIX=/usr/local line in 
per/perl.mak:80 to a folder where I have write permission.
Apparently, perl.mak does not honour the --prefix= setting of 
./configure.

Is it possible to change perl.mak to honor the PREFIX?

Best,
Mo


Steps to reproduce:

wget 
https://mirrors.edge.kernel.org/pub/software/scm/git/git-2.9.5.tar.xz
tar xf git-2.9.5.tar.xz
cd git-2.9.5
./configure --prefix=$HOME/.usr
make
make install # fails

Output (last lines):

install -d -m 755 '/qg-10/data/AGR-QG/lell/.usr/share/locale'
(cd po/build/locale && gtar cf - .) | \
(cd '/qg-10/data/AGR-QG/lell/.usr/share/locale' && umask 022 && gtar xof 
-)
make -C perl prefix='/qg-10/data/AGR-QG/lell/.usr' DESTDIR='' install
make[1]: Entering directory 
`/qg-10/data/AGR-QG/lell/.usr/git-2.9.5/perl'
make[2]: Entering directory 
`/qg-10/data/AGR-QG/lell/.usr/git-2.9.5/perl'
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
ERROR: Can't create '/usr/local/share/man/man3'
Do not have write permissions on '/usr/local/share/man/man3'
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
  at -e line 1.
make[2]: *** [pure_site_install] Error 13
make[2]: Leaving directory `/qg-10/data/AGR-QG/lell/.usr/git-2.9.5/perl'
make[1]: *** [install] Error 2
make[1]: Leaving directory `/qg-10/data/AGR-QG/lell/.usr/git-2.9.5/perl'
make: *** [install] Error 2



