From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: Re: [RFC] Enable compilation by Makefile for the MSVC toolchain
Date: Tue, 18 Aug 2009 15:09:47 +0200
Message-ID: <40aa078e0908180609h13968c56m4e0d0fd4dfa07669@mail.gmail.com>
References: <alpine.DEB.1.00.0908172149480.8306@pacific.mpi-cbg.de>
	 <1250600335-8642-1-git-send-email-mstormo@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes.Schindelin@gmx.de, msysgit@googlegroups.com,
	git@vger.kernel.org, lznuaa@gmail.com, bonzini@gnu.org
To: Marius Storm-Olsen <mstormo@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 18 15:10:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MdORr-0004tz-4Z
	for gcvg-git-2@lo.gmane.org; Tue, 18 Aug 2009 15:09:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751167AbZHRNJr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 18 Aug 2009 09:09:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751162AbZHRNJr
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Aug 2009 09:09:47 -0400
Received: from qw-out-2122.google.com ([74.125.92.24]:4671 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750865AbZHRNJq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 18 Aug 2009 09:09:46 -0400
Received: by qw-out-2122.google.com with SMTP id 8so1217533qwh.37
        for <git@vger.kernel.org>; Tue, 18 Aug 2009 06:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=EDf5TL4Cp20N/eCHC0Geq7npsixQPfAgOTGcxsLwVCw=;
        b=NkZiOA1882DWdrmPmYUz0y8DzSuwVyQHGLsp0LxQhU5Q4sbTPCvKKlNXKGDW4gqUWM
         j9BbevxPJkrUTYrIuZwPrdWIciFqeBZWt8L2gSjtUOdjRPo7nUJwj6k+Cya/QQwrgMDX
         k2q/44mwxmOjuGkrflXq/P3KxxlOEzm4k2VTU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=jKuXkKOKk9pZcrFqUERhiqem5XtyBo1/+wZAcKDkWORd/zhkA462fx70YFgZgP0Nim
         y5IMFuPpTBfK0G77NX9+MH/7xR7ySA6X4fsg4X9otRgi6Jvt7pMZRRF+C/FXZz8ENxLS
         KashY28zj6StrLsBgP6Gpx6tSiAHq63aJ2yh0=
Received: by 10.224.16.131 with SMTP id o3mr5383823qaa.18.1250600987308; Tue, 
	18 Aug 2009 06:09:47 -0700 (PDT)
In-Reply-To: <1250600335-8642-1-git-send-email-mstormo@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126396>

On Tue, Aug 18, 2009 at 2:58 PM, Marius Storm-Olsen<mstormo@gmail.com> =
wrote:
> @@ -1331,14 +1396,14 @@ strip: $(PROGRAMS) git$X
> =A0git.o: git.c common-cmds.h GIT-CFLAGS
> =A0 =A0 =A0 =A0$(QUIET_CC)$(CC) -DGIT_VERSION=3D'"$(GIT_VERSION)"' \
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0'-DGIT_HTML_PATH=3D"$(htmldir_SQ)"' \
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 $(ALL_CFLAGS) -c $(filter %.c,$^)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 $(ALL_CFLAGS) $(COMPFLAG) $(COBJFLAG)gi=
t.o $(filter %.c,$^)
>
> =A0git$X: git.o $(BUILTIN_OBJS) $(GITLIBS)
> - =A0 =A0 =A0 $(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ git.o \
> + =A0 =A0 =A0 $(QUIET_LINK)$(LINK) $(LINKER_CFLAGS) $(LOBJFLAG)$@ git=
=2Eo \
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0$(BUILTIN_OBJS) $(ALL_LDFLAGS) $(LIBS)
<snip>
> =A0ifdef NO_EXPAT
> =A0http-walker.o: http-walker.c http.h GIT-CFLAGS
> - =A0 =A0 =A0 $(QUIET_CC)$(CC) -o $*.o -c $(ALL_CFLAGS) -DNO_EXPAT $<
> + =A0 =A0 =A0 $(QUIET_CC)$(CC) $(COBJFLAG)$*.o $(COMPFLAG) $(ALL_CFLA=
GS) -DNO_EXPAT $<
> =A0endif

Perhaps this is the right time to change the make-system to using the
somewhat standard $(COMPLIE.c), $(OUTPUT_OPTION) etc macros?

--=20
Erik "kusma" Faye-Lund
kusmabite@gmail.com
(+47) 986 59 656
