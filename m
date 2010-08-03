From: Benjamin Kramer <benny.kra@googlemail.com>
Subject: Re: [RFC/PATCH] git-compat-util.h: Don't define NORETURN under __clang__
Date: Tue, 3 Aug 2010 15:35:51 +0200
Message-ID: <C210797E-AE95-4074-AADE-CD2B518D8202@gmail.com>
References: <1280840883-24540-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
	<avarab@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 03 15:40:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OgHj4-0006CX-Jo
	for gcvg-git-2@lo.gmane.org; Tue, 03 Aug 2010 15:40:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756461Ab0HCNf7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 3 Aug 2010 09:35:59 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:56366 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756433Ab0HCNf6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 Aug 2010 09:35:58 -0400
Received: by fxm14 with SMTP id 14so1981686fxm.19
        for <git@vger.kernel.org>; Tue, 03 Aug 2010 06:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:subject:mime-version
         :content-type:from:in-reply-to:date:cc:content-transfer-encoding
         :message-id:references:to:x-mailer;
        bh=eH0qEDMSSIC3rYL0jRpB8YET4s5mexSCom+KecGqTQw=;
        b=pJcJZ0pKj2unRLR9oy0XSnPc8kcDTq0Y0ZxFlP9Pn0Yj/JS+Q7T6FHK/jLtksPW2pS
         W+feHO5SmPNJW2vPLU6/FvKtUeaa9HUXygDW8NnQnEJ8tH6mn6Lk1kaQd1o2TTnIjA0c
         l3ufN8uKOb7CC5gNoaAMY+PoWC9arMCO7OnK8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=subject:mime-version:content-type:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to:x-mailer;
        b=Vtnxz2V2R8UjRvHYJwnOJ2ag7ZRpWJTKIKFBAhx/C5OOqFPtrrgzvlEuYcg6Qi/34h
         Lan+UfQhR6IjnLOteltaKalid0ttu2b3bwV38+Dxozw+8au2T7g/7svOi2bccAFOt/ml
         EJSDNZV/NQN1ODq9S9DJYrvbEFaTrq2WjkKT8=
Received: by 10.223.125.196 with SMTP id z4mr7285158far.80.1280842557001;
        Tue, 03 Aug 2010 06:35:57 -0700 (PDT)
Received: from [192.168.1.24] (p50923316.dip.t-dialin.net [80.146.51.22])
        by mx.google.com with ESMTPS id e22sm153353faa.2.2010.08.03.06.35.53
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 03 Aug 2010 06:35:54 -0700 (PDT)
In-Reply-To: <1280840883-24540-1-git-send-email-avarab@gmail.com>
X-Mailer: Apple Mail (2.1081)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152519>


On 03.08.2010, at 15:08, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> clang version 1.0 on Debian testing x86_64 defines __GNUC__, but barf=
s
> on `void __attribute__((__noreturn__))'. E.g.:

This is a bug in clang 1.0 that was fixed in the llvm 2.7/clang 1.5 tim=
eframe, it didn't
recognize attributes on function pointers properly. clang tries to be a=
s compatible with GCC as
possible so it obviously has to define __GNUC__ ;)

>=20
>    usage.c:56:1: error: function declared 'noreturn' should not retur=
n [-Winvalid-noreturn]
>    }
>    ^
>    1 diagnostic generated.
>    make: *** [usage.o] Error 1

It's a "warning which defaults to an error" you can pacify it by passin=
g -Winvalid-noreturn or
=10-Wno-invalid-noreturn.

I oppose adding workarounds for obsolete versions of clang, Debian shou=
ld upgrade their packages to
a more recent release. clang 1.0 had all kinds of weird bugs and should=
n't be used anymore.