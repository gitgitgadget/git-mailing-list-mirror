From: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
Subject: Re: git status: small difference between stating whole repository and
 small subdirectory
Date: Fri, 10 Feb 2012 17:18:55 +0100
Message-ID: <CAA01Csp6_9fP2rg4104UWUXwOxZmUVdQNDAaBe6fRou6agBz6g@mail.gmail.com>
References: <CAA01Csr8FbvQ8uFvxX8_6i-hysin6JuaifVVC-yoLyoT0N5F4Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Feb 10 17:19:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RvtBd-0003Js-NQ
	for gcvg-git-2@plane.gmane.org; Fri, 10 Feb 2012 17:19:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756911Ab2BJQS4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 10 Feb 2012 11:18:56 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:50514 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754568Ab2BJQSz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 10 Feb 2012 11:18:55 -0500
Received: by iacb35 with SMTP id b35so459666iac.19
        for <git@vger.kernel.org>; Fri, 10 Feb 2012 08:18:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=sR9XDOznwJs6ICydqUqE3MHVEKaMCvGwrIW+SqOvjD8=;
        b=q7vhDNapNaJyGiq3OVmBwB7OVaflcYbfueF1Yuy4t9w+63V4HC8L2q9yvCHCAbUNpT
         ZNZTzlKowAvRg1as5y7PVd84qksaG4//XVjM5EGRubLRidE0j6w4Hci72WGh6yNMTgbO
         FGEWHH3rnryIZ50hAoorYPIcyELh5YiBuczt4=
Received: by 10.42.145.131 with SMTP id f3mr11622941icv.8.1328890735377; Fri,
 10 Feb 2012 08:18:55 -0800 (PST)
Received: by 10.50.46.33 with HTTP; Fri, 10 Feb 2012 08:18:55 -0800 (PST)
In-Reply-To: <CAA01Csr8FbvQ8uFvxX8_6i-hysin6JuaifVVC-yoLyoT0N5F4Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190414>

On Fri, Feb 10, 2012 at 10:42 AM, Piotr Krukowiecki
<piotr.krukowiecki@gmail.com> wrote:
> Hi,
>
> I compared stating whole tree vs one small subdirectory, and I
> expected that for the subdirectory status will be very very fast.
> After all, it has only few files to stat. But it's not fast. Why?
>
>
> With cold cache (echo 3 | sudo tee /proc/sys/vm/drop_caches):
>
> $ time git status =A0 =A0> /dev/null
> real =A0 =A00m41.670s
> user =A0 =A00m0.980s
> sys =A0 =A0 0m2.908s
>
> $ time git status -- src/.../somedir =A0 > /dev/null
> real =A0 =A00m17.380s
> user =A0 =A00m0.748s
> sys =A0 =A0 0m0.328s
>
>
> With warm cache:
>
> $ time git status =A0 =A0> /dev/null
> real =A0 =A00m0.792s
> user =A0 =A00m0.404s
> sys =A0 =A0 0m0.384s
>
> $ time git status -- src/.../somedir =A0 > /dev/null
> real =A0 =A00m0.335s
> user =A0 =A00m0.288s
> sys =A0 =A0 0m0.048s
>
>
> Repository/dir stats:
>
> $ find * -type f | wc -l
> 127189
> $ du -shc * | grep total
> 2.2G =A0 =A0total
>
> $ find src/.../somedir -type f | wc -l
> 55
> $ du -shc src/.../somedir | grep total
> 224K =A0 =A0total
>
>
> $ git --version
> git version 1.7.9.rc0.10.gbeecc

I can't reproduce this behavior at the moment. 'status' on the
directory takes about 1.5s instead of 17s. status on whole repository
takes 27s.
This is my work repository, so it was changed today.

I'll get back to you when I can reproduce the problem again...


--=20
Piotr Krukowiecki
