From: "Nathan W. Panike" <nathan.panike@gmail.com>
Subject: Re: [PATCH/RFC] Add a --bouquet option to git rev-list
Date: Tue, 1 Dec 2009 11:31:56 -0600
Message-ID: <d77df1110912010931l40472723v80ad675a92d23fa3@mail.gmail.com>
References: <4b143a9c.c401be0a.364f.ffffba5b@mx.google.com>
	 <4B14CF47.5020808@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Dec 01 18:32:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NFWa4-0004GV-Gj
	for gcvg-git-2@lo.gmane.org; Tue, 01 Dec 2009 18:32:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753675AbZLARbv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 1 Dec 2009 12:31:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753644AbZLARbu
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Dec 2009 12:31:50 -0500
Received: from mail-yw0-f182.google.com ([209.85.211.182]:40065 "EHLO
	mail-yw0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752932AbZLARbu convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 1 Dec 2009 12:31:50 -0500
Received: by ywh12 with SMTP id 12so5381736ywh.21
        for <git@vger.kernel.org>; Tue, 01 Dec 2009 09:31:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=G3kWzAXzW/ZQK7kFBeGTYnriAjIMuA3y2t1lZM2G5Qk=;
        b=mQqbSgqHriBL7QxOSBsg/3YuHH6vKjn0MiFHUqEXjcR30v503DRBO13RKd/tEUOm2U
         tAem0C5DpTFTOnai+fBvXUkMd3IQ5K8IhIoQdbW4viEkOQctf6rrVmDJBJRSKdCgmh3c
         fvGL61ovdmwWeVWjyqT7kSGKunNiWIzVd+Fag=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=XwOxOFV20FxWCh+7x6tF0hl/QM4IRR1tp34vhUg5YEy3guajErsYsChgxCCm2TyBIj
         BkLBA4+/TrKUZbsAKD8VDvUfYN6qbjVDX7zUzlfrPLpkxP1QC9z6FhgimsZVKpKASzJb
         Iovt3PdiYtrwFreJi3OSjCDnWBjm4ZDFE9G7Q=
Received: by 10.151.21.1 with SMTP id y1mr10292358ybi.3.1259688716444; Tue, 01 
	Dec 2009 09:31:56 -0800 (PST)
In-Reply-To: <4B14CF47.5020808@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134236>

Hello,

On Tue, Dec 1, 2009 at 2:09 AM, Michael J Gruber
<git@drmicha.warpmail.net> wrote:
> Nathan W. Panike venit, vidit, dixit 30.11.2009 21:55:
>> Add a command line option to rev-list so the command 'git rev-list -=
-bouquet'
>> shows all revisions that are ancestors of refs which share history w=
ith HEAD.
>>
>> Signed-off-by: Nathan W. Panike <nathan.panike@gmail.com>
>> ---
>> I have a repository with the following structure:
>>
>> =A0 =A0 =A0 B
>> =A0 =A0 =A0/
>> A'--A--C
>> =A0 =A0 =A0\
>> =A0 =A0 =A0 D
>>
>> E'--E
>>
>> Thus the command 'git merge base E A' returns nothing, as there is n=
o common
>> history. =A0The E history contains stuff that is derived from the ot=
her history
>> (A, B, C, or D). =A0Often I find myself doing the following:
>
> Either I don't understand the diagram or your term "derived". If
> "derived" means "on some branch of a merge" and E is derived from A, =
B,
> C, or D, then (since B, C, D is derived from A, and from A') E is
> derived from A', and they will have a merge base.
>

"Derived" in my case means that E is processed from a snapshot of the
tree at, say, A.

> Are these diagrams really disconnected from each other?

Yes.  I started the history of E with plumbing using git commit-tree,
without a -p flag specifying a parent

>
>> git checkout C
>> gitk $(include_forks) &
>> <View history, make changes, merges, et cetera>
>> git checkout E
>> <go back to gitk, only see history for B, C, etc>
>>
>> Now the 'include_forks' command is a bash function in my .bashrc:
>>
>> include_forks ()
>> {
>> =A0 =A0 local head=3D"$(git show -s --pretty=3Dformat:'%H' HEAD)";
>> =A0 =A0 echo "HEAD $(git for-each-ref --format=3D'%(refname)' \
>> =A0 =A0 =A0 refs/heads refs/remotes | while read ref; do \
>> =A0 =A0 =A0 if test "$(git merge-base HEAD ${ref}^{commit})" !=3D ""=
; \
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 then echo ${ref}; fi; done)"
>> }
>>
>> The shell thus intercepts my command and I must restart gitk to see =
the history
>> of E.
>>
>> With this patch, I can issue the command 'gitk --bouquet' and when I=
 checkout
>> E, I can 'reload' in gitk and see the history of E automatically.
>
> What would your patch do in the example you gave above? Which refs wo=
uld
> it cause gitk (rev-list) to show?
>

I wish to be concrete, so let us suppose you use a default clone of
git.git.  Further, suppose you are on origin/master.
Then, with my patch,

git rev-list --bouquet

should be an---admittedly less efficient---equivalent to

git rev-list --all --not refs/remotes/origin/html
refs/remotes/origin/man refs/remotes/origin/todo

> Michael
>

Thanks,

Nathan Panike
