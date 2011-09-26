From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: [PATCH/RFC 0/2] Teach receive-pack not to run update hook for
 corrupt/non existent ref
Date: Tue, 27 Sep 2011 05:14:02 +0530
Message-ID: <CAMK1S_gR6U=OxzGsjTD8LbvZFS125=p1fQ8Af7aRD2XSsRur_Q@mail.gmail.com>
References: <1316927182-14212-1-git-send-email-pangyanhan@gmail.com>
	<CAMK1S_hadzaqixaW3Fx81pf=hVsvAMpVvVGqVtZ8ncfUsie_9w@mail.gmail.com>
	<20110925094822.GA1702@myhost>
	<CAMK1S_h3ufrK29_ajpcSSW7HV6ZA8z8ZVHvhHr2bx5Cga5FAKQ@mail.gmail.com>
	<7vwrcuzy44.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Pang Yan Han <pangyanhan@gmail.com>, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>, Jeff King <peff@peff.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 27 01:44:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R8KqI-00012V-7d
	for gcvg-git-2@lo.gmane.org; Tue, 27 Sep 2011 01:44:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752718Ab1IZXoF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 26 Sep 2011 19:44:05 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:51432 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752682Ab1IZXoE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 26 Sep 2011 19:44:04 -0400
Received: by vws1 with SMTP id 1so6150461vws.19
        for <git@vger.kernel.org>; Mon, 26 Sep 2011 16:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=lMPnOHsJ7Z6cPeVthsR17WGf6K7ISedrw0NvBs6azJA=;
        b=MJbMS28otuNQwSc5AHVTZV9fibgkuHalgtQ+MOMuiUNcKsOh3f9RcNmICdWTXJiU4c
         MonpI9rNlPQnkNo4bMyKg3Pcb5/pfr9dkv1Mz/57riEtpfml6drIcBZgO2ZFrwR56a0/
         elW8SBnifjHCcltzT7nuzQzBa1JYjP6xzldOc=
Received: by 10.52.69.67 with SMTP id c3mr4197167vdu.469.1317080642981; Mon,
 26 Sep 2011 16:44:02 -0700 (PDT)
Received: by 10.52.160.161 with HTTP; Mon, 26 Sep 2011 16:44:02 -0700 (PDT)
In-Reply-To: <7vwrcuzy44.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182193>

On Tue, Sep 27, 2011 at 4:53 AM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Sitaram Chamarty <sitaramc@gmail.com> writes:
>
>> From a philosophical point of view, update and pre-receive *check*
>> things to make sure everything is OK. =C2=A0IMO they should be allow=
ed to
>> run even if the ref being deleted doesn't exist -- that could well b=
e
>> an error condition that the guy who owns the repo wants to trap and
>> alert himself to in some special way. =C2=A0I would *not* like them
>> disabled.
>
> I think this is a sane thing to do.
>
>> Post-{update,receive} are for *after* a successful push. =C2=A0My
>> suggestion would be to make sure the inputs supplied to those hooks
>> (via STDIN for post-receive, and as arguments in case of post-update=
)
>> reflect this -- only successfully updated refs are sent in as args.
>
> Perhaps sane.
>
>> This might mean that in the case of 'git push origin
>> :refs/heads/non-existent-ref' the post-receive hook would run but
>> STDIN would be empty, and post-update would run but have no argument=
s.
>
> Hmm?
>
> In that case (if "non-existent-ref" was indeed non-existent, and not =
just
> pointing at a dangling commit), I would say the post anything hook sh=
ould
> not be called for that ref. =C2=A0These hooks of course need to run i=
f there
> are _other_ refs that were updated, though, to handle these _other_ r=
efs,
> but I do not think they should be told about the no-op.

Question is what happens if none of them existed.  It's a difference
between not calling the hook at all, versus calling it with no
arguments/empty stdin (as the case may be) -- which would you do?  I
say the hook *should* always run, and the code inside the hook should
take care of the fact that no arguments/no input means nothing
actually happened.

--=20
Sitaram
