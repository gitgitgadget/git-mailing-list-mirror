From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] Add ERR support to smart HTTP
Date: Mon, 6 Sep 2010 18:31:58 +0200
Message-ID: <201009061832.00512.jnareb@gmail.com>
References: <1283707815-32038-1-git-send-email-ilari.liusvaara@elisanet.fi> <201009061049.38546.jnareb@gmail.com> <AANLkTi=jqpspQvz6--CGfVEpP8raD7RpNGgMs6KabXfS@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "=?utf-8?q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason" 
	<avarab@gmail.com>, Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Tarmigan Casebolt <tarmigan+git@gmail.com>
To: Sitaram Chamarty <sitaramc@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 06 18:31:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OsebZ-0000GS-Ug
	for gcvg-git-2@lo.gmane.org; Mon, 06 Sep 2010 18:31:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752462Ab0IFQbc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Sep 2010 12:31:32 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:35918 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751080Ab0IFQbb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Sep 2010 12:31:31 -0400
Received: by bwz11 with SMTP id 11so3423899bwz.19
        for <git@vger.kernel.org>; Mon, 06 Sep 2010 09:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=tpU03pp91V6ZTtp8Gz7v6ZBAEgt9YEIa+FaMcmzGzHI=;
        b=EIG1uY9BNz68a2XFpzFECwtb2jouddp4iOpWXAWer2yaqH5KfXHgabiQQXJfHbddek
         veEKQU3pGWzWDWM1lSnmOGEgnOkZKeQA+qwLPwWq9gaP8xgj0Xmt0FlnAThAgKSC6SF4
         0LMLVjy4NjsRlrnP7DIPYQv1qMM4uhZH4igLg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=sE7O5X1WzAzktZ3q8liie6f8FA/ZAfZf9AYdNjrwpNQ2EzSO9xwiYL4xoPxkBrWFoA
         PxSwnWVVs9jc9lceXf70RxgR2b1soC0KS7REODIT972oHYSZfZIThHfjYOjF5MFX+svC
         pNLGN7kVjGr74SmNlmQbkP/3zokaZi+Je1qiw=
Received: by 10.204.112.7 with SMTP id u7mr3349207bkp.70.1283790689675;
        Mon, 06 Sep 2010 09:31:29 -0700 (PDT)
Received: from [192.168.1.13] (abwo37.neoplus.adsl.tpnet.pl [83.8.238.37])
        by mx.google.com with ESMTPS id x19sm4462623bkv.21.2010.09.06.09.31.27
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 06 Sep 2010 09:31:28 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <AANLkTi=jqpspQvz6--CGfVEpP8raD7RpNGgMs6KabXfS@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155582>

Sitaram Chamarty wrote:
> On Mon, Sep 6, 2010 at 2:19 PM, Jakub Narebski <jnareb@gmail.com> wro=
te:

> > Nevertheless I think it would be a good idea to make *client* more
> > accepting, which means:
> > 1. Printing full HTTP status, and not only HTTP return / error code=
;
> > =C2=A0 perhaps only if it is non-standard, and perhaps only in --ve=
rbose
> > =C2=A0 mode.
> > 2. If message body contains ERR line, print error message even if t=
he
> > =C2=A0 HTTP status was other than "200 OK". =C2=A0To be "generous i=
n what you
> > =C2=A0 receive" (well, kind of).
> > 3. In verbose mode, if body of HTTP error message (not "HTTP OK")
> > =C2=A0 exists and does not contain ERR line (e.g. an error from web=
 server),
> > =C2=A0 print it in full (perhaps indented).
> >
> > I think that neither of the above would lead to leaking sensitive
> > information.
>=20
> I didn't understand this bit about leaking info.  If the bits are
> coming into my machine I know what they are anyway (or am able to fin=
d
> out easily enough, even if git itself isn't showing them to me).
> Where's the leak?

I meant here that programs (including git) do not provide full details
about error condition, especially if it has to do womething with=20
authentication, to avoid leaking sensitive information (like e.g.=20
saying that username + password combination is invalid, instead of
telling which one is wrong, to avoid disclosing usernames).

--=20
Jakub Narebski
Poland
