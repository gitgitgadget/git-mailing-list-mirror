From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCHv6 06/23] notes.h/c: Propagate combine_notes_fn return
 value to add_note() and beyond
Date: Sun, 14 Nov 2010 15:22:43 -0600
Message-ID: <20101114212243.GC10150@burratino>
References: <1289339399-4733-1-git-send-email-johan@herland.net>
 <1289339399-4733-7-git-send-email-johan@herland.net>
 <AANLkTinQhkXvfa0BS0dFK6-mXFpU+uQ=rKRJ1QaXXA1S@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johan Herland <johan@herland.net>, git@vger.kernel.org,
	bebarino@gmail.com, avarab@gmail.com, gitster@pobox.com,
	srabbelier@gmail.com
To: Thiago Farina <tfransosi@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 14 22:23:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PHk2n-0005VA-IP
	for gcvg-git-2@lo.gmane.org; Sun, 14 Nov 2010 22:23:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753242Ab0KNVXU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 14 Nov 2010 16:23:20 -0500
Received: from mail-gx0-f174.google.com ([209.85.161.174]:49026 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751912Ab0KNVXT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Nov 2010 16:23:19 -0500
Received: by gxk23 with SMTP id 23so2654058gxk.19
        for <git@vger.kernel.org>; Sun, 14 Nov 2010 13:23:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=x1JgqY2374MreTPTji/VXKycmCNiP9YjpCFa4NxKsok=;
        b=shdxPN6v2uc/s4BxHt3mSd13cPVt/OBT1mZWezaMGsc5DcYTvx4DOvlssnXEc3+4Px
         gQyMVcihXOB3/DhMrsSeoqhdNBI3LgwG/E4TIBT+mh0mCH8XUa0GH/MZ9dEYn5vADuVJ
         niNQJEZNCcyCVKI4Wi8I3rI5yUeCtFGfv1O/g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=ezffVX/sWQYXuwTp0yMPtOnoXfS3lj+nmWABgRgndpkfqQBc7Z3sNG3Qh9pSTAuaq2
         Pdi1125Ii0jGzyVfrQCGpJVVfVMoAoIEwJxiDmiXEuKgV8g8C5+Bl9Xux7CrEjLIBLgn
         XLJBbsZZVJ8jYFi4Qt4FgB4JxlhS3FcJeJ9es=
Received: by 10.151.44.9 with SMTP id w9mr8180253ybj.274.1289769798175;
        Sun, 14 Nov 2010 13:23:18 -0800 (PST)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id v39sm2409380yba.19.2010.11.14.13.23.15
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 14 Nov 2010 13:23:17 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <AANLkTinQhkXvfa0BS0dFK6-mXFpU+uQ=rKRJ1QaXXA1S@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161442>

Thiago Farina wrote:
> On Tue, Nov 9, 2010 at 7:49 PM, Johan Herland <johan@herland.net> wro=
te:

>> --- a/builtin/notes.c
>> +++ b/builtin/notes.c
>> @@ -573,8 +573,8 @@ static int add(int argc, const char **argv, cons=
t char *prefix)
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (is_null_sha1(new_note))
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0remove_note(t=
, object);
>> - =C2=A0 =C2=A0 =C2=A0 else
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 add_note(t, objec=
t, new_note, combine_notes_overwrite);
>> + =C2=A0 =C2=A0 =C2=A0 else if (add_note(t, object, new_note, combin=
e_notes_overwrite))
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 die("confused: co=
mbine_notes_overwrite failed");
>
> This message looks like more a debug information. Could it be
> rewritten to be more user friendly / more informative?

Sverre mentioned the same thing.  The intent is the same as the existin=
g

		die("should not happen, someone must be hit on the forehead");

--- i.e., to provoke bug reports if it happens, without the appearance
of begging. :)

So how about:

		die("BUG: combine_notes_overwrite failed");

Something involving assert() could also work, but that tends to be
a bit ugly.
