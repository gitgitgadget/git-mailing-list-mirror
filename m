From: Dmitry Ivankov <divanorama@gmail.com>
Subject: Re: long fast-import errors out "failed to apply delta"
Date: Thu, 28 Jul 2011 17:24:06 +0600
Message-ID: <CA+gfSn_dzuW-z-S8y2n2jnzwdm477GN5oXdnAoUb81-fQyC-_A@mail.gmail.com>
References: <CA+gfSn8jjptyv10iVimmfXpf6QHrR_3UpkRdd+Dv1M=KgORtGQ@mail.gmail.com>
	<CA+gfSn8C-nB2hSSRTqSu1N1Z-b8ctRsVmUGAjLXTW0du_W3EQw@mail.gmail.com>
	<CA+gfSn8m=_vd91Xe5EnFXUvZnuJf-yUE6H7FU+ak8S8a+NtCjA@mail.gmail.com>
	<20110728095634.GA6991@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>,
	David Barr <davidbarr@google.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 28 13:24:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QmOhK-0000PJ-DL
	for gcvg-git-2@lo.gmane.org; Thu, 28 Jul 2011 13:24:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755450Ab1G1LYI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 28 Jul 2011 07:24:08 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:49967 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755399Ab1G1LYH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Jul 2011 07:24:07 -0400
Received: by qwk3 with SMTP id 3so1263682qwk.19
        for <git@vger.kernel.org>; Thu, 28 Jul 2011 04:24:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=0aBQAU4Jp695fSBCs1cYFO6EtXVvZpVOhngX0w6Uc58=;
        b=WmI3eCLFJtywqGkDBIe8unHElJrohVcQTVah4MZiKgL/93Ujag2nOHNAGXee4IuK3/
         zD+OwCZYOoUV3Y228jj2pMmvarMLL/g8iDR1dr7iVpbE6dhdmYKTiV/Wr35QioKjEZFI
         gkqtrzphwgvPBZKMBhStnnuoW+Jbstf64SfzM=
Received: by 10.229.213.208 with SMTP id gx16mr361923qcb.150.1311852246734;
 Thu, 28 Jul 2011 04:24:06 -0700 (PDT)
Received: by 10.229.189.3 with HTTP; Thu, 28 Jul 2011 04:24:06 -0700 (PDT)
In-Reply-To: <20110728095634.GA6991@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178063>

On Thu, Jul 28, 2011 at 3:56 PM, Jonathan Nieder <jrnieder@gmail.com> w=
rote:
> Dmitry Ivankov wrote:
>
>> --- a/fast-import.c
>> +++ b/fast-import.c
>> @@ -1514,6 +1514,9 @@ static int tree_content_set(
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (=
e->tree)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 release_tree_content_recursive(e->tree);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 e->t=
ree =3D subtree;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (S_=
ISDIR(mode)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 hashclr(e->versions[0].sha1);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 hash=
clr(root->versions[1].sha1);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 retu=
rn 1;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>
> Based on your later explanations, it looks like this hit the nail on
> the head. =A0The idea is that normally e->tree includes entries for b=
oth
> e->versions[0] and e->versions[1] and that in the "M 040000 ..." case=
,
> this codepath at least currently doesn't have enough information to
> decide on a good delta base.
>
> Just doing a "hashclr(e->versions[0].sha1)" will change the preimage
> tree object for the parent directory, causing invalid deltas _there_.
> So that's not quite right.
>
> Possible fixes:
>
> =A0a. invalidate preimage tree names all the way up the hierarchy.
> =A0 =A0This is what I misread the code as doing at first. =A0It would
> =A0 =A0be a cop-out; I think we can do better.
>
> =A0b. merge the preimage and postimage trees in e->tree, and use
> =A0 =A0the existing preimage tree as delta basis. =A0This would produ=
ce
> =A0 =A0an unnecessarily large delta, but it should work.
That's what I was trying to do in  [7/7] fast-import: fix data
corruption in load_tree.
But [7/7] covers only subtree =3D=3D NULL case.
Delta size shouldn't be too large for the top level tree, if of course
preimage and postimage are similar. Another bad thing is that changes
go deep down the tree (while in a. they go up the tree).

> =A0c. add a bit to "struct tree_content" (or abuse delta_depth) to
> =A0 =A0say "my parent entry's versions[0].sha1 has nothing to do with
> =A0 =A0me; please do not write me out as a delta against it"
>
> =A0d. invalidate preimage tree object names up the hierarchy, and all=
ow
> =A0 =A0tree_content_set callers to pass a "const struct tree_entry_ms=
 *"
> =A0 =A0argument indicating a preimage tree object name for the new
> =A0 =A0subtree.
not much better than a.

> =A0e. instead of replacing a tree entry, delete it and add it again a=
s a
> =A0 =A0new tree entry. =A0Make sure internal APIs can deal with multi=
ple
> =A0 =A0tree entries with the same name.
There is a risk that trees will grow twice in ram :)

> I find (c) tempting.
The best thing about it is that it's local. And it looks like it
disables deltas for the minimum number of objects among a-d, and e.
isn't too much better.

> =A0Like this, vaguely. =A0What do you think?
Tested it on my dump - no fsck complaints.

[skipped part of the patch]
> @@ -1470,6 +1477,7 @@ static void tree_content_replace(
> =A0{
> =A0 =A0 =A0 =A0if (!S_ISDIR(mode))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0die("Root cannot be a non-directory");
> + =A0 =A0 =A0 hashclr(root->versions[0].sha1);
> =A0 =A0 =A0 =A0hashcpy(root->versions[1].sha1, sha1);
> =A0 =A0 =A0 =A0if (root->tree)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0release_tree_content_recursive(root->t=
ree);
Should it be root->versions[0].mode |=3D NO_DELTA instead?
I see that it's only called for the tree root, but still. This way
versions[0].sha1
will be changed only in store tree to discard the preimage and in
load_tree or other
entry creation place (in the end of tree_content_set).

Will give it more testing, thanks for a small patch for this problem :)
