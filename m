From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH] grep: do not do external grep on skip-worktree entries
Date: Mon, 4 Jan 2010 17:14:00 +0700
Message-ID: <fcaeb9bf1001040214q678bf7d6ya922923136da0598@mail.gmail.com>
References: <7vzl4zy5z3.fsf@alter.siamese.dyndns.org> <fcaeb9bf1001021115j7b23264n42cfba7855c2253e@mail.gmail.com> 
	<7v7hs09tpi.fsf@alter.siamese.dyndns.org> <87ljgfgbl0.fsf@catnip.gol.com> 
	<fc339e4a1001021847hf1e1a7fq894de7908839ff77@mail.gmail.com> 
	<877hrzga16.fsf@catnip.gol.com> <alpine.LFD.2.00.1001031124420.3630@localhost.localdomain> 
	<7v3a2mzzg4.fsf@alter.siamese.dyndns.org> <20100104053125.GA5083@coredump.intra.peff.net> 
	<7vbphaquwl.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Miles Bader <miles@gnu.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 04 11:14:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NRjxB-0004Ls-Ne
	for gcvg-git-2@lo.gmane.org; Mon, 04 Jan 2010 11:14:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753333Ab0ADKOV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 4 Jan 2010 05:14:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753320Ab0ADKOV
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Jan 2010 05:14:21 -0500
Received: from mail-gx0-f211.google.com ([209.85.217.211]:59311 "EHLO
	mail-gx0-f211.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752217Ab0ADKOU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 4 Jan 2010 05:14:20 -0500
Received: by gxk3 with SMTP id 3so2620232gxk.1
        for <git@vger.kernel.org>; Mon, 04 Jan 2010 02:14:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=/Yp+xeNWp9OD+Te7gTIkAbd+9P2oa+kg/8lWAqIbs6s=;
        b=BpB0T7VPd7akZyR79BJOQ1OMAcWePUjks0JJzEUjXNgFQKGTuRrSCnVnt1YHw+PD9K
         XFjw6agJFOZy/REB9nGJFEn9pvRauUfIvlpT47QiSfBIiM48/YZIFa0caO5wwGK1Kv63
         94P+40yh3+nGrYo6ntjT74vT9wkQn0tpcpN4w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=aYohdtanSzHCoEY9lcVMDMBdzjGYs8oreBHL/YFQFhhO+wVdJRuIVCNgxOj+HmETVs
         +RVkRya9oF6Vb7OtASAE0XraS9JwcsKEF71a8F7qTlVMIAkK3yoP2sWN/a5azTpXdtyp
         BtCCfjQoEXMXVKQU+eGq/u2a3UzP6tzKYtayk=
Received: by 10.101.117.19 with SMTP id u19mr24650220anm.79.1262600060084; 
	Mon, 04 Jan 2010 02:14:20 -0800 (PST)
In-Reply-To: <7vbphaquwl.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136105>

On Mon, Jan 4, 2010 at 12:52 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
>> I agree that Solaris default tools are insane, but is there any reas=
on
>> to munge the PATH for a single feature like external grep? Why not
>> EXTERNAL_GREP=3D/usr/xpg4/bin/grep (or /usr/local/bin/grep) in the
>> Makefile? Why not GIT_EXTERNAL_GREP=3D$HOME/bin/grep in the environm=
ent?
>
> That git-sh-setup "fix" is not for running external grep. =C2=A0It is=
 for our
> scripted Porcelains that rely on working basic tools (sed, tr, who kn=
ows
> what else is broken).
>
> In fact, our Makefile by default punts on external grep on Sun's. =C2=
=A0Run
> "git grep NO_EXTERNAL_GREP -- Makefile" to see for yourself --- it wo=
uld
> work even on Solaris ;-)

A bit off-topic. But it seems to me on linux (main development
platform?) GNU grep may be tested more than the builtin grep because
NO_EXTERNAL_GREP would be undefined by default. Should we test both
greps in that case?
--=20
Duy
