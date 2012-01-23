From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 2/2] add a Makefile switch to avoid gettext translation
 in shell scripts
Date: Mon, 23 Jan 2012 16:12:56 -0600
Message-ID: <20120123221256.GG20833@burratino>
References: <CALxABCZME-g++HxMsD4Nrn1J6s27vN7M_KQSVT3PeLWBqP7qJg@mail.gmail.com>
 <CACBZZX4TsL-tj04PmUwGNWjXO+JY-8unAv-aRKOGvgB71qdYCg@mail.gmail.com>
 <CALxABCadHdvR02Br9e6STy0w+EPoycUKr62RiSUSP_EPF-TH3g@mail.gmail.com>
 <CACBZZX4tB6DGV-1tiuOamq7ACPk0a-=1Pb9Vk1SgyDqAq-EFOw@mail.gmail.com>
 <CALxABCbaBmP6k5TYrYLCYm8oiv=9cF=N7_opSTKUnbkz5b-cwg@mail.gmail.com>
 <20120119195222.GA5011@blimp.dmz>
 <7v1uqq84es.fsf@alter.siamese.dyndns.org>
 <7vwr8i6prk.fsf_-_@alter.siamese.dyndns.org>
 <7vr4yq6poy.fsf_-_@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Alex Riesen <raa.lkml@gmail.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 23 23:13:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RpS8e-0003O9-Sc
	for gcvg-git-2@lo.gmane.org; Mon, 23 Jan 2012 23:13:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754058Ab2AWWNJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jan 2012 17:13:09 -0500
Received: from mail-yw0-f46.google.com ([209.85.213.46]:56732 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753850Ab2AWWNI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jan 2012 17:13:08 -0500
Received: by yhoo21 with SMTP id o21so1533869yho.19
        for <git@vger.kernel.org>; Mon, 23 Jan 2012 14:13:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=IqUAHOR0vN775BHeySPVEl0VeYlRAQ2WtuWrgZ0nV0g=;
        b=HCAwxEu+OUIMY4BM/FdRXfFU7YFZOvYFHZLC4QxnMoPSM1PfDiicQUu3Fyhn+kqLOp
         S+JpBmDjNVkdNAmtCEbtS035QbAXEXlfV9K9x23dG7q2W/wpJivCSZ6yIUkQVRUJgzfT
         H4Q0eS9N3jsaEtxSNxMieHTXtzU3Zvj/nDW/U=
Received: by 10.236.79.135 with SMTP id i7mr12871841yhe.4.1327356786961;
        Mon, 23 Jan 2012 14:13:06 -0800 (PST)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id o16sm38581758ank.14.2012.01.23.14.13.04
        (version=SSLv3 cipher=OTHER);
        Mon, 23 Jan 2012 14:13:05 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <7vr4yq6poy.fsf_-_@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189017>

Junio C Hamano wrote:

>     make USE_GETTEXT_SCHEME=fallthrough
>
> This will replace the translation routines with fallthrough versions,
> that does not use gettext from the platform.

Nice implementation.  I still don't understand why NO_GETTEXT=YesPlease
should not imply this.  Is it to ensure the GETTEXT_SCHEME=gnu mode
gets more testing?

Here's a patch to consider squashing in that makes the option take
effect if it changes between builds.

diff --git i/Makefile w/Makefile
index 63dfd64d..b2b738bb 100644
--- i/Makefile
+++ w/Makefile
@@ -2268,7 +2268,7 @@ cscope:
 ### Detect prefix changes
 TRACK_CFLAGS = $(CC):$(subst ','\'',$(ALL_CFLAGS)):\
              $(bindir_SQ):$(gitexecdir_SQ):$(template_dir_SQ):$(prefix_SQ):\
-             $(localedir_SQ)
+             $(localedir_SQ):$(USE_GETTEXT_SCHEME)
 
 GIT-CFLAGS: FORCE
 	@FLAGS='$(TRACK_CFLAGS)'; \
