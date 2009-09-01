From: skillzero@gmail.com
Subject: Re: Problems with GIT under Windows - "not uptodate"
Date: Tue, 1 Sep 2009 11:19:44 -0700
Message-ID: <2729632a0909011119l3a19447ds9d4896a27ac488c1@mail.gmail.com>
References: <a21e6af7ee05f56fd8c02d0955af1c72.squirrel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: david.hagood@gmail.com
X-From: git-owner@vger.kernel.org Tue Sep 01 20:19:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MiXxT-0002Qs-JE
	for gcvg-git-2@lo.gmane.org; Tue, 01 Sep 2009 20:19:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754690AbZIASTo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Sep 2009 14:19:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754068AbZIASTn
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Sep 2009 14:19:43 -0400
Received: from qw-out-2122.google.com ([74.125.92.24]:53115 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751902AbZIASTn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Sep 2009 14:19:43 -0400
Received: by qw-out-2122.google.com with SMTP id 8so111525qwh.37
        for <git@vger.kernel.org>; Tue, 01 Sep 2009 11:19:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=xQ9DgNF/LcZc896h7QmhDbo4jYFiYq+HQt000ySc0GY=;
        b=anWVVbhOTUxqLsDMQck4ZpN+1qP9LikFTfS3lobENNilEJqTP2KFjPyAPIf+7OxojZ
         oOluIUa+dFGBZ9Ln3ZByB70mKgDDVCuvWv7Vj/45sGZRH+7etPaSpLH+V7EO3ftNusK9
         2D1TMB3uDiTGurz6R0M7UcsYjlCUnn6Ecr/oA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=g8EEhwLb+/n2kTwvPkUb2pAJKfJG7JKMfFTIqdef/Prp5uhDhwq4bZqeGfZRwL/v8n
         0ALvxC8GM/v6QXdJktRM+VPnTzbCI6vst33eOhpZFlAk9holSaabGXgBLLN9Dv2i4e3m
         KDkzuXBSWCEp1H5Tb/PuuRh+/ARgsjqRzAC+c=
Received: by 10.224.3.74 with SMTP id 10mr4735019qam.302.1251829184851; Tue, 
	01 Sep 2009 11:19:44 -0700 (PDT)
In-Reply-To: <a21e6af7ee05f56fd8c02d0955af1c72.squirrel@localhost>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127547>

On Tue, Sep 1, 2009 at 8:46 AM, <david.hagood@gmail.com> wrote:
> I am having a problem trying to support my poor, deluded cow-orkers who
> use Windows and need to use GIT.
>
> The scenario goes something like this:
>
> They have a local repo, they have changes on their branch, they are
> staging a commit to the master branch on their local.
>
> They do a "git merge" and the merge has conflicts. They need to undo the
> merge, so they do a "git reset --hard".
>
> From that point onward, if they try to access the origin repository (e.g.
> "git pull") they get the error message
>
> Error: Entry "Some file name" not uptodate: cannot merge.
>
> We've tried "git reset --hard; git pull ." We've tried "git reset --hard;
> git checkout -f master". Neither seems to fix this.
>
> We Linux users don't see this.
>
> I conjecture it is something to do with DOS's CR/LF line endings (the
> files in question are a type of XML file which ALWAYS have CR/LF endings,
> even under Linux) - perhaps *something* in the GIT processing chain is
> trying to do a CR/LF -> LF conversion, and screwing things up.
>
> Does anybody have any suggestions on what I am doing wrong (Please, not
> "you are using Windows")?

Yeah I run into the same thing on Windows if somebody accidentally
checks in a CRLF file. Do you have core.autocrlf on? If you do, I
think the problem is that it's going to try to convert the line
endings on every checkout/etc, but since the file is already CRLF (not
LF as is normally in the repository), it's going to make the file look
different every time.

It seems like you want core.autocrlf to be false or you want a
.gitattributes file to override it on a per-file basis for the files
you know are CRLF (i.e. the ones that are CRLF even on the Linux
side).
