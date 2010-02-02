From: Eugene Sajine <euguess@gmail.com>
Subject: Re: [BUG] - "git commit --amend" commits, when exiting the editor 
	with no changes written
Date: Tue, 2 Feb 2010 17:31:08 -0500
Message-ID: <76c5b8581002021431o2b5073a0s42b273b6d61893db@mail.gmail.com>
References: <76c5b8581002021207y3eccdc19i9a4abcc3d04315f0@mail.gmail.com>
	 <8c9a061002021214j673afbc8vfa5d941fba518648@mail.gmail.com>
	 <32541b131002021227o1ec9f369w6096e85382857b8a@mail.gmail.com>
	 <76c5b8581002021247j6df8f609ld9e5d87a060a5423@mail.gmail.com>
	 <394FB581-C9B9-40AB-AFB6-39B68ED5BEAD@wincent.com>
	 <76c5b8581002021356m52bb1817k9a4a29da0d4b681d@mail.gmail.com>
	 <77153A83-158D-4D36-A622-7AA3947C7D52@wincent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Avery Pennarun <apenwarr@gmail.com>,
	Jacob Helwig <jacob.helwig@gmail.com>, git@vger.kernel.org
To: Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Tue Feb 02 23:31:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NcRHB-0003dp-5a
	for gcvg-git-2@lo.gmane.org; Tue, 02 Feb 2010 23:31:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757023Ab0BBWbM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 2 Feb 2010 17:31:12 -0500
Received: from mail-iw0-f201.google.com ([209.85.223.201]:60806 "EHLO
	mail-iw0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756720Ab0BBWbL convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 2 Feb 2010 17:31:11 -0500
Received: by iwn39 with SMTP id 39so753574iwn.1
        for <git@vger.kernel.org>; Tue, 02 Feb 2010 14:31:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=PYLsoY32NhUdx60onSClkWqtVZPQ+Q7d1YhcAjV4mdw=;
        b=h380SXEUrR2sQLb7rqHNKQDOzC1UHsV+FoWVA12lxJlbZ9K4Km3F/iCZEU6TBnyPpl
         Oh0LuOyi3VS+6GAtZrYLOKY31u0UrMHdQS90OxskH14mmgfLUD1wbg5ERWAAmXRbWi+6
         n+npLNUmFBXChXMalbSN9AOg/HW76InOeOKF8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=DN4P29cMHaSmyYgIIMwskRkRThQuLfjX0WzsGehckleViUf8Gi9HpZ5LYqJVH4j1mC
         he1Lr/8o8b6CLu0EfOMwf+vpJY59rkrH1I+fCAaZ4VTmHh+/4cRIVMPvhb/1R79BMRjV
         ORUpPdBawMTjFXnxPKsmFn3FUCaHQ74O06SnE=
Received: by 10.231.79.136 with SMTP id p8mr3294638ibk.4.1265149868766; Tue, 
	02 Feb 2010 14:31:08 -0800 (PST)
In-Reply-To: <77153A83-158D-4D36-A622-7AA3947C7D52@wincent.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138772>

>
> Why should Git care about how you exited from your EDITOR? All it sho=
uld
> care about is the contents of the commit message, and the exit code o=
f the
> editor.

It doesn't matter which editor is used. The only thing that matters is
that you saving or not saving on exit from editor. If not saving -
abort the action.

>
>> For example IF there is a variable somewhere where message is stored=
:
>> For new commit message it is NULL and when commit is ready it is set
>> up to "message". We check If it is not empty and not NULL (:wq
>> executed), =C2=A0then we can commit.
>> For "prepopulated" messages this variable can be is set to "message"
>> from the beginning, so it doesn't matter if you're writing changes o=
r
>> not the check will always be true, so we can commit.
>
> I don't understand what change you're asking for, as things already w=
ork as
> you've just described (the "variable" is the file, .git/COMMIT_EDITMS=
G).

So, i was right in my assumption about how it is implemented - good;)

>
>> If the implementation would be like this, then I would propose to
>> clean up this variable after the prepopulated message is populated, =
so
>> it won't use it blindly, but only after you're overwriting the messa=
ge
>> (even if the message is not changed).
>
> Here is where you've lost me. Not sure what you mean here, nor how yo=
u're
> going to maintain the existing behavior for all of the people who hav=
e grown
> used to it over a long, long period of time.

Let me explain it like this (sorry for syntax):

new commit:

COMMIT_EDITMSG =3D NULL;
$ git commit

in background:
$EDITOR .git/COMMIT_EDITMSG

If saved/written
COMMIT_EDITMSG=3Dmessage

if (COMMIT_EDITMSG !=3D NULL &&  !COMMIT_EDITMSG.equalsIgnoreCase("")  =
)  {
commit();
} else abort();

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
amend or rebase:
COMMIT_EDITMSG =3D "message from commit or rebase sequence";
$ git commit --amend

in background:
$EDITOR .git/COMMIT_EDITMSG

COMMIT_EDITMSG =3D NULL    <=3D=3D=3D=3D=3D=3D=3D=3D this i think is mi=
ssing. We have to
clean it after it is populated in the editor.

If written back by save:
COMMIT_EDITMSG=3D"message from commit or rebase sequence" (it was not
changed, but saved/written)

If not saved, the check below will abort the action

if (COMMIT_EDITMSG !=3D NULL &&  !COMMIT_EDITMSG.equalsIgnoreCase("")  =
)  {
commit();
} else abort();


Is that a better explanation?

So, the only change from user perspective will be that you will have
always save/write your changes/rebase sequences (even if you don't
change the message) for the program to proceed with commit
amend/rebase or whatever the same way as for the simple commit.

Thanks,
Eugene
