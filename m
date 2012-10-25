From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 1/3] t9350: point out that refs are not updated correctly
Date: Thu, 25 Oct 2012 07:13:07 +0200
Message-ID: <CAMP44s16mbFgS__NfXAexAS53PgwANK0-cU7wjeu5PYi=aJwEA@mail.gmail.com>
References: <1320535407-4933-1-git-send-email-srabbelier@gmail.com>
	<1320535407-4933-2-git-send-email-srabbelier@gmail.com>
	<CAMP44s1hdZb_7Lv8SEe+MsfC_q-nXsnjJobABFq6eFR_er4TaA@mail.gmail.com>
	<alpine.DEB.1.00.1210242333550.5980@bonsai2>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Dmitry Ivankov <divanorama@gmail.com>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	Eric Herman <eric@freesa.org>,
	Fernando Vezzosi <buccia@repnz.net>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Oct 25 07:13:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TRFkx-000788-1G
	for gcvg-git-2@plane.gmane.org; Thu, 25 Oct 2012 07:13:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753323Ab2JYFNJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Oct 2012 01:13:09 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:61015 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752068Ab2JYFNI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Oct 2012 01:13:08 -0400
Received: by mail-ob0-f174.google.com with SMTP id uo13so1212505obb.19
        for <git@vger.kernel.org>; Wed, 24 Oct 2012 22:13:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=9LeiEGbFmRYkm66RpoeCsyG5nXBPPzyh5M9y0SVjrSA=;
        b=UDMr8rFp6J0h5enB1MRjEp4tPQSF4P4gJGqU25ZafUsq4nGxCqHBfXwrVMb9W2n3Eg
         265icwKn63LZj7M+r/kEsgcD76cnwAvctB4vot5r+tzfWj3MFexN8eogDu9I3jzohENt
         DPOzfsQXvhf8d7/RPUSS8FckzNuit+kWpsWJ0qIZns61VKNL5Ef+443yp0MU6KXLgzgv
         kkBsXowE5SXh0ONfqQdRPmQe6wPFVoUb345NjEs5vUYbrdcqL1d0/w8SWDG5LVSHRrnt
         V3e641fGDGMhIROmVvNGa+uDQCuvElmJfZyqkBYO1V3a/cW0EEtsoTX+a5S/wAyIakiO
         Y/Rw==
Received: by 10.182.38.101 with SMTP id f5mr14918438obk.80.1351141987152; Wed,
 24 Oct 2012 22:13:07 -0700 (PDT)
Received: by 10.60.4.74 with HTTP; Wed, 24 Oct 2012 22:13:07 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.1210242333550.5980@bonsai2>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208342>

On Wed, Oct 24, 2012 at 11:41 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Wed, 24 Oct 2012, Felipe Contreras wrote:
>
>> 2) master..master shouldn't export anything
>
> The underlying issue -- as explained in the thread -- is when you want to
> update master to a commit that another ref already points to. In that case
> no commits need to exported, but the ref needs to be updated nevertheless.
>
> We just wrote the test in the most convenient way, no need to complicate
> things more than necessary.

That test cannot work, and it shouldn't work.

You say you want to 'update master to a commit that another ref
already points to'. What other ref? If you want to update master, this
is what you do:

% git fast-export master

What do you expect 'git fast-export master..master' to export? This?

---
reset refs/heads/master
from $(git rev-parse master)

---

What is a remote helper supposed to do with a SHA-1? Nothing, a git
SHA-1 is useless to say, a mercurial remote helper. To make sense of
it you would need to access the git repository and get the commit
object, and that's defeating the purpose of a fast exporter.

No, that's not what you want.

But at this point there's only one ref in the picture, you said
'update master to a commit that another ref already points to', but
there's only one ref, where is the other ref?

Maybe your test should do this:

% git fast-export foo master

But wait, that actually works, except that the output will be nothing
close what you expected before, we would get all the commits and files
that constitute 'foo', which is actually useful, and what we expect
from fast-export, and in addition, master will be updated to the right
ref.

No, the problem is not only 'update master to a commit that another
ref already points to', but that this happens in two different
commands, and that can only be done with marks, just like the test I
proposed.

The original test doesn't expose the problem we are trying to solve,
and it shouldn't work anyway.

Moreover, what we eventually want to do is support the transport
helpers, so how about you run this:

---
#!/bin/sh

cat > git-remote-foo <<-\EOF
#!/bin/sh

read l
echo $l 1>&2
echo export
echo refspec refs/heads/*:refs/foo/origin/*
test -e /tmp/marks-git && echo *import-marks /tmp/marks-git
echo *export-marks /tmp/marks-git
echo

read l
echo $l 1>&2
echo ? refs/heads/master
echo

read l
echo $l 1>&2

while read l; do
	echo $l 1>&2
	test "$l" == 'done' && exit
done
EOF

chmod +x git-remote-foo

export PATH=$PWD:$PATH

rm -f /tmp/marks-git

(
git init test
cd test
echo Test >> Test
git add --all
git commit -m 'Initial commit'
git branch foo
echo "== master =="
git push foo::test master
echo "== foo =="
git push foo::test foo
)
---

I get this output with my patch:

---
[master (root-commit) b159eff] Initial commit
 1 file changed, 1 insertion(+)
 create mode 100644 Test
== master ==
capabilities
list
export
feature done
blob
mark :1
data 5
Test

reset refs/heads/master
commit refs/heads/master
mark :2
author Felipe Contreras <felipe.contreras@gmail.com> 1351140987 +0200
committer Felipe Contreras <felipe.contreras@gmail.com> 1351140987 +0200
data 15
Initial commit
M 100644 :1 Test

done
== foo ==
capabilities
list
export
feature done
reset refs/heads/foo
from :2

done
---

Hey, did you see that? 'foo' is updated, both 'master' and 'foo' point
to the same object.

What is the problem?

-- 
Felipe Contreras
