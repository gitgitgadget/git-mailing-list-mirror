From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] grep: --full-tree
Date: Sun, 29 Nov 2009 13:38:23 +0200
Message-ID: <94a0d4530911290338h459dd5a2p4752f7d58c455964@mail.gmail.com>
References: <20091125203922.GA18487@coredump.intra.peff.net>
	 <20091125210034.GC18487@coredump.intra.peff.net>
	 <7vmy2as319.fsf@alter.siamese.dyndns.org>
	 <20091125214949.GA31473@coredump.intra.peff.net>
	 <7vtywiqmbs.fsf@alter.siamese.dyndns.org>
	 <20091125222625.GB2861@coredump.intra.peff.net>
	 <4B0DB29D.5010101@gmail.com>
	 <20091125225318.GA10127@coredump.intra.peff.net>
	 <4B0DB894.7010800@gmail.com>
	 <20091125232210.GA15538@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: A Large Angry SCM <gitzilla@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Nov 29 12:38:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NEi6s-0000jq-Bv
	for gcvg-git-2@lo.gmane.org; Sun, 29 Nov 2009 12:38:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754160AbZK2LiS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 29 Nov 2009 06:38:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754143AbZK2LiS
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Nov 2009 06:38:18 -0500
Received: from mail-iw0-f171.google.com ([209.85.223.171]:32835 "EHLO
	mail-iw0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754080AbZK2LiR convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 29 Nov 2009 06:38:17 -0500
Received: by iwn1 with SMTP id 1so1648214iwn.33
        for <git@vger.kernel.org>; Sun, 29 Nov 2009 03:38:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=sBzXDGN+ZGyTVfcCfC7jHT0bcU6AZ8K3Ixu8NIsso1Q=;
        b=XHXn2+y5v/6WEuO1X36hKATl0JYrHV7sWYho9HGnoFOPkueaBGyCmO1qsnxek9IvJz
         lTQtVj6wmU58ZBtzuqmXDJleywJyEoBgDUQRp7Z5AiC0JkMEqtAeyH1ROgVPR3oFBvOu
         S553lM8uJxaRp5F9QT3ddYe1cQ1Ojly0uweLw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=joow53NIojf8OZVMtS7aYPe2D4mx0FNXtZQ/QUS6gAzLQKDLmfmMZ2r080P3Rl3vOb
         IatjCh3fstxREFRUVM+4kOKHIZr+EVm9O5KY24oyA+FlDE0cFjSjVtIqEpieKfqrF7s2
         dzmIWNdq1QkSO5VkIJ6Hjr9eoJnzkjyFIHu8U=
Received: by 10.231.122.103 with SMTP id k39mr5873324ibr.10.1259494703309; 
	Sun, 29 Nov 2009 03:38:23 -0800 (PST)
In-Reply-To: <20091125232210.GA15538@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134012>

On Thu, Nov 26, 2009 at 1:22 AM, Jeff King <peff@peff.net> wrote:
> Probably we would want something flexible, but with sane defaults. Li=
ke
> an environment variable to ignore all (or most) config options, but t=
hen
> the ability to opt into specific ones. Something like:
>
> =C2=A0GIT_PLUMBING=3D1; export GIT_PLUMBING
> =C2=A0git log ;# does not respect any non-plumbing config
> =C2=A0git --respect=3D'log.showroot' ;# respect just the one variable
> =C2=A0git --respect=3D'color.*' log ;# you get all color
>
> But there are two big obstacles (besides the obvious issue that
> introducing this in itself needs a gentle transition plan):
>
> =C2=A01. We need to annotate every config option with whether it is
> =C2=A0 =C2=A0 potentially problematic. For example, core.filemode sho=
uld probably
> =C2=A0 =C2=A0 be respected no matter what (but I'm not sure if it is =
simply true
> =C2=A0 =C2=A0 for core.*).
>
> =C2=A02. Script writers need to actually use the system, which is som=
ewhat
> =C2=A0 =C2=A0 more verbose and annoying than what they have to do now=
=2E But at
> =C2=A0 =C2=A0 least it defaults to safety when they are lazy, and the=
n they can
> =C2=A0 =C2=A0 re-add options. Of course, they are stuck on an upgrade=
 treadmill
> =C2=A0 =C2=A0 of analyzing and approving each new option that appears=
 in git.

+1 on this.

This would make it easier to add options in the future that would be
potentially dangerous to scripts otherwise. But more than
"non-plumbing" I would rather define these variables as *preferences*;
things that are not essential to the proper functioning of git
commands, and would vary from user to user.

--=20
=46elipe Contreras
