From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] gitweb: Add a feature for adding more branch refs
Date: Wed, 04 Dec 2013 09:57:31 -0800
Message-ID: <xmqqli00lcs4.fsf@gitster.dls.corp.google.com>
References: <1386082603-8404-1-git-send-email-krzesimir@endocode.com>
	<1386082603-8404-3-git-send-email-krzesimir@endocode.com>
	<xmqqr49tn11c.fsf@gitster.dls.corp.google.com>
	<CANQwDwcpkbbfND9MmB9wGcL7mrhV_Mxb1amvGPgWeR344_fcfw@mail.gmail.com>
	<1386161398.2173.9.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>,
	git <git@vger.kernel.org>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Krzesimir Nowak <krzesimir@endocode.com>
X-From: git-owner@vger.kernel.org Wed Dec 04 18:57:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VoGhg-0007Q8-Lr
	for gcvg-git-2@plane.gmane.org; Wed, 04 Dec 2013 18:57:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932559Ab3LDR5g convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 4 Dec 2013 12:57:36 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42486 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755872Ab3LDR5f convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 4 Dec 2013 12:57:35 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EAE0956F93;
	Wed,  4 Dec 2013 12:57:34 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=UhJXKtIWBV6L
	lOSunX0xADyQwCU=; b=F47wyV4ok8LkzX7Phfqa+bm1aSuA6eUoDNG7CCMgrPsm
	TWlzHGG4tX9o6TgTcf5Tnx8x2nkvociy2JnfMh4ENyyFmsLSryxMNILVcV4pu9WU
	mxltAD/B2o5rva8iWHVXZMFX7IsTZH1rDlKgFcBUc7lQVJUrpiXG7DPzXpgc6p4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=WvDXxi
	n5XnP8+DIs2teKVe9ZKzWJGukqa9G0jbmtevICIRez45MdyCLeZeGOy1MLIDSC1Q
	SSuG9xqFXljCcrEXGaOxXNpnawT1k83cOxvZ3dt8SsiDkweahhCNDDb22ghEL2af
	Sy5F331AxWcZWGZuYK3mYe5sApV4kbhj8kmes=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DA3A656F8F;
	Wed,  4 Dec 2013 12:57:34 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 12F2456F8E;
	Wed,  4 Dec 2013 12:57:33 -0500 (EST)
In-Reply-To: <1386161398.2173.9.camel@localhost.localdomain> (Krzesimir
	Nowak's message of "Wed, 04 Dec 2013 13:49:58 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 8D7B4C60-5D0D-11E3-91E4-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238796>

Krzesimir Nowak <krzesimir@endocode.com> writes:

> On Tue, 2013-12-03 at 21:38 +0100, Jakub Nar=C4=99bski wrote:
>> On Tue, Dec 3, 2013 at 9:15 PM, Junio C Hamano <gitster@pobox.com> w=
rote:
>> > Krzesimir Nowak <krzesimir@endocode.com> writes:
>> >
>> >> @@ -626,6 +640,17 @@ sub feature_avatar {
>> >>       return @val ? @val : @_;
>> >>  }
>> >>
>> >> +sub feature_extra_branch_refs {
>> >> +     my (@branch_refs) =3D @_;
>> >> +     my $values =3D git_get_project_config('extra_branch_refs');
>> >
>> > Hmph.  Three points.
>> >
>> > * Almost all callers of this function use
>> >
>> >     my ($val) =3D git_get_project_config(...);
>> >     my @val =3D git_get_project_config(...);
>> >
>> >   to expect that the function returns a list of things (and grab t=
he
>> >   first one among them, not the length of the list).  Shouldn't th=
is
>> >   part do the same?
>>=20
>> Right. feature_snapshot() has here
>>=20
>>     my (@fmts) =3D @_;
>>     my ($val) =3D git_get_project_config('snapshot');
>>=20
>> ...though git_get_project_config returns scalar.
>
> So what's the point of it? 'my @val =3D git_get_project_config ()' ju=
st
> creates an array with one element.

The point is that "my ($val) =3D git_get_project_config('name')" calls
the sub in the list context like everybody else, which would be more
robust, if you want to be prepared for somebody else's change to the
implementation in the future, I think.

>> > * Wouldn't this be a good candidate for a multi-valued configurati=
on
>> >   variable, e.g. shouldn't this
>> >
>> >         [gitweb]
>> >                 extraBranchRefs =3D wip
>> >                 extraBranchRefs =3D sandbox other
>> >
>> >   be parsed as a three-item list, qw(wip sandbox other)?
>>=20
>> This would require changes in git_get_project_config(), which would
>> need to be able to deal with multi-valued result (it caches these
>> results, so we pay only one cost of `git config` call).
>
> Hm, actually not at all. Now, if I have a setup like Junio wrote the
> git_get_project_config just returns an array ref. So modifying the
> feature_extra_branch_refs to handle the returned value as either simp=
le
> scalar or array reference should be enough.

Yes, changing the calling site to use of config_to_multi() around
(see the handling of 'ctag' for an example) and then concatenate the
result of splitting each returned element would be one way to do
this.

Jakub may have had in mind to teach git_get_project_config() to
return a list; because existing callers call the sub in the list
context, they will not get surprising result---even though they may
only use the first one and discard the rest.

Which might not be a bad thing in the longer term, but I think it is
outside the scope of this particular topic, but in order to prepare
for that kind of internal API enhancement, it would still help to
make sure that this new caller calls the sub in the list context
like others.
