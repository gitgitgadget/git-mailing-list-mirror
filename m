From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH] transport: do not allow to push over git:// protocol
Date: Mon, 3 Oct 2011 20:44:22 +1100
Message-ID: <CACsJy8B7Z-fT+ED=4F-Ug-bhvCagSxr0X6vZqn5PGRfB7KnUTA@mail.gmail.com>
References: <1317432415-9459-1-git-send-email-pclouds@gmail.com>
 <20111003074250.GB9455@sigill.intra.peff.net> <4E8975E7.2040804@viscovery.net>
 <20111003093912.GA16078@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org,
	Jonathan Nieder <jrnieder@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Oct 03 11:45:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RAf51-00054k-3i
	for gcvg-git-2@lo.gmane.org; Mon, 03 Oct 2011 11:44:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754185Ab1JCJoz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 3 Oct 2011 05:44:55 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:46619 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753964Ab1JCJox convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 3 Oct 2011 05:44:53 -0400
Received: by bkbzt4 with SMTP id zt4so5081068bkb.19
        for <git@vger.kernel.org>; Mon, 03 Oct 2011 02:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=zzzcqRJpLm5BPVDEqy/tA1i0QC3VXVcPymOkVEAxMIo=;
        b=M2XRoJVBHpvwRkHYA1kpgPPTmvDCecmTyIRw8W61Cwjpjr3DlRVUqYJvRSPpLDpQgf
         6jO4tXgfIhwLPe0sHXWlfY6sqKJfpRtJoIx8PtMzvbLuC945C8GV8NpZB6bgZS9gBMj3
         FImQJpaWZqzFtlyxE3kZPofTSqtKitEIdbmO8=
Received: by 10.204.13.74 with SMTP id b10mr796170bka.95.1317635092251; Mon,
 03 Oct 2011 02:44:52 -0700 (PDT)
Received: by 10.204.120.75 with HTTP; Mon, 3 Oct 2011 02:44:22 -0700 (PDT)
In-Reply-To: <20111003093912.GA16078@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182643>

2011/10/3 Jeff King <peff@peff.net>:
> So yeah, that makes it even worse for the client to start refusing th=
is
> without even contacting the server. I forgot that we added the "ERR"
> response way back in a807328 (connect.c: add a way for git-daemon to
> pass an error back to client, 2008-11-01).
>
> GitHub uses it to make nice messages:
>
> =C2=A0$ git push origin
> =C2=A0fatal: remote error:
> =C2=A0 =C2=A0You can't push to git://github.com/gitster/git.git
> =C2=A0 =C2=A0Use git@github.com:gitster/git.git
>
> We should maybe do something like the patch below:

Jonathan also mentions another patch

http://article.gmane.org/gmane.comp.version-control.git/182536

> but:
>
> =C2=A01. There is some information leakage there. In particular, one =
can
> =C2=A0 =C2=A0 tell the difference now between "repo does not exist" a=
nd
> =C2=A0 =C2=A0 "receive-pack is not turned on". Personally, I think th=
e tradeoff
> =C2=A0 =C2=A0 to have actual error messages is worth it. HTTP has had=
 real error
> =C2=A0 =C2=A0 codes for decades, and I don't think anybody is too up-=
in-arms that
> =C2=A0 =C2=A0 I can probe which pages are 404, and which are 401.

To me, just "<service>: access denied" is enough. Not particularly
friendly but should be a good enough clue.
--=20
Duy
