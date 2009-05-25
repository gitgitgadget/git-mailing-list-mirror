From: Asger Ottar Alstrup <asger@area9.dk>
Subject: Re: git subtree as a solution to partial cloning?
Date: Mon, 25 May 2009 19:35:53 +0200
Message-ID: <8873ae500905251035v64084e83wa1a89a562d20224a@mail.gmail.com>
References: <8873ae500905250021p20e7096dwf5bc71c36c4047b@mail.gmail.com>
	 <32541b130905250059n7b31cc1bk688e5f4bfaf83142@mail.gmail.com>
	 <8873ae500905250233t52dce5b5v8ca88b9921a88437@mail.gmail.com>
	 <32541b130905250850h75f905e0t84287f897600187f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Alexander Gavrilov <angavrilov@gmail.com>
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 25 19:36:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M8e6D-0007Bq-CW
	for gcvg-git-2@gmane.org; Mon, 25 May 2009 19:36:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752545AbZEYRfz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 25 May 2009 13:35:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752005AbZEYRfy
	(ORCPT <rfc822;git-outgoing>); Mon, 25 May 2009 13:35:54 -0400
Received: from mail-bw0-f222.google.com ([209.85.218.222]:35890 "EHLO
	mail-bw0-f222.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752467AbZEYRfx convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 May 2009 13:35:53 -0400
Received: by bwz22 with SMTP id 22so3249009bwz.37
        for <git@vger.kernel.org>; Mon, 25 May 2009 10:35:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:date:x-google-sender-auth:message-id:subject:from:to:cc
         :content-type:content-transfer-encoding;
        bh=OvcisNj5ioXsVz9/TijxAOcboteieu3hI8HNtH9cUZY=;
        b=OPQDEg/XPTgic0EA/VMWZ3MlKrv8KOkF3t5VfzrbFLFCLTURj+gz1NnSWp4uWxxT2o
         6Zw7OxgHkU4a9b7wDsIqHZh40Qkire3R3i1bKVyV/UzUedcRplx7I79xvO9Wvk2qjFQv
         gr3pOkwHfd6bgAJdxguE6oTslbnm6u6GYAd+M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=vDDqQdmB7kKMEy1OOYbqMvjKczCsP8U4Q8Zw2RPE9QeSqdwbWaFPv93RC6QmEnpASV
         GqrTS/yLhTmrmTLSSse+KyGlFWQhjuBso3bmUts2rhPUfvY3tl9gJ6oUzGQBR53ce1mQ
         F+lKcmxiAG1XeBwRhnvN9yyoZnAM+YEW5yQqg=
Received: by 10.223.113.200 with SMTP id b8mr3767465faq.84.1243272953968; Mon, 
	25 May 2009 10:35:53 -0700 (PDT)
In-Reply-To: <32541b130905250850h75f905e0t84287f897600187f@mail.gmail.com>
X-Google-Sender-Auth: 02036aaaaa852f01
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119944>

On Mon, May 25, 2009 at 5:50 PM, Avery Pennarun <apenwarr@gmail.com> wr=
ote:
> On Mon, May 25, 2009 at 5:33 AM, Asger Ottar Alstrup <asger@area9.dk>=
 wrote:
>> No, that is unfortunately not so easy. If we could, I suppose we cou=
ld
>> use submodules instead.
>
> Your only option may be to use git filter-branch then. =A0It lets you=
 do
> pretty much anything you want, although merging it back together agai=
n
> could be entertaining. =A0(Making it correctly mergeable is by far th=
e
> trickiest part of git-subtree.)

OK, so git subtree is not usable as it is for this. Instead, it seems
a new system has to be developed which would be similar to git subtree
in spirit, except that it worked at a file-level. Of course, the git
merge subtree strategy can not be used, so merging has to be done
differently.

So a poor mans system could work like this:

- A reduced repository is defined by a list of paths in a file, I
guess with a format similar to .gitignore

- To extract: A copy of the original repository is made. This copy is
reduced using git filter-branch. Is there some way of turning a
=2Egitignore syntax file into a concrete list of files? Also, can this
entire step be done in one step without the copy? Having to copy the
entire project first seems excessive. Will filter-branch preserve
and/or prune pack files intelligently?

- To merge from the reduced to the original: The very simple version
is just to copy all the files from the reduced repository into a
checkout of the original repository, and then merge. This would not
support removal (or renaming) of files, but that might be ok in my
setup. If this needs to be more intelligent, the list of files in the
reduced repository could be compared with the list of paths that was
used to reduce it originally. This can be used to detect removals and
additions of files.

- To merge from the original to the reduced: First merge the other
way, and then extract again.

I am new to git, so please excuse me if this design is mentally unsound=
=2E

Regards,
Asger
