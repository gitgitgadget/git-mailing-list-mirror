From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] diff --follow: do call diffcore_std() as necessary
Date: Fri, 13 Aug 2010 15:46:39 -0700
Message-ID: <7vzkwqi10w.fsf@alter.siamese.dyndns.org>
References: <AANLkTikPhWgeeLBV3dbLZ5UM3UDmkOmpqrmwqPmGfn7Z@mail.gmail.com>
 <7vhbiyl8ji.fsf@alter.siamese.dyndns.org>
 <7vpqxmjphl.fsf@alter.siamese.dyndns.org>
 <7veie2jnww.fsf_-_@alter.siamese.dyndns.org>
 <AANLkTin-qPe-meW_kV5vtC0BT8QS-sZ90BrckRAbjk9X@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Bo Yang <struggleyb.nku@gmail.com>,
	Constantine Plotnikov <constantine.plotnikov@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 14 00:47:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ok31f-0004Fs-Gf
	for gcvg-git-2@lo.gmane.org; Sat, 14 Aug 2010 00:46:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755938Ab0HMWqy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 13 Aug 2010 18:46:54 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:58132 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755452Ab0HMWqy convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 13 Aug 2010 18:46:54 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id CDE06CD1E3;
	Fri, 13 Aug 2010 18:46:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=+hpX4KB0E5cJ
	grn4tWG/os9Ms2Y=; b=Zp1jef0QeHdBWxnqIbb0mqjAxeSaInN2V1SXTUKy4fqQ
	qmfSuSaUPagXcrdtz0zHL1/5DNQvn1azPO1cQPQOMZE4AZH1mCpi+ShcYRLP/oC2
	3dTk4PgmjJnZUH7sW8UbiEyiNQlG/05Oy1wObZuixpvRexdg4YSvLXBOyzwWbt0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=VH6RKI
	+BQ4cOSvdoR78/ZO5qwLEqqXxv7snQy2fAgc5ucITurNnVQsd5AGK3PTuns6SBqf
	3JaSLE3KHKTnTukWZFvkRqonPI85BFn1gW9/Mxq8GSi702+is0RwbTHcxl/OdDLw
	6RffRai5NOg70RrblU1ul/B4OeK6tfqQPDPkg=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 7B036CD1E1;
	Fri, 13 Aug 2010 18:46:48 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 699CFCD1E0; Fri, 13 Aug
 2010 18:46:41 -0400 (EDT)
In-Reply-To: <AANLkTin-qPe-meW_kV5vtC0BT8QS-sZ90BrckRAbjk9X@mail.gmail.com>
 (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Fri\, 13 Aug
 2010 21\:27\:38 +0000")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: A815464C-A72C-11DF-8B3B-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153523>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> On Fri, Aug 13, 2010 at 19:46, Junio C Hamano <gitster@pobox.com> wro=
te:
>
>> This hopefully fixes the breakage.
>
> Hopefully. It'd also be nice if we had a regression test for this, bu=
t
> I don't know how hard that would be to arrange. If it's hard to
> reproduce we might get away with a filter-branch + subdir filter from
> the idea repository.

As I wrote, the test added by 0cdca13 breaks with just a reversion of
1da6175 but with this patch it passes.  I didn't run any other test,
though ;-).
