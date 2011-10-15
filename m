From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: Re: interrupting "git rebase" (Re: git rebase +)
Date: Sat, 15 Oct 2011 08:23:23 -0700
Message-ID: <CAOeW2eFK5vSKmf+nxzD-6yh5CWZRv4WqSerbSXTPtXmtNeNjxg@mail.gmail.com>
References: <loom.20111013T134405-495@post.gmane.org>
	<4E96E5E1.7010103@viscovery.net>
	<20111014052653.GA5052@elie.hsd1.il.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Sixt <j.sixt@viscovery.net>, Adam Piatyszek <ediap@wp.pl>,
	git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Oct 15 17:23:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RF65H-000394-LJ
	for gcvg-git-2@lo.gmane.org; Sat, 15 Oct 2011 17:23:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753341Ab1JOPXZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 15 Oct 2011 11:23:25 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:62113 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752678Ab1JOPXY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 15 Oct 2011 11:23:24 -0400
Received: by iaek3 with SMTP id k3so3925269iae.19
        for <git@vger.kernel.org>; Sat, 15 Oct 2011 08:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=loe4ir0ziOb/vrHIQzpCuNN4NDtZkg2JBd1WyLqnRXM=;
        b=YkJ/emsMx4n6XGevB4gCim+D/3q9+YrSDYDRInV3rRWlcWh/Qg6nKelW03a5nd2UQZ
         HkgFOnc/qHNvrXewCOpEJXxHnGBFWkFqgR6575VYUdIIscjPYi3NfEKoseilp0gKIJJ9
         kRzZ47MOAigZEuCzR/h9QDjwz2HfofDwlIwNw=
Received: by 10.231.46.66 with SMTP id i2mr5699441ibf.0.1318692203985; Sat, 15
 Oct 2011 08:23:23 -0700 (PDT)
Received: by 10.231.208.77 with HTTP; Sat, 15 Oct 2011 08:23:23 -0700 (PDT)
In-Reply-To: <20111014052653.GA5052@elie.hsd1.il.comcast.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183662>

On Thu, Oct 13, 2011 at 10:26 PM, Jonathan Nieder <jrnieder@gmail.com> =
wrote:
> Johannes Sixt wrote:
>
>> Hitting Ctrl-C during git-rebase results undefined behavior. git-reb=
ase is
>> a shell script and was never designed to operate in any form of atom=
icity.
>>
>> You should have let it run until it stopped.
>
> Wait, really? =C2=A0That's bad, and unlike most git commands.

If Ctrl-C is pressed while the state is being written, it could be
left with incomplete information, yes. It has been like that forever I
think. I'll put it on my todo list, but it will not be my top priority
(and I have very little git time now anyways).

> If interrupting the rebase leaves the repository in a state that
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0rm -fr .git/rebase-apply
> =C2=A0 =C2=A0 =C2=A0 =C2=A0git reset --hard <appropriate commit name>
>
> cannot recover from, I'd consider it a serious problem.

I agree, but I don't know of any way that can happen. Even "git rebase
--abort" should always work (in the sense that
=2Egit/rebase-[apply|merge] would be deleted), although it will not
return to the original branch if some state is missing.

> By the way, what happened to the "git rebase --abort-softly" synonym
> for "rm -fr .git/rebase-apply" discussed a while ago?

I think we simply did not agree on a syntax, but here was also some
discussion about future plans for the sequencer. I remember seeing
some discussions about making "git reset --hard" remove the sequencer
state, but I don't remember the conclusion. It is not clear to me what
is ok to implement in git-rebase nowadays and what would just be
double work if it needs to be re-implemented in the sequencer.

Martin
