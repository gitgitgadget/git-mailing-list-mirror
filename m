From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: git diff-index with relative git-dir does not work
Date: Thu, 11 Feb 2010 17:35:25 +0700
Message-ID: <fcaeb9bf1002110235p7fdb50a7we41715b795f76b99@mail.gmail.com>
References: <871vguy8hz.wl@dns1.atmark-techno.com> <fcaeb9bf1002090358v3d7f69d5ra80c186d30a1304d@mail.gmail.com> 
	<87wrymwo5a.wl@dns1.atmark-techno.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Yasushi SHOJI <yashi@atmark-techno.com>
X-From: git-owner@vger.kernel.org Thu Feb 11 11:36:06 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NfWOw-0005h8-0B
	for gcvg-git-2@lo.gmane.org; Thu, 11 Feb 2010 11:36:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751332Ab0BKKfs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 11 Feb 2010 05:35:48 -0500
Received: from mail-pz0-f172.google.com ([209.85.222.172]:41759 "EHLO
	mail-pz0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751020Ab0BKKfq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 11 Feb 2010 05:35:46 -0500
Received: by pzk2 with SMTP id 2so420504pzk.21
        for <git@vger.kernel.org>; Thu, 11 Feb 2010 02:35:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=fk0IZ/lkxXpV//FGBGW+bm7irM/qryfDhZCHqbwcS6Y=;
        b=aMswhG6IZ4HDfbEfa4omQdJ6GYA5FCOz0LwLATQ0COOwZIkTIf3LUyjOIOapE1dLJV
         jqdSU0L0NjCkPg433VAjkyEccJjQmEMI8QohJp3aaEla6dU4GbE9RR4E4xipq8dAl5Ao
         a6JH3cluEV8InmVr8yTB6+n6xNgr+qCvjWhj0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=g86QtSPYY/eE9IjpeDGUcc6a88sPgaXCoOuRnPbddqAZNX0OruBL3FnIAZkgK3SdCk
         OMngERKNfZWcNjS8NHj5cP6RSzPlTR7Ehy/QI0Uc03N/Gauli4vTBREqMasc9kt7sMNR
         jPc4PtFvqa9u+sQn7X0o6Q2xVs2dBHF5y6bng=
Received: by 10.114.68.17 with SMTP id q17mr1030327waa.147.1265884545232; Thu, 
	11 Feb 2010 02:35:45 -0800 (PST)
In-Reply-To: <87wrymwo5a.wl@dns1.atmark-techno.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139583>

On Tue, Feb 9, 2010 at 8:10 PM, Yasushi SHOJI > In the diff-index
case, it, indeed, has RUN_SETUP explicitly
> set. however, it does not have NEED_WORK_TREE set. =C2=A0And, this is
> correct in the current semantics because diff-index is a tool to
> compare the index and the object store. it does not need a work tree.

Unless --cached is given, work tree is needed. I'm not saying that
diff-index is bug-free. But the bug you described is not relevant to
this.

> However, diff-index is used in describe which need a work tree if
> --dirty is given. =C2=A0That means that diff-index might be called
> with --work-tree.

Yes. And git-describe calls git-diff-index correctly, i.e. without --ca=
ched.

>> > =C2=A0In that case, we must change the setup functions signature t=
o
>> > =C2=A0allow marking "not interested" or something.
>>
>> I'm not sure I get your idea.
>
> Given that in the current form of git, many built-in command is calle=
d
> by many other built-in commands. It is hard to predict what is needed
> and what's not. =C2=A0Plus, --git-dir and --work-tree are options to =
git
> itself not built-in's. =C2=A0So, I thought it might be a good idea to=
 call,
> say, setup_work_tree_with_abs_path(), regardless of NEED_WORK_TREE, t=
o
> explicitly setup run time environment before any other part of the
> code call, say, open_sha1_file.

The thing is not every command expect cwd to be moved to top
directory. In other words, they don't care about the prefix argument
being passed to it. So you would need go go through all commands
before doing that.

By the way, are you working on a patch for the diff-index bug?
--=20
Duy
