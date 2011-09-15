From: Ted Zlatanov <tzz@lifelogs.com>
Subject: Re: git credential helper design [
Date: Thu, 15 Sep 2011 05:47:22 -0500
Organization: =?utf-8?B?0KLQtdC+0LTQvtGAINCX0LvQsNGC0LDQvdC+0LI=?= @
 Cienfuegos
Message-ID: <87vcsuaxqd.fsf@lifelogs.com>
References: <7vk4a2mjx6.fsf@alter.siamese.dyndns.org>
	<20110825202057.GB6165@sigill.intra.peff.net>
	<7vhb55i11i.fsf@alter.siamese.dyndns.org>
	<20110831023801.GB3340@sigill.intra.peff.net>
	<CAEBDL5XnoCtiKQB8jRxvueWc9zy-yzC+MxgTLmP1amY+U=7aOw@mail.gmail.com>
	<20110910065332.GA10935@sigill.intra.peff.net>
	<CAEBDL5UGhanJboiT2SppeXa6UaKbE1MOpajf9wSaQCkR9EdRYw@mail.gmail.com>
Reply-To: git@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 15 12:47:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R49Tw-0002q5-Bo
	for gcvg-git-2@lo.gmane.org; Thu, 15 Sep 2011 12:47:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932827Ab1IOKrm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 15 Sep 2011 06:47:42 -0400
Received: from lo.gmane.org ([80.91.229.12]:32821 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932575Ab1IOKrl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Sep 2011 06:47:41 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1R49Tn-0002mJ-0v
	for git@vger.kernel.org; Thu, 15 Sep 2011 12:47:39 +0200
Received: from 38.98.147.133 ([38.98.147.133])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 15 Sep 2011 12:47:39 +0200
Received: from tzz by 38.98.147.133 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 15 Sep 2011 12:47:39 +0200
X-Injected-Via-Gmane: http://gmane.org/
Mail-Followup-To: git@vger.kernel.org
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: 38.98.147.133
X-Face: bd.DQ~'29fIs`T_%O%C\g%6jW)yi[zuz6;d4V0`@y-~$#3P_Ng{@m+e4o<4P'#(_GJQ%TT= D}[Ep*b!\e,fBZ'j_+#"Ps?s2!4H2-Y"sx"
Mail-Copies-To: never
User-Agent: Gnus/5.110018 (No Gnus v0.18) Emacs/24.0.50 (gnu/linux)
Cancel-Lock: sha1:Rzz7ZZXAfQMu4s+l02TLFfC+9Rk=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181456>

On Tue, 13 Sep 2011 04:29:30 -0400 John Szakmeister <john@szakmeister.n=
et> wrote:=20

JS> On Sat, Sep 10, 2011 at 2:53 AM, Jeff King <peff@peff.net> wrote:
>> On Fri, Sep 09, 2011 at 05:55:38AM -0400, John Szakmeister wrote:
>>=20
>>> A little feedback here: I do look into my keychain on Mac OS X. =A0=
I
>>> tend to keep most of my credentials in a separate keychain that get=
s
>>> whenever my computer sleeps or the screen saver kicks on. =A0So tha=
t
>>> blob ends up being user-visible to some degree. =A0Could I munge it=
 into
>>> something else? =A0Sure. =A0But I do wonder if it might be better t=
o make
>>> it something closer to what the user expects to see.
>>=20
>> Sure, I agree. I guess my question is: what does the user expect to =
see?

JS> Originally I was going to use SecKeychainFindGenericPassword(), and
JS> the token would have been the "serviceName".  However,
JS> SecKeychainFindInternetPassword() is clearly the better fit, which
JS> means busting out the individual bits.

I would make it work like Safari, period.

JS> [snip]
>> Perhaps it's worth providing the information in two forms: parsed an=
d
>> broken out by individual pieces, and as a more opaque blob. Then sys=
tems
>> which care can use the pieces, and systems which are trying to be as
>> simple as possible can use the blob.

JS> That would be useful.  Right now, it looks like I'll be parsing the=
 token.

>> That still leaves the question of how the user specifies policy abou=
t
>> which parts of the blob are relevant. That is, how do they say that =
only
>> the "domain" portion of the hostname is relevant? Or that the path i=
s or
>> is not relevant?
>>=20
>> I was really hoping for the user to be able to specify this at the g=
it
>> level, to give each storage helper roughly the same feature set.

JS> Ooh... yeah, I'm not sure. :-(

I posted a simple proposal for auth domains, which would introduce an
extra abstraction layer between the URL and the credential helper.  I
think that would help.

>> Maybe it would be enough to do something like:
>>=20
>> =A01. Assemble all of the parts (protocol, username (if any), hostna=
me,
>> =A0 =A0 path) into a canonicalized URL representing the authenticati=
on
>> =A0 =A0 context.
>>=20
>> =A02. Look for git config matching the context URL, and allow
>> =A0 =A0 transformations (e.g., match and replace the whole thing, or=
 even
>> =A0 =A0 regexp-style substitution).

JS> That seems burdensome.  There is a method in HTTP/HTTPS for saying
JS> "use this set of credentials".  You'd do that via the security doma=
in.
JS>  That doesn't necessarily apply to other urls (ssh, for example), b=
ut
JS> it would allow a storage backend to cache it for a specific path, b=
ut
JS> fallback to looking up the credential using the security domain.

The HTTP security domain is set by the remote, not the Git user, and so
is neither customizable nor reliable, unfortunately.  Also as you
mentioned it won't work for non-HTTP URLs, and it is determined late in
the process, perhaps too late for some helpers.

Ted
