From: Mark Lodato <lodatom@gmail.com>
Subject: Re: [PATCHv2] completion: make compatible with zsh
Date: Mon, 30 Aug 2010 20:55:46 -0400
Message-ID: <AANLkTimNULQNVZ4hzaNY1ZobPRtj_zj545Xi29guGu4g@mail.gmail.com>
References: <1282877156-16149-1-git-send-email-lodatom@gmail.com> <20100830141927.GA16495@neumann>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org,
	avarab@gmail.com, Jonathan Nieder <jrnieder@gmail.com>,
	Andrew Sayers <andrew-git@pileofstuff.org>
To: =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Tue Aug 31 02:56:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OqF97-0008Fq-Gn
	for gcvg-git-2@lo.gmane.org; Tue, 31 Aug 2010 02:56:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756317Ab0HaA4J convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 30 Aug 2010 20:56:09 -0400
Received: from mail-qy0-f174.google.com ([209.85.216.174]:52771 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755901Ab0HaA4I convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 Aug 2010 20:56:08 -0400
Received: by qyk36 with SMTP id 36so85034qyk.19
        for <git@vger.kernel.org>; Mon, 30 Aug 2010 17:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=o5UoimyxwWtPcR0u3OIIEwAVq80p4o69T2wO6N5YqNo=;
        b=IbxNr1Sr0pvXxF2Mp3yN3/PgEh/ztdFFHT71bvDI3e5HNh66sKm/isaIyftEo41pf1
         l4OGAs6rqvD+Q/8uCHRykgMLIo6TURdwxCr1PM6dw7XFU1Ba4INwcxb0pmu+QhhDZjUL
         998K1qMYxzNVw7geu2Ia3YQvgk1YC66u7u4yI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=bF7gP7TtIV/uhMKCGvBv30rFDPNARXNBGajWmpxVtmLW1wBzCmXVEGV7L6Y+xGASGM
         H0nuVxZXMwZiKdDCfWGf4IqLaFG8ibm+FGQjanADFWJVzBF8cD+/41SftNfgGguQuDDI
         z33XM/LoSnAs22GRmii/6NYv0iNYhfp5AB6N0=
Received: by 10.224.97.97 with SMTP id k33mr3542958qan.49.1283216166187; Mon,
 30 Aug 2010 17:56:06 -0700 (PDT)
Received: by 10.229.114.136 with HTTP; Mon, 30 Aug 2010 17:55:46 -0700 (PDT)
In-Reply-To: <20100830141927.GA16495@neumann>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154872>

2010/8/30 SZEDER G=C3=A1bor <szeder@ira.uka.de>
> On Thu, Aug 26, 2010 at 10:45:56PM -0400, Mark Lodato wrote:
> > @@ -2417,3 +2433,29 @@ if [ Cygwin =3D "$(uname -o 2>/dev/null)" ];=
 then
> > =C2=A0complete -o bashdefault -o default -o nospace -F _git git.exe=
 2>/dev/null \
> > =C2=A0 =C2=A0 =C2=A0 || complete -o default -o nospace -F _git git.=
exe
> > =C2=A0fi
> > +
> > +if [[ -z $ZSH_VERSION ]]; then
>
> -z? =C2=A0I think you wanted to use -n here, like at the other places=
=2E

Oh, yes, sorry.  This was a mistake.  Thanks for catching it.


> Nit: why "if [[ ... ]]"? =C2=A0FWIW "if [ ... ]" would be enough.

Because you don't need to quote variables with [[ ... ]] --- e.g. [
$lines =3D 0 ] fails, though in this case this feature does not matter
--- and because [[ ... ]] is faster.

Bash 4.1.5:
> time (for (( i =3D 0; i < 200000; i++ )); do [ -z $foo ]; done)
real    0m3.430s
user    0m3.240s
sys     0m0.180s
> time (for (( i =3D 0; i < 200000; i++ )); do [[ -z $foo ]]; done)
real    0m2.219s
user    0m2.090s
sys     0m0.100s

Zsh 4.3.10:
> time (for (( i =3D 0; i < 2000000; i++ )); do [ -z $foo ]; done)
(; for ((i =3D 0; i < 2000000; i++ )) do; [ -z $foo ]; done; )  13.56s
user 1.64s system 99% cpu 15.327 total
> time (for (( i =3D 0; i < 2000000; i++ )); do [[ -z $foo ]]; done)
(; for ((i =3D 0; i < 2000000; i++ )) do; [[ -z $foo ]]; done; )  4.62s
user 0.01s system 99% cpu 4.644 total

Is there a reason to prefer [ ... ] ?
