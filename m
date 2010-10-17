From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Stable ab/i18n branch
Date: Sat, 16 Oct 2010 21:44:12 -0700
Message-ID: <7vwrph4eeb.fsf@alter.siamese.dyndns.org>
References: <7v39s9fkk1.fsf@alter.siamese.dyndns.org>
 <AANLkTimr73DUBBwdj9MXOQQ=O-vmyyEZpgwdHmRsGG_-@mail.gmail.com>
 <20101014200027.GA18813@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	git@vger.kernel.org, Erik Faye-Lund <kusmabite@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 17 06:44:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P7L6n-0003ZF-Ly
	for gcvg-git-2@lo.gmane.org; Sun, 17 Oct 2010 06:44:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751303Ab0JQEoZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 17 Oct 2010 00:44:25 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:64294 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751154Ab0JQEoY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 17 Oct 2010 00:44:24 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 9D531DFC2F;
	Sun, 17 Oct 2010 00:44:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=AI8IKcqiOZJ10S0gZw29zfzjY
	8Y=; b=D80EtW0Uje7Cl+kDrA3omGtdtHUHM6Babw3RPWLVN4iCYT3j9zOk3rmEB
	/Y+O0uzEnG8rTr7Qwf/bomnXCl0fEffgX/FxqwmLNWQOunr9MJ7zNG/GZbILtDaK
	VtVxiz88x8Knn+FXAKZfCSHCdZRJ173vLYbM5+tY2iFFZw79yA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=qwWEkPTu0y+4JPCReGB
	4TXB+ih3udx95+kZESDBLfUs4FG4FHHLWOfXn9sKH1JIh5hB/kSBRTfYx8tMme93
	RGW6Gz1qvlsgh3UoseQUVGHCqKSYRLzXUcjjyx1L1IkEjhEACZW1NRar5eRXvBRO
	niLYE+WidqPlH+wlD+JwcudM=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 587ABDFC2D;
	Sun, 17 Oct 2010 00:44:19 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 53EF0DFC2B; Sun, 17 Oct
 2010 00:44:14 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 34351FE0-D9A9-11DF-B445-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159197>

Jonathan Nieder <jrnieder@gmail.com> writes:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>
>> Could you please pick up the 160 commit version of this at:
>>=20
>>     git://github.com/avar/git.git ab/i18n
>
> This is a "give an inch and they'll ask for a mile" sort of thing, bu=
t
> would it be possible to maintain a stable branch with the i18n
> infrastructure that only gets rebased when there is reorganization
> going on?

People might have noticed that I've refrained to take other topics that
may add new messages to 'next'.  I would wanted to merge ab/i18n early =
in
the cycle soon after dust has settled after 1.7.3 release.  And I still
do.

Having said that, there are different classes of risks associated with
i18n effort.

(1) Regressions that even hit a NO_I18N build.
(2) Regressions that hit LC_ALL=3DC execution in a !NO_I18N build.
(3) Regressions that hit plumbing run in a non-C locale.

 . i18n needs not just marking strings with _("string") but also needs =
to
   fix code that manually formulates messages by series of strcat().  I=
t
   may need to start using allocations on the heap, with potential risk=
 of
   usual bugs (leaks, use-after-free, etc.) and performance degradation=
=2E

 . Messages left unmarked with _("string"), or messages that are marked
   with _("string") that shouldn't have, won't be serious issues for th=
e
   first two classes.  The latter is a serious regression for the
   plumbing.

We are all human, and misconversion during this process is possible, ev=
en
though the above classes of regressions are unacceptable.  On the other
hand, as long as the above three classes of regressions are minimum and
quickly fixed/fixable, issues in non-C locale Porcelains are tolerable
during the initial cut.

I've looked at the patches in the series, and plan to take another look=
=2E
I'm sure others on the list have checked the series, some with fine com=
bs,
too, and hopefully =C3=86var has fixed any such regression that has bee=
n
reported and plans to do so for the ones discovered in the future.  As
long as we are sure that we have done a reasonable effort to eyeball th=
e
patches, the logical next step would be to merge the series to 'next' f=
or
further testing.

(4) Incomplete *.po file, and languages without *.po file.

Once we are sure that the series does not have the first two classes of
issues, we can ask everybody to mark new strings in their series, iow,
merge the i18n part to 'master'.  If we can do that sooner, it would be
better, and we do not need specific l10n part from the series during th=
at
stage. =20

A language that already has *.po file may lack necessary translation;
there may be languages that do not have *.po file.  They can be added w=
ith
a lot smaller risk later without unstabilizing the codebase.

So where are we now?  I think a constantly rebased 160-patch series tha=
t
has infrastructure bits and l10n bits mixed together is not very friend=
ly
to review for the first three classes of regressions (which are all I c=
are
about at this point) to help the series hit 'master' sooner.

In any case, the branch merged to 'pu' has been replaced with the tip o=
f
the said branch from =C3=86var's repository now.
