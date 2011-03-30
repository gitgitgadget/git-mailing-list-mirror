From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH] Fix potential local deadlock during fetch-pack
Date: Wed, 30 Mar 2011 11:42:12 +0200
Message-ID: <AANLkTikCRRftjExdhMgFGFMy-Dc1UCMdW1nTYV2bK1-T@mail.gmail.com>
References: <7vtyelsvp0.fsf@alter.siamese.dyndns.org>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>,
	msysGit <msysgit@googlegroups.com>, Johannes Sixt <j6t@kdbg.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 30 11:42:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q4rvE-0004i8-BT
	for gcvg-git-2@lo.gmane.org; Wed, 30 Mar 2011 11:42:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755698Ab1C3Jmf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 30 Mar 2011 05:42:35 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:54588 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755681Ab1C3Jme convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 30 Mar 2011 05:42:34 -0400
Received: by fxm17 with SMTP id 17so891089fxm.19
        for <git@vger.kernel.org>; Wed, 30 Mar 2011 02:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:reply-to:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=HuUplIP1d4pRhgkUQreD47aGtTJvfPo/qKmq0WGfqMs=;
        b=HT1ftC/+FfcHAbSzBpES6Y5zW79PNJMbPlyyD9cpEopNpDCXgLzRqH+61Cd89mE7PR
         0Tuerr5U5lAw2cEP3qQ1h3fTEG5zLfIsmihnNgLIY6qc5rOthrUJJXBDt+2TIGfm/VOC
         HcsVg4PZvA9zkw4xg6plvj60zeHA9QN/Ynf7g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        b=ga0fGhKzzJmY0FfcGzNRcBmLCEfu0YQukEAL/V9SYAJDcQZNT1QlzobLMqcz2QxrY0
         PnQkNhHDwRA9d37BrAGplffYUjFXbAhKCOZNEbmAwFkBlWmvFpOkYRfBVbBzrK+KgcFf
         3Hh5BVg/xj2grRMvTZD4yqxmOtu3X/WnF7PRI=
Received: by 10.223.100.86 with SMTP id x22mr957370fan.108.1301478153161; Wed,
 30 Mar 2011 02:42:33 -0700 (PDT)
Received: by 10.223.126.145 with HTTP; Wed, 30 Mar 2011 02:42:12 -0700 (PDT)
In-Reply-To: <7vtyelsvp0.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170370>

On Tue, Mar 29, 2011 at 7:06 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> The fetch-pack/upload-pack protocol relies on the underlying transpor=
t
> (local pipe or TCP socket) to have enough slack to allow one window w=
orth
> of data in flight without blocking the writer. =A0Traditionally we al=
ways
> relied on being able to have a batch of 32 "have"s in flight (roughly=
 1.5k
> bytes) to stream.
>

Hmm, this explanation makes me wonder: Could this be related to the
deadlock we're experiencing with git-push over the git-protocol on
Windows when side-band-64k is enabled?
