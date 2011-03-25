From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH (BUGFIX)] gitweb: Fix handling of fractional timezones in
 parse_date
Date: Fri, 25 Mar 2011 10:15:16 -0700
Message-ID: <7v8vw36s0r.fsf@alter.siamese.dyndns.org>
References: <dab08d0ff27b0f571a17ed4f1ab0f39b@localhost>
 <1300925335-3212-2-git-send-email-warthog9@eaglescrag.net>
 <201103241617.37400.jnareb@gmail.com> <201103251620.28811.jnareb@gmail.com>
 <AANLkTik5bLaR_0uhqGrNWW6U7z82KfmpNTyvRwkKFfj+@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jakub Narebski <jnareb@gmail.com>,
	"John 'Warthog9' Hawley" <warthog9@eaglescrag.net>,
	git@vger.kernel.org
To: Kevin Cernekee <cernekee@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 25 18:15:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q3Ac3-0004vb-Nc
	for gcvg-git-2@lo.gmane.org; Fri, 25 Mar 2011 18:15:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754880Ab1CYRPf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 25 Mar 2011 13:15:35 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:64659 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753703Ab1CYRPb convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 25 Mar 2011 13:15:31 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id E0337438A;
	Fri, 25 Mar 2011 13:17:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=zWvdqGIK4fdF
	O+CEgzL4kKr9zhg=; b=EqYScl4TV8JE575o3kR/CuhSFXRKUIGq4jtwgEj1ybx8
	GIbUzdNmzDPNPscm6Q1emreB7jdjY+Oi0olPCz3t3R/AmSzu2TY3loB3dGutzyUj
	JOT28ufXjj3MDTvRu91XSAgYcKZP3mFOS5bu3NwtKwLbJ9IuGAdd1xt2JLK5xq0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=WNfGQ6
	R6hjklxeM+/Pa38H3o297O9DJKxmGeaJ8I4ldvMe/hUPaK4vRPvmVyaMxQNzRNE5
	m75+o26KbdS6MquIA450uDsnXw+caf8jq+rNBzy8rPV66hseuSzL0gUOMkShwT10
	GGvXXigMeUX+1vgR0X6w/EQIjOca2eMniwOIs=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id A01AB4387;
	Fri, 25 Mar 2011 13:17:05 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 2770E4385; Fri, 25 Mar 2011
 13:16:59 -0400 (EDT)
In-Reply-To: <AANLkTik5bLaR_0uhqGrNWW6U7z82KfmpNTyvRwkKFfj+@mail.gmail.com>
 (Kevin Cernekee's message of "Fri, 25 Mar 2011 09:26:22 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B515B3CC-5703-11E0-B932-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169999>

Kevin Cernekee <cernekee@gmail.com> writes:

> It's just a matter of personal preference, but I would find this
> regexp slightly easier to read:
>
> +               ($tz =3D~ m/^([+\-])([0-9]{2})([0-9]{2})$/);

I'd say "^([-+])(\d\d)(\d\d)$" makes it the most clear.

>> + =C2=A0 =C2=A0 =C2=A0 $tz_sign =3D ($tz_sign eq '-' ? -1 : +1);
>> + =C2=A0 =C2=A0 =C2=A0 my $local =3D $epoch + $tz_sign*($tz_hour + (=
$tz_min/60.0))*3600;
>
> If you wanted to avoid floats, you could do something like:
>
> +       my $local =3D $epoch + $tz_sign * ($tz_hour * 3600 + $tz_min =
* 60);

That is not just float-avoidance, but is much more logical.

	(($h * 60) + $m) * 60

may be even more logical and more readable, though.

Care to re-roll the patch?
