From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC 2/2] receive-pack: hint that the user can stop "git push" at auto gc time
Date: Tue, 04 Feb 2014 10:25:31 -0800
Message-ID: <xmqqha8eag6c.fsf@gitster.dls.corp.google.com>
References: <CACsJy8B0WKfxSYBSgRZQYz6_h+S9pGd03A=rrWM0_twRdKvyZw@mail.gmail.com>
	<1391496765-29564-1-git-send-email-pclouds@gmail.com>
	<1391496765-29564-2-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, jugg@hotmail.com
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 04 19:26:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WAkhi-0001MV-5Q
	for gcvg-git-2@plane.gmane.org; Tue, 04 Feb 2014 19:26:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754652AbaBDS0e convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 4 Feb 2014 13:26:34 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45064 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751056AbaBDS0d convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 4 Feb 2014 13:26:33 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5A85368075;
	Tue,  4 Feb 2014 13:26:27 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=/xFHq2Sm4Bvx
	L/YTjBWzlfh+vyU=; b=ZaEufdzF7RbkxG2bXV6sAvc6KWV/Bki3Ly2cPBR/+Whh
	Akpij0qI11jtB8wT9p0OuNo19G3Y8NWmQRmyAhdsTU/qcYZPSPWQ2AQN3XzKI8rB
	l9UrDokNL7WiHJJ+Cw7HYd1V6Kic78Epny649BPErKaBYyjqidpdi801NuEpnSU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=pwMms5
	H7MMQspdUXz/x9K2d7x0KqeJuhYL6C2MG5N6pRMVeXDcrfyWMc8dUBd4bYVx2FKo
	u/PfA/BOlkCR6aOSqXGJ+IVnd2BZaA9Xd4f5xpG77UlAXFNWiXA0i8AHDgx9AT8+
	OoDbXPzKSkkNvF3cEM27VVuFmoEHCeibbVi6Y=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4582A68074;
	Tue,  4 Feb 2014 13:26:27 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 49A4E67FD0;
	Tue,  4 Feb 2014 13:25:35 -0500 (EST)
In-Reply-To: <1391496765-29564-2-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Tue, 4 Feb
 2014 13:52:45 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: BD2E3B88-8DC9-11E3-8C8B-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241534>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> Housekeeping jobs like auto gc generally should not get in the way.
> Users who are pushing may not want to wait until auto gc is done on
> the server. Give a hint for those users that it's safe now to break
> "git push" and stop waiting.
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  This bandage patch may be a good compromise between running auto gc
>  and not annoying users much.
> =20
>  If I'm not mistaken, when ^C on "git push" this way, gc will still b=
e
>  running until it needs to print something out (which it should not
>  normally because of --quiet). The user won't see gc errors, but the
>  user generally can't do much anyway.

If you are over local transport, I would think you would kill the
both ends.  Also, wouldn't killing "git push" before it is done
talking with the receive-pack stop it before it has a chance to
update the remote tracking refs to pretend as if it fetched from
there immediately after a push?

So, no. I do not think we should ever encourage "if this bothers
you, you can ^C it".  Making it not to bother is fine, though.
