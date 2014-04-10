From: =?UTF-8?Q?Diego_Lago_Gonz=C3=A1lez?= 
	<diego.lago.gonzalez@gmail.com>
Subject: Re: [PATCH] Add support for commit attributes
Date: Thu, 10 Apr 2014 08:32:42 +0200
Message-ID: <CAFozjsg_sta+c4=Cbrj=cfS=geOnnWic4wU_hd6=1Gaf4PAUcg@mail.gmail.com>
References: <1397072295-7670-1-git-send-email-diego.lago.gonzalez@gmail.com> <CACsJy8BJw3+=vSHzfBYigoK6ejt-DNHJPTcOWS3Nv=zxpF1f7g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 10 08:33:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WY8YJ-0001gB-Eq
	for gcvg-git-2@plane.gmane.org; Thu, 10 Apr 2014 08:33:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933537AbaDJGdV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 10 Apr 2014 02:33:21 -0400
Received: from mail-wg0-f48.google.com ([74.125.82.48]:52949 "EHLO
	mail-wg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934647AbaDJGdE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 10 Apr 2014 02:33:04 -0400
Received: by mail-wg0-f48.google.com with SMTP id l18so3515791wgh.19
        for <git@vger.kernel.org>; Wed, 09 Apr 2014 23:33:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=zxR23xw8ES8/fErWBaiz5xl9WSiEEMl/AMbQDuaFbyA=;
        b=DsKULallV8dJDi/s8hlS4axixCxcyHZtkEiVaVC5aA/CGBxTZNpHhr1VFabBdLDpF4
         9xUdtkNuXiRwU/tkBosx6HqmB2Pypcl6ipVFGE0sJ7chlW4knHrhyi4yE2uy/w+TUXrr
         cU5m5w+PwTkerHQ5Mn1ZjFmr/+2ryZxVgoCdjkdQfsqF9KIfs3UJzp1bPBvdxhl3N5lk
         McNCW7P+149dE/RmCoP6UuPl5k1jayEuTDx96FNVPRtwnrqy6DL4sIC0i/mXGNHIMa4F
         x/CafEA5wPB6xEt9Kx/+zq3m97urwmAwykI6DGJ+lSt69vvR+ofdwTrc0bIS/Ga/WFcv
         DsIA==
X-Received: by 10.180.96.66 with SMTP id dq2mr13523866wib.54.1397111582325;
 Wed, 09 Apr 2014 23:33:02 -0700 (PDT)
Received: by 10.194.235.6 with HTTP; Wed, 9 Apr 2014 23:32:42 -0700 (PDT)
In-Reply-To: <CACsJy8BJw3+=vSHzfBYigoK6ejt-DNHJPTcOWS3Nv=zxpF1f7g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246010>

2014-04-10 6:25 GMT+02:00 Duy Nguyen <pclouds@gmail.com>:
> On Thu, Apr 10, 2014 at 2:38 AM, Diego Lago
> <diego.lago.gonzalez@gmail.com> wrote:
>> Commit attributes are custom commit extra headers the user can
>> add to the commit object.
>>
>> The motivation for this patch is that in my company we have a custom
>> continuous integration software that uses a custom formatted commit
>> message (currently in YALM format) to show several information into
>> our CI server front-end.
>>
>> But this YALM-based commit message pollutes the commit object not be=
ing
>> human readable, so a good form of achieve the YALM's behaviour (with=
out
>> using YALM nor any other structured language) is to add custom attri=
butes
>> to the commit object itself.
>>
>> For example, in our CI server we show the risk of the change (that c=
an
>> be low, medium or high); we, as said before, add this information by=
 putting
>> YALM code inside the commit message, but the problem is that this me=
ssage
>> is not human readable.
>
> If the problem is polluting human eyes, wouldn't it be better to make
> git-log to filter it out? For example, we could tell git that all
> fields (in the message body) that start with X- are "rubbish", so
> instead of showing "X-something: base64 stuff...", it shows
> "X-something: <filtered out>" instead? At least people will see that
> this commit carries human-unreadable stuff.
> --
> Duy

Writing this data into the message, the user is forced to write it in
the correct format (I think is better to write key=3Dvalue pairs as an
option instead of writing as message lines with spaces in key, between
key and equal sign and value, and other mistakes). And is simpler to
parse these attributes than the message itself.

And, what if the log message is seen from the command line instead of
our CI front-end? Why the CLI user (for example) should see
information that does not need or does not want to see?

Commit attributes are extra information, not the main information,
hence this patch.

PD: Sorry for the previous message not in plain text.

--=20
Diego Lago Gonz=C3=A1lez
