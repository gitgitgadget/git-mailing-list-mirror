From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH v2 2/2] index-pack: support multithreaded delta resolving
Date: Mon, 12 Mar 2012 19:18:44 +0700
Message-ID: <CACsJy8A5xY54Ls+yWbY3E_aef22Znu4Jygdoppx4_3+DL17zDA@mail.gmail.com>
References: <1331519549-28090-1-git-send-email-pclouds@gmail.com>
 <1331519549-28090-3-git-send-email-pclouds@gmail.com> <87y5r684t6.fsf@thomas.inf.ethz.ch>
 <CACsJy8CyLgKrEAriS-uLU9qG6ahBeQ6qLbvHiLvsbTjMZsMW+g@mail.gmail.com> <87boo282hg.fsf@thomas.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Mon Mar 12 13:19:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S74Dg-0002F5-Sj
	for gcvg-git-2@plane.gmane.org; Mon, 12 Mar 2012 13:19:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753707Ab2CLMTQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 12 Mar 2012 08:19:16 -0400
Received: from mail-wi0-f178.google.com ([209.85.212.178]:34556 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753152Ab2CLMTP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 12 Mar 2012 08:19:15 -0400
Received: by wibhq7 with SMTP id hq7so3628913wib.1
        for <git@vger.kernel.org>; Mon, 12 Mar 2012 05:19:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=LjRIDn7HH98EBnb00QeJu29jICh6IgifgESUIKb0tRg=;
        b=L7Vv3cgx9gd3IPfelKFuO56x7g7Bj3jcNSiuYrmvS9Q4uGz8aCMfNp253U4DG6NmwV
         yK4WLN/g+jtlJHXJ9cwpVpWd1tKcRTQXNA61uZEdpFS2VAmwJlYlsBBev+kXjK4/2kPV
         qKTjV///aG32HJERuGRDY/g4Qx0n+uCxUb0ZacdAnba/Kwqd8OdLr+lwDxQuurIhW09w
         hf5CHLGfsbaMBrZWhbhwcQ+u9l11Eod0FMJ6psEMlIEvEjKqdOL4MDpEwy393NifLLC4
         PinJ0LOt3GKyAw12DoLddqcVcFKDng8yWT5kn1rTy3Y+z+cC9JBdCN7qFYqJDIOvP/SO
         tDyQ==
Received: by 10.180.106.9 with SMTP id gq9mr26761791wib.17.1331554754256; Mon,
 12 Mar 2012 05:19:14 -0700 (PDT)
Received: by 10.223.13.5 with HTTP; Mon, 12 Mar 2012 05:18:44 -0700 (PDT)
In-Reply-To: <87boo282hg.fsf@thomas.inf.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192862>

On Mon, Mar 12, 2012 at 6:47 PM, Thomas Rast <trast@inf.ethz.ch> wrote:
> Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:
>
>> 2012/3/12 Thomas Rast <trast@inf.ethz.ch>:
>>> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com> write=
s:
>>>
>>>> This puts delta resolving on each base on a separate thread, one b=
ase
>>>> cache per thread. Per-thread data is grouped in struct thread_loca=
l.
>>>> When running with nr_threads =3D=3D 1, no pthreads calls are made.=
 The
>>>> system essentially runs in non-thread mode.
>>>
>>> As discussed when we took the git-grep measurements, it may be
>>> interesting to have a way to run 1 thread. =C2=A0Can you put in suc=
h an
>>> option?
>>
>> Sorry I wasn't clear, nr_threads =3D=3D 1 is equivalent to --threads=
=3D1. So
>> yes it supports running in non-thread mode.
>
> Well, in that case I wasn't clear: I meant that there should be a way=
 to
> run with the whole threading machinery enabled, but still only have o=
ne
> thread (doing the work, possibly having another that fills the queue)=
=2E
>
> That allows us to see how big the overhead is.

I really don't want to add overhead, no matter how small it is, to
--threads=3D1. How's GIT_USE_THREADS variable for testing purposes?
Threaded grep can share the same variable if you also like to avoid
threading machinery in git grep --threads=3D1.
--=20
Duy
