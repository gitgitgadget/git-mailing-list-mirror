From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [RFC 2/2] Make misuse of get_pathname() buffers detectable by valgrind
Date: Wed, 16 Nov 2011 20:57:52 +0700
Message-ID: <CACsJy8CG0A1kUUyA=1AW+3cNTjrgb_iKjdfs7M8Sa6s0cuDANw@mail.gmail.com>
References: <1317097687-11098-1-git-send-email-mhagger@alum.mit.edu> <1317097687-11098-3-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Petr Baudis <pasky@suse.cz>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed Nov 16 14:58:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RQg0T-0004iy-L7
	for gcvg-git-2@lo.gmane.org; Wed, 16 Nov 2011 14:58:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757829Ab1KPN6Z convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 16 Nov 2011 08:58:25 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:36093 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757764Ab1KPN6Y convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 16 Nov 2011 08:58:24 -0500
Received: by bke11 with SMTP id 11so575806bke.19
        for <git@vger.kernel.org>; Wed, 16 Nov 2011 05:58:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=gHejgIy6Wi+CnbFofUVDiBaKYohg8J1E6mVYIg0dhfI=;
        b=qPp+cZdQttvl0Z+Er6R+pxOj8Td7eiWbzIUejZTSPVfGiqxtugKoVGa/8Y8jF+dQIL
         8CVy9Yb1VEmZdyMe+rjBzNrS2WBmBqnHSKGdEusJJibiSm413RemR8TGY7XFyhrY0HLo
         H/LwE0W/7nSzc7WARtvQMUo7OEAtPP2IflOl4=
Received: by 10.205.117.10 with SMTP id fk10mr28840356bkc.29.1321451903221;
 Wed, 16 Nov 2011 05:58:23 -0800 (PST)
Received: by 10.204.23.2 with HTTP; Wed, 16 Nov 2011 05:57:52 -0800 (PST)
In-Reply-To: <1317097687-11098-3-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185549>

On Tue, Sep 27, 2011 at 11:28 AM, Michael Haggerty <mhagger@alum.mit.ed=
u> wrote:
> A temporary buffer produced by get_pathname() is recycled after a few
> subsequent calls of get_pathname(). =C2=A0The use of such a buffer af=
ter it
> has been recycled can result in the wrong file being accessed with
> very strange effects. =C2=A0Moreover, such a bug can lie dormant unti=
l code
> elsewhere is changed to use a temporary buffer, causing very
> mysterious, nonlocal failures that are hard to analyze.
>
> Add a second implementation of get_pathname() (activated if the
> VALGRIND preprocessor macro is defined) that allocates and frees
> buffers instead of recycling statically-allocated buffers. =C2=A0This=
 does
> not make the problem less serious, but it turns the errors into
> access-after-free errors, making it possible to locate the guilty cod=
e
> using valgrind.
>
> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
> ---
>
> I believe that it is frowned upon to use #ifdefs in git code, but no
> good alternative is obvious to me for this type of use. =C2=A0Suggest=
ions
> are welcome.

Enable the code based on an environment variable, e.g.
GIT_DEBUG_FENCE, then enable it by default in test-lib.sh :-)
--=20
Duy
