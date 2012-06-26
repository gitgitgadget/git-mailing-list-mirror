From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH v2 1/1] index-pack: Disable threading on cygwin
Date: Wed, 27 Jun 2012 00:57:26 +0200
Message-ID: <CABPQNSaqxouhpsHBN5uVCiaRpkuR65uNNn6c30CxEx3zGbJrSg@mail.gmail.com>
References: <4FE9FD34.5020406@ramsay1.demon.co.uk> <7vk3ytc0es.fsf@alter.siamese.dyndns.org>
 <CABPQNSZ7=kqSjXPLior+LXqAt4AzcybOjJ1P8ZLQ+J-9gCgvdw@mail.gmail.com> <7v62adaee3.fsf@alter.siamese.dyndns.org>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Johannes Sixt <j6t@kdbg.org>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 27 00:58:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sjei6-0006O3-Hq
	for gcvg-git-2@plane.gmane.org; Wed, 27 Jun 2012 00:58:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754214Ab2FZW6J convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 26 Jun 2012 18:58:09 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:57671 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751841Ab2FZW6G convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 Jun 2012 18:58:06 -0400
Received: by dady13 with SMTP id y13so532705dad.19
        for <git@vger.kernel.org>; Tue, 26 Jun 2012 15:58:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=XvmAqcKVlfNLJqXQV87Ef9+JBfFUS94KiK0rKax8Jps=;
        b=DwfJ0uJ9j5N88Z7MDdsWezlzW6esg1CMgGsZu2Z6EDpURUuKAdQOajUQSfXKjPRARI
         KLKb5TrrHWV11Xu6/uUtH+W/edRn5MNw+EmnWwU+jX50yOF2Kw27TdedVbiGozo/V1cJ
         1IRcwObOAOH2BP4s1DOJiLseLTu6kaaegOXXQYUfpMqnABwX18nUG8QIMMd2tkPHS23A
         WRoCYSu4hHoBq2kdS9DbbieoQWf4sT4kjrexf+7n0jEgaQkYxE6lgPbpXvR/nQYQsBTl
         VEOSr3dzmneAlUykrYFzQc/A4fS0659CLcixaxtSARlE+n6c0Y6idsw61pdCcHZ0McdO
         +4pQ==
Received: by 10.68.132.166 with SMTP id ov6mr57993108pbb.24.1340751486393;
 Tue, 26 Jun 2012 15:58:06 -0700 (PDT)
Received: by 10.68.40.98 with HTTP; Tue, 26 Jun 2012 15:57:26 -0700 (PDT)
In-Reply-To: <7v62adaee3.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200699>

On Wed, Jun 27, 2012 at 12:37 AM, Junio C Hamano <gitster@pobox.com> wr=
ote:
> Erik Faye-Lund <kusmabite@gmail.com> writes:
>
>> On Tue, Jun 26, 2012 at 9:56 PM, Junio C Hamano <gitster@pobox.com> =
wrote:
>>> Ramsay Jones <ramsay@ramsay1.demon.co.uk> writes:
>>>
>>>> =A0 =A0- renamed FAKE_PREAD_NOT_THREAD_SAFE to NO_THREAD_SAFE_PREA=
D
>>>
>>> Sensible.
>>>
>>>> =A0 =A0- when NO_PREAD, set NO_THREAD_SAFE_PREAD in the Makefile, =
rather
>>>> =A0 =A0 =A0than in git-compat-util.h
>>>
>>> I think it is a bad change. =A0When compat/ pread gets improved to =
be
>>> thread-safe, this will surely be missed.
>>
>> But CAN it be fixed? I don't think it could, at least not without
>> wrapping ALL calls to functions that perform IO on file handles or
>> file descriptors...
>
> Is that relevant? =A0It may be true that both Erik and Junio are not
> being clever enough to come up with a solution offhand. =A0But is tha=
t
> a good justification to go against a sound engineering practice?
>

I didn't really mean to argue for or against this particular solution,
sorry if I was unclear. I'm more interested in actually fixing the
issue without disabling threading ;)

At least on Windows, the CRT actually does take a lock for the
file-handle for all standard IO opterations. Perhaps we can somehow
take it ourselves? I'm not entirely sure how to get hold of it, but it
would probably require quite a deep-dive into the CRT sources...
