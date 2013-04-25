From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 1/9] remote-bzr: trivial cleanups
Date: Thu, 25 Apr 2013 14:20:14 -0500
Message-ID: <CAMP44s2nRHRFY_BRO7+x=CVKgrob78xZCpiV4Hk9sjWB_Q=vng@mail.gmail.com>
References: <1366888849-19607-1-git-send-email-felipe.contreras@gmail.com>
	<1366888849-19607-2-git-send-email-felipe.contreras@gmail.com>
	<CALkWK0meg1FgU=-4MFoFGjpDq_oa9XR_+qeiseR0J85mS71dNg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Christophe Simonis <christophe@kn.gl>,
	Simon Ruderich <simon@ruderich.org>, Max Horn <max@quendi.de>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 25 21:20:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UVRiT-0005mU-Tk
	for gcvg-git-2@plane.gmane.org; Thu, 25 Apr 2013 21:20:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932492Ab3DYTUU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Apr 2013 15:20:20 -0400
Received: from mail-la0-f53.google.com ([209.85.215.53]:54356 "EHLO
	mail-la0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758432Ab3DYTUQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Apr 2013 15:20:16 -0400
Received: by mail-la0-f53.google.com with SMTP id eg20so2920919lab.40
        for <git@vger.kernel.org>; Thu, 25 Apr 2013 12:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=hgFeevR3HBXXMvTco6NQc8IfWJY6Uv/5oqrHGMCS1eE=;
        b=ckos2RQSJjXFsBglr1FjD+Qp3gJcbhzkVJWFiVf3iAwPhgxBEnJuF7/UzHAr0hEANk
         X3cF4CeAztdkr00ljU3AKM/UmuOTwohvKgOghxuPgobZPePGKTvGYar2RC8wD75+3xZE
         DvxFEKab490GRs8Bf90+M+VYa+i8EjXlr1diScidjq1dhwMTWDf4JBH+sUHCzENQ2E/9
         sJLtfmLDURFZM6ZheKcpdsr7hq9ZtOHM4pMrBqKto9zX4iGo3yxzDkE81InUk2SiFwqs
         Mk9Itdu1IA+MQMiu6+015JhG6XDlFUIvzDrWdmSdUNfI2cnbvw55yBDstATaE/cOTWTA
         yM0g==
X-Received: by 10.112.140.100 with SMTP id rf4mr11500260lbb.82.1366917614938;
 Thu, 25 Apr 2013 12:20:14 -0700 (PDT)
Received: by 10.114.83.167 with HTTP; Thu, 25 Apr 2013 12:20:14 -0700 (PDT)
In-Reply-To: <CALkWK0meg1FgU=-4MFoFGjpDq_oa9XR_+qeiseR0J85mS71dNg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222416>

On Thu, Apr 25, 2013 at 1:19 PM, Ramkumar Ramachandra
<artagnon@gmail.com> wrote:
> Felipe Contreras wrote:
>> diff --git a/contrib/remote-helpers/git-remote-bzr b/contrib/remote-helpers/git-remote-bzr
>> index aa7bc97..82bf7c7 100755
>> --- a/contrib/remote-helpers/git-remote-bzr
>> +++ b/contrib/remote-helpers/git-remote-bzr
>> @@ -94,7 +94,7 @@ class Marks:
>>          return self.last_mark
>>
>>      def is_marked(self, rev):
>> -        return self.marks.has_key(rev)
>> +        return rev in self.marks
>
> Why?  Is the new form faster than the older one?

has_key is deprecated.

>> @@ -224,7 +224,7 @@ def export_files(tree, files):
>>              else:
>>                  mode = '100644'
>>
>> -            # is the blog already exported?
>> +            # is the blob already exported?
>
> What is this?  Whitespace?

s/blog/blob/

>> @@ -521,7 +521,7 @@ def c_style_unescape(string):
>>      return string
>>
>>  def parse_commit(parser):
>> -    global marks, blob_marks, bmarks, parsed_refs
>> +    global marks, blob_marks, parsed_refs
>
> How is this trivial?  You just removed one argument.

It's not an argument.

>> @@ -555,7 +555,7 @@ def parse_commit(parser):
>>              mark = int(mark_ref[1:])
>>              f = { 'mode' : m, 'data' : blob_marks[mark] }
>>          elif parser.check('D'):
>> -            t, path = line.split(' ')
>> +            t, path = line.split(' ', 1)
>
> How on earth is this trivial?  It changes the entire meaning!

And nobody has noticed any problem.

>> @@ -643,6 +643,7 @@ def do_export(parser):
>>                  wt = repo.bzrdir.open_workingtree()
>>                  wt.update()
>>          print "ok %s" % ref
>> +
>
> Whitespace?

Aka. trivial.

> I'm outraged by this.  What kind of changes are you pushing to
> remote-hg?  A "trivial cleanups" bundling miscellaneous changes, with
> no commit message?

There are no miscellaneous changes other than the *possible* fix for
deleted files. Which we don't know if it would actually fix anything,
but as far as we know if it's a bug, nobody has seen it, and if it
isn't, it's very unlikely that anybody is relying on the current
behavior.

Plus the change seems to be obviously correct, as it comes from
remote-hg, where somebody appeared to have found a bug.

That being said, I do remember writing an explanation for this in the
commit message:

--
commit ca8c02dc7ea6395b1c864296f2500b718892fab8
Reflog: HEAD@{143} (Felipe Contreras <felipe.contreras@gmail.com>)
Reflog message: rebase -i (fixup): remote-bzr: trivial cleanups
Author: Felipe Contreras <felipe.contreras@gmail.com>
Date:   Tue Apr 23 18:29:49 2013 -0500

    remote-bzr: trivial cleanups

    Mostly from remote-hg. It's possible that there's a fix to delete files
    with spaces.

    Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---

Yeap, there it is. It was just squashed by mistake.

But I do not care that much really. The patch is good either way, if
you don't like it, you go ahead and fix it, because I won't. I have
174 remote-helper related patches in my queue, and nobody benefits
from rambling about a one liner that is obviously correct, not you,
not me, not the users, not the developers.

Junio of course might disagree and drop this patch, but then he would
need to deal with the fallout of possible conflicts. Or he can do the
sensible thing and pick the commit message above. I have real issues
to deal with, and I think the less-than-perfect commit messages in a
*contrib* script that is extremely recent is a small price to pay for
having nice and workable bzr and mercurial remote-helpers as soon as
possible; our users would thank us, and in fact, they already are.

In my hurry to reorganize all the commits of my fourteen remote-helper
branches, I squashed the commit message of a trivial fix into trivial
cleanups. Big whooping deal.

> Why don't you just squash everything into one
> "miscellaneous changes" patch?

Hyperbole much?

Cheers.

-- 
Felipe Contreras
