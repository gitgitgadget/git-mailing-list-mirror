From: Anatol Pomozov <anatol.pomozov@gmail.com>
Subject: Re: Removing useless merge commit with "filter-branch"
Date: Tue, 13 Mar 2012 15:27:42 -0700
Message-ID: <CAOMFOmUT+2q7jC9Z1=zFJdBi_KAg=A66yHJNF2LRvjfQcgbdFw@mail.gmail.com>
References: <CAOMFOmWMsXgepY0-ZWFymd9uHSUmbOk66r75qa-Kv5TWx_U=EA@mail.gmail.com>
	<7v62eebri3.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 13 23:27:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S7aC4-0004NG-4U
	for gcvg-git-2@plane.gmane.org; Tue, 13 Mar 2012 23:27:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759113Ab2CMW1o convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 13 Mar 2012 18:27:44 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:37083 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753227Ab2CMW1n convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 13 Mar 2012 18:27:43 -0400
Received: by ghrr11 with SMTP id r11so1136248ghr.19
        for <git@vger.kernel.org>; Tue, 13 Mar 2012 15:27:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=HlycbxoUFR6DC9K02DphG+zhvscKYr+MdaTXf4O6u68=;
        b=af8sAH3tx0Y5J3d2ovNyCcjvZtYOzQQOj7LwgKNrRVTCcogzQuunwYDdNxkJohRIaK
         zIW9/PKNDC5UuKpHRHhodRuPARJ1lbfmQ6PahvKRxlPZZ7xF0h99+Yr4H+v4xvfury1M
         HtnumprPlCr87i5Q2dhKTIsNzBEI76+mvRu/W0S8nLrUv9ELqsqI07s/DgxDdrGoGTmI
         oWXcCYs/Aw0nt8lMPGaAaVXDgpJ6If2W30Of/NsFJEbVn3L98AwseY7d7HjHnJt4niPl
         FA1Wrcs9c9DD0NSYRm4oDxQTcyFiCQGU9Hvjd4NlC5ZM7JpTK2EcXc05iW8FhYBQBgtf
         R+EQ==
Received: by 10.236.78.201 with SMTP id g49mr356355yhe.33.1331677662650; Tue,
 13 Mar 2012 15:27:42 -0700 (PDT)
Received: by 10.100.173.17 with HTTP; Tue, 13 Mar 2012 15:27:42 -0700 (PDT)
In-Reply-To: <7v62eebri3.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193076>

Hi

On Thu, Mar 8, 2012 at 3:30 PM, Junio C Hamano <gitster@pobox.com> wrot=
e:
> Anatol Pomozov <anatol.pomozov@gmail.com> writes:
>
>> |
>> o =C2=A0 =C2=A0 =C2=A0- merge commit that previously merged feature =
X
>> |\
>> | \
>> | =C2=A0\
>> o =C2=A0| =C2=A0 - real commit
>> | =C2=A0 |
>> | =C2=A0/
>> |/
>> |
>
> It is unclear how many commits are drawn in the above picture and
> what "feature X" is about in the above picture. =C2=A0Care to redraw =
the
> commit DAG to explain what you are trying to do a bit better?
>
> The way I read it is that you start from a history like this (note
> that when we draw an ascii art history we often write it sideways,
> time flows from left to right):
>
> =C2=A0 =C2=A0---A-----B-----M---
> =C2=A0 =C2=A0 =C2=A0 =C2=A0\ =C2=A0 =C2=A0 =C2=A0 =C2=A0 /
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 C-------D
>
> where a side branch to implement "feature X" that has C and D forked
> at A, and it was merged at M after somebody else committed B on the
> mainline. =C2=A0When you filtered out some parts of the tree, it turn=
s
> out that C and D are totally unintereseting because their changes
> touch parts outside of your interest, i.e. the history is:
>
> =C2=A0 =C2=A0---A-----B-----M---
> =C2=A0 =C2=A0 =C2=A0 =C2=A0\ =C2=A0 =C2=A0 =C2=A0 =C2=A0 /
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 o-------o
>
> where 'o' are now no-op.
>
> Is that what you are talking about?

Yes, in fact --prune-empty flag removes empty commits so the history lo=
oks like

-----A-------B-------M--------
       \               /
        --------------


So M is a merge that has 2 parents A and B. I would like to remove
this merge M and leave the history as

-----A-----B-----

as only these commits have changes in my library that I am trying to ex=
tract.

I think some trickery with "git filter-branch --parent-filter" should h=
elp here.

=46irst one runs filter-branch with --parent-filter and removes useless
parents from merges (in this example with will be parent A---M), this
converts such merges to regular empty commits

then run filter-branch one more time with --prune-empty - it removes
empty commits.
>
> I think "log --simplify-merges A..M -- path" may already has logic
> that deals with this, so it may help if you study what it does and
> how it does what it does.
