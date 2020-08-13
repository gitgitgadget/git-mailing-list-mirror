Return-Path: <SRS0=IFun=BX=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D5C5C433E1
	for <git@archiver.kernel.org>; Thu, 13 Aug 2020 21:52:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3727E20838
	for <git@archiver.kernel.org>; Thu, 13 Aug 2020 21:52:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="NVhJcdEJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726578AbgHMVwm (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Aug 2020 17:52:42 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:62752 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726427AbgHMVwl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Aug 2020 17:52:41 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 76400DE96B;
        Thu, 13 Aug 2020 17:52:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=ihijGe2fd2UZ
        CBFtb5BX+76juFE=; b=NVhJcdEJwazdgNAuiIcm8B2v5M232T6ThxpZXU6myqJc
        qXYLP6ku3Rhvg9co8xgYveixUBWTPrFtwOe5Dqo3SZk/i60L5A1Elat6HzyWT799
        0n6Vf5fAVF5bDTjmuU3iJQdtRI+m2K+njkaulqmyQpak3q74OQodvcWT93UycDQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=K59ouE
        +noAkt5ZxntpteEk8ZMD+tzJCdObVrvsHlSGJXU+XFX8tubR9r7GcGaL623dheB7
        Fq9eYqtkmaw3S/Xd3IQBmA+chtN9LKgParIwvcTNOHK9C5OEZf+CTmkToHwRbjqz
        aoft6fGVhdmcPhe5rJ+nvF2/fqugOzpgyjks0=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 6EFD2DE96A;
        Thu, 13 Aug 2020 17:52:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id AF0B3DE966;
        Thu, 13 Aug 2020 17:52:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Alexander Ost <ost@ieee.org>, Git List <git@vger.kernel.org>
Subject: Re: [BUG] `make install' partly ignores `NO_INSTALL_HARDLINKS'
References: <CAGNCYk3hGWHuSb4vDzrBE54P5y6Sm+TwfVrCfHD0LnLQWSr9nA@mail.gmail.com>
        <CAPig+cQnGUyM2cwNjDm_zys15B9n82QT6-RD7Lgyz1-XSGp8yw@mail.gmail.com>
Date:   Thu, 13 Aug 2020 14:52:33 -0700
In-Reply-To: <CAPig+cQnGUyM2cwNjDm_zys15B9n82QT6-RD7Lgyz1-XSGp8yw@mail.gmail.com>
        (Eric Sunshine's message of "Thu, 13 Aug 2020 17:45:38 -0400")
Message-ID: <xmqqimdm1ae6.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 4C4C4D3C-DDAF-11EA-AC0C-843F439F7C89-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Wed, Aug 12, 2020 at 4:16 AM Alexander Ost <ost@ieee.org> wrote:
>> Despite installing with `make NO_INSTALL_HARDLINKS=3D1 install', the
>> installation process tries to create hard links, and the installation
>> fails (a quick workaround is `sed -i git-gui/Makefile -e "s/ln /ln -s
>> /g"').
>>
>> make NO_INSTALL_HARDLINKS=3D1 install
>> ln: failed to create hard link
>> =E2=80=98/filesystem_without_hardlink_support/libexec/git-core/git-cit=
ool=E2=80=99 =3D>
>> =E2=80=98/filesystem_without_hardlink_support/libexec/git-core/git-gui=
=E2=80=99:
>> Operation not permitted
>
> Indeed, it appears that the git-gui Makefile does not respect
> NO_INSTALL_HARDLINKS. The git-gui project is maintained and developed
> outside of the Git project (even though it gets bundled with Git), so
> it has its own issue tracker. It would probably be best to re-submit
> this bug report there:
>
> https://github.com/prati0100/git-gui/issues

Thanks.  Perhaps something along this line (which is totally
untested), as the top-level Makefile already exports
NO_INSTALL_HARDLINKS to submakes?



 Makefile | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index f10caedaa7..1cdbf8e504 100644
--- a/Makefile
+++ b/Makefile
@@ -44,6 +44,11 @@ endif
 ifndef INSTALL
 	INSTALL =3D install
 endif
+ifdef NO_INSTALL_HARDLINKS
+	LN =3D cp
+else
+	LN =3D ln
+endif
=20
 RM_RF     ?=3D rm -rf
 RMDIR     ?=3D rmdir
@@ -57,7 +62,7 @@ INSTALL_X1 =3D
 INSTALL_A0 =3D find # space is required here
 INSTALL_A1 =3D | cpio -pud
 INSTALL_L0 =3D rm -f # space is required here
-INSTALL_L1 =3D && ln # space is required here
+INSTALL_L1 =3D && $(LN) # space is required here
 INSTALL_L2 =3D
 INSTALL_L3 =3D
=20
@@ -87,7 +92,7 @@ ifndef V
 	INSTALL_L0 =3D dst=3D
 	INSTALL_L1 =3D && src=3D
 	INSTALL_L2 =3D && dst=3D
-	INSTALL_L3 =3D && echo '   ' 'LINK       ' `basename "$$dst"` '->' `bas=
ename "$$src"` && rm -f "$$dst" && ln "$$src" "$$dst"
+	INSTALL_L3 =3D && echo '   ' 'LINK       ' `basename "$$dst"` '->' `bas=
ename "$$src"` && rm -f "$$dst" && $(LN) "$$src" "$$dst"
=20
 	CLEAN_DST =3D echo ' ' UNINSTALL
 	REMOVE_D0 =3D dir=3D
