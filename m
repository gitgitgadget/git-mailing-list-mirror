From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: Git configure/make does not honor ARFLAGS
Date: Wed, 16 Sep 2015 15:38:57 -0400
Message-ID: <20150916193856.GA15738@flurp.local>
References: <CAH8yC8kV77h8cRA9Qo_1FYe9sv0zgsE7yKxaX+OtpRfj9+7wog@mail.gmail.com>
 <20150913101727.GB26562@sigill.intra.peff.net>
 <CAPig+cQV-kaDDdBH+QZXsSjDHjP2CUYDXp3WKSBtgguVmLvofg@mail.gmail.com>
 <20150914043016.GA10167@sigill.intra.peff.net>
 <CAPc5daUBBPRxaaptTS9xyr+pJ6Fgt4XXi+MU=DSZeoQ6uHCHvg@mail.gmail.com>
 <20150914045953.GA11039@sigill.intra.peff.net>
 <CAPc5daXjnLduFOD5au+wV0AN6EXTUWTM6JQ66U+0DwzVhk3YcA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Jeffrey Walton <noloader@gmail.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 16 21:39:14 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZcIXx-0003wh-3W
	for gcvg-git-2@plane.gmane.org; Wed, 16 Sep 2015 21:39:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752924AbbIPTjI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Sep 2015 15:39:08 -0400
Received: from mail-io0-f174.google.com ([209.85.223.174]:32835 "EHLO
	mail-io0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752809AbbIPTjH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Sep 2015 15:39:07 -0400
Received: by iofh134 with SMTP id h134so240731746iof.0
        for <git@vger.kernel.org>; Wed, 16 Sep 2015 12:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=x8hDe4RsFpbwWWfXYqtjiiIR7dKWUEO4z8cHUhRIAuU=;
        b=ePdLyoFDJeraxTxMnTb3oMjmtt+m04no3XHEMfh9WH8zus9XyiSFCUq+Sj1fJma7w4
         co4ao8QfL2QSGB1C/+0yQqeOvwKi8QwdtkQZJEpL2ul9Y+vrksNJQzh64JF7Mbtm5hbf
         6pjcRobijVtBeMldBYC1NLR0c+8GhQxlGXi5PpTUjPqPGfiIlssukOLzFwfjhkOSN6sv
         AauknJ9tlOGO2Z3rtD/Lz4M9FG8I14DSji/osagapfuCrTxpSlOtRvPwO3W6mh1a4zF6
         IrtnW4I++q2hJsGPNGr9/PZYerQrGcXVtFBwNt2wiqCPenJIqxVx5QntmxuefMQdWN7y
         BQyQ==
X-Received: by 10.107.128.106 with SMTP id b103mr39677158iod.116.1442432345451;
        Wed, 16 Sep 2015 12:39:05 -0700 (PDT)
Received: from flurp.local (user-12l3cpl.cable.mindspring.com. [69.81.179.53])
        by smtp.gmail.com with ESMTPSA id k2sm2588380igx.0.2015.09.16.12.39.04
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 16 Sep 2015 12:39:04 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAPc5daXjnLduFOD5au+wV0AN6EXTUWTM6JQ66U+0DwzVhk3YcA@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278054>

On Sun, Sep 13, 2015 at 10:52:36PM -0700, Junio C Hamano wrote:
> On Sun, Sep 13, 2015 at 9:59 PM, Jeff King <peff@peff.net> wrote:
> >
> > My follow-up question was going to be: is this something we should be
> > setting in config.mak.uname for appropriate versions of Darwin? It
> > wasn't clear to me from Eric's description if this is something that
> > particular versions need, or just something that people who want to
> > build Universal binaries would choose to use.
> 
> My preference is not to worry anything about config.mak.uname
> ourselves, until somebody who does work on the ports proposes
> to do something concrete.

Normal 'ar' works for non-multi-architecture-binaries (MAB);
'libtool' is only needed when building Universal. Unfortunately,
there probably isn't a reliable way to auto-detect a Universal build.
Back in the NextStep days, projects would support MAB via a
TARGET_ARCHS variable:

    make TARGET_ARCHS='m68k i386 sparc hppa'

And, for project's which didn't understand that, you'd just have to
specify build flags which the Makefile did understand:

    make CFLAGS='-arch ppc -arch i386' LDFLAGS='-arch ppc -arch i386'

or, just make ad-hoc modifications to the Makefile if it didn't even
respect those variables. So, I don't think there's really a good way
to detect MAB builds.

On the other hand, as far as I know, it's *always* safe to replace
'ar' with 'libtool' on this platform, so we could just do it
unconditionally.

--- 8< ---
diff --git a/config.mak.uname b/config.mak.uname
index be5cbec..e7970dd 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -88,6 +88,8 @@ ifeq ($(uname_S),SCO_SV)
 	TAR = gtar
 endif
 ifeq ($(uname_S),Darwin)
+	AR = libtool
+	ARFLAGS = -static -o
 	NEEDS_CRYPTO_WITH_SSL = YesPlease
 	NEEDS_SSL_WITH_CRYPTO = YesPlease
 	NEEDS_LIBICONV = YesPlease
--- 8< ---

I've tested this on modern Mac OS X, Yosemite 10.10.5 (x86_64), and
ancient Snow Leopard 10.5.8 PowerPC (circa 2009), and it works fine
in both cases, so perhaps that's the way to go.

My one concern, however, would be people who've installed GNU libtool
and have that in PATH before Apple's tools.
