From: "David Syzdek" <syzdek@gmail.com>
Subject: Re: [PATCH] Add support for uintmax_t type on FreeBSD 4.9
Date: Sun, 26 Oct 2008 21:46:20 -0800
Message-ID: <9a0027270810262246i56cf5515l5fa0875f91d90a7a@mail.gmail.com>
References: <1225021957-11880-1-git-send-email-david.syzdek@acsalaska.net>
	 <7vy70aip06.fsf@gitster.siamese.dyndns.org>
	 <9a0027270810262239r311074m51d382bdd95fd0dc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 27 06:47:38 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KuKwz-0004P0-F7
	for gcvg-git-2@gmane.org; Mon, 27 Oct 2008 06:47:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751639AbYJ0FqV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Oct 2008 01:46:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751641AbYJ0FqV
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Oct 2008 01:46:21 -0400
Received: from rv-out-0506.google.com ([209.85.198.224]:50725 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751627AbYJ0FqV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Oct 2008 01:46:21 -0400
Received: by rv-out-0506.google.com with SMTP id k40so1970022rvb.1
        for <git@vger.kernel.org>; Sun, 26 Oct 2008 22:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=SfieyhiVaW5wPbIe5i9hTloC+mb9bULaoaHBdIvij88=;
        b=jIOdfxW4E4/QX44hsTHPieh4k5cbZGnxEp3jxJGaFV47UMPEIaN2EAlE08Zp+A/CTv
         trGxhDmujzwU6E+3Nb3G9Sa9kCGNIv2s08j1gPp1AcLtV2ZrrnSl3B/RsfIurLTzuQXi
         kxd/mBPK8OUG8wrL4TUa9OcHRvZbSdtWHTET8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=o8eJy3zedjAb+rlGjS/5TtxwH+yvde0hP/nfVNvPeix4A+K5N3ug6zLEkXUoVtIcet
         tOhWBaLmYW+THQvv/qKetx1f4ZHpss21jHVRCqz1RoI+7F2OMA60GJKXQzV6R9PNuJWM
         1uLZZJNjUQmDaoCrerRo/oXi7e1BAvafb/4Do=
Received: by 10.141.171.6 with SMTP id y6mr3007089rvo.84.1225086380282;
        Sun, 26 Oct 2008 22:46:20 -0700 (PDT)
Received: by 10.141.77.7 with HTTP; Sun, 26 Oct 2008 22:46:20 -0700 (PDT)
In-Reply-To: <9a0027270810262239r311074m51d382bdd95fd0dc@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99207>

On Sun, Oct 26, 2008 at 9:30 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
> "David M. Syzdek" <david.syzdek@acsalaska.net> writes:
>
> > This adds NO_UINTMAX_T for ancient systems. If NO_UINTMAX_T is defined, then
> > uintmax_t is defined as uint32_t. This adds a test to configure.ac for
> > uintmax_t and adds a check to the Makefile for FreeBSD 4.9-SECURITY.
> > ...
> > diff --git a/Makefile b/Makefile
> > index 0d40f0e..bf6a6dc 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -931,6 +931,9 @@ endif
> >  ifdef NO_IPV6
> >       BASIC_CFLAGS += -DNO_IPV6
> >  endif
> > +ifdef NO_UINTMAX_T
> > +     BASIC_CFLAGS += -Duintmax_t=uint32_t
> > +endif
>
> I have a stupid question.
>
> Would it be a more appropriate improvement to do it like this:
>
>        ifdef USE_THIS_AS_UINTMAX_T
>            BASIC_CFLAGS += -Duintmax_t="$(USE_THIS_AS_UINTMAX_T)"
>        endif
>
> and then add a section for FreeBSD 4.9-SECURITY like this:
>
>        ifeq ($(uname_R),4.9-SECURITY)
>                USE_THIS_AS_UINTMAX_T = uint32_t
>        endif
>
> That way, an oddball 64-bit machine can use uint64_t here if it wants to,
> possibly including FreeBSD 4.9-SECURITY backported to 64-bit ;-).
>

Your suggestion provides more flexibility for other environments. I
was making the assumption that 64-bit systems would define uintmax_t,
however in retrospect that would be unwise.
Would you like me to resubmit the patches with your modifications?


--
An earthquake wiped out Etchisketchistan today.
  -- Onion TV
