From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: gitweb not friendly to firefox revived
Date: Sat, 14 Aug 2010 10:48:08 +0000
Message-ID: <AANLkTimR9Wkz+YOchyjvO8fgAwk5YsGtcpMOpyZY4Fjv@mail.gmail.com>
References: <20100801195138.GA1980@pengutronix.de>
	<m3lj8qozan.fsf@localhost.localdomain>
	<20100803210730.GA1254@pengutronix.de>
	<201008032350.40117.jnareb@gmail.com>
	<4C6670EE.3060806@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jakub Narebski <jnareb@gmail.com>,
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
	<u.kleine-koenig@pengutronix.de>, git@vger.kernel.org,
	kernel@pengutronix.de
To: Stephen Boyd <bebarino@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 14 12:48:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OkEHn-00083p-PW
	for gcvg-git-2@lo.gmane.org; Sat, 14 Aug 2010 12:48:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934693Ab0HNKsK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 14 Aug 2010 06:48:10 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:51232 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934688Ab0HNKsJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 14 Aug 2010 06:48:09 -0400
Received: by yxg6 with SMTP id 6so1329487yxg.19
        for <git@vger.kernel.org>; Sat, 14 Aug 2010 03:48:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=W2PQzbdngzXLlWTD9Qr97RBkkqV4Qu2qkZ3maBK1Ae0=;
        b=pv7EuxExJlyUT6ghmfXKyaWu+eNAeKiDtLfwUgSY61jV88IDEnxPTFKm6UnNRkDA6+
         bn8w/196NvcFF/D8SqsFPVumJOHsyuNOP3njxHlodyIAUWX5SddiEZuRjxqIli7pUo3N
         RZsDTlnGWJutBo2W6yMdg0t4EgPbdB44ebBiM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=btU9W7DujdKzE934J9dIww4QuIw8NMABhwuPHe9RDEqAYpSfRnVitFhrsBM+CLNDSk
         2YUPRzTMr8uubZ4MS3InGlnXKNtPXbOefKNysJbnRJZrehBzK8gC5k+oZ2eNO5i/NaHn
         jGkL4T24Y9LeV2j+X0WM8LsiNgfhmaw0eg/bo=
Received: by 10.231.35.77 with SMTP id o13mr3000774ibd.92.1281782888159; Sat,
 14 Aug 2010 03:48:08 -0700 (PDT)
Received: by 10.231.186.226 with HTTP; Sat, 14 Aug 2010 03:48:08 -0700 (PDT)
In-Reply-To: <4C6670EE.3060806@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153553>

2010/8/14 Stephen Boyd <bebarino@gmail.com>:
> =C2=A0On 08/03/2010 02:50 PM, Jakub Narebski wrote:
>>
>> +
>> + =C2=A0 =C2=A0 =C2=A0 my $title =3D to_utf8("Search for commits $pe=
rformed by $author");
>> + =C2=A0 =C2=A0 =C2=A0 $title =3D~ s/[[:cntrl:]]/?/g;
>> +
>>
>
> Isn't it possible that other data coming from git could have escape
> characters in them such as the commit subject line? In which case thi=
s same
> bug would occur?
>
> Therefore isn't it better to strip out control characters (that's wha=
t this
> patch is doing right?) in esc_html?

I don't think stripping them out is the right thing either, hiding
from you that something is Really Wrong (binary garbage in patches)
isn't good.

Something like this would be better:

    s/([[:cntrl:]])/sprintf("\\%03x", ord $1)/ge

E.g.:

    $ perl -E 'my $s =3D join "", map { chr } 1 .. 40; $s =3D~
s/([[:cntrl:]])/sprintf("\\%03x", ord $1)/ge; say $s'
    \001\002\003\004\005\006\007\008\009\00a\00b\00c\00d\00e\00f\010\01=
1\012\013\014\015\016\017\018\019\01a\01b\01c\01d\01e\01f
!"#$%&'(
