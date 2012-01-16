From: Vitor Antunes <vitor.hda@gmail.com>
Subject: Re: [PATCH 2/3] git-p4: Search for parent commit on branch creation
Date: Mon, 16 Jan 2012 23:41:39 +0000
Message-ID: <CAOpHH-UkyK-c_AHUOPbQQmW9cQQypDvirMR0Jb7vTGSQF7RZpw@mail.gmail.com>
References: <1326674360-2771-1-git-send-email-vitor.hda@gmail.com>
 <1326674360-2771-3-git-send-email-vitor.hda@gmail.com> <20120116185738.GA21996@padd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Pete Wyckoff <pw@padd.com>
X-From: git-owner@vger.kernel.org Tue Jan 17 00:42:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RmwBt-0002ut-Fz
	for gcvg-git-2@lo.gmane.org; Tue, 17 Jan 2012 00:42:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751930Ab2APXmN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 16 Jan 2012 18:42:13 -0500
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:57826 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750696Ab2APXmM convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jan 2012 18:42:12 -0500
Received: by lahc1 with SMTP id c1so1206498lah.19
        for <git@vger.kernel.org>; Mon, 16 Jan 2012 15:42:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=rN1VHJeaiexxMD2iXUEsIpa6xlqmcnc5O1KJ1F23ZKk=;
        b=AXPYxv5qyx1CoUJEEXt89cIRFWfr0bfyv5kwrt6u8WfYsnnjgONP2mgXx6qXAeFqPX
         hd1yRjWrsaFwka8nAUOclGvyUMByNd2ZqNupWyKfezpwc5xxbxm2BH8tZaH9oETnW3en
         2mvD6JpAZFv98t+L10Wjd2v2SRsdhex7IuMI8=
Received: by 10.112.98.37 with SMTP id ef5mr3689731lbb.73.1326757330485; Mon,
 16 Jan 2012 15:42:10 -0800 (PST)
Received: by 10.152.6.197 with HTTP; Mon, 16 Jan 2012 15:41:39 -0800 (PST)
In-Reply-To: <20120116185738.GA21996@padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188675>

On Mon, Jan 16, 2012 at 6:57 PM, Pete Wyckoff <pw@padd.com> wrote:
> This looks much better without the need for "--force". =A0It'll be
> great to fix this major branch detection problem. =A0Can you make a
> couple of further minor changes?

Of course I can :)

>> diff --git a/contrib/fast-import/git-p4 b/contrib/fast-import/git-p4
>> @@ -2012,7 +2014,28 @@ class P4Sync(Command, P4UserMap):
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0self.commit(descrip=
tion, filesForCommit, branch, [branchPrefix], parent)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0parentFound =3D 0
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if len(parent) > 0:
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0self.checkp=
oint()
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0for blob in=
 read_pipe_lines("git rev-list --reverse --no-merges %s" % parent):
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0blo=
b =3D blob.strip()
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0tem=
pBranch =3D self.tempBranchLocation + os.sep + "%d-%s" % (change, blob)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if =
self.verbose:
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0print "Creating temporary branch: " + tempBranch
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0sel=
f.commit(description, filesForCommit, tempBranch, [branchPrefix], blob)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0sel=
f.tempBranches.append(tempBranch)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0sel=
f.checkpoint()
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if =
len( read_pipe("git diff-tree %s %s" % (blob, tempBranch)) ) =3D=3D 0:
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0parentFound =3D 1
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0if self.verbose:
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0print "Found parent of %s in commit %s" % (branch, blob)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0break
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if parentFound:
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0self.commit=
(description, filesForCommit, branch, [branchPrefix], blob)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0else:
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if self.ver=
bose:
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pri=
nt "Parent of %s not found. Committing into head of %s" % (branch, pare=
nt)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0self.commit=
(description, filesForCommit, branch, [branchPrefix], parent)
>
> 1. =A0Move the tempBranch commit outside of the "for blob" loop.
> =A0 =A0It can have no parent, and the diff-tree will still tell you
> =A0 =A0if you found the same contents. =A0Instead of a ref for
> =A0 =A0each blob inspected for each change, you'll just have one ref
> =A0 =A0per change. =A0Only one checkpoint() after the tempBranch
> =A0 =A0commit should be needed.

You're right. Completely oversaw that. Will improve the code
accordingly.

> 2. =A0Nit. =A0parentFound is boolean, use True/False, not 1/0.

That was not a nice thing to do... thanks for noticing :)

>> @@ -2347,6 +2370,12 @@ class P4Sync(Command, P4UserMap):
>> + =A0 =A0 =A0 =A0# Cleanup temporary branches created during import
>> + =A0 =A0 =A0 =A0if self.tempBranches !=3D []:
>> + =A0 =A0 =A0 =A0 =A0 =A0for branch in self.tempBranches:
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0os.remove(".git" + os.sep + branch)
>> + =A0 =A0 =A0 =A0 =A0 =A0os.rmdir(".git" + os.sep + self.tempBranchL=
ocation)
>> +
>
> 3. =A0Deleting refs should probably use "git update-ref -d"
> =A0 =A0just in case GIT_DIR is not ".git". =A0I think you could just
> =A0 =A0leave the "git-p4-tmp" directory around, but use
> =A0 =A0os.environ["GIT_DIR"] instead of ".git" if you want to
> =A0 =A0delete it.

Will use os.environ.get, which can be configured to return ".git" if
$GIT_DIR is not defined. Is this ok?

> 4. =A0Paths are best manipulated with os.path.join(dir, file), to han=
dle
> =A0 =A0weirdnesses like drive letters.

Perfect. I was completely unaware of that method. Thanks for the tip.

> Eventually if the fast-import protocol learns to delete the refs
> it creates, we can clean up a bit more nicely. =A0I think there was
> agreement this was a good idea, just needs someone to do it
> sometime.

One can always hope ;)

Thanks,
Vitor
