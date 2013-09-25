From: Peter Oberndorfer <kumbayo84@arcor.de>
Subject: Re: Searching explanation of different diff algorithms
Date: Wed, 25 Sep 2013 17:30:45 +0200
Message-ID: <524301A5.2060401@arcor.de>
References: <201309250924.15741.thomas@koch.ro> <20130925085557.GA11402@domone.kolej.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thomas Koch <thomas@koch.ro>, git@vger.kernel.org
To: =?UTF-8?B?T25kxZllaiBCw61sa2E=?= <neleai@seznam.cz>
X-From: git-owner@vger.kernel.org Wed Sep 25 17:30:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VOr3E-00078t-Hb
	for gcvg-git-2@plane.gmane.org; Wed, 25 Sep 2013 17:30:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754531Ab3IYPat convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 25 Sep 2013 11:30:49 -0400
Received: from mail-in-09.arcor-online.net ([151.189.21.49]:42161 "EHLO
	mail-in-09.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753914Ab3IYPas (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 25 Sep 2013 11:30:48 -0400
Received: from mail-in-12-z2.arcor-online.net (mail-in-12-z2.arcor-online.net [151.189.8.29])
	by mx.arcor.de (Postfix) with ESMTP id B79E0197670;
	Wed, 25 Sep 2013 17:30:46 +0200 (CEST)
Received: from mail-in-01.arcor-online.net (mail-in-01.arcor-online.net [151.189.21.41])
	by mail-in-12-z2.arcor-online.net (Postfix) with ESMTP id AE3402E61C8;
	Wed, 25 Sep 2013 17:30:46 +0200 (CEST)
Received: from [10.0.0.4] (91-113-3-116.adsl.highway.telekom.at [91.113.3.116])
	(Authenticated sender: kumbayo84@arcor.de)
	by mail-in-01.arcor-online.net (Postfix) with ESMTPA id 5AE565A3D2;
	Wed, 25 Sep 2013 17:30:46 +0200 (CEST)
X-DKIM: Sendmail DKIM Filter v2.8.2 mail-in-01.arcor-online.net 5AE565A3D2
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arcor.de; s=mail-in;
	t=1380123046; bh=WS7H7AgfEZE01FZdYbGx2m5CIC1e+25QOjV1aQGJaeE=;
	h=Message-ID:Date:From:MIME-Version:To:CC:Subject:References:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	b=SNE7hPz7ZFiKP6UXGIjVGD2l9A5aQk7rS1r5WK8t7+PLp3DrQlfr4DcYzICgylndl
	 FKC87HJIAzLlq94st6WD/ReC58rOqYicza6RiIF3LGeNbB4wGW9WLbCaI30diWNKhl
	 zGxZkjvOvGKeeHg1Ecsrly7WVh3M6oxd/mygDBsQ=
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:17.0) Gecko/20130803 Thunderbird/17.0.8
In-Reply-To: <20130925085557.GA11402@domone.kolej.mff.cuni.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235356>

On 2013-09-25 10:55, Ond=C5=99ej B=C3=ADlka wrote:
> On Wed, Sep 25, 2013 at 09:24:15AM +0200, Thomas Koch wrote:
>> Is there any explanation available of the different merrits and draw=
backs of=20
>> the diff algorithms that Git supports?
>>
>> I'm not satisfied with the default diff but have enough processing p=
ower for a=20
>> slower algorithm that might produce diffs that better show the inten=
tion of the=20
>> edit.
>>
> It is not just question of algorithm, even definition how should most
> readable diff look like is problematic, for example when large block =
is
> rewritten and one line is unchanged then you get diff like
>=20
> if (x){
> - foo
> + bar
> } else {
> - foo
> + bar
> }
>=20
> but it is better to create following diff as it does not break flow o=
f code.
>=20
> if (x) {
> - foo
> -} else {
> - foo
> + bar
> +} else {
> + bar
> }

I already asked the list for such a feature in the past[1].
I might be able to provide a rough/unfinished hack
that does exactly this in a few days after cleaning it up a bit.

It works like this:
If 2 hunks are separated by less than a certain count of lines and
those lines are identified as containing no "interesting information"
like {, }, /*, */, <whitespace> then the 2 hunks are fused together.

The hack is mainly lacking the following things:
* A way to identify boring lines.
(a like a list of boring keywords?, per filetype?)
* Configuration/commandline options to turn it on/off
* Tests
* Cleanup the code

Greetings Peter

[1] http://article.gmane.org/gmane.comp.version-control.git/207239/
