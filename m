From: "Mike Ralphson" <mike.ralphson@gmail.com>
Subject: Re: [PATCH] Makefile: update the default build options for AIX
Date: Wed, 7 May 2008 17:20:14 +0100
Message-ID: <e2b179460805070920i2ff5798dpacb5c55d851d5ede@mail.gmail.com>
References: <1210149355875-git-send-email-mike@abacus.co.uk>
	 <4821992F.4060201@viscovery.net>
	 <e2b179460805070551x7a0072e0w4d406ef4112849ce@mail.gmail.com>
	 <4821AB32.8090700@viscovery.net> <4821BECA.8020509@nrlssc.navy.mil>
	 <e2b179460805070815u6cc627feo6137084fe7c5a635@mail.gmail.com>
	 <4821CD5C.5010506@nrlssc.navy.mil>
	 <7vfxsudrt0.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Brandon Casey" <casey@nrlssc.navy.mil>,
	"Johannes Sixt" <j.sixt@viscovery.net>, git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 07 18:21:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JtmOF-0005JO-Ot
	for gcvg-git-2@gmane.org; Wed, 07 May 2008 18:21:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757027AbYEGQUU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 May 2008 12:20:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756937AbYEGQUT
	(ORCPT <rfc822;git-outgoing>); Wed, 7 May 2008 12:20:19 -0400
Received: from rv-out-0506.google.com ([209.85.198.230]:45707 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755637AbYEGQUP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 May 2008 12:20:15 -0400
Received: by rv-out-0506.google.com with SMTP id l9so441114rvb.1
        for <git@vger.kernel.org>; Wed, 07 May 2008 09:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=2kY2jR1cu7LZG13+mDCJgnxJ3aZF+C7Fvoz0YTN8CwU=;
        b=MYoWvKHbkxpsZSlItRXt5e0mFwdOsMXn/0OamZK+mzyhQEoYlqcv//cEEiZ11QxT6R7g89pJoy6CV8/nrXq7UIgdUsfLzIiYyZkJNH9jA5Xo2IF/a0uTJdFtXEQ9f+tRAjiMWzdmMDcnhOO+EL/iNnypUO2OTW06Q919oqTN7i0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=WB4LZPMWxRE3hf0SjwmsFKWSRiq/koUeTf4PQUCjquDcTwCow4ipHOH2dxXy0m8MOkAtVYNNe+iZCdsU5h0idjlN1SiKT6OwBCQfM7V5OPBMFAVzIMpKcbVseb6s3WGHOol2vtwooLH+TzLNgQC3kmoYogn3cxd5I3J/07zqXeY=
Received: by 10.141.49.6 with SMTP id b6mr1036392rvk.223.1210177214433;
        Wed, 07 May 2008 09:20:14 -0700 (PDT)
Received: by 10.140.142.5 with HTTP; Wed, 7 May 2008 09:20:14 -0700 (PDT)
In-Reply-To: <7vfxsudrt0.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81460>

2008/5/7 Junio C Hamano <gitster@pobox.com>:
>
> Brandon Casey <casey@nrlssc.navy.mil> writes:
>
>  > Mike Ralphson wrote:
>  >> 2008/5/7 Brandon Casey <casey@nrlssc.navy.mil>:
>  >>> Johannes Sixt wrote:
>  >>>  > The #define fopen in git-compat-util.h essentially defeats the effect of
>  >>>  > _LARGE_FILES as far as fopen() calls are concerned: If
>  >>>  > FREAD_READS_DIRECTORIES is not defined, fopen() would be redirected to
>  >>>  > fopen64(), but when it is defined, it is redirected to git_fopen(), which
>  >>>  > in turn uses fopen() instead of fopen64() (due to the #undef in
>  >>>  > compat/fopen.c).
>  >>>  >
>  >>>
>  >>>  How about something like this?
>  >>>
>  >>>  diff --git a/compat/fopen.c b/compat/fopen.c
>  >>>  index ccb9e89..70b0d4d 100644
>  >>>  --- a/compat/fopen.c
>  >>>  +++ b/compat/fopen.c
>  >>>  @@ -1,5 +1,5 @@
>  >>>  +#undef FREAD_READS_DIRECTORIES
>  >>>   #include "../git-compat-util.h"
>  >>>  -#undef fopen
>  >>>   FILE *git_fopen(const char *path, const char *mode)
>  >>>   {
>  >>>         FILE *fp;
>  >>>
>  >>>
>  >>>  -brandon
>  >>>
>  >>
>  >> Ta. I still get all the warnings with that, was that what you were
>  >> trying to solve? The 64 bit specific tests in t5302 do still pass.
>  >
>  > Ah, yes. You would still get the warnings for every other file that
>  > includes git-compat-util.h, except compat/fopen.c. I didn't think
>  > about all of those. :) In this case those are indeed harmless. And now
>  > the git provided git_fopen() will use the compiler selected fopen()
>  > which should avoid any of the gotchas that Hannes brought up.
>
>  In any case, that #undef then #include dance needs a big comment on why it
>  has to be so.
>

Indeed. Please add ascii-art diagrams and don't use long words. I may
then have a chance of understanding how this works, and how I should
have spotted 5 potentially non-harmless warnings among 400 noise ones,
when all I did was get the testsuite from non-passing to passing! 8-)

In reality, thanks to all for pitching in.

Mike
