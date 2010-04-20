From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: ghost refs
Date: Tue, 20 Apr 2010 10:52:42 -0400
Message-ID: <g2u76718491004200752gcf73abf1se05e89bd605e77a@mail.gmail.com>
References: <89030B4A18ECCD45978A3A6B639D1F24032A074E1C@FL01EXMB01.trad.tradestation.com>
	 <r2h32541b131004070958pa66bb7a3g6a1ecfaea0419965@mail.gmail.com>
	 <20100407210010.GB27012@coredump.intra.peff.net>
	 <loom.20100420T085842-887@post.gmane.org>
	 <20100420115124.GB22907@coredump.intra.peff.net>
	 <s2m76718491004200633la1cb07a6n8bc0d8d8e71b4e92@mail.gmail.com>
	 <20100420142444.GA8851@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Yann Dirson <yann.dirson@bertin.fr>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Apr 20 16:52:51 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O4Eok-00011J-3b
	for gcvg-git-2@lo.gmane.org; Tue, 20 Apr 2010 16:52:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750756Ab0DTOwp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 20 Apr 2010 10:52:45 -0400
Received: from mail-iw0-f197.google.com ([209.85.223.197]:63137 "EHLO
	mail-iw0-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750718Ab0DTOwn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 20 Apr 2010 10:52:43 -0400
Received: by iwn35 with SMTP id 35so3113111iwn.21
        for <git@vger.kernel.org>; Tue, 20 Apr 2010 07:52:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:received:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=2evgPN5BaGm7SiXnwj10UYo1E/A/EgGWq8AriH9KYH0=;
        b=eKnx00fMj1r8cY6Bl6eeATZ3vzE9k48y9F5z+gFZ/OwWVRHUafIbpeW+kKhFMYL86g
         wAMrT0aTg5sNk8swwNgL/40Nv7+guN9Lp/hZvCRlRditAmkZLktv+3Ac+jxRlwxLMn/R
         HciTQ+QfADJ0ziAC/ETXLD+vniIGyCyM+Ch8I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=gPPViYlfhP0+oHVbgp/tmSlQ+LoBj+5eGUI1gyJ0WilodtUJGv539+Gn4Gj409s7hn
         3dxo7RL+PQFIDrkScncU5DhBxukpjVOa4c38zHrizDffdZOIlARgYO3oFdwgFy7vK5jQ
         pIPxINHfB0KQrAS8Jpmf6sdkWDY/8kZUbJZBg=
Received: by 10.231.36.9 with HTTP; Tue, 20 Apr 2010 07:52:42 -0700 (PDT)
In-Reply-To: <20100420142444.GA8851@coredump.intra.peff.net>
Received: by 10.231.149.10 with SMTP id r10mr2422957ibv.63.1271775162621; Tue, 
	20 Apr 2010 07:52:42 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145381>

On Tue, Apr 20, 2010 at 10:24 AM, Jeff King <peff@peff.net> wrote:
> On Tue, Apr 20, 2010 at 09:33:42AM -0400, Jay Soffian wrote:
> I like how the user would interact with that, but what happens with:
>
> =C2=A0git checkout -b topic/subtopic
>
> The reflog of the deleted branch is in the way.

Handle it just as gracefully as we do today. This is what happens when
you try to create a branch with a similar collision:

$ git branch foo/bar
$ git branch foo
error: there are still refs under 'refs/heads/foo'
fatal: Failed to lock ref for update: Is a directory

So the reflog analog would be:

$ git branch topic/subtopic
error: there are still logs under 'logs/refs/heads/topic'
fatal: Failed to lock log for update: Is a directory

I think it's an edge case; thus I think it's okay to fail as long as
we give a reasonable error and a way to rename it.

j.
