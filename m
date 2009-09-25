From: Yakov Lerner <iler.ml@gmail.com>
Subject: Re: [PATCH] fix obscure perl message when encryption=tls and smtp 
	cannot connect.
Date: Sat, 26 Sep 2009 00:39:52 +0300
Message-ID: <f36b08ee0909251439o38b8e414nc7621085d7489ade@mail.gmail.com>
References: <1253914213-22274-1-git-send-email-iler.ml@gmail.com>
	 <20090925213440.GX14660@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Git Mailing List <git@vger.kernel.org>,
	"Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Sep 25 23:40:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MrIWF-0007p4-5M
	for gcvg-git-2@lo.gmane.org; Fri, 25 Sep 2009 23:39:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752521AbZIYVju convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 25 Sep 2009 17:39:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752361AbZIYVjt
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Sep 2009 17:39:49 -0400
Received: from fg-out-1718.google.com ([72.14.220.157]:21286 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752345AbZIYVjt convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 25 Sep 2009 17:39:49 -0400
Received: by fg-out-1718.google.com with SMTP id 22so289935fge.1
        for <git@vger.kernel.org>; Fri, 25 Sep 2009 14:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=AcSy/mQmMB4rlA50cIYIvRHDYnc2dxehhR+KEBJHpeY=;
        b=hsPrJJBbih1RPnWlmdZvtYQpH/vXHQZ3FMp8Q2E5BzSr0HFM5tIa6WagHEr+JcErTN
         0MnObJn9JQe6FtLtFJBrBZY+JsahM+any5WxDu5p+JaqI3mGWGaZDXzeKs5zduZ2u8Yd
         reLJkdf42zBlELsOw+/fzjPKIDi+RvieiaOqQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        b=ekeBU6FiyrUmJQKiHuTu4n2RU/y2t6AROArYvWPawhWcfocJYs/TFN+F30SqsHFi1w
         DDC1Ej8TQnLBOTn0KkvEgX2eETftPVdsQKTdc/0j8EfnmUWquRmsaUvN+aOXjTVA/EmA
         fGhs8+CkqBTlxWqBY8uqJgIpg7YfP5wkCWhHE=
Received: by 10.239.168.135 with SMTP id k7mr57016hbe.99.1253914792380; Fri, 
	25 Sep 2009 14:39:52 -0700 (PDT)
In-Reply-To: <20090925213440.GX14660@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129121>

On Sat, Sep 26, 2009 at 00:34, Shawn O. Pearce <spearce@spearce.org> wr=
ote:
>
> iler.ml@gmail.com wrote:
> > When encryption=3Dtls and smtp cannot connect, git-send-email print=
s following perl error:
> >
> > Can't call method "command" on an undefined value at /usr/local/lib=
exec/git-core/git-send-email line 927.
> >
> > (ithis is when smtp host orport is misspelled, or network is down, =
and encryption is tls).
> > We expect some familiar "Cannot connect to SERVER:PORT" message.
> > Fix it to print normal "smtp can't connect" diagnostics.
>
> Thanks, looks reasonable. =A0Signed-off-by line, per the Developer's
> Certificate of Origin in Documentation/SubmittingPatches ?


Signed-off-by: Yakov Lerner <iler.ml@gmail.com>

>
> > --- /usr/local/libexec/git-core/git-send-email.000 =A0 =A02009-09-2=
6 00:10:01.000000000 +0300
> > +++ /usr/local/libexec/git-core/git-send-email =A0 =A0 =A0 =A02009-=
09-26 00:11:39.000000000 +0300
> > @@ -922,7 +922,7 @@
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 $smtp ||=3D Net::SMTP->=
new((defined $smtp_server_port)
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0? "$smtp_server:$smtp_server_port"
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0: $smtp_server);
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ($smtp_encryption eq '=
tls') {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ($smtp_encryption eq '=
tls' && $smtp) {
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 require=
 Net::SMTP::SSL;
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 $smtp->=
command('STARTTLS');
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 $smtp->=
response();
>


Yakov
