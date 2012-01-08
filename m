From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 3/6] revert: don't let revert continue a cherry-pick
Date: Mon, 9 Jan 2012 01:33:41 +0530
Message-ID: <CALkWK0=-AWy7HnVASB1rt8njavTYOhV7Zxsdq4TE+VShVZmEzQ@mail.gmail.com>
References: <1326025653-11922-1-git-send-email-artagnon@gmail.com>
 <1326025653-11922-4-git-send-email-artagnon@gmail.com> <20120108193749.GH1942@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jan 08 21:04:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RjyyR-0007DA-Li
	for gcvg-git-2@lo.gmane.org; Sun, 08 Jan 2012 21:04:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754462Ab2AHUEF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 Jan 2012 15:04:05 -0500
Received: from mail-wi0-f174.google.com ([209.85.212.174]:52094 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753985Ab2AHUED convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 8 Jan 2012 15:04:03 -0500
Received: by wibhm6 with SMTP id hm6so2131972wib.19
        for <git@vger.kernel.org>; Sun, 08 Jan 2012 12:04:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=Q2Uz3Kz6GusiSQ6Ax3NyvpnwGk4DhDB1YMqygbOa4pI=;
        b=abVHFipVVz097AaBoC0JjNp5+K0kNyP6NGvvLLtyrI8mAeU8pWOvdw+s+M+SeQXXd/
         AB0Nfs/KEG0vN9rbaj9FfY1mmtKAhuM0z1Ds7XgeD8cxNY3w9fdhHnBqX234xPvXc9+y
         LETkgXOv8nbDG8mjt9TVGh6gdozzg9D7OA6jw=
Received: by 10.180.103.2 with SMTP id fs2mr382657wib.21.1326053042189; Sun,
 08 Jan 2012 12:04:02 -0800 (PST)
Received: by 10.216.175.3 with HTTP; Sun, 8 Jan 2012 12:03:41 -0800 (PST)
In-Reply-To: <20120108193749.GH1942@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188124>

Hi,

Jonathan Nieder wrote:
> Ramkumar Ramachandra wrote:
>
>> When we allow mixing "revert" and "pick" instructions in the same
>> sheet in the next patch, the following workflow would be perfectly
>> valid:
>>
>> =C2=A0 $ git cherry-pick base..latercommit
>> =C2=A0 [conflict occurs]
>> =C2=A0 $ edit problematicfile
>> =C2=A0 $ git add problematicfile
>> =C2=A0 $ git revert --continue
>> =C2=A0 [finishes successfully]
>
> Does "workflow" mean "sequence of commands"?

Yes.  Clarified wording.

>> This is confusing to the operator, because the sequencer is an
>> implementation detail hidden behind the 'git cherry-pick' and 'git
>> revert' builtins.
>
> I don't know --- it's not confusing to me. =C2=A0Could you explain fu=
rther
> what harm the current behavior does? =C2=A0E.g., could it cause me to
> misunderstand some basic concepts, or could it lead me to run command=
s
> that cause me to scratch my head or lose data?

Junio explained this to me in [1].  It's very unnatural for a user to
want to execute "git cherry-pick --continue" when the previous command
was a "git revert": it probably means that she forgot about the
in-progress "git revert".  The problem becomes more serious when the
sequencer grows more capabilities: a "git merge --continue" to
continue a "git am" sounds much more absurd.  Ofcourse, we will
provide a way to continue any sequencer operation in the future: "git
continue" seems to be a good candidate.

[1]: http://thread.gmane.org/gmane.comp.version-control.git/185355

Thanks.

-- Ram
