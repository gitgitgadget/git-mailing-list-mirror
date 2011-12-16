From: Michael Horowitz <michael.horowitz@ieee.org>
Subject: Re: git-p4.skipSubmitEdit
Date: Fri, 16 Dec 2011 10:38:58 -0500
Message-ID: <CAFLRboo8DBk3zFEBF9OqKmre=d5PM7+3J9V0pHNz53MPtqjOWA@mail.gmail.com>
References: <1315514452.10046.0.camel@uncle-pecos>
	<4E6DB5F0.7080303@diamand.org>
	<1315847540.10046.29.camel@uncle-pecos>
	<20111018004500.GA31768@arf.padd.com>
	<4E9DBD0B.7020505@diamand.org>
	<20111020011610.GA7292@arf.padd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Luke Diamand <luke@diamand.org>,
	"L. A. Linden Levy" <alevy@mobitv.com>, git@vger.kernel.org
To: Pete Wyckoff <pw@padd.com>
X-From: git-owner@vger.kernel.org Fri Dec 16 16:39:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RbZsJ-0007sd-4w
	for gcvg-git-2@lo.gmane.org; Fri, 16 Dec 2011 16:39:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759280Ab1LPPjA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 16 Dec 2011 10:39:00 -0500
Received: from mail-pw0-f46.google.com ([209.85.160.46]:43629 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756507Ab1LPPi6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 16 Dec 2011 10:38:58 -0500
Received: by pbdu13 with SMTP id u13so779098pbd.19
        for <git@vger.kernel.org>; Fri, 16 Dec 2011 07:38:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=0BT86U/CmcUvLNsDIN9U5Bld253ltqYAh3kLc2wHY90=;
        b=NHuvOA2bH7UoOb09Y+5GeqdhIv1AFj/4IvONirKIwI9YgEa2nm4muvS+X1ec7UxWPi
         L5btW7yhhuZT4kF7HHaGnIb2ALexTm9qEkEFBwKzIyedyBLZK3rVPWD9YK8vhREwAeg9
         1/6j/mMPoIZQLOMcoh1sE8ynxqVcPAJKFXxrU=
Received: by 10.68.190.202 with SMTP id gs10mr17152300pbc.5.1324049938471;
 Fri, 16 Dec 2011 07:38:58 -0800 (PST)
Received: by 10.143.31.6 with HTTP; Fri, 16 Dec 2011 07:38:58 -0800 (PST)
In-Reply-To: <20111020011610.GA7292@arf.padd.com>
X-Google-Sender-Auth: Z6nQ_2tjwjPwHXJafUtCGrEvXio
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187282>

All,

It appears that this change has introduced a bug that causes submit to
fail every time if you do not skip the submit edit.

=46rom what I can tell, this is because the new edit_template method
does not return True at the end.

Thanks,

Mike



On Wed, Oct 19, 2011 at 9:16 PM, Pete Wyckoff <pw@padd.com> wrote:
> luke@diamand.org wrote on Tue, 18 Oct 2011 18:53 +0100:
>> Looks good, one minor nit (see below) and a comment.
> [..]
>> >+ =A0 =A0 =A0 =A0# invoke the editor
>> >+ =A0 =A0 =A0 =A0if os.environ.has_key("P4EDITOR"):
>> >+ =A0 =A0 =A0 =A0 =A0 =A0editor =3D os.environ.get("P4EDITOR")
>> >+ =A0 =A0 =A0 =A0else:
>> >+ =A0 =A0 =A0 =A0 =A0 =A0editor =3D read_pipe("git var GIT_EDITOR")=
=2Estrip()
>> >+ =A0 =A0 =A0 =A0system(editor + " " + template_file)
>>
>> This is where we should really check the return code. However, doing
>> so seems to break lots of the existing tests so it's not as easy as
>> it looks.
>
> Indeed. =A0I'll not fix that now, but agree it should be.
>
>> >+
>> >+ =A0 =A0 =A0 =A0# If the file was not saved, prompt to see if this=
 patch should
>> >+ =A0 =A0 =A0 =A0# be skipped. =A0But skip this verification step i=
f configured so.
>> >+ =A0 =A0 =A0 =A0if gitConfig("git-p4.skipSubmitEditCheck") =3D=3D =
"true":
>> >+ =A0 =A0 =A0 =A0 =A0 =A0print "return true for skipSubmitEditCheck=
"
>>
>> You print a helpful/annoying(?) message here, but not further up at
>> skipSubmitEdit?
>
> Aargh. =A0Leaked debug code. =A0Thanks for noticing. =A0I got rid of
> it.
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0-- Pete
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
