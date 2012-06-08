From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCHv6 1/4] Read (but not write) from $XDG_CONFIG_HOME/git/config
 file
Date: Fri, 8 Jun 2012 14:33:04 +0200
Message-ID: <CABPQNSbSVznFbnm=iy4HdZ4PDC70UfbrqvvSKx9moy+9AOk+Rw@mail.gmail.com>
References: <1338754481-27012-1-git-send-email-Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>
 <1338988885-21933-1-git-send-email-Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>
 <7vpq9aenl0.fsf@alter.siamese.dyndns.org> <20120608142601.Horde.Tq7UO3wdC4BP0e9ZGAy1EwA@webmail.minatec.grenoble-inp.fr>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Huynh Khoi Nguyen NGUYEN 
	<Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>, git@vger.kernel.org,
	Matthieu.Moy@grenoble-inp.fr,
	NGUYEN Huynh Khoi Nguyen <nguyenhu@ensibm.imag.fr>,
	Valentin Duperray <Valentin.Duperray@ensimag.imag.fr>,
	Franck Jonas <Franck.Jonas@ensimag.imag.fr>,
	Lucien Kong <Lucien.Kong@ensimag.imag.fr>,
	Thomas Nguy <Thomas.Nguy@ensimag.imag.fr>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>
To: nguyenhu@minatec.inpg.fr
X-From: git-owner@vger.kernel.org Fri Jun 08 14:33:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ScyO2-0001Ka-Ac
	for gcvg-git-2@plane.gmane.org; Fri, 08 Jun 2012 14:33:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760965Ab2FHMdt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 8 Jun 2012 08:33:49 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:49798 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756333Ab2FHMds convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 8 Jun 2012 08:33:48 -0400
Received: by dady13 with SMTP id y13so2295178dad.19
        for <git@vger.kernel.org>; Fri, 08 Jun 2012 05:33:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=3Oe8baQ8o7bWJ5Xz4fWXJCsGcwZPpWqgEpKbfk25oiQ=;
        b=cs0lHkR4mN9LE8qB6VnqhfEMUdurs1f8gejoqxLY27tGh/RGZ/Aoz0fWXjj/bYYzrH
         jmeO7OtceW0iH7vxN/+UTJTEYlQ7rZGIHTHKaim/61epso6J0c4H1ZkEs/1X8IDvZgCU
         H2ewr6DnGymxNROdHsToOSDztWv/mbmCN6A2PjiueX5WAPRIVCKYCmgWKNcUAiKEWPeN
         aEjsGPlci7aDwajLgwvFL23EgfEUsO51qf7TM2X+1ftg76WzA6MY5OAd1lJAvRB7ZxFk
         N8RFdpf0H6AbclM+kEl5t/ZFgqBPgqqTZ2bzSqTdsRH4gbChnozHn2CFrWYEEcgZFP/W
         ubLw==
Received: by 10.68.216.5 with SMTP id om5mr16541138pbc.64.1339158824841; Fri,
 08 Jun 2012 05:33:44 -0700 (PDT)
Received: by 10.68.40.98 with HTTP; Fri, 8 Jun 2012 05:33:04 -0700 (PDT)
In-Reply-To: <20120608142601.Horde.Tq7UO3wdC4BP0e9ZGAy1EwA@webmail.minatec.grenoble-inp.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199483>

On Fri, Jun 8, 2012 at 2:26 PM,  <nguyenhu@minatec.inpg.fr> wrote:
>
> Junio C Hamano <gitster@pobox.com> a =E9crit=A0:
>
>>> +char *mkpathdup(const char *fmt, ...)
>>> +{
>>> + =A0 =A0 =A0 char path[PATH_MAX];
>>> + =A0 =A0 =A0 va_list args;
>>> + =A0 =A0 =A0 unsigned len;
>>> +
>>> + =A0 =A0 =A0 va_start(args, fmt);
>>> + =A0 =A0 =A0 len =3D vsnprintf(path, sizeof(path), fmt, args);
>>> + =A0 =A0 =A0 va_end(args);
>>> + =A0 =A0 =A0 if (len >=3D sizeof(path))
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return xstrdup(bad_path);
>>> + =A0 =A0 =A0 return xstrdup(cleanup_path(path));
>>> +}
>>
>>
>> Hrmph. If a new helper is introduced anyway, wouldn't it be a better
>> idea to get rid of the hardcoded PATH_MAX limitation, perhaps using
>> strbuf_vaddf() or something in the implementation of this function?
>
>
> What about this ?
>
>
> char *mkpathdup(const char *fmt, ...)
> {
> =A0 =A0 =A0 =A0char *path;
> =A0 =A0 =A0 =A0struct strbuf sb =3D STRBUF_INIT;
> =A0 =A0 =A0 =A0va_list args;
>
> =A0 =A0 =A0 =A0va_start(args, fmt);
> =A0 =A0 =A0 =A0strbuf_vaddf(&sb, fmt, args);
> =A0 =A0 =A0 =A0va_end(args);
> =A0 =A0 =A0 =A0path =3D sb.buf;
>
> =A0 =A0 =A0 =A0strbuf_release(&sb);
> =A0 =A0 =A0 =A0return xstrdup(cleanup_path(path));
>
> }

No, strbuf_release(&sb) frees 'sb.buf', causing 'path' to point to
unallocated memory. You can fix that by doing something along these
lines on top:

 	va_end(args);
-	path =3D sb.buf;
+	path =3D xstrdup(cleanup_path(path));

 	strbuf_release(&sb);
-	return xstrdup(cleanup_path(path));
+	return path;
 }
