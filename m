From: Ben Bennett <benbennett@gmail.com>
Subject: Re: clone from url with email address as username?(escaping @ symbol)
Date: Tue, 29 Sep 2009 12:51:41 -0500
Message-ID: <970bc7c80909291051q5dff9209u650cee4f84d92fae@mail.gmail.com>
References: <970bc7c80909290720i1c5566fer1c1a3db744edc609@mail.gmail.com>
	 <fabb9a1e0909290725w616c3ea9vcb1d2c53950f7788@mail.gmail.com>
	 <vpq1vlp962h.fsf@bauges.imag.fr>
	 <fabb9a1e0909290732h5119170ew133d906b67e49f99@mail.gmail.com>
	 <970bc7c80909290831l59b7fc4at4ec0082f42f3ef87@mail.gmail.com>
	 <vpq63b1u1p6.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Sverre Rabbelier <srabbelier@gmail.com>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Sep 29 19:51:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Msgrc-0006ug-11
	for gcvg-git-2@lo.gmane.org; Tue, 29 Sep 2009 19:51:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752903AbZI2Rvi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 29 Sep 2009 13:51:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752398AbZI2Rvi
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Sep 2009 13:51:38 -0400
Received: from mail-px0-f194.google.com ([209.85.216.194]:64265 "EHLO
	mail-px0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751609AbZI2Rvh convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 29 Sep 2009 13:51:37 -0400
Received: by pxi32 with SMTP id 32so4578029pxi.4
        for <git@vger.kernel.org>; Tue, 29 Sep 2009 10:51:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=lQYzJnLQ/Gnp3DlybbfTwaovdhfOZ0aoeat1ZuDtkwA=;
        b=JgqFGh1449vjOJlCxUgmiesM3xd/ssChV3XndaYjKdT73kHAVQEz3e6qbxAIvWkZA5
         u7BrwB9RKqY5sV316kMMoU44UrfLbFTWcfk/s+Mly2KWOIQB9S+kLuvclfmfDXs8RC3C
         8mbViEQcqepVNMEYGqwNj61C8BwwsUkjK+eME=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=AToyFjHo4bD+0FEJscSCFfJAMToL8pAkTZvPwRj6BAF8O0XAHpwcxxwRll1rSwTY3j
         tzdvf7HEA1FSRLqE0ZJrttFFxbm9AnPPn6dGQ1WMUav5+CYYaA6QBpak0EfK2CfDGrih
         1m758rgSYDc9ZrtUcHbHhK510EXsPhOdR/YkU=
Received: by 10.140.188.19 with SMTP id l19mr50863rvf.251.1254246701336; Tue, 
	29 Sep 2009 10:51:41 -0700 (PDT)
In-Reply-To: <vpq63b1u1p6.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129317>

Is it escaping the %40 when passed down? I am getting an error 401  ,
and checking the server logs , it is passing the %40 to the server in
the username.
Running curl from command line , I can connect, but through git , the
username is getting mangled or I have something screwed up.
 I will look at http.c tonight after work, to see if I am messing somet=
hing up.

Thanks,
Ben


On Tue, Sep 29, 2009 at 11:59 AM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Ben Bennett <benbennett@gmail.com> writes:
>
>> I am attempting to do a https clone. The username is an email addres=
s
>> but when I do a clone here is what happens.
>
> Hmm, right, it works with ssh, but not http.
>
> I tried a quick fix like this:
>
> diff --git a/http.c b/http.c
> index 23b2a19..361a6be 100644
> --- a/http.c
> +++ b/http.c
> @@ -281,9 +281,10 @@ static void http_auth_init(const char *url)
> =A0 =A0 =A0 =A0 * "proto://<host>/..."?
> =A0 =A0 =A0 =A0 */
> =A0 =A0 =A0 =A0cp +=3D 3;
> - =A0 =A0 =A0 at =3D strchr(cp, '@');
> =A0 =A0 =A0 =A0colon =3D strchr(cp, ':');
> =A0 =A0 =A0 =A0slash =3D strchrnul(cp, '/');
> + =A0 =A0 =A0 for(at =3D slash-1; *at !=3D '@' && *at !=3D '/'; at--)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 continue;
> =A0 =A0 =A0 =A0if (!at || slash <=3D at)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return; /* No credentials */
> =A0 =A0 =A0 =A0if (!colon || at <=3D colon) {
>
> Unfortunately, it seems the complete URL is passed to curl, and curl
> is the one doing it wrong. Indeed:
>
> $ curl -v https://user@email.com@server.com/path/
> * getaddrinfo(3) failed for email.com@server.com:443
> * Couldn't resolve host 'email.com@server.com'
> * Closing connection #0
> curl: (6) Couldn't resolve host 'email.com@server.com'
>
> Now for the good news:
>
> http://curl.haxx.se/mail/lib-2006-02/0134.html
> http://sourceforge.net/tracker/index.php?func=3Ddetail&aid=3D2826621&=
group_id=3D976&atid=3D100976
>
> In short, you have to use %40 to escape the @, and curl does it this
> way because the RFC doesn't allow @ in usernames.
>
> --
> Matthieu Moy
> http://www-verimag.imag.fr/~moy/
>
