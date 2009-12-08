From: Jeffrey Middleton <jefromi@gmail.com>
Subject: false directory/file merge conflict
Date: Tue, 8 Dec 2009 16:55:30 -0600
Message-ID: <4389ce950912081455g2f6ad1c3i72386073e5154d6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 08 23:55:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NI8yL-0006cu-3O
	for gcvg-git-2@lo.gmane.org; Tue, 08 Dec 2009 23:55:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966669AbZLHWzq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Dec 2009 17:55:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936703AbZLHWzp
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Dec 2009 17:55:45 -0500
Received: from mail-ew0-f209.google.com ([209.85.219.209]:65445 "EHLO
	mail-ew0-f209.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936114AbZLHWzo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Dec 2009 17:55:44 -0500
Received: by ewy1 with SMTP id 1so3428470ewy.28
        for <git@vger.kernel.org>; Tue, 08 Dec 2009 14:55:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:from:date:message-id
         :subject:to:content-type;
        bh=60+k6i+4ZUcWLa4hGTssbTGWW8lUivNIJxe9ETKZAas=;
        b=iu5Bc0YIASZy3IJICsdDIQmS7kIIjj7qSfAznGltfAXIQoRFY+/3PMyk9nHSVjCby+
         mCcQraZK84z2rH2ZFXjEwf54URAu7IKQXBjcWWRlCiKz7jyg3To1lhVAStGal5eAWHcR
         E6cl0rqIJ+oTwClhgX5Al+F0ZVobXvfg3/hC0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type;
        b=jVcjDYcGl7A8U6N0R5YzNtOqDon+PFYo1JJzJXxZNhOKmux5VMouEeNZ3eNz6Ch8jj
         n4qMO9AjcKDuQgaWh4GfidA6Lp86fjgabEtuyPjsj3+cTdcsYtzetaYwpcgtFpr5czuO
         1PkY3xHg4Ht+S6N7mlupTEy9tV5B3if2r9+U8=
Received: by 10.213.2.75 with SMTP id 11mr1733497ebi.9.1260312950086; Tue, 08 
	Dec 2009 14:55:50 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134919>

When a directory (with contents) has changed into a file on one
branch, and another branch attempts to merge it, there's a false
conflict - the directory is processed before its contents are removed.
This is particularly nasty, because "resolving" the non-existent
conflict results in no changes, so future merges will fail in exactly
the same way.  Test script and failed merge output below.

Jeffrey

-- 8< --

rm -rf directory-file
mkdir directory-file
cd directory-file
git init

mkdir foo
echo bar > foo/bar
echo bas > foo/baz
git add foo/bar foo/baz
git commit -m "check in files"

git branch foo_unchanged

git rm -r foo
echo foo > foo
git add foo
git commit -m "foo changes from directory to file"

git checkout foo_unchanged
echo foobar > foobar
git add foobar
git commit -m "make a separate change"

git merge master

-- 8< --

CONFLICT (directory/file): There is a directory with name foo in HEAD.
Adding foo as foo~master
Removing foo/bar
Removing foo/baz
Automatic merge failed; fix conflicts and then commit the result.
