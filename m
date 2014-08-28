From: Christian Couder <christian.couder@gmail.com>
Subject: Re: Git Bug Report: bisect run failed to locate the right commit,
 detail testing
Date: Thu, 28 Aug 2014 14:44:21 +0200
Message-ID: <CAP8UFD1KXC7KzV46VJZ=PY4SN39uEtDvJKm0k3VwCp0Rvp64aQ@mail.gmail.com>
References: <C40A01C66E914D4EB90E1B40564B0E56CBFE30C9@MBOX2-4.ntu.internal>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: =?UTF-8?B?5p2O56WQ5qOg?= <r01942008@ntu.edu.tw>
X-From: git-owner@vger.kernel.org Thu Aug 28 14:44:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XMz4D-0005GW-0z
	for gcvg-git-2@plane.gmane.org; Thu, 28 Aug 2014 14:44:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751222AbaH1MoX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 28 Aug 2014 08:44:23 -0400
Received: from mail-ie0-f177.google.com ([209.85.223.177]:54559 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751026AbaH1MoV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Aug 2014 08:44:21 -0400
Received: by mail-ie0-f177.google.com with SMTP id tp5so856283ieb.22
        for <git@vger.kernel.org>; Thu, 28 Aug 2014 05:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=yT9n9bVQw5zGOsCb9qVtTYg+6DZNmmv7kS77fsBqvaU=;
        b=uqgB8ICMRNAAmJiArLyzJERASAHkjsHhhiTXrZvwXiSwluI3Uhw53c3XLLFcfbyzNY
         UbiGGhlyerzkgj6mb3wwR4jn6EuSCAw0l9U2nIqDnpGgrFIUFtkzudsv4b6xaybppfa/
         ZSHhRR6vKm+0dkSpf6BcLSOjv/1/9cIl0ZTZkYwqHk+yWrh7GSbj3TESJkoVso+uYsHR
         mQZO/HHR7OqdhUq5F0J9LeJhoeRySpGoOHtyIJ8YL/DW0NV4WnMUL/V2UBwZqiq4nxPz
         32OLAnnnXH3Evh4B9jnhpFzmPb2ojuWiFYAGZQ9T1Rs/rxtyubpXIuaqL79BmhlSDYaB
         IqGQ==
X-Received: by 10.50.111.112 with SMTP id ih16mr37212252igb.30.1409229861140;
 Thu, 28 Aug 2014 05:44:21 -0700 (PDT)
Received: by 10.50.212.3 with HTTP; Thu, 28 Aug 2014 05:44:21 -0700 (PDT)
In-Reply-To: <C40A01C66E914D4EB90E1B40564B0E56CBFE30C9@MBOX2-4.ntu.internal>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256081>

Hi,

On Thu, Aug 28, 2014 at 3:49 AM, =E6=9D=8E=E7=A5=90=E6=A3=A0 <r01942008=
@ntu.edu.tw> wrote:
> Dear git developers:
>
> Allow me to describe the testing situation more detail:
>
> First the testing repository is in
> https://github.com/gawel/pyquery
> my git version is 1.9.2 running on Archlinux 3.14.2
>
> I try to track issue #74(which is closed now)
> It give result False/True in version 1.2.8(good), and result False/Fa=
lse in version 1.2.9(bad).
>
> The testing script are manualscript.py and autoscript.py
> Both of them implement the test case describe in issue #74.
> Th only difference is that autoscript.py call sys.exit() to return th=
e testing value.
>
> First we test with git-bisect manually with manualscript.py:
> The testing result is shown in 'bisectmanual_manualscript'
>
> Then we test with git-bisect manually with autoscript.py
> This time we echo $? every time we execute autoscript.py, and the tes=
ting result is shown in 'bisectmanual_autoscript'
>
> In both situation the script give the same result, and the return val=
ue of autoscript.py is correct, too.
>
> However, if we use git-bisect-run with autoscript.py, it will show a =
different result. The testing result is shown in 'bisectrun'.
> The log shows that autoscript.py output False/False all the way.
> As Mr. Couder said, there is some checkout commit that autoscript.py =
and manualscript.py give different result, for example commit d22159bb3=
2510e9eacf6c5c2408a79792e99fe76.
> If I checkout this commit outside bisect state and run manualscript.p=
y and autoscript.py, they both give False/True result.
> So, I guess there is some problem in the checkout procedure in bisect=
-run, so the commit didn't successfully checkout.

I don't think so.

I tried to run the following command many times in a row:

for rev in bc1b16509cec70de7a32354026443fca777f4d7d
b81a9e8a2b0d48ec0c64d6de14293dd4a680a20b
d22159bb32510e9eacf6c5c2408a79792e99fe76; do git checkout $rev; python
-m pyquery.autoscript; done

And here is the log:

$ for rev in bc1b16509cec70de7a32354026443fca777f4d7d
b81a9e8a2b0d48ec0c64d6de14293dd4a680a20b
d22159bb32510e9eacf6c5c2408a79792e99fe76; do git checkout $rev; python
-m pyquery.autoscript; done
Note: checking out 'bc1b16509cec70de7a32354026443fca777f4d7d'.

You are in 'detached HEAD' state. You can look around, make experimenta=
l
changes and commit them, and you can discard any commits you make in th=
is
state without impacting any branches by performing another checkout.

If you want to create a new branch to retain commits you create, you ma=
y
do so (now or later) by using -b with the checkout command again. Examp=
le:

  git checkout -b new_branch_name

HEAD is now at bc1b165... created a .gitignore file(which is almost a
copy of .hgignore with some minor changes and comments)
=46alse
=46alse
Previous HEAD position was bc1b165... created a .gitignore file(which
is almost a copy of .hgignore with some minor changes and comments)
HEAD is now at b81a9e8... fixed issue #9
=46alse
=46alse
Previous HEAD position was b81a9e8... fixed issue #9
HEAD is now at d22159b... test pseudo classes; documentation effort
=46alse
True
$ for rev in bc1b16509cec70de7a32354026443fca777f4d7d
b81a9e8a2b0d48ec0c64d6de14293dd4a680a20b
d22159bb32510e9eacf6c5c2408a79792e99fe76; do git checkout $rev; python
-m pyquery.autoscript; done
Previous HEAD position was d22159b... test pseudo classes; documentatio=
n effort
HEAD is now at bc1b165... created a .gitignore file(which is almost a
copy of .hgignore with some minor changes and comments)
=46alse
=46alse
Previous HEAD position was bc1b165... created a .gitignore file(which
is almost a copy of .hgignore with some minor changes and comments)
HEAD is now at b81a9e8... fixed issue #9
=46alse
=46alse
Previous HEAD position was b81a9e8... fixed issue #9
HEAD is now at d22159b... test pseudo classes; documentation effort
=46alse
True
$ for rev in bc1b16509cec70de7a32354026443fca777f4d7d
b81a9e8a2b0d48ec0c64d6de14293dd4a680a20b
d22159bb32510e9eacf6c5c2408a79792e99fe76; do git checkout $rev; python
-m pyquery.autoscript; done
Previous HEAD position was d22159b... test pseudo classes; documentatio=
n effort
HEAD is now at bc1b165... created a .gitignore file(which is almost a
copy of .hgignore with some minor changes and comments)
=46alse
=46alse
Previous HEAD position was bc1b165... created a .gitignore file(which
is almost a copy of .hgignore with some minor changes and comments)
HEAD is now at b81a9e8... fixed issue #9
=46alse
=46alse
Previous HEAD position was b81a9e8... fixed issue #9
HEAD is now at d22159b... test pseudo classes; documentation effort
=46alse
=46alse
$ for rev in bc1b16509cec70de7a32354026443fca777f4d7d
b81a9e8a2b0d48ec0c64d6de14293dd4a680a20b
d22159bb32510e9eacf6c5c2408a79792e99fe76; do git checkout $rev; python
-m pyquery.autoscript; done
Previous HEAD position was d22159b... test pseudo classes; documentatio=
n effort
HEAD is now at bc1b165... created a .gitignore file(which is almost a
copy of .hgignore with some minor changes and comments)
=46alse
=46alse
Previous HEAD position was bc1b165... created a .gitignore file(which
is almost a copy of .hgignore with some minor changes and comments)
HEAD is now at b81a9e8... fixed issue #9
=46alse
=46alse
Previous HEAD position was b81a9e8... fixed issue #9
HEAD is now at d22159b... test pseudo classes; documentation effort
=46alse
True
$ for rev in bc1b16509cec70de7a32354026443fca777f4d7d
b81a9e8a2b0d48ec0c64d6de14293dd4a680a20b
d22159bb32510e9eacf6c5c2408a79792e99fe76; do git checkout $rev; python
-m pyquery.autoscript; done
Previous HEAD position was d22159b... test pseudo classes; documentatio=
n effort
HEAD is now at bc1b165... created a .gitignore file(which is almost a
copy of .hgignore with some minor changes and comments)
=46alse
=46alse
Previous HEAD position was bc1b165... created a .gitignore file(which
is almost a copy of .hgignore with some minor changes and comments)
HEAD is now at b81a9e8... fixed issue #9
=46alse
=46alse
Previous HEAD position was b81a9e8... fixed issue #9
HEAD is now at d22159b... test pseudo classes; documentation effort
=46alse
=46alse

As you can see the result of running the autoscript.py on commit
d22159b is sometimes "False False" and sometimes "False True".

Bisecting cannot work properly if the result is not stable.

> ps. I found this time the bisect run give me another version of outpu=
t compared to the last version I sent to everybody OAO. That is weird.

Yeah but I doubt it is a git bisect problem or a git checkout problem.

It looks like it is a cleanup problem, because it looks much more stabl=
e with:

for rev in bc1b16509cec70de7a32354026443fca777f4d7d
b81a9e8a2b0d48ec0c64d6de14293dd4a680a20b
d22159bb32510e9eacf6c5c2408a79792e99fe76; do git checkout $rev; git
clean -dfx; cp ../testresult/autoscript.py pyquery/; python -m
pyquery.autoscript; done

Best,
Christian.
