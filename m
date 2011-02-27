From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1.8.0] add: make "add -u" update full tree without
 pathspec
Date: Sun, 27 Feb 2011 11:39:52 -0800
Message-ID: <7vy6512rnb.fsf@alter.siamese.dyndns.org>
References: <1297045643-26697-1-git-send-email-pclouds@gmail.com>
 <7vei6t4uwa.fsf@alter.siamese.dyndns.org>
 <AANLkTi=BwTHRWcUu26VLWAhFupmuJpu8fvOF98--HJ5f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Sebastian Pipping <webmaster@hartwork.org>,
	SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Jeff King <peff@peff.net>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 27 20:40:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PtmTa-00030x-L1
	for gcvg-git-2@lo.gmane.org; Sun, 27 Feb 2011 20:40:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751620Ab1B0TkL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 27 Feb 2011 14:40:11 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:55729 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751417Ab1B0TkK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 27 Feb 2011 14:40:10 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 574B9300B;
	Sun, 27 Feb 2011 14:41:26 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=aucagv6y7cIl
	t/yI3GwVmwuO9LQ=; b=CZRIzJ4ZRVq4YgIcoaB8MlzxVhK7w9/6iPh8vZBIhZDy
	PewNMoFV2ozycPL13yb4ynhaSuGdOk2hFqgOJkMWxZ198RFnBAnmNl4UjLCRYpjK
	D2/N2gVTkvT8ENLmUJku08qKFaCqfFn9456AT6to/IGzCeYTcY2MzYotUTOSPN4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=dF6Mh2
	jIaqVzomzMcEHuJmIKFg74BL8prfP+CkvzxcU+v+6T0lleOm6lAvfFzpn64JEehO
	siK2mAS/2sfl1XOqqvAueca+GX/5s7oNaCYwmv3RBQWEj3x1g0A9760UZGM1DKOp
	ASFmcXzYqKPy1s3o7h6Wvb5w+KoTxSdPxh+Ik=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id EA349300A;
	Sun, 27 Feb 2011 14:41:19 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 1C9BC3008; Sun, 27 Feb 2011
 14:41:11 -0500 (EST)
In-Reply-To: <AANLkTi=BwTHRWcUu26VLWAhFupmuJpu8fvOF98--HJ5f@mail.gmail.com>
 (Nguyen Thai Ngoc Duy's message of "Sun\, 27 Feb 2011 23\:52\:34 +0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 8CBCBD58-42A9-11E0-A7EB-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168051>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

> On Sun, Feb 27, 2011 at 5:46 PM, Junio C Hamano <gitster@pobox.com> w=
rote:
>> Perhaps in this order:
>>
>> Step 1, as soon as possible:
>>
>> =C2=A0* Introduce "add.make_update_global" configuration variable, a=
nd toggle
>> =C2=A0 the above variable when it is explicitly given; also record t=
he fact
>> =C2=A0 that you actually saw this variable in the config parser rega=
rdless of
>> =C2=A0 the value that is given;
>
> Ermm.. compat.make_update_global, with the intent that the config wil=
l
> be dropped in future (1.9.0 maybe)?

As you haven't yet proven that this "new feature" is even useful to hel=
p
new people nor existing users at this step, you cannot claim "we plan t=
o
drop this in the future", hence naming it "compat.*" is a no-go.  Durin=
g
this step, we can not even say "we plan to make this the default"; we
would confuse the users otherwise (it is fine to say "we might make thi=
s
the default some day").

Even if we indeed end up proceeding to step 2, I don't see a point in
planning to drop the support from the beginning.  We might end up doing
so, but we can decide when that becomes necessary, and that would be lo=
ng
after the tree-wide default proves a reasonable one, and preferably aft=
er
seeing a new person or two raise "what's the point of making 'add -u'
restricted to cwd?  we have too many options and this can go" on the li=
st.

Then we would start deprecating the config, giving a warning when peopl=
e
who still rely on their "add.make_update_global =3D false" say "add -u"
without pathspec in a few cycles, and then finally drop it at a version
bump boundary.

> There's a problem. I use git on many machines. Some will have this
> config enabled, some will not (yet). Perhaps a third option, which
> will print something when "git add -u" is issued as a reminder?

Such a warning would not help you on a machine that does not even have =
git
with Step 1 change.

What you conceive as a problem is just a reminder that any incompatible
change you plan to add will have pain involved.  On two machines, one w=
ith
a new feature and the other without the new feature, you would have to
work differently _or_ you would train yourself to use both versions in =
a
compatible way (e.g. when you mean tree-wide, you would cdup, and when =
you
mean cwd, you would explicitly say ".", from the command line).  That i=
s
not limited to this particular feature but any incompatible change, no?
