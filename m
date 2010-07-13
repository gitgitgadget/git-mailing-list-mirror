From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG] 'diff A...B' fails with multiple merge bases
Date: Mon, 12 Jul 2010 17:45:14 -0700
Message-ID: <7vy6dg5hwl.fsf@alter.siamese.dyndns.org>
References: <3BA20DF9B35F384F8B7395B001EC3FB36CF674AE@azsmsx507.amr.corp.intel.com>
 <7vaapw8ehn.fsf@alter.siamese.dyndns.org>
 <7vocec6xlt.fsf@alter.siamese.dyndns.org>
 <7viq4k6xea.fsf@alter.siamese.dyndns.org>
 <AANLkTinfo1QDguIbNgOt9w9V9xuJbhrCmusfe9g8fosm@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	"Pickens\, James E" <james.e.pickens@intel.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 13 02:45:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OYTcn-0002u5-Kp
	for gcvg-git-2@lo.gmane.org; Tue, 13 Jul 2010 02:45:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753673Ab0GMApZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 12 Jul 2010 20:45:25 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:38137 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752421Ab0GMApY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 12 Jul 2010 20:45:24 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 454B3C4C1D;
	Mon, 12 Jul 2010 20:45:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=NXDheoeTgsE9
	vaiohdblq4RGh1c=; b=dpAyPFVzgrs7D/Aj6kZgBf5NqRTSirsA3S9mIvrEg2D1
	vgpdplAij+BxUV3+IHaA0X7XGvo2FdbW6et28584xvq1GvUZ88BJ79MlbsUJLq71
	fZnkIlNCBlRLHjNFYRbk9gvxB4rZ4a5o/hPDgAmJEadwlqV79ZsJ0rzU5BwUzFg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=DKIwAz
	SNRpC0jajxDlWtOD4DB9A0ZwolqKtG0Q+twpYCHO26yd0dHzWuO3LCzyfiGpnIp9
	UZneJ0R7StrM24gFTQaTnPprCQoBAFUJzmRbVCZQrJqbJiIgLdRQjOXSMPaGs2Gs
	/ViKBs6f4cWp30I4P10Tgnnl2WoMAFig4DAwk=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 1217BC4C1B;
	Mon, 12 Jul 2010 20:45:21 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3CBF9C4C1A; Mon, 12 Jul
 2010 20:45:16 -0400 (EDT)
In-Reply-To: <AANLkTinfo1QDguIbNgOt9w9V9xuJbhrCmusfe9g8fosm@mail.gmail.com>
 (Sverre Rabbelier's message of "Mon\, 12 Jul 2010 19\:41\:45 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: EA48E3E4-8E17-11DF-8B57-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150861>

Sverre Rabbelier <srabbelier@gmail.com> writes:

> Heya,
>
> On Mon, Jul 12, 2010 at 19:25, Junio C Hamano <gitster@pobox.com> wro=
te:
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ents !=3D i +=
 2 ||
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (en=
t[i+1].item->flags & UNINTERESTING) ||
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (!e=
nt[i].item->flags & SYMMETRIC_LEFT) ||
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (en=
t[i+1].item->flags & SYMMETRIC_LEFT))
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 die("what do you mean by that?");
>
> That's about as helpful an error message as "Your parents must hate
> you" or whatever it is. Can we rephrase it to tell the user what they
> did wrong, and how to fix it?

This will trigger only when you did something random like this.

    $ git diff ^maint master ^next ^pu sr/frotz..

What else would you say against such an input?
