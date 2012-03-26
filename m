From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: Re: [PATCH 0/4] grep: add more information to hunk separators
Date: Mon, 26 Mar 2012 20:48:12 +0200
Message-ID: <CAKPyHN25miyA6A0p3GMX9XrxnqLu0C9H6VjjCy_HvKfqXo4B2g@mail.gmail.com>
References: <1332729705-9283-1-git-send-email-lodatom@gmail.com>
	<7vr4wgq6zm.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Mark Lodato <lodatom@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 26 20:48:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SCExx-0005ER-Tn
	for gcvg-git-2@plane.gmane.org; Mon, 26 Mar 2012 20:48:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933306Ab2CZSsQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 26 Mar 2012 14:48:16 -0400
Received: from mail-vx0-f174.google.com ([209.85.220.174]:39261 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933059Ab2CZSsN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 26 Mar 2012 14:48:13 -0400
Received: by vcqp1 with SMTP id p1so4592243vcq.19
        for <git@vger.kernel.org>; Mon, 26 Mar 2012 11:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=QF/UCfS7hPTdnT0G0aDDHh2eFBN9jUm3LkL8GaJXzHI=;
        b=CG2wB+n5kF2xPTOKp70C/VyCJtMzha5+BAoAXzkMPWU5zJ5gddWYDGkuhrpQxq2Tv3
         5dpt9iqghZzRenMkIPQRlLc7moh9RlhXWzEt+7t7A76YbXVJhnhWgT9sy7nP26PWQlPG
         o9vn/vDHCftgaE59TBxWXzTI0/UhoXsRQy++SUIA4Qr8D9FqrdVYfNitEWv4E+UohA33
         yvG6l6LXh26Q5Ad+x8sMSiwdD3tv9qx0aau2lYBerbbR3NvLNEUux/LjBLwNtOP32KDB
         HVv63qqm4rciVk3ECf7vwqwJE6hjTXzuDYbFWHSqoRlQDi2+/eXDBuu0PSc1oJn94A1h
         139w==
Received: by 10.220.228.200 with SMTP id jf8mr10581065vcb.0.1332787692729;
 Mon, 26 Mar 2012 11:48:12 -0700 (PDT)
Received: by 10.52.186.8 with HTTP; Mon, 26 Mar 2012 11:48:12 -0700 (PDT)
In-Reply-To: <7vr4wgq6zm.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193954>

On Mon, Mar 26, 2012 at 07:14, Junio C Hamano <gitster@pobox.com> wrote=
:
> Mark Lodato <lodatom@gmail.com> writes:
>
>> Originally, I had envisioned also moving the function name (`-p') to=
 the hunk
>> header, similar to the diff context line. =C2=A0For example:
>>
>> =C2=A0 =C2=A0 -- git.c:570 -- int main(int argc, char argv)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 printf("usage: %s\n\n", git_usage_string);
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 list_common_cmds_help();
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 printf("\n%s\n", git_more_info_string);
>>
>> After implementing this feature, I was not happy with the result and
>> subsequently removed it. =C2=A0To me, the output was too cluttered a=
nd the line
>> number was ambigous. =C2=A0For example, in the above, it is not obvi=
ous to me that
>> line 570 is the "printf" line and not the "int main" line. =C2=A0Sti=
ll, if you
>> would like to see the patch to implement this feature, please let me=
 know.
>
> The worst part of all of the above is that the output becomes utterly
> ambiguous and the reader cannot tell if "-- git.c..." came because th=
e
> file had such a line that begin with two dashes in it and grep found =
it,
> or it is your output format embellishment. It is obvious that these a=
re
> not meant to be machine parseable, but if the goal is to make the out=
put
> more useful to the humans, then it may be a better approach to come u=
p
> with a front end that reads our machine readable output and shows out=
put
> with its own embellishments. You could even make it an interactive fr=
ont
> end.

=46YI, I once posted a git-gui grep prototype:

<1289770869-11665-1-git-send-email-bert.wesarg@googlemail.com>

I have since added it to git-gui, see bw/master~2 'git-gui: add grep
tab' in http://repo.or.cz/w/git-gui/bertw.git.

Bert

>
> In other words, I am not yet convinced this belongs to "git grep" pro=
per.
>
>
