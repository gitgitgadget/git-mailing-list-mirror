From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: [BUG] - "git commit --amend" commits, when exiting the editor 
	with no changes written
Date: Tue, 2 Feb 2010 17:35:59 -0500
Message-ID: <32541b131002021435kadb68ffge77ad5f4e1775418@mail.gmail.com>
References: <76c5b8581002021207y3eccdc19i9a4abcc3d04315f0@mail.gmail.com> 
	<8c9a061002021214j673afbc8vfa5d941fba518648@mail.gmail.com> 
	<32541b131002021227o1ec9f369w6096e85382857b8a@mail.gmail.com> 
	<76c5b8581002021247j6df8f609ld9e5d87a060a5423@mail.gmail.com> 
	<394FB581-C9B9-40AB-AFB6-39B68ED5BEAD@wincent.com> <76c5b8581002021356m52bb1817k9a4a29da0d4b681d@mail.gmail.com> 
	<77153A83-158D-4D36-A622-7AA3947C7D52@wincent.com> <76c5b8581002021431o2b5073a0s42b273b6d61893db@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Wincent Colaiuta <win@wincent.com>,
	Jacob Helwig <jacob.helwig@gmail.com>, git@vger.kernel.org
To: Eugene Sajine <euguess@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 02 23:36:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NcRM9-0007B0-Kv
	for gcvg-git-2@lo.gmane.org; Tue, 02 Feb 2010 23:36:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757077Ab0BBWgU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 2 Feb 2010 17:36:20 -0500
Received: from mail-yx0-f189.google.com ([209.85.210.189]:56380 "EHLO
	mail-yx0-f189.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756614Ab0BBWgT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 2 Feb 2010 17:36:19 -0500
Received: by yxe27 with SMTP id 27so572821yxe.4
        for <git@vger.kernel.org>; Tue, 02 Feb 2010 14:36:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=OPIXZGWeRk/zSO5KJIcR7QE9jmnLG/JhseEkJqqlxIY=;
        b=puR7wIjJUcpIP8IumQUiEa3h336BdK1H1bIYNNSWThA7CRIr3ZrTq31L4m4Bcb3/Rr
         E15CFUyZAeTMCg1w0J9AcjowBd5MtkYfO2lw2/1k2QnXuTLyf27pIC4y4+pg/2oUI6B2
         3/yEpqaVLQhowWPcbY+5HE3613XshkynbzZQA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=hK2Yn4AxuZjDG+miMk4rYTW7EeNOnznEjAIW85KeMqPSvz7Ltk1bl6OiTAQOfIZFY0
         KPRB4BDDliIcTIoJ8JMATrFt1kzUcxopq1/LyEcsG4xqDBBDTz32Y3k/+fEpkM2gMUKt
         /gALyoLZ9yLnU9OL2ngZ9rmlhb/+l6QJhZatw=
Received: by 10.150.120.7 with SMTP id s7mr9347452ybc.345.1265150179101; Tue, 
	02 Feb 2010 14:36:19 -0800 (PST)
In-Reply-To: <76c5b8581002021431o2b5073a0s42b273b6d61893db@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138774>

> amend or rebase:
> COMMIT_EDITMSG =3D "message from commit or rebase sequence";
> $ git commit --amend
>
> in background:
> $EDITOR .git/COMMIT_EDITMSG
>
> COMMIT_EDITMSG =3D NULL =A0 =A0<=3D=3D=3D=3D=3D=3D=3D=3D this i think=
 is missing. We have to
> clean it after it is populated in the editor.

That's not going to work.  Most editors will get quite angry at you if
you modify the file while the editor has it open.  Furthermore, how do
you know how long to wait after launching the editor but before
deleting the file?

Like I suggested earlier, monitoring the mtime of the file to see if
it has changed after the editor exits, even if the file itself is
identical to what it was, might work.  This feature would have to be
optional in order to not confuse existing users, and not annoy users
of editors (like my favourite, joe) which don't save-on-exit if the
file hasn't changed.  But I think it might be valuable to some people
nevertheless.  And if it became popular, perhaps it could become the
default in some future version of git (after giving people enough
notice, etc, etc).

So you might want to submit a patch to implement an option like that.

Avery
