From: Paul Richards <paul.richards@gmail.com>
Subject: Re: Alter parent ID of existing commit object
Date: Mon, 26 Apr 2010 12:02:09 +0100
Message-ID: <k2za1138db31004260402le42e15fhc791700cbf28b17e@mail.gmail.com>
References: <n2xa1138db31004260313jcd22b2ebw403ca2bd547e784b@mail.gmail.com>
	 <20100426103637.GA8896@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 26 13:02:18 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O6M4v-0007Gb-W9
	for gcvg-git-2@lo.gmane.org; Mon, 26 Apr 2010 13:02:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751789Ab0DZLCM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 26 Apr 2010 07:02:12 -0400
Received: from mail-ww0-f46.google.com ([74.125.82.46]:46736 "EHLO
	mail-ww0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751396Ab0DZLCK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 26 Apr 2010 07:02:10 -0400
Received: by wwb22 with SMTP id 22so306323wwb.19
        for <git@vger.kernel.org>; Mon, 26 Apr 2010 04:02:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=61PckUfAUpe6LgkGsZvq/3iP9bzZzNdgJVNLq0aEXsc=;
        b=jQdMBOURsKzbsOFF6WC3gCIlmfioYex87qiibiHO9XFhPvkXtaxOWaBQ8faOzK48Si
         JGMsX14y+KDl0mS+zdnX2yisT7KE+a2/KReIHqHOpAteq48I0vS5h982hdde1tUW8YEd
         +qWvAtJpAZFOGtahKmICgT+nIL4I0eISbm5Cc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        b=XLlpbBo13JXbLcyNMZz4OYxXH1GbQUen37tZIiLBcZQBoxNw2uGxb/mhDh5hVtKTEe
         i2Uxcm0POlmoIGL8+j4oEJdVPsZMYvwzYYCvSqeBaygAQovkXqOMxVyR6qsDE4kB995a
         0/36U8Eb9cFmX1aTp3wVAv8erHppRUyGaFOYc=
Received: by 10.216.90.145 with SMTP id e17mr4671516wef.106.1272279729144; 
	Mon, 26 Apr 2010 04:02:09 -0700 (PDT)
Received: by 10.216.81.75 with HTTP; Mon, 26 Apr 2010 04:02:09 -0700 (PDT)
In-Reply-To: <20100426103637.GA8896@progeny.tock>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145812>

On 26 April 2010 11:38, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Hi Paul,
>
> Paul Richards wrote:
>
>> Is it possible to edit an old commit object and only alter the ID of
>> the parent commit but otherwise leave all the other information inta=
ct
>> (tree, message, authors, date, etc).
>>
>> I'd expect such a command to return the new hash of the modified com=
mit.
>
> The standard answer to this question is to say =E2=80=9Cuse grafts an=
d
> filter-branch=E2=80=9D. =C2=A0The git-filter-branch(1) man page expla=
ins this
> approach. =C2=A0It is very powerful, but sometimes I do not want to h=
ave
> that much power.
>
> So I will tell a secret: in the scenarios when I wanted something lik=
e
> this (actually, what I have occasionally wanted is to transform a
> single-parent commit into a merge), I did something like the followin=
g:
>
> =C2=A0$ git cat-file commit $rev
> =C2=A0tree dcd2cc4b76f8756423f5c1ab7d2c62d458a8b15f
> =C2=A0parent 5f1e6d9ce35e212708f9adc55e6b9a7e0d296df4
> =C2=A0author Will Palmer <wmpalmer@gmail.com> 1272275407 -0500
> =C2=A0committer Jonathan Nieder <jrnieder@gmail.com> 1272275443 -0500
>
> =C2=A0pretty: Respect --abbrev option
>
> =C2=A0Prior to this, the output of git log -1 --format=3D%h was alway=
s 7
> =C2=A0characters long, without regard to whether --abbrev had been pa=
ssed.
>
> =C2=A0Signed-off-by: Will Palmer <wmpalmer@gmail.com>
> =C2=A0Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
> =C2=A0$ git cat-file commit $rev >tmp
> =C2=A0$ sed -i -e "s/parent .*/parent $(git rev-parse othercommit)/" =
tmp
> =C2=A0$ git hash-object -t commit -w tmp
> =C2=A0ca55c560685284ac6d121939b2cd881f426e7074
>
> Easy. =C2=A0Still, I would be happy to see this packaged in a command=
, so I
> could recommend it in combination with =E2=80=98git replace=E2=80=99 =
to people who are
> scared of sed.
>
> Thanks for bringing it up.
> Jonathan
>


Thanks, this looks perfect.  I knew about "cat-file", but
"hash-object" was the missing command for me here. :)



--=20
Paul Richards
