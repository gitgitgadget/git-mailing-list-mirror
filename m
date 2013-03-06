From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH] help: show manpage for aliased command on git <alias>
 --help
Date: Wed, 06 Mar 2013 14:10:01 +0100
Message-ID: <51374029.6080906@drmicha.warpmail.net>
References: <1362494681-11419-1-git-send-email-avarab@gmail.com> <20130305173831.GB9379@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	"H.Merijn Brand" <h.m.brand@xs4all.nl>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Mar 06 14:10:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UDE71-0007AS-7E
	for gcvg-git-2@plane.gmane.org; Wed, 06 Mar 2013 14:10:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754591Ab3CFNKA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 6 Mar 2013 08:10:00 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:53987 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752942Ab3CFNJ7 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 6 Mar 2013 08:09:59 -0500
Received: from compute6.internal (compute6.nyi.mail.srv.osa [10.202.2.46])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 129712093B;
	Wed,  6 Mar 2013 08:09:59 -0500 (EST)
Received: from frontend1.nyi.mail.srv.osa ([10.202.2.160])
  by compute6.internal (MEProxy); Wed, 06 Mar 2013 08:09:59 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=AQA+B52XtQodn1VDMZQedG
	hwx7U=; b=JFA0ZfbxsfR9jA6piqztnSBaCQKCApXeGmIwVOU5Kz8CHF2cvNoZiV
	Ui7w+KAZ5w3cILy5M+s2wKfCjLGQGh7vueyQ+2mRqkY4CeQukFheAAR/qTu2sdq4
	jKQnnZWKllfrvMaBf1tw8ddKndgSNre+Uwa6Xttg/aLlSnIopyfhw=
X-Sasl-enc: xDW2wE/s1U3v4YAbxEeLFOcfnkWWj+fDrI5f4QTOGWu8 1362575398
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 32251C80E8B;
	Wed,  6 Mar 2013 08:09:58 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130219 Thunderbird/17.0.3
In-Reply-To: <20130305173831.GB9379@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217524>

Jeff King venit, vidit, dixit 05.03.2013 18:38:
> On Tue, Mar 05, 2013 at 02:44:41PM +0000, =C3=86var Arnfj=C3=B6r=C3=B0=
 Bjarmason wrote:
>=20
>> Change the semantics of "git <alias> --help" to show the help for th=
e
>> command <alias> is aliased to, instead of just saying:
>>
>>     `git <alias>' is aliased to `<whatever>'
>>
>> E.g. if you have "checkout" aliased to "co" you won't get:
>>
>>     $ git co --help
>>     `git co' is aliased to `checkout'
>>
>> But will instead get the manpage for git-checkout. The behavior this
>> is replacing was originally added by Jeff King in 2156435. I'm
>> changing it because of this off-the-cuff comment on IRC:
>>
>>     14:27:43 <@Tux> git can be very unhelpful, literally:
>>     14:27:46 <@Tux> $ git co --help
>>     14:27:46 <@Tux> `git co' is aliased to `checkout'
>>     14:28:08 <@Tux> I know!, gimme the help for checkout, please
>>
>> And because I also think it makes more sense than showing you what t=
he
>> thing is aliased to.
>=20
> In this simple case, I think it is helpful to show the "checkout"
> manpage, because there is no other information to give (and by showin=
g
> the checkout manpage, you implicitly indicate that "co" maps to
> "checkout").

Well, even in the simple case one has to wonder: Why does the user
invoke help for "co"? There are two very likely cases:

A) User does not remember what "co" is aliased to.
B) User wants to see the man page.

If A is not the case then it's easy for the user to request help for
"checkout" (or "commit" or ...).

Removing the only easy way to look up the definition of an alias is a
major regression. And no, "git config --get alias.co" is not an easy wa=
y.

Removing that easy way would be OK only after introducing a "git alias"
command which works similar to shell's alias. You can even set it up as
an alias for git config, of course.

> But like others, I am concerned about the other cases, where there is=
 no
> manpage, it is not a git command with a manpage, or it is a git comma=
nd
> with options.  You are losing useful information that is currently gi=
ven
> to the user in all but the single-word case.
>=20
> In an ideal world, we could say "here is how the alias expands, and b=
y
> the way, here is the manpage for the expanded command". And obviously
> just omit the latter part when there is no such page. But we are rely=
ing
> on external programs to do the presentation and paging. Doing the
> C equivalent of:
>=20
>   echo "'git co' is aliased to 'checkout'" &&
>   man checkout
>=20
> does not quite work, because "man" will start a pager. We can run our
> own pager (which should suppress man's invocation), but that is a
> regression for anyone who uses MANPAGER.
>=20
> The user may also be using help.format to use something besides man. =
If
> help.format is set to "html", we will spawn a browser. In that case w=
e
> can still output the alias information, but it may or may not be seen
> (though come to think of it, that is probably already a problem for "=
git
> help <alias>" on Windows systems, or anybody invoking git help from a
> GUI porcelain).
>=20
> So I'd only be in favor of this patch if it managed to avoid informat=
ion
> loss in the more complicated cases. And I'm not sure how best to do
> that. The "only trigger for a single-word alias" suggestion seems lik=
e
> the least ugly to me.
>=20
> -Peff
>=20
