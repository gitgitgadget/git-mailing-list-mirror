From: Computer Druid <computerdruid@gmail.com>
Subject: Re: Git changes permissions on directories when deleting files.
Date: Mon, 28 Feb 2011 21:19:58 -0500
Message-ID: <AANLkTinCjaGMe3TnheqORe7Y_qWYTAr3p6UEsK3u4VyE@mail.gmail.com>
References: <AANLkTikJcOgBAZS=cCWULFYz4U_Mxx1gFMg51+r9qDo0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Chad Joan <chadjoan@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 01 03:20:07 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PuFC3-0007QO-58
	for gcvg-git-2@lo.gmane.org; Tue, 01 Mar 2011 03:20:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755460Ab1CACUA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Feb 2011 21:20:00 -0500
Received: from mail-wy0-f174.google.com ([74.125.82.174]:45358 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755300Ab1CACT7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Feb 2011 21:19:59 -0500
Received: by wyg36 with SMTP id 36so4259671wyg.19
        for <git@vger.kernel.org>; Mon, 28 Feb 2011 18:19:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=Vou9gHD4iWsLeFFNcegg/Hrsg/r+dGSJCwBVBLv7S9s=;
        b=xTfWrJcTQu77HHnoksCzcpc2g2VvbhsJwnDYYhMXCh9WslwAtgTIfEX9kk2Nv5QQgT
         AOrwHbUO3hueSwr/emMNit7+FV/wNkADv7lOzVp1kCwU64p8Oe27zxdW2tQ1l+xL+k6+
         /V6JnHlhOJuRBqWlDFARyD0mi38CVGydvodDg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=qRUqI+qd7YO7o1btyDz59RpZmjGkJumScBOjTfZPjaGiJeZO7nKd+43dgebPItuxC9
         rr6z2TtSb657V3WDSU15tJA+tkIG0+k7HhoNZ6M7nbevD+lMzhpcfLcRjagFriubK9Hf
         K3akV9ZHUJIo3jHPiZbLhGHCJHASU6shevvnM=
Received: by 10.216.13.194 with SMTP id b44mr5191718web.68.1298945998615; Mon,
 28 Feb 2011 18:19:58 -0800 (PST)
Received: by 10.216.161.79 with HTTP; Mon, 28 Feb 2011 18:19:58 -0800 (PST)
In-Reply-To: <AANLkTikJcOgBAZS=cCWULFYz4U_Mxx1gFMg51+r9qDo0@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168183>

On Mon, Feb 28, 2011 at 8:42 PM, Chad Joan <chadjoan@gmail.com> wrote:
> Hello,
>
> What I'm experiencing is this:
>
> $ cd ~/project
> $ ls -dl somedir
> drwxrwx--- 1 cjoan cjoan 0 Feb 28 19:57 somedir
> $ echo "some text" > somedir/somefile.txt
> $ git add somedir/somefile.txt
> $ git rm -f somedir/somefile.txt
> rm 'somedir/somefile.txt'
> $ ls -dl somedir
> drw------- 1 cjoan cjoan 0 Feb 28 19:57 somedir
> $ echo "some text" > somedir/somefile.txt
> bash: somedir/somefile.txt: Permission denied

After you remove the file, is "somedir" empty?

Git doesn't track empty directories, and therefore git rm on the last
file in a directory deletes it:

% git init
Initialized empty Git repository in /home/cdruid/testrepo/.git/
% mkdir dir
% ls -l
total 4
drwxr-xr-x 2 cdruid cdruid 4096 Feb 28 21:14 dir
% touch dir/test.txt
% git add dir/test.txt
% git rm -f dir/test.txt
rm 'dir/test.txt'
% ls -l
total 0

My guess is git is somehow failing to delete the directory, thus
causing your changed permissions issue.

-Dan Johnson
