From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [PATCH] Teach merge the '[-e|--edit]' option
Date: Fri, 7 Oct 2011 14:01:00 -0400
Message-ID: <CAG+J_Dz7-tTdgT=cqoKhK+fAhmESLnp93yHyxOF_NOY5Wx01+w@mail.gmail.com>
References: <1318001347-11347-1-git-send-email-jaysoffian@gmail.com>
	<7vk48gwvyd.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 07 20:01:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RCEjK-0005iq-H7
	for gcvg-git-2@lo.gmane.org; Fri, 07 Oct 2011 20:01:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753801Ab1JGSBB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 7 Oct 2011 14:01:01 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:64941 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752787Ab1JGSBA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 7 Oct 2011 14:01:00 -0400
Received: by gyg10 with SMTP id 10so3847938gyg.19
        for <git@vger.kernel.org>; Fri, 07 Oct 2011 11:01:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=Z+kxpV8H3W5awn8IUbXOpO9gy+L/ZlN34zDPBSJ6i4E=;
        b=QPHVT8d9SOIBA/YACaaz9qAvi/BhHWlYd72qTwG0MRzKDSgUAwqL1fKB0BBQFI/Suy
         IkFPjb4cX/222vq1NYIocWPCuvKRonqwvs07u91fR5i/n7wbV5VI+8zS4Dc+7xjDU+Nz
         dyikMIWB7GEd6s2njGNi0faITN8xCUbRUayDI=
Received: by 10.236.190.200 with SMTP id e48mr11624322yhn.59.1318010460208;
 Fri, 07 Oct 2011 11:01:00 -0700 (PDT)
Received: by 10.147.32.18 with HTTP; Fri, 7 Oct 2011 11:01:00 -0700 (PDT)
In-Reply-To: <7vk48gwvyd.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183092>

On Fri, Oct 7, 2011 at 1:30 PM, Junio C Hamano <gitster@pobox.com> wrot=
e:
> Jay Soffian <jaysoffian@gmail.com> writes:
>
>> Implement "git merge [-e|--edit]" as "git merge --no-commit && git c=
ommit"
>> as a convenience for the user.
>>
>> Signed-off-by: Jay Soffian <jaysoffian@gmail.com>
>> ---
>> ...
>> @@ -1447,6 +1457,10 @@ int cmd_merge(int argc, const char **argv, co=
nst char *prefix)
>> =C2=A0 =C2=A0 =C2=A0 }
>>
>> =C2=A0 =C2=A0 =C2=A0 if (merge_was_ok) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (option_edit) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 const char *args[] =3D {"commit", "-e", NULL};
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 return run_command_v_opt(args, RUN_GIT_CMD);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fprintf(stderr, _("=
Automatic merge went well; "
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 "stopped before committing as requested\n"));
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;
>
>
> I wanted to like this approach, thinking this approach might be safer=
 and
> with the least chance of breaking other codepaths, but this feels lik=
e an
> ugly hack.
>
> Are we still honoring all the hooks "git merge" honors? =C2=A0More im=
portantly,
> isn't this make it impossible for future maintainers of this command =
to
> enhance the command by adding other hooks after the commit is made?

Git is already inconsistent with respect to which hooks are called
when. Shouldn't post-merge be called on a merge commit regardless of
whether you use --no-commit or not? Well, it isn't, it's only called
when merge performs the commit internally. The post-merge hook was
probably a mistake -- git calls the post-commit hook passing the
context as an argument, so probably merge should just call post-commit
"merge". But that ship has sailed.

See also 65969d43d1 (merge: honor prepare-commit-msg hook, 2011-02-14).

> If we wanted to do this properly, we should update builtin/merge.c to=
 call
> launch_editor() before it runs commit_tree(), in a way similar to how
> prepare_to_commit() in builtin/commit.c does so when e.g. "commit -m =
foo -e"
> is run. An editmsg is prepared (you already have it in MERGE_MSG), th=
e
> editor is allowed to update it, and then the original code before suc=
h a
> patch will run using the updated contents of MERGE_MSG. That way, the=
 _only_
> change in behaviour when "-e" is used is to let the user update the m=
essage
> used in the commit log, and everything else would run exactly the sam=
e way
> as if no "-e" was given, including the invocation of hooks.

I find git very difficult to reason about (and inconsistent in its
behavior) due to piecemeal hoisting of some functionality into
porcelain commands (another example, revert.c building in the
recursive merge strategy but not any others).

I actually think a better choice would be to remove commit_tree() from
merge and always have it run commit externally. I'm not seriously
suggesting that be done, but it would make git more consistent. But
I'm not going to send in a patch which makes the situation worse.

j.
