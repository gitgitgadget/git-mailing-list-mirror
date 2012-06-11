From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Help understanding git checkout behavior
Date: Mon, 11 Jun 2012 11:56:57 -0700
Message-ID: <7vaa097k3q.fsf@alter.siamese.dyndns.org>
References: <CAMUXYmUFbixgA1bVMA46Zzjed1Dwmjv54kWWXyjsuyu904GpTA@mail.gmail.com>
 <20120611202132.Horde.dPo1XHwdC4BP1jcsTvSBaFA@webmail.minatec.grenoble-inp.fr> <CAA3EhH+iD-sS-3Sg4HJDHgs4Deg2=qbCuJD4UwZWtGQsKbV5aA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: konglu@minatec.inpg.fr,
	=?utf-8?Q?Cl=C3=A1udio_Louren=C3=A7o?= <pt.smooke@gmail.com>,
	git@vger.kernel.org, Renato Neves <nevrenato@gmail.com>
To: Leila <muhtasib@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 11 20:57:09 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Se9nW-0000BQ-Gh
	for gcvg-git-2@plane.gmane.org; Mon, 11 Jun 2012 20:57:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752311Ab2FKS5B convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 11 Jun 2012 14:57:01 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48853 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751919Ab2FKS5A convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 11 Jun 2012 14:57:00 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 06A778F4B;
	Mon, 11 Jun 2012 14:57:00 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=tZjbYaT7uTc4
	7uN57y28pQrvEgg=; b=T7a5tuxufKATh5ReBcoSpg4XAXe7JbmV+m52b0Y6iGNl
	QhTLMr09rXVL0dOipowqyQUH9BVM5SuRJt3rb5zoNhunHnYPgLer8q5BydlvnqYl
	fNe+rcEJ23j5AGaoPohvIbwwL2l+sR4OleKhqjXeC2LRrPv5NcRGsNvNn1Tgw28=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=ra84hb
	RH1RbqYLKgXjPEGpEwKqyMx4Yiug8gikUq2MuZgeceWipM7q50Q8ST3x9UpjyaiA
	XwtOAd55gyH+XONlcCNc70L9KEsTvxuF7Xb9wbMsECizodoWmb1h5PmJcsaM6HyK
	IBg3OpZ767DRWI+fxC0uevSbukzFAqVWzsTHY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F0FE08F4A;
	Mon, 11 Jun 2012 14:56:59 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5413C8F48; Mon, 11 Jun 2012
 14:56:59 -0400 (EDT)
In-Reply-To: <CAA3EhH+iD-sS-3Sg4HJDHgs4Deg2=qbCuJD4UwZWtGQsKbV5aA@mail.gmail.com> (Leila's
 message of "Mon, 11 Jun 2012 14:34:01 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 391170CA-B3F7-11E1-A446-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199699>

Leila <muhtasib@gmail.com> writes:

> When you create a branch, it will contain everything committed on the
> branch you created it from at that given point. So if you commit more
> things on the master branch like you have done (after creating b),
> then switch to branch b, they won't appear. This is the correct
> behavior. Does that answer your question?

If there were "git commit" immediately before the "git checkout b"
to check out the branch "b", then something/f1 would be among the
data committed to the branch "master", and it is perfectly fine to
remove it in order to check out branch "b" that does not have the
directory "something" or file in it "something/f1".

But if there is "something/f1" that is not yet committed, the
command should have refused to check out the branch "b", which I
think is what Cl=C3=A1udio is talking about.  It looks like a bug to me=
=2E

>
>
> On Mon, Jun 11, 2012 at 2:21 PM,  <konglu@minatec.inpg.fr> wrote:
>>
>> Cl=C3=A1udio Louren=C3=A7o <pt.smooke@gmail.com> a =C3=A9crit :
>>
>>
>>> The project was going pretty fine, till we start modeling the check=
out
>>> operation. We are with some problems finding useful information abo=
ut
>>> the properties that have to be satisfied when the "git checkout" is
>>> performed. We have concluded that if everything that is on index is
>>> commited then we have no problems making checkout.
>>> The problem is when we have something on index that is not updated
>>> with the last commit. We cannot find a general property that says w=
hen
>>> checkout can be performed. We have even found some files that are
>>> lost, like in this case:
>>>
>>> smooke  teste $ git init
>>> Initialized empty Git repository in /home/smooke/Dropbox/teste/.git=
/
>>> smooke  teste $ touch f
>>> smooke  teste $ echo a > f
>>> smooke  teste $ git add f
>>> smooke  teste $ git commit -m 'first commit'
>>> [master (root-commit) dab04b9] first commit
>>>  1 files changed, 1 insertions(+), 0 deletions(-)
>>>  create mode 100644 f
>>> smooke  teste $ git branch b
>>> smooke  teste $ touch something
>>> smooke  teste $ echo b > something
>>> smooke  teste $ git add something
>>> smooke  teste $ git commit -m 'something added'
>>> [master 9f2b8ad] something added
>>>  1 files changed, 1 insertions(+), 0 deletions(-)
>>>  create mode 100644 something
>>> smooke  teste $ git rm something
>>> rm 'something'
>>> smooke  teste $ mkdir something
>>> smooke  teste $ cd something/
>>> smooke  something $ touch f1
>>> smooke  something $ echo c > f1
>>> smooke  something $ cd ..
>>> smooke  teste $ git add something/f1
>>> smooke  teste $ git checkout b
>>> Switched to branch 'b'
>>> smooke  teste $ ls
>>> f
>>> smooke  teste $ git checkout master
>>> Switched to branch 'master'
>>> smooke  teste $ ls
>>> f  something
>>> smooke  teste $ cat something
>>> b
>>
>>
>> What do you mean by "lost files" ? Are you talking about "something"
>> that doesn't appear on branch 'b' ?
>>
>>
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe git" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
