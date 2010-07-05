From: Dylan Reid <dgreid@gmail.com>
Subject: Re: [PATCH] xdiff: optimise for no whitespace difference when 
	ignoring whitespace.
Date: Mon, 5 Jul 2010 08:34:29 -0400
Message-ID: <AANLkTinmdeTSRVCTblnGrG5lGpNKCiYIb8BO8jMhajXW@mail.gmail.com>
References: <1278310017-24299-1-git-send-email-dgreid@gmail.com>
	<4C319931.4020603@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Mon Jul 05 14:34:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OVkse-0002XQ-Qp
	for gcvg-git-2@lo.gmane.org; Mon, 05 Jul 2010 14:34:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755958Ab0GEMeb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 5 Jul 2010 08:34:31 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:33446 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755861Ab0GEMea convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 5 Jul 2010 08:34:30 -0400
Received: by gye5 with SMTP id 5so1203344gye.19
        for <git@vger.kernel.org>; Mon, 05 Jul 2010 05:34:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=pTYW+KzgEQbmliVwTT+3jjVncGOWDid7Oj7VJH/qmgY=;
        b=DZvN+g46txuo+ZLgtk/XtZBVxmXI26I0fscnryf8JikjCMson6YlXJtqBnaCX/8PXU
         nuRsFf/i1gFBzhhM3pXruvaLv4IFYRJp83GTrcmBT5SGkDDFuIBvFbLpOKxlnLqx5efC
         FBD8HBGSFFLWYLU7KMqUtt5X03Ji97S/ikcAQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=DgGEYp8UBF6V5odJKrBCBPLuAsDxhYyhz89GXDlFZ0VdNGLWKj+o9XOCoWaKl3QMnS
         zrSee7dGSbAGkED4YjF7kCY+4YfimnA7IpU9pkuhk7bG2/QUHqTy+Lpa3J0tRUw1MnV5
         mgkmULrTzK/Jjhq8jqHRkW0SXWDuiip9IGojk=
Received: by 10.229.28.74 with SMTP id l10mr1484643qcc.142.1278333269234; Mon, 
	05 Jul 2010 05:34:29 -0700 (PDT)
Received: by 10.150.51.17 with HTTP; Mon, 5 Jul 2010 05:34:29 -0700 (PDT)
In-Reply-To: <4C319931.4020603@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150263>

On Mon, Jul 5, 2010 at 4:34 AM, Michael J Gruber
<git@drmicha.warpmail.net> wrote:
> Dylan Reid venit, vidit, dixit 05.07.2010 08:06:
>> Invert the order of the memcmp and flag check are done in xdl_recmat=
ch,
>
> I was wondering whether you describe old (before patch) or new (after
> patch) here. Maybe one of the following is clearer:
>
> "Invert the order of the memcmp and flag check which are done in
> xdl_recmatch,"
>
> "Invert the order of the memcmp and flag check in xdl_recmatch,"
>

I'll make that more clear.

>> + =A0 =A0 if (s1 =3D=3D s2 && !memcmp(l1, l2, s1))
>> + =A0 =A0 =A0 =A0 =A0 =A0 return 1;
>> + =A0 =A0 else if (!(flags & XDF_WHITESPACE_FLAGS))
>
> You can do without the "else" here.

sure can, will do.

>> + =A0 =A0 =A0 =A0 =A0 =A0 return 0;
>>
>> =A0 =A0 =A0 i1 =3D 0;
>> =A0 =A0 =A0 i2 =3D 0;
>
> BTW: How did you find this? Are you profiling parts of git?
>
> Michael
>

I was looking to add an unrelated feature and just happened to notice
this.  It was a really cheap change for a good speedup.

Thanks,

Dylan
