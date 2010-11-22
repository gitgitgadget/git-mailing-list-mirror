From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: [PATCH v2 3/7] url: add str wrapper for end_url_with_slash()
Date: Tue, 23 Nov 2010 01:19:18 +0800
Message-ID: <AANLkTinADtgPfOESd8OTxk20GDFDN2DCOZt7jf0ra_x8@mail.gmail.com>
References: <1290433298-6000-1-git-send-email-rctay89@gmail.com>
	<1290433657-4444-1-git-send-email-rctay89@gmail.com>
	<1290433657-4444-2-git-send-email-rctay89@gmail.com>
	<1290433657-4444-3-git-send-email-rctay89@gmail.com>
	<1290433657-4444-4-git-send-email-rctay89@gmail.com>
	<20101122171433.GB2084@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 22 18:19:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PKa3L-00018J-IA
	for gcvg-git-2@lo.gmane.org; Mon, 22 Nov 2010 18:19:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755601Ab0KVRTX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 22 Nov 2010 12:19:23 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:41990 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750856Ab0KVRTT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 22 Nov 2010 12:19:19 -0500
Received: by eye27 with SMTP id 27so4016164eye.19
        for <git@vger.kernel.org>; Mon, 22 Nov 2010 09:19:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=wUOLN2AQ5OKuj4At1svjLqs9Ds3BFDYhwtjh6o6e9hI=;
        b=fCjk4jDduOt8ayUmNiZqetIpPuiXFIG1bPN4WHGmJRjEoi4WRf40NmXURULU7T3ABU
         sNZi5ne9yA0RY3O+SfT8G8hXHUQRbYR5D4MJj9NvUBgRzvF0vn3FHrZusdUu5dFAij7+
         BRs8SjEepiiuqCzHXRF2+CElD9A+Wftzyy9s8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=bQlyTCFwan2FDhyRvne7eWkuITFErFVI2JdVYQz/AdWPDiIo8uGpRZhdRUYZ0+WWTN
         ZJhqzAyKw5WXCHHx2SUhY/TW6mXoLdEtkRZAH03/z/EzkrAwppP9df50+svsYMRJtPik
         FK+IMYuPTgj6ayB/tJAnJo3WwQIs2exOTCWL4=
Received: by 10.213.14.146 with SMTP id g18mr8138881eba.2.1290446358054; Mon,
 22 Nov 2010 09:19:18 -0800 (PST)
Received: by 10.213.112.195 with HTTP; Mon, 22 Nov 2010 09:19:18 -0800 (PST)
In-Reply-To: <20101122171433.GB2084@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161904>

Hi,

On Tue, Nov 23, 2010 at 1:14 AM, Jonathan Nieder <jrnieder@gmail.com> w=
rote:
> Tay Ray Chuan wrote:
>
>> --- a/url.c
>> +++ b/url.c
>> @@ -132,3 +132,11 @@ void end_url_with_slash(struct strbuf *buf, con=
st char *url)
>> =A0 =A0 =A0 if (buf->len && buf->buf[buf->len - 1] !=3D '/')
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 strbuf_addstr(buf, "/");
>> =A0}
>> +
>> +void str_end_url_with_slash(const char *url, char **dest) {
>> + =A0 =A0 struct strbuf buf =3D STRBUF_INIT;
>> + =A0 =A0 end_url_with_slash(&buf, url);
>> + =A0 =A0 if (dest)
>> + =A0 =A0 =A0 =A0 =A0 =A0 free(*dest);
>> + =A0 =A0 *dest =3D strbuf_detach(&buf, NULL);
>
> I think this should be
>
> =A0 =A0 =A0 =A0end_url_with_slash(&buf, url);
> =A0 =A0 =A0 =A0free(*dest);
> =A0 =A0 =A0 =A0*dest =3D strbuf_detach(...
>
> If dest were NULL, the assignment would segfault anyway. =A0If dest w=
ere
> non-NULL and *dest NULL, the free() would be a no-op.

Thanks for the tip.

--=20
Cheers,
Ray Chuan
