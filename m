From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [BUG] Autocompletion fails with "bash: words: bad array
 subscript"
Date: Tue, 10 May 2011 18:45:52 -0500
Message-ID: <20110510234552.GG1994@elie>
References: <BANLkTi=nOUEp_J+2dkZZp=HvER-eAdG9eg@mail.gmail.com>
 <20110510203101.GG14456@sigill.intra.peff.net>
 <20110510203943.GH14456@sigill.intra.peff.net>
 <BANLkTi=0r_hCgt3wh4EkRqS6gnCyyKrY2g@mail.gmail.com>
 <20110510210116.GA25224@sigill.intra.peff.net>
 <BANLkTin9=7y+2eqUgo_ObcYeGs3TQ7YMGw@mail.gmail.com>
 <20110510211016.GB26231@sigill.intra.peff.net>
 <20110510223935.GA31029@goldbirke>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Sverre Rabbelier <srabbelier@gmail.com>,
	Git List <git@vger.kernel.org>,
	"Shawn O. Pearce" <gsoc@spearce.org>,
	Stephen Boyd <bebarino@gmail.com>
To: SZEDER =?utf-8?B?R8OhYm9y?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Wed May 11 01:46:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QJwct-0001DR-H3
	for gcvg-git-2@lo.gmane.org; Wed, 11 May 2011 01:46:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753513Ab1EJXp6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 10 May 2011 19:45:58 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:62703 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753361Ab1EJXp5 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 May 2011 19:45:57 -0400
Received: by iyb14 with SMTP id 14so5610274iyb.19
        for <git@vger.kernel.org>; Tue, 10 May 2011 16:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=Ay6kTMN88WeORLGULsk7JZ9uYCsrY+x4kInU1GgRZ/g=;
        b=ph920jeqae2AfPOAn5HNcT+SVYPTb4FFWowY02BoDZs4XnMM7NCFCfKXFMLPCSeZ5X
         IgtNteEh2Tyttg75NeKgL0Iv3DqdZtOyMvi3qY/ZUXWVbLmTC38VBUasCzx3OlGDCtf8
         Lqv4MOnh2MM3OOEwEf2xUvcB0Fw3016KgSGVY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=rofpyIYQZbyNZqpodwf4yV7PbwdSoBSzYRPJZ6Z4EJkC08s9mksGfWZfdZsRnrSczw
         G8gbJpeJePjO7Esbf4w0/WaQcdZRAqgBH12ObjWfYHRdwzgo+C/U+u17AtuDkTsGtpkq
         dYRnnTrzvDTqNZTfRXNR2K+WVs/BVilv4zLZE=
Received: by 10.42.227.69 with SMTP id iz5mr8979683icb.442.1305071156896;
        Tue, 10 May 2011 16:45:56 -0700 (PDT)
Received: from elie (adsl-69-209-56-134.dsl.chcgil.ameritech.net [69.209.56.134])
        by mx.google.com with ESMTPS id 19sm3279004ibx.52.2011.05.10.16.45.54
        (version=SSLv3 cipher=OTHER);
        Tue, 10 May 2011 16:45:55 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110510223935.GA31029@goldbirke>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173385>

SZEDER G=C3=A1bor wrote:

> Thinking a bit more about it, you don't even need to search history t=
o
> reproduce.

Yep.  Doing

 $ . /etc/bash_completion
 $ ls<^A><TAB>
 bash: words: bad array subscript

produces the same.

> So the bug is definitely not git-related.  The fix would be a check
> along the lines of the first two hunks of the patch I just sent out.

=46WIW it looks like the bash-completion lib adopted a different fix
recently: see [1] (_init_completion: Indicate that completion should
not continue if cword =3D=3D 0, 2011-05-02).

[1] http://git.debian.org/?p=3Dbash-completion/bash-completion.git;a=3D=
commitdiff;h=3D457dbf6061eea5f2d1e3bccacf1691265f7321cc
