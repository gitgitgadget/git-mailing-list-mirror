From: konglu@minatec.inpg.fr
Subject: Re: [PATCH] Warnings before rebasing -i published history
Date: Fri, 08 Jun 2012 09:32:57 +0200
Message-ID: <20120608093257.Horde.eeddeHwdC4BP0aqpIrqTaVA@webmail.minatec.grenoble-inp.fr>
References: <1339104053-7782-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
 <7vwr3ieo0i.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	DelSp=Yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Lucien Kong <Lucien.Kong@ensimag.imag.fr>, git@vger.kernel.org,
	Valentin Duperray <Valentin.Duperray@ensimag.imag.fr>,
	Franck Jonas <Franck.Jonas@ensimag.imag.fr>,
	Thomas Nguy <Thomas.Nguy@ensimag.imag.fr>,
	Huynh Khoi Nguyen Nguyen 
	<Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 08 09:33:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sctgx-00030w-N4
	for gcvg-git-2@plane.gmane.org; Fri, 08 Jun 2012 09:33:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757886Ab2FHHdB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 8 Jun 2012 03:33:01 -0400
Received: from v-smtp.minatec.grenoble-inp.fr ([147.173.216.28]:36191 "EHLO
	v-smtp.minatec.grenoble-inp.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751741Ab2FHHdA (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 8 Jun 2012 03:33:00 -0400
Received: from localhost (www02.minatec.grenoble-inp.fr [147.173.216.15])
	by v-smtp.minatec.grenoble-inp.fr (Postfix) with ESMTP id 64A061A02F4;
	Fri,  8 Jun 2012 09:32:57 +0200 (CEST)
Received: from wifi-028016.grenet.fr (wifi-028016.grenet.fr [130.190.28.16])
 by webmail.minatec.grenoble-inp.fr (Horde Framework) with HTTP; Fri, 08 Jun
 2012 09:32:57 +0200
In-Reply-To: <7vwr3ieo0i.fsf@alter.siamese.dyndns.org>
User-Agent: Internet Messaging Program (IMP) H4 (5.0.17)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199466>


Junio C Hamano <gitster@pobox.com> a =E9crit=A0:

>> +	do
>> +		test -n "$sha1" || break
>> +		if test -n "$(git branch -r --contains "$sha1")"
>> +		then
>> +			printf "%s\n" "$(sed -e "/"$sha1"/ s|$| [Published]|" "$1")" >"$=
1"
>> +		fi
>> +	done
>
> What's inside $() looks like it wants to say something like
>
> 	sed -e "/ $sha1 /s/$/ [Published]/" "$1"
>
> but it has a few fishy double-quotes that makes it unclear why $sha1
> wants to be outside the quotes.
>
> Why does it need 'printf "%s" $()' in the first place?  Wouldn't
>
> 	sed ... >"$1"
> sufficient?

The fact is that the input of sed is "$1" itself. An redirecting the ou=
tput
of sed to the same input doesn't seem to work.

> The logic is merely _guessing_ that the commit could have been
> published, no?  The particular remote repository the test happens to
> find may not be for consumption by other people.
>
> I am afraid that doing this would send users a wrong message that is
> unnecessarily alarming, especially the marker says "Published" as if
> it were a confirmed fact.

True. It would be annoying for people that rewrite consciously publishe=
d
history. From this point of view, a better idea would be to show the
remote branch name, as Matthieu suggested, so that the user could know
which branch is involved.
