From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: large files and low memory
Date: Tue, 5 Oct 2010 18:55:53 +0700
Message-ID: <AANLkTi=ni_21uP7oPrmB3obMscg0o9Z=uawkM2PoxWxT@mail.gmail.com>
References: <20101004092046.GA4382@nibiru.local> <AANLkTimbdrAqoWMxiteT5zNYmwHp8M698BEv1FLuiAxx@mail.gmail.com>
 <4CAA1BEB.3050908@workspacewhiz.com> <AANLkTi=nzyRgiBL07f2oeyjdUc8XnaKbJEJ+k8_g9rQ1@mail.gmail.com>
 <20101005005902.GC2768@nibiru.local> <20101005074144.GA22564@nibiru.local>
 <vpqpqvpf4qm.fsf@bauges.imag.fr> <20101005081700.GB22564@nibiru.local>
 <AANLkTin+i7VZApDRmairgpMth4MzPoDF=oHt-UHCt98E@mail.gmail.com> <vpqbp78x418.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Alex Riesen <raa.lkml@gmail.com>, weigelt@metux.de,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Oct 05 13:56:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P3684-0003ZB-V6
	for gcvg-git-2@lo.gmane.org; Tue, 05 Oct 2010 13:56:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753047Ab0JEL4P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Oct 2010 07:56:15 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:57356 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751822Ab0JEL4O (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Oct 2010 07:56:14 -0400
Received: by wyb28 with SMTP id 28so5917002wyb.19
        for <git@vger.kernel.org>; Tue, 05 Oct 2010 04:56:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=Z1xypMjQ6RAy5EyKwl1ZJn6Xgg/ohCHNpelsknTQ+Js=;
        b=p8Ek95Apuk975iTRX1DzvPebCT7SkAh07Heb+n3jHrWPsLcScqhHuf4feeOKmZdMv6
         WiAUVjpVZAKgz0G/Ks4x+dRzmpNtm1y9rvbayYzfROzcCMy2MPPuN7LPGZL81kp/5pv7
         Olgn6NP044G0ZiLc4SmQY9BsWp1PFPY8GQ1S4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=jNQqb4HEx67KqR5AOb8YFIteoRJ3BFvzjiDUp9v7Ix8MpjwatyX4xoywlrZybGHu7j
         5sCv0TZrqyx8H6OrODoi6snS456VTrx9rGjeEkrz0PZqlPS9MotmBv7hJs9MY4K1G9yO
         4G/C1sO7PywvKz3rNgCB5wcDHteRd22lEOOtk=
Received: by 10.216.174.69 with SMTP id w47mr9096160wel.25.1286279773653; Tue,
 05 Oct 2010 04:56:13 -0700 (PDT)
Received: by 10.216.153.195 with HTTP; Tue, 5 Oct 2010 04:55:53 -0700 (PDT)
In-Reply-To: <vpqbp78x418.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158191>

On Tue, Oct 5, 2010 at 6:38 PM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Alex Riesen <raa.lkml@gmail.com> writes:
>
>> On Tue, Oct 5, 2010 at 10:17, Enrico Weigelt <weigelt@metux.de> wrote:
>>> * Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> wrote:
>>>
>>>> git commit will show what's being commited (the output of "git commit
>>>> --dry-run") in your editor, hence it needs to compute that.
>>>
>>> hmm, is there any way to get around this ?
>>>
>>
>> Try "git commit -q -uno". This should skip creation of summary in the
>> commit message and lookup for untracked files.
>
> To avoid including the summary, the option would be --no-status (-q
> makes commit less verbose in stdout, not in COMMIT_EDITMSG).
>
> But
>
> strace -fe lstat64 git commit -uno --no-status -q
>
> still shows lstat64 for each tracked file in my working tree (even
> when using -m to avoid launching the editor). I don't know if this is
> intended, or just that nobody cared enough to optimize this.

I assume you do git-commit with no index modification at all. The
index refresh part dated back in 2888605 (builtin-commit: fix
partial-commit support - 2007-11-18). Commit message does not tell why
index refresh is needed (for summary stat maybe?). If so, then we can
skip refreshing if -q is given.
-- 
Duy
