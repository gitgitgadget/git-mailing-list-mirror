From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 04/13] revert: Propogate errors upwards from do_pick_commit
Date: Sat, 2 Jul 2011 16:01:27 +0530
Message-ID: <BANLkTin6dMPkhr4W+Z1VNJ51M4hNPLsLnQ@mail.gmail.com>
References: <1308661489-20080-1-git-send-email-artagnon@gmail.com>
 <1308661489-20080-5-git-send-email-artagnon@gmail.com> <20110621162232.GI15461@elie>
 <7viprz8018.fsf@alter.siamese.dyndns.org> <20110621193217.GA17390@elie> <7vei2n6irh.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Git List <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jul 02 12:31:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QcxUP-0000Z9-Lo
	for gcvg-git-2@lo.gmane.org; Sat, 02 Jul 2011 12:31:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754202Ab1GBKbt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 2 Jul 2011 06:31:49 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:49625 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754084Ab1GBKbs convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 2 Jul 2011 06:31:48 -0400
Received: by wwe5 with SMTP id 5so3881281wwe.1
        for <git@vger.kernel.org>; Sat, 02 Jul 2011 03:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=cY2+FpW59Mb59LGo2cYTFopEx1qKxsGwS71f+cOJNt0=;
        b=uGZtNEfPR1U3E8uUc9M67GAOwZNoYuH0roySGKdLW331/4fqy4Yads+g7AH0trZgP9
         /j4Dykbo5pUjD5mx8S03QfqPb5n/H9Vvy0Y+0LykiGl/ZNXoc8EtyUpWdMcypwJPZalj
         mzBAM4H4GUukuLbrJlr6EqjnkPrA0Gx3cS1P4=
Received: by 10.216.236.208 with SMTP id w58mr1899925weq.62.1309602707197;
 Sat, 02 Jul 2011 03:31:47 -0700 (PDT)
Received: by 10.216.134.194 with HTTP; Sat, 2 Jul 2011 03:31:27 -0700 (PDT)
In-Reply-To: <7vei2n6irh.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176552>

Hi Junio and Jonathan,

Junio C Hamano writes:
> Jonathan Nieder <jrnieder@gmail.com> writes:
>> Jun 21, 2011 at 12:19:47PM -0700, Junio C Hamano wrote:
>>> Jonathan Nieder <jrnieder@gmail.com> writes:
>>
>>>>> + =C2=A0if (res < 0)
>>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0die(_("%s failed"), me);
>>>>> + =C2=A0return 0;
>>>>
>>>> Should the "revert" or "cherry-pick" here be part of the message
>>>> marked for translation? =C2=A0A translator might want to paraphras=
e to
>>>>
>>>> =C2=A0 =C2=A0 fatal: failed to cherry-pick
>>>>
>>>> if that is more natural in the language at hand.
>>>
>>> Wouldn't such a message file simply say
>>>
>>> =C2=A0 =C2=A0 =C2=A0msgid "%s failed"
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 msgstr "failed to %s"
>>>
>>> IOW, I am not sure what problem you are seeing.
>>
>> Ah, sorry for the lack of clarity. =C2=A0What I meant is that the no=
un
>> and verb will be different words in many languages. =C2=A0There can =
also be
>> problems of subject/verb agreement. =C2=A0Also "me" is used elsewher=
e to
>> hold the command name as typed on the command line even when LANG
>> points to a language other than English if I remember correctly.
>
> Yes, "me" is the name of the command as the user types, so to whateve=
r
> language you are translating, it can only be usable as the name of th=
e
> command in the message. =C2=A0Even if your language has a single verb=
 to
> express the act of "running the cherry-pick command", say, "distim", =
you
> cannot translate the message to "failed to distim". =C2=A0Your messag=
e has to
> say something like "Sorry, I got a failure while running the 'cherry-=
pick'
> command", and in English (which is msgid is in) "%s failed" would be =
good
> enough to convey that meaning.

Right.

> BUT.
>
>> If the message were in revert_or_cherry_pick instead of having two
>> identical copies in cmd_revert and cmd_cherry_pick, it would have be=
en
>> less striking (but still a potential problem).
>
> The effort by =C3=86var to switch among totally different message str=
ings
> depending on "action" was going in the direction to actually allow yo=
u to
> translate one of these messages to "failed to distim", and it was los=
t
> earlier in this patch (error-dirty-index). We may want to fix that in
> addition to this one.

But why is it required here?  I already know what "me" is depending on
whether I'm in cmd_cherry_pick or cmd_revert and there are two
different translation strings anyway.  I fixed the problem I
introduced in error-dirty-index earlier in this patch.

-- Ram
