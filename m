From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH/RFC] clone: inform the user we are checking out
Date: Mon, 7 May 2012 11:46:53 +0200
Message-ID: <CABPQNSbbH3ULjgYxW6RdH0emrgXoKf1mkiEAm2fR19LsC5q8_w@mail.gmail.com>
References: <1336381787-6484-1-git-send-email-kusmabite@gmail.com>
 <4FA7952C.90702@viscovery.net> <CABPQNSZ+FtMJ1msSmqvROP6YqRGKvz1uz8w1z5mF3YDXZyiPQw@mail.gmail.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Mon May 07 11:47:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SRKXb-0003IF-7N
	for gcvg-git-2@plane.gmane.org; Mon, 07 May 2012 11:47:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756028Ab2EGJrf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 7 May 2012 05:47:35 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:44692 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755668Ab2EGJre convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 7 May 2012 05:47:34 -0400
Received: by dady13 with SMTP id y13so1045523dad.19
        for <git@vger.kernel.org>; Mon, 07 May 2012 02:47:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=6gf61VoqkzrzE1zO0gCK/VFjRB+mXfg0H0RwGiIjLjo=;
        b=XbsY+AUcgfFyky3rmO9k9W9W72+d0nEC1ncVdIfbgJxzMJ8ZvzJYhncU1KjfH7Gj8m
         dQrMwEmfwHgbwZciYmy97EyKwTSqwTWxNc13S0AUci9dL+Zfr9C5VUdc3G5B45Ams2k+
         rA3eeG52wTumxOsXjrSQmzDbb1wE5ORRw5GHC2qCw74Fg40H1x5kHtv6CY9M4CUP6BdU
         zP67NRv3+H1VAOHWgAFJAvlMr6WJCEknBoyv5a4LEYdbcBSD7g51phvjO6ZNExEZQlL3
         lKBAPbi9hcyPpKiMZT0fhQshnVvh8TBPiZ7wNbdWqB8tiMnR52kqOgTqFKkRZM9vKnMB
         f6kQ==
Received: by 10.68.218.163 with SMTP id ph3mr4338573pbc.6.1336384054051; Mon,
 07 May 2012 02:47:34 -0700 (PDT)
Received: by 10.68.73.65 with HTTP; Mon, 7 May 2012 02:46:53 -0700 (PDT)
In-Reply-To: <CABPQNSZ+FtMJ1msSmqvROP6YqRGKvz1uz8w1z5mF3YDXZyiPQw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197251>

On Mon, May 7, 2012 at 11:35 AM, Erik Faye-Lund <kusmabite@gmail.com> w=
rote:
> On Mon, May 7, 2012 at 11:26 AM, Johannes Sixt <j.sixt@viscovery.net>=
 wrote:
>> Am 5/7/2012 11:09, schrieb Erik Faye-Lund:
>>> When cloning a large repository over a local file-system
>> ...
>>> $ git clone some-repo.git some-other-repo
>>> Cloning into 'some-other-repo'... =A0 =A0<happens instantly>
>>> done. =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
<hangs for minutes>
>>> $
>> ...
>>> I asked git
>>> to clone, and it told me it finished, only to hang around for
>>> several minutes while, judging by the output, doing nothing.
>>
>> We have a nice "Checking out files" progress indicator. I wonder why=
 you
>> do not see it.
>>
>
> That's a very good point, I forgot about that one. I'll investigate
> that part. Just to be clear, I'm seeing this problem on version
> 1.7.10.1.457.g8275905 (junio's 'master' as of right now, AFAICT) on
> CentOS. I've built with:
> NO_OPENSSL =3D YesPlease
> NO_CURL =3D YesPlease
>
> "git config -l" does not reveal that any progress related
> config-options are set.
>

It seems progress is only enabled when cloning with the verbose-flag.
This is because check_updates in unpack-trees.c only enabled progress
if both o->update and o->verbose_update is set, and checkout in
builtin/clone.c fills in opts.verbose_update with (option_verbosity >
0).

So that's that mystery. I still think the output without the
verbose-flag is confusing as-is.
