From: arnaud brejeon <arnaud.brejeon@gmail.com>
Subject: Re: [PATCH 1/2] Add password parameter to git svn commands and use it when provided instead of defaulting to end-user prompt
Date: Mon, 21 Oct 2013 19:06:29 +0200
Message-ID: <005DF7EA-CF5A-408F-A145-07F53D836974@gmail.com>
References: <1381569810-2167-1-git-send-email-arnaud.brejeon@gmail.com> <20131014141127.GA21200@google.com> <20131014184005.GA3352@dcvr.yhbt.net> <20131014223602.GB12116@sigill.intra.peff.net> <20131014233556.GA31230@dcvr.yhbt.net>
Mime-Version: 1.0 (Mac OS X Mail 6.6 \(1510\))
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>,
	matthijs@stdin.nl, Eric Wong <normalperson@yhbt.net>
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Oct 21 19:06:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VYIwA-0001Ls-7r
	for gcvg-git-2@plane.gmane.org; Mon, 21 Oct 2013 19:06:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751341Ab3JURGd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 21 Oct 2013 13:06:33 -0400
Received: from mail-wi0-f175.google.com ([209.85.212.175]:60176 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751078Ab3JURGc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 21 Oct 2013 13:06:32 -0400
Received: by mail-wi0-f175.google.com with SMTP id hm4so4300561wib.14
        for <git@vger.kernel.org>; Mon, 21 Oct 2013 10:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=content-type:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=qNuBabQtyrJxdtFdFTjR+lOWxj2x+HMlJHUMdEilf3Y=;
        b=c/Z6OAwPwy9LrKgEX7fkf0IBQG7johSzFJ2HTkdvyTczb4Nhk2sskXqzdMJZV2xQiE
         omEs1lAXtTPU4r9z/CGLdHhYApMSr8/uqJ8L3aB5TQ0+q6pwlEkAVll4Lg/1R5m3piYk
         BQOnJmkqtYitFqd4uxRxOuba7ainiBBgUeL4y0whQ9gl7P5LTqd3ZzXA5TFoZsY5KeVJ
         uRc2Kg/b40onkCoQomB5g1e6yX2myTjT31BEIm1JpI1HDL9OYdxVN4RxngMZ3r63YRtf
         +Bc51RUKEmp7yfuBaeDAPsnKYjpVZRN+eDruMBmZqe+OF0ExVBWro9uHicRjjAST4TuJ
         TEbQ==
X-Received: by 10.194.94.33 with SMTP id cz1mr7942wjb.73.1382375191719;
        Mon, 21 Oct 2013 10:06:31 -0700 (PDT)
Received: from new-host-2.home (APuteaux-552-1-79-43.w90-61.abo.wanadoo.fr. [90.61.246.43])
        by mx.google.com with ESMTPSA id y20sm34135828wib.0.2013.10.21.10.06.30
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 21 Oct 2013 10:06:31 -0700 (PDT)
In-Reply-To: <20131014233556.GA31230@dcvr.yhbt.net>
X-Mailer: Apple Mail (2.1510)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236434>

I played with GIT_ASKPASS and managed to get a fully automated behavior=
 without any user prompt.
I guess that the patches are not necessary as we can provide the same ,=
 it is just less straightforward than direct parameters but I understan=
d the security concerns.

I dont know if you plan to keep GIT_ASKPASS as is, but this environment=
 variable is not mentioned on git svn documentation and I guess just a =
few people know about it. Moreover, the name is misleading as it handle=
s all the prompts, not only the password one.

Arnaud

Le 15 oct. 2013 =E0 01:35, Eric Wong <normalperson@yhbt.net> a =E9crit =
:

> Jeff King <peff@peff.net> wrote:
>> On Mon, Oct 14, 2013 at 06:40:05PM +0000, Eric Wong wrote:
>>=20
>>>> arnaud.brejeon@gmail.com wrote:
>>>>=20
>>>>> Signed-off-by: Arnaud Brejeon <arnaud.brejeon <at> gmail.com>
>>>>=20
>>>> Thanks.
>>>>=20
>>>> Can you say a little more about the context?  Do you run a script =
that
>>>> wants to pass a password to 'git svn', do you type it each time on=
 the
>>>> command line, or something else?  Is it ok that the password would
>>>> show up in "ps" output?  Would the platform's keyring or netrc be
>>>> usable here, or is there something in the context that avoids that=
?
>>>=20
>>> I think using keyring or netrc is more appropriate.  Having a passw=
ord
>>> on the command-line and visible to all via ps doesn't seem like
>>> something git should support.
>>=20
>> Agreed. We have ready-made git-credential helpers to handle this exa=
ct
>> problem. We would need to convert SVN::Prompt to use git-credential
>> rather than prompting itself, though. One of the things that held me
>> back from writing such a patch is that I thought libsvn already hand=
led
>> things like keychain integration, and it was better for git-svn to b=
e
>> more svn-like than git-like in its access of SVN repos.
>>=20
>> Are those already supported out of the box by libsvn? If git's
>> credential helpers are significantly more featureful, it might be wo=
rth
>> converting, but if not, I think it makes sense to stay with svn's
>> existing code.
>=20
> I looks like this patch was forgotten once again:
>=20
> http://mid.gmane.org/1371573490-21973-1-git-send-email-matthijs@stdin=
=2Enl
>=20
> Matthijs: can you add a Signed-off-by for your patch?  I'm inclined t=
o
> push it to Junio as-is since it looks reasonable.
> I admit I don't know SVN callbacks anymore well enough and don't have
> time to test with GNOME.
