From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH] checkout: do not switch branch during a rebase unless -f
 is given
Date: Tue, 9 Nov 2010 20:40:06 +0700
Message-ID: <AANLkTinKNF6OEX=k1aepD-Zrm2_4GzHaB+SVHdfTMG-j@mail.gmail.com>
References: <1285649564-24737-1-git-send-email-pclouds@gmail.com>
 <1285649702-24773-1-git-send-email-pclouds@gmail.com> <AANLkTinUudOXmhKW-+rkcpzb-VNnSBLZwGZcjrS6UdMu@mail.gmail.com>
 <AANLkTin19PREB3B68s+ejsgtXwe3CBxZF-caCvRp4UXv@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?RnLDqWTDqXJpYyBCcmnDqHJl?= <fbriere@fbriere.net>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Christian Couder <chriscool@tuxfamily.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 09 14:40:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PFoR9-0005Qn-N2
	for gcvg-git-2@lo.gmane.org; Tue, 09 Nov 2010 14:40:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752866Ab0KINka convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 9 Nov 2010 08:40:30 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:63015 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751954Ab0KINk3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 9 Nov 2010 08:40:29 -0500
Received: by wwb34 with SMTP id 34so10124wwb.1
        for <git@vger.kernel.org>; Tue, 09 Nov 2010 05:40:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=dWZ/32vdJXnVdhVM5U2Qsd/RajA4OOeUNmwomPm5vvw=;
        b=ghG1NIjGLridL5GPn2xwHvkGalYrX9Ix6NZfvZBS6V7ZA2TUuLkQBSY/P0JPYD+95e
         oZUnmM51pPHopPWHymEiNnro8mCCT3Os74DXMvYH1t5Zrv4wpYNJE/nLxR5wZBFYqZkY
         o/GkpyKpRYaXmM0SeYis2qzo7FhZzQS3OLwa0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=RWwPex6vYgaaCPv9+qsuiE6Xha+hD56FgZVlUF4RQLT6eLSn3uWRC+qVDQLcWY5r50
         wcY0f/Q1nwrudBLgBpO44919E/9ME/ROVxGgASi+7re8wRp3kXZQ6bGmgUdoMOclZfg/
         Xpd96qI7HfQfHGBUfqk4lK878WKaC5XA0fLoo=
Received: by 10.216.47.19 with SMTP id s19mr809675web.56.1289310027131; Tue,
 09 Nov 2010 05:40:27 -0800 (PST)
Received: by 10.216.172.199 with HTTP; Tue, 9 Nov 2010 05:40:06 -0800 (PST)
In-Reply-To: <AANLkTin19PREB3B68s+ejsgtXwe3CBxZF-caCvRp4UXv@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161046>

2010/9/28 Nguyen Thai Ngoc Duy <pclouds@gmail.com>:
>> Even rebase --interactive uses checkout from time to time:
>>
>> =C2=A0- for preserving merges
>> =C2=A0- to move to the correct branch in response to "git rebase -i
>> <upstream> <branch>"
>> =C2=A0- to move to the target in "git rebase -i --onto <new base> <u=
pstream>"
>>
>> Unfortunately I do not have any good advice. Would it make sense to
>>
>> =C2=A0- first, change these call sites in git to use checkout -f
>> =C2=A0- teach checkout to warn (without erroring out) to give people=
 time
>> to change their scripts
>> =C2=A0- warn loudly about the upcoming change in the release notes
>> =C2=A0- later, change checkout to error out when -f is not supplied
>>
>> or am I being too paranoid?
>
> No. But I don't like the idea of making scripts use "checkout -f". My
> intention was to stop users from doing that, not scripts. Putting "-f=
"
> everywhere might have more negative side effects.
>
> Maybe adding "--porcelain" to checkout first, updating scripts to use
> it, then only check for rebase/bisect/am when --porcelain is missing.

Another approach is to let checkout work as usual, but refuse update re=
fs:

 - after rebase starts, HEAD can only be updated either by rebase, or
any commands that keep HEAD a headless ref.
 - the branch being rebased is locked. No commands but rebase can updat=
e it.

I think the second point is good for all interactive commands like
rebase. Create a .lock file with a signature inside (e.g. command
name). If update_ref() callers do not give correct signature, refuse
to update.
--=20
Duy
