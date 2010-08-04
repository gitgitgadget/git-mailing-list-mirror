From: Eugene Sajine <euguess@gmail.com>
Subject: Re: git merge - "both added" conflict resolution
Date: Wed, 4 Aug 2010 19:29:21 -0400
Message-ID: <AANLkTi=dScNMsf4XZ+sS8R+424fESyOr6wYO4WamAutj@mail.gmail.com>
References: <AANLkTi=Hp6DsE75XbgehS2bucp-M9NXmGgYbvw0kp6j8@mail.gmail.com>
	<20100804205916.GC2920@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 05 01:29:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OgnOp-0000E2-Na
	for gcvg-git-2@lo.gmane.org; Thu, 05 Aug 2010 01:29:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759450Ab0HDX3X convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 4 Aug 2010 19:29:23 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:39928 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757837Ab0HDX3V convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 4 Aug 2010 19:29:21 -0400
Received: by qwh6 with SMTP id 6so3463387qwh.19
        for <git@vger.kernel.org>; Wed, 04 Aug 2010 16:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=3jSorItg0affVJ/cnZ15pG0gDT6da7EKq+Xrpdq7HZs=;
        b=xK01Q2cHIa7P8i/DVRIeHBX38Cd1sf0D1bngTYqz7tOKBbQ9HRpQ2zWrNa1MWMFahf
         AEVTyRVU3b2M/IB29uiOmwC2eFIolnNJVJLjDLbfbFTWMwhOh1mNA9gQVRbeyKCjt21L
         vgWBoKDrj4oRZllVnhdi0JpuDnE6kQsMRMBs4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=VBrXgtIR0DajLeKHqDZ/MA6s5lILr4vn4uCBL0XrB3Ajo87VHKnWmXLpS9+ZBBMcZG
         kPWPX89HKFA9CGYbqrW3Q6nl0PE9OmIEynLU4CqIfKDAhz8rGCjfnWragfQRBpBWStx9
         Pk47KdgZBo+O0xoBC+w/6eFGWCnmpN4FW+C1U=
Received: by 10.229.106.17 with SMTP id v17mr2823864qco.261.1280964561099; 
	Wed, 04 Aug 2010 16:29:21 -0700 (PDT)
Received: by 10.229.48.205 with HTTP; Wed, 4 Aug 2010 16:29:21 -0700 (PDT)
In-Reply-To: <20100804205916.GC2920@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152609>

On Wed, Aug 4, 2010 at 4:59 PM, Jonathan Nieder <jrnieder@gmail.com> wr=
ote:
> Hi Eugene,
>
> Eugene Sajine wrote:
>
> [in an add/add conflict]
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 when i resolve the conflict the b=
uild.xml returns to its
>> last committed state of dest repo, so git cannot determine any
>> changes.
>> Therefore, i cannot execute git add for this file and i cannot commi=
t
>> my merge results
>
> Could you explain further (preferrably with a simple example
> transcript)? =C2=A0I would think that after an add/add conflict,
> a simple "git add" would mark the file resolved and allow
> committing.
>

Let's say in a source repository i have a master branch with few
coomits and only two files file1.java and build.xml
build.xml is as simple as few lines one of which is
=2E..
<property name=3DprojectName value=3DprojectOne/>
=2E..
In the second *unrelated* repository which is the destination for
merge I have a master branch with two files: file2.java and build.xml
this build.xml is absolutely identical with an exception of the
projectName property
=2E..
<property name=3DprojectName value=3DprojectTwo/>
=2E..

I'm doing
$ cd projecttwo (I'm in master branch)
$ git add remote temp ../projectone
$ git fetch temp
$ git merge temp/master

here i'm getting a conflict in build.xml.
file1.java is succesfully staged for commit

=46or build.xml git status gives me
=2E..
both added: build.xml
=2E..

Now i have to resolve the conflict on build.xml and as I'm merging two
projects into one it is obvious that the resolution of the conflict is
to leave the original version of build.xml

So, I'm removing all conflict markers and removing the incoming line
with the property value=3DprojectOne leaving it as projectTwo.
This effectively means that there is no changes in build.xml for git.
And I'm stuck because i cannot add file, that is not changed and
cannot commit merge results as it is a partial commit.

Is that better;)?

Interesting enough this worked OK on git version 1.6.4.msysgit.0
But giving me headache in git 1.7.0.5 on Linux

Below is command sequence which is supposed to reflect everything above

mkdir test3
mkdir test4
cd test3/
git init
echo file content> file1.java
git add .
git commit -am "initial commit"
echo "<property name=3Dprojectname value=3Dtest3/>" > build.xml
git add .
git commit -am "add build.xml"
echo "more content" >> file1.java
git commit -am "some change"
cd ../test4
git init
echo file content> file2.java
git add .
git commit -am "initial commit"
echo "<property name=3Dprojectname value=3Dtest4/>" > build.xml
git add .
git commit -am "add build.xml"
echo "more content" >> file2.java
git commit -am "another change"
git remote add temp ../test3
git fetch temp
git merge temp/master
git status
vi build.xml
git status
git add build.xml
git st
git commit -am "merging"


Thanks,
Eugene
