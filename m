From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: Odd encoding issue with UTF-8 + gettext yields ? on non-ASCII
Date: Sun, 29 Aug 2010 08:37:10 +0000
Message-ID: <AANLkTinzXSSGHjauw7X9SOfNhUR75+rZ+H0EgLHARS0k@mail.gmail.com>
References: <AANLkTi=cb5zyKyogdunB6NzWDk99V2hSg-c0vQpwKM-Z@mail.gmail.com>
	<AANLkTikHbxrmj3R1LDghVvMA1KNEdfeiXj44cq1KRN7M@mail.gmail.com>
	<20100828214641.GA5515@burratino>
	<20100828215956.GB5515@burratino>
	<alpine.BSF.2.00.1008282213420.67930@x.fncre.vasb>
	<20100828221655.GB5777@burratino>
	<AANLkTimKQO1MQASvQCz=gpz8FTs3h6FSvm12oFUe7WFD@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Marcin Cieslak <saper@saper.info>,
	Git Mailing List <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 29 10:37:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OpdOQ-0004Oe-Vt
	for gcvg-git-2@lo.gmane.org; Sun, 29 Aug 2010 10:37:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752517Ab0H2IhN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 29 Aug 2010 04:37:13 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:33195 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752329Ab0H2IhL convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 29 Aug 2010 04:37:11 -0400
Received: by iwn5 with SMTP id 5so3939474iwn.19
        for <git@vger.kernel.org>; Sun, 29 Aug 2010 01:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=0wetL0BVvigscjZAen2WpHiqIx3Vuw7gQ558+6zHNCk=;
        b=NI7m+VCVSM9SdPPbcRe0Fz5zAneMTeEI73TYHEcF3sQXAYcD0lGNY3GMm7Vxr6RaIc
         yRH95HelMeaaoSUFrgkpfCTkLPw5R5QPT3CQXD1zAdlPYyWSdNLk4cNKK0uRq4g09p7z
         6Ymr+KIZLXTNuXJJ618DTf2sxaIu+/5ME5lT4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=hbih9bLN1AO7Ts8i7Wj3u8dGJThDt3JeY9kkhvErakpHVBHju3SCrxV3BypyRtgTrJ
         qX5+5X5acUDHz50dMxbHVWAJVoBmFU2pBBGeXx4+cYuDBiMxwvhHd7u8RG4MHPJQOq43
         PK2CA9bOq0+PLDft9NsJF2x+Cg+XbkBY37oOk=
Received: by 10.231.32.130 with SMTP id c2mr3347610ibd.194.1283071030688; Sun,
 29 Aug 2010 01:37:10 -0700 (PDT)
Received: by 10.231.171.145 with HTTP; Sun, 29 Aug 2010 01:37:10 -0700 (PDT)
In-Reply-To: <AANLkTimKQO1MQASvQCz=gpz8FTs3h6FSvm12oFUe7WFD@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154684>

On Sun, Aug 29, 2010 at 07:36, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <=
avarab@gmail.com> wrote:

> We also have another bug, compiling git with
> SNPRINTF_RETURNS_BOGUS=3DYesGNuIsBuggy and running "git show v0.99.6~=
1"
> on our own repository causes a segfault, presumably due to the same
> bug, but I didn't track it down further than this:

I forgot to mention, compiling it with this partial revert of 107880a o=
f course:

    diff --git a/gettext.c b/gettext.c
    index db99742..7ae5cae 100644
    --- a/gettext.c
    +++ b/gettext.c
    @@ -19,2 +19,3 @@ extern void git_setup_gettext(void) {
            (void)setlocale(LC_MESSAGES, "");
    +       (void)setlocale(LC_CTYPE, "");
            (void)textdomain("git");
