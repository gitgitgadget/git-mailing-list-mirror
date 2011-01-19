From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 3/3] setup: always honor GIT_WORK_TREE and core.worktree
Date: Wed, 19 Jan 2011 13:31:16 -0600
Message-ID: <20110119193116.GB30618@burratino>
References: <1290785563-15339-1-git-send-email-pclouds@gmail.com>
 <1290785563-15339-40-git-send-email-pclouds@gmail.com>
 <20110118074400.GA4185@burratino>
 <7v1v4aknij.fsf@alter.siamese.dyndns.org>
 <20110119123732.GA23222@burratino>
 <20110119124230.GD23222@burratino>
 <AANLkTinE5gNZM_HDJq31qs5ARJn-DrO9HW66cszTayPa@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Maaartin <grajcar1@seznam.cz>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 19 20:31:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pfdkn-0007Jz-Ck
	for gcvg-git-2@lo.gmane.org; Wed, 19 Jan 2011 20:31:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753010Ab1ASTbc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 19 Jan 2011 14:31:32 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:50096 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750984Ab1ASTbb convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 19 Jan 2011 14:31:31 -0500
Received: by eye27 with SMTP id 27so697510eye.19
        for <git@vger.kernel.org>; Wed, 19 Jan 2011 11:31:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=4FPnMvSzx1V4KI8KlC71MFn4C0I/2rilPLFS3vr6TX0=;
        b=A+GXi/9eMerZn2hWWij6//3VJwmxvT/0/GqA9PK2yBLDyesAQmZaV8ZtXRhwbZR92A
         EsFB1yg09aFAAAIpnfQj+ixYrjQl92/oeSp0QeXl8soHU9dnhJ8e6vmpukKQosU6CkCu
         vmOJKiM0hCJWofNH48nCHgpRw1asYZVPd37l4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=PkXO37AmsciyZmxPQwEI3mV+Sg3es+ZehfNatbqWwK2/HiwelzYUqtLD/Ii5PCUieA
         TkgivXZVzPuqKKFX0i4GfgVgn/b/7uefobZ+y0tBstXxfsVJJUodKUw8B0h3Rf6+2GzI
         zA2HnRvp7YQmzKgrhP2AyTfM1esJM0jb/T6o8=
Received: by 10.227.141.77 with SMTP id l13mr1296093wbu.159.1295465489832;
        Wed, 19 Jan 2011 11:31:29 -0800 (PST)
Received: from burratino (adsl-69-209-76-37.dsl.chcgil.ameritech.net [69.209.76.37])
        by mx.google.com with ESMTPS id 11sm5362632wbj.13.2011.01.19.11.31.27
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 19 Jan 2011 11:31:28 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <AANLkTinE5gNZM_HDJq31qs5ARJn-DrO9HW66cszTayPa@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165282>

Nguyen Thai Ngoc Duy wrote:
> 2011/1/19 Jonathan Nieder <jrnieder@gmail.com>:

>> @@ -411,6 +411,16 @@ static const char *setup_discovered_git_dir(con=
st char *gitdir,
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (check_repository_format_gently(gitdir=
, nongit_ok))
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return NULL;
>>
>> + =C2=A0 =C2=A0 =C2=A0 /* Accept --work-tree to support old scripts =
that played with fire. */
>> + =C2=A0 =C2=A0 =C2=A0 if (getenv(GIT_WORK_TREE_ENVIRONMENT) || git_=
work_tree_cfg) {
>
> Can we leave git_work_tree_cfg out? If this code is to support misuse=
d
> scripts, then $GIT_WORK_TREE alone ought to be enough.

Sure, it would be easy to exclude git_work_tree_cfg here.  I guess the
relevant question is

Maaartin wrote:
> On 11-01-19 13:42, Jonathan Nieder wrote:

>> Unfortunately the existence of GIT_WORK_TREE makes it tempting to
>> use without setting GIT_DIR.
>
> Maybe I'm asking nonsense, but why should I always use both?

That is, why do we want to discourage setting the work tree without
GIT_DIR in the first place?

The issues seem to be:

1. Previously there was some confusion about what path the worktree
   is relative to.  Now setup_explicit_git_dir makes it clear:
   + GIT_WORK_TREE and --work-tree are relative to the original cwd;
   + the "[core] worktree" setting is relative to the gitdir.

2. Previously there was some confusion about the right order of
   operations --- move to worktree first, or find the git dir?
   Now the setup procedure is clearly "first find git dir, then
   act on worktree".

3. A global "[core] worktree" setting with relative path is
   nonsensical since there is not necessarily a gitdir for it to be
   relative to.

4. Likewise, setting GIT_WORK_TREE when outside any git repository
   has no clear meaning.

5. The interaction with core.bare and implicit bareness are not
   obvious.  Clearly core.bare should conflict with core.worktree,
   but can GIT_WORK_TREE override that?  Maybe
   check_repository_format_gently is the right place for this check
   (rather than the setup procedure).

(1) and (2) have been resolved by your work (nice!), (3) seems like
a case of "don't do that, then", and (4) out to error out in
setup_nongit (though my patch doesn't take care of that).  Given an
answer to (5) we could wholeheartedly and consistently support
worktree with implicit gitdir, as a new feature.

Is that a fair summary?

[...]
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (offset !=3D l=
en && !is_absolute_path(gitdir))
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 gitdir =3D xstrdup(make_absolute_path(gitdir));
>
> The behavior regarding relative $GIT_WORK_TREE before nd/setup series
> is inconsistent. If setup_git_directory() is used, work_tree is
> relative to user's cwd. In other cases, when get_git_work_tree() is
> called, work_tree is made absolute relative to _current_ cwd (usually
> at discovered work_tree root). Which way do you want to keep?

The former.  But this is worrisome: scripts using cd_to_toplevel are
getting the latter behavior.  Maybe a warning for relative
GIT_WORK_TREE is in order, like you hinted before.
