From: Mark Lodato <lodatom@gmail.com>
Subject: Re: RFC: Adding an option to log-like commands to call an external
 command for each revision
Date: Sat, 11 Sep 2010 13:09:04 -0400
Message-ID: <AANLkTikmCA2Cidz1UEDGH5j94_HucvJPGj27g8p_pcEi@mail.gmail.com>
References: <AANLkTikh-KoWuPYE12pVszwduGTBOssKDxqk=4iF6QZT@mail.gmail.com>
 <20100830030819.GA25415@sigill.intra.peff.net> <AANLkTi=WokEQMDc92SoWXPJW67dy0q79WW9RajrBHRx3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>
To: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 11 19:09:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OuTa1-0005Yo-4w
	for gcvg-git-2@lo.gmane.org; Sat, 11 Sep 2010 19:09:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753501Ab0IKRJ0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 11 Sep 2010 13:09:26 -0400
Received: from mail-qy0-f174.google.com ([209.85.216.174]:44907 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753380Ab0IKRJZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 11 Sep 2010 13:09:25 -0400
Received: by qyk36 with SMTP id 36so470476qyk.19
        for <git@vger.kernel.org>; Sat, 11 Sep 2010 10:09:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=8IqOWFp4I3dHloI6a84OQEY6QlaV72tLiVLW/h7jbMw=;
        b=kvLYbV2uC4EC4Opgw7JKFej4JFw8Hq6lA2atJ5wbjfkhIXsgpFYyD+8uBlQ8TeL2Pg
         QEOPUIg7Wco4uZ0AnLU3vlwQogVa+fB/MOdIut0B3a1TuF7BQ6Cwtafdva2Iz3scAx42
         0DOYru1FPCz8WchCu+8yWLX3wIKUBI7Grl9EU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=N9+QJ4gLfr+9YF/vd6txQhMp+IQfRehUTSSlfIzbS0yr3h8KDzuuxm7wREeNmmJ8dF
         S4yF5nymEDhhKXorkKK7sCUBOhNA0txe+OQJuix2DwOl5hDVgmbKC8W6uylGQGaHSpUP
         8BKpEwS5Qhsnb236Uw0sy4/N3qMhTq+5R1FM0=
Received: by 10.224.97.233 with SMTP id m41mr1418335qan.221.1284224964124;
 Sat, 11 Sep 2010 10:09:24 -0700 (PDT)
Received: by 10.229.230.13 with HTTP; Sat, 11 Sep 2010 10:09:04 -0700 (PDT)
In-Reply-To: <AANLkTi=WokEQMDc92SoWXPJW67dy0q79WW9RajrBHRx3@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155995>

On Sat, Sep 11, 2010 at 11:56 AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmaso=
n
<avarab@gmail.com> wrote:
> `On Mon, Aug 30, 2010 at 03:08, Jeff King <peff@peff.net> wrote:
>> I think it is not very Unix-y. We already have many ways to to call =
a
>> command once per commit, including:
>>
>> =C2=A0- for i in `git rev-list "$@"`; do git show $i; done
>>
>> =C2=A0- git rev-list "$@" | xargs -n 1 git show
>>
>> =C2=A0- git log -z "$@" | perl -0ne 'open(LESS, "|less"); print LESS=
'
>>
>> [snip]
>
> Yeah, it's not very Unixy, I just find it so useful that I thought
> there might be interest in adding it to Git. It's easily in the list
> of top 5 git commands that I use.

I also find myself wanting to walk through commits in a particular
order.  In my case, I don't want to run a command per commit, but
instead I want to check them out a la "git bisect." Let's pretend such
a command is called "git walk".  In in my case, I would run:

    git walk start --reverse 49ea7b8..e1ef3c1
    <compile, test, ...>
    git walk next
    <compile, test, ...>
    git walk next
    <...>
    git walk reset

In =C3=86var's case, he would just want:

    git walk start --reverse 49ea7b8..e1ef3c
    git walk run git show
    git walk reset

Or perhaps a shortcut:

    git walk start --reverse 49ea7b8..e1ef3c --run git show

There is already a simple implementation by August Lilleaas [1], but
it would be nice to re-use the git-bisect machinery.

Mark

[1] http://github.com/augustl/binbin/blob/master/git-walk
