Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4AC1A1F404
	for <e@80x24.org>; Fri, 16 Mar 2018 22:08:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752192AbeCPWHx (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Mar 2018 18:07:53 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54187 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751372AbeCPWHv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Mar 2018 18:07:51 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E6DD0C634E;
        Fri, 16 Mar 2018 18:07:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to; s=sasl; bh=wNFDtM6xa4EwFct
        MF4Jknp0W+ms=; b=tcqNya3AjjXVZDBBdpeiXMhzvb4/QRAsGYNyIwf459HOLS8
        /x90fr0ve/eqc76jij1FgO1I59O5dB+1p4mfp+vEMy4At8Ej+qEkSyxMbDJJuhrn
        4XkPked6Va77i5JwZr2RiNnyNOB3D7QU9o90Gz13OptLGld2twHjObJahKAE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to; q=dns; s=sasl; b=pMz1iAhfc
        qnGWSmwwfbFNe1qNw4/3g6Kf4BXUShM9XoMrzxDUMuptJMaIM09upB2h1inyFwcB
        E5dsMeijl3dVp7AarMfy3wuVtyiJBhupiF5OUyWxU6r3Nm2erP/BsrqWE80RQDJT
        EQR/9bS4p0gFRAGvkZs+AR8LWD7XcOTACM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DF585C634D;
        Fri, 16 Mar 2018 18:07:50 -0400 (EDT)
Received: from morphine.paradise.teonanacatl.net (unknown [47.202.85.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 29C8DC634C;
        Fri, 16 Mar 2018 18:07:50 -0400 (EDT)
From:   Todd Zullinger <tmz@pobox.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, git@vger.kernel.org,
        git-packagers@googlegroups.com, linux-kernel@vger.kernel.org
Subject: [PATCH] RelNotes: add details on Perl module changes
Date:   Fri, 16 Mar 2018 18:07:48 -0400
Message-Id: <20180316220748.4279-1-tmz@pobox.com>
X-Mailer: git-send-email 2.17.0.rc0
In-Reply-To: <xmqq7eqb3nct.fsf@gitster-ct.c.googlers.com>
X-Pobox-Relay-ID: 779087D8-2966-11E8-A93C-44CE1968708C-09356542!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Document changes to core and non-core Perl module handling in 2.17.
---
Junio C Hamano <gitster@pobox.com> writes:

>> I haven't wordsmithed it fully, but it should say something along
>> the lines of ...
>>
>>  Documentation/RelNotes/2.16.0.txt | 10 ++++++++++
>>  1 file changed, 10 insertions(+)
>
> Eh, of course the addition should go to 2.17 release notes ;-)  I
> just happened to be reviewing a topic forked earlier.

Maybe something like this?  I had intended to suggest a note about
NO_PERL_CPAN_FALLBACKS as well, so that's included too.  I don't know if that
should be expanded to provide more of a hint to users/packagers on platforms
where these modules are harder to install, letting them know that we now have
fallbacks to Error and Mail::Address.  That might allow scripts which were
previously excluded to be included on their platforms.

 Documentation/RelNotes/2.17.0.txt | 14 ++++++++++++++
 INSTALL                           |  3 ++-
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/Documentation/RelNotes/2.17.0.txt b/Documentation/RelNotes/2.17.0.txt
index c828d37345..085bf1dba1 100644
--- a/Documentation/RelNotes/2.17.0.txt
+++ b/Documentation/RelNotes/2.17.0.txt
@@ -75,6 +75,20 @@ Performance, Internal Implementation, Development Support etc.
  * The build procedure for perl/ part has been greatly simplified by
    weaning ourselves off of MakeMaker.
 
+ * Perl 5.8 or greater has been required since Git 1.7.4 released in
+   2010, but we continued to assume some core modules may not exist and
+   used a conditional "eval { require <<module>> }"; we no longer do
+   this.  Some platforms (Fedora/RedHat/CentOS, for example) ship Perl
+   without all core modules by default (e.g. Digest::MD5, File::Temp,
+   File::Spec, Net::Domain, Net::SMTP).  Users on such platforms may
+   need to install these additional modules.
+
+ * As a convenience, we install copies of Perl modules we require which
+   are not part of the core Perl distribution (e.g. Error and
+   Mail::Address).  Users and packagers whose operating system provides
+   these modules can set NO_PERL_CPAN_FALLBACKS to avoid installing the
+   bundled modules.
+
  * In preparation for implementing narrow/partial clone, the machinery
    for checking object connectivity used by gc and fsck has been
    taught that a missing object is OK when it is referenced by a
diff --git a/INSTALL b/INSTALL
index 60e515eaf7..c39006e8e7 100644
--- a/INSTALL
+++ b/INSTALL
@@ -126,7 +126,8 @@ Issues of note:
 	  Redhat/Fedora are reported to ship Perl binary package with some
 	  core modules stripped away (see http://lwn.net/Articles/477234/),
 	  so you might need to install additional packages other than Perl
-	  itself, e.g. Time::HiRes.
+	  itself, e.g. Digest::MD5, File::Spec, File::Temp, Net::Domain,
+	  Net::SMTP, and Time::HiRes.
 
 	- git-imap-send needs the OpenSSL library to talk IMAP over SSL if
 	  you are using libcurl older than 7.34.0.  Otherwise you can use
-- 
2.17.0.rc0

