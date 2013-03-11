From: =?UTF-8?Q?Micha=C5=82_Janiszewski?= <janisozaur@gmail.com>
Subject: Re: A bug or unhandled case
Date: Mon, 11 Mar 2013 17:39:09 +0100
Message-ID: <CABB6UqHgcsx9oK2GHhmwpuhv+T3aMAJk_udw8enkGB3OutzbNg@mail.gmail.com>
References: <CABB6UqEfx=ssbiD1+2HA3AtmSrFeJeg5fmU3z1SKukNsKvd4qw@mail.gmail.com>
 <7vvc8xaoia.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 11 17:40:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UF5lc-0008IO-1r
	for gcvg-git-2@plane.gmane.org; Mon, 11 Mar 2013 17:40:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754250Ab3CKQjb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 11 Mar 2013 12:39:31 -0400
Received: from mail-da0-f53.google.com ([209.85.210.53]:40005 "EHLO
	mail-da0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753530Ab3CKQja convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 11 Mar 2013 12:39:30 -0400
Received: by mail-da0-f53.google.com with SMTP id n34so751614dal.26
        for <git@vger.kernel.org>; Mon, 11 Mar 2013 09:39:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=ZUwzG2gXzZqU5rYNCrA3ZYqgC03qkoQCtu5R+BvcVwg=;
        b=zNnUgmUY3Q36hYPgEo+oGSFyIekELvbGMgyqE1a3FRCZ0RemOCK6pz/FeL6EPjEKVT
         JNuUjLC62bA0KX/8f96bUbu75L3y2vNspPvrok/YdcQguyKftMMC9iFTB1YaUGpS9DNg
         PrnMvFTbCjLmsv39LpNNVgs6X6eYaBnn/6U+jx5OHncl4reAjDLazunMiGd2ZQNtzFFx
         IKD/wQWVGykIPVSuYSawQWEJzA47FHvWRyaNllf+dUdLPJdxumLMZPqOfkXPDCIXtqUD
         GSQxgBawMxo//nPkqJTo7uqPsXuD9ydcqKlIkb/Rnls7CWWjfi/IPNV6CRnqojce4UVJ
         aYtA==
X-Received: by 10.68.48.227 with SMTP id p3mr30111843pbn.34.1363019969425;
 Mon, 11 Mar 2013 09:39:29 -0700 (PDT)
Received: by 10.68.43.225 with HTTP; Mon, 11 Mar 2013 09:39:09 -0700 (PDT)
In-Reply-To: <7vvc8xaoia.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217886>

Hmm, indeed it works. Sorry for the confusion then (and a bit mistaken
commands, but you got them correct).
I wasn't aware of the -r option.

On Mon, Mar 11, 2013 at 5:29 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Micha=C5=82 Janiszewski <janisozaur@gmail.com> writes:
>
>> Hi,
>> I think I've found a bug in git or at least a use case that is not h=
andled.
>> In few words it can be described like this: if you push a remote
>> branch to another remote, which is bare repository, you cannot remov=
e
>> that branch from said bare repository.
>> Here is a recipe how to reproduce that with git 1.8.0:
>> git init foo
>> git init --bare bar.git
>> git init --bare baz.git
>> cd foo
>> echo test > file
>> git commit -am "initial commit"
>
> Nothing added, nothing committed, at this point.
> I'd assume there is "git add file" before this commit.
>
>> git remote add bar ../bar.git
>> git remote add baz ../baz.git
>> git push bar master
>> cd ..
>> git clone bar.git bax
>> cd bax
>> git checkout -b "test_branch"
>> echo evil > file
>> git commit -am "evil commit"
>> git push origin test-branch
>
> error: src refspec test-branch does not match any.
> error: failed to push some refs to '...../bar.git'
>
> I'd assume that is test_branch
>
>> cd ../foo
>> git fetch bar
>> git push baz bar/test_branch
>> cd ../baz.git
>>
>> ###
>> # on that point in baz.git there is only one branch:
>
> Correct.
>
>> # remotes/bar/test_branch 8b96ffe evil commit
>> # trying to remove that branch yields no results:
>> $ git branch -D refs/remotes/bar/test_branch
>
> That is not the way to remove the remote tracking branch test_branch
> you have from remote bar, is it?
>
>         git branch -r -D bar/test_branch
>



--
Michal Janiszewski
