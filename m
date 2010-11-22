From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: OK, how should I have done this...
Date: Mon, 22 Nov 2010 17:14:25 +0100
Message-ID: <vpqtyj9xrmm.fsf@bauges.imag.fr>
References: <AANLkTim0_J0i_a0o+z1oCC4mramfUxCGtCg_Y+ab+h+-@mail.gmail.com>
	<vpq4ob9qy6f.fsf@bauges.imag.fr>
	<AANLkTi=uxRfsy2vG+4CBJv8Vhjrr2roVOXeNLvPA+6U+@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>
To: Patrick Doyle <wpdster@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 22 17:18:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PKZ5z-0000ao-0m
	for gcvg-git-2@lo.gmane.org; Mon, 22 Nov 2010 17:18:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751465Ab0KVQSH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 22 Nov 2010 11:18:07 -0500
Received: from imag.imag.fr ([129.88.30.1]:37071 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751001Ab0KVQSG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Nov 2010 11:18:06 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id oAMGEX5R005936
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 22 Nov 2010 17:14:33 +0100 (CET)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1PKZ2A-0007CV-5k; Mon, 22 Nov 2010 17:14:26 +0100
In-Reply-To: <AANLkTi=uxRfsy2vG+4CBJv8Vhjrr2roVOXeNLvPA+6U+@mail.gmail.com> (Patrick Doyle's message of "Mon\, 22 Nov 2010 09\:22\:21 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Mon, 22 Nov 2010 17:14:34 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161900>

Patrick Doyle <wpdster@gmail.com> writes:

> On Mon, Nov 22, 2010 at 8:34 AM, Matthieu Moy
> <Matthieu.Moy@grenoble-inp.fr> wrote:
>> Patrick Doyle <wpdster@gmail.com> writes:
>>
>>> I just checked in modifications to 1/2 dozen or so files in a singl=
e
>>> commit and pushed them to my server.
>>
>>> So now I want to figure out which modification(s) in which file(s)
>>> introduced the problem.
>>
>> 'didn't read all the details of your message, but the way I'd have
>> done this would be with stash --keep-index:
>>
>> (untested)
>>
>> git checkout the-one-that-works # staging area and tree checked out.
>> git reset the-one-that-doesnt =A0 # just change the staging area
>> git add -p
>> # pick some commits
>> git stash --keep-index
>> # run some tests
>> # if test fail then
>> =A0 # happy, "git diff --staged" tells you what.
>> # else
>> =A0 git commit -m "first modification"
>> =A0 git stash pop
>> =A0 # goto the git add -p step.
>> # fi
>
> That looks kinda scary to me.  The last time I played with git-reset,
> I ended up losing(*) the commit at the head of my branch.

In general, you should think twice before doing this kind of surgery.
But :

* The git checkout at the beginning brings you in detached HEAD state,
  so you're not going to damage the branches themselves. The
  intermediate commits you'll do will be unreachable unless you create
  a ref explicitely. So, "git checkout branch-name" will bring you
  back to your branch when you're done.

* Git has this great "reflog" thing, so even if you mess up your
  branch, it's still in the reflog.

* Hopefully, you're working on a local clone, and really important
  stuff have already been pushed to a safer place, so the very worst
  thing that can happen is to start over with a fresh clone.

In my proposal, *if* you end up with a set of small commit that you
prefer over your initial big commit, you can chose to record it in
history (either git update-ref, dangerous if you've already pushed
anything, or git merge, to keep both the big commit and the small ones
in the history).

--=20
Matthieu Moy
http://www-verimag.imag.fr/~moy/
