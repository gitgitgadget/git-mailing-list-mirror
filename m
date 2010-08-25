From: Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 15/32] unpack_trees: only unpack $GIT_DIR/narrow subtree
 in narrow repository
Date: Tue, 24 Aug 2010 23:04:30 -0600
Message-ID: <AANLkTinaF6e+bfVqRRThuZ=2PjpOs4P88RKFsxOTVSJR@mail.gmail.com>
References: <1282688422-7738-1-git-send-email-pclouds@gmail.com>
	<1282688422-7738-16-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 25 07:04:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oo8AE-0002GL-FK
	for gcvg-git-2@lo.gmane.org; Wed, 25 Aug 2010 07:04:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755458Ab0HYFEd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 25 Aug 2010 01:04:33 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:35221 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754620Ab0HYFEc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 25 Aug 2010 01:04:32 -0400
Received: by fxm13 with SMTP id 13so90833fxm.19
        for <git@vger.kernel.org>; Tue, 24 Aug 2010 22:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=gzM3pPLxli9vykYFjIH3Bi4RJym9bOFSKo2+J+1icTo=;
        b=R/cnDCNVzn0P4FriE69RPUYVaVXlKHOF/ksETS2cEJrnxDTt5DopxidyU+onHLhsxz
         KDFEyp8nEXQEL5W58g4AV7KvRji5CUa0fQAn/tASGAWupkId3aYgstdQy5bHkVGzjCtr
         hMHtDQAUed2aJmyapYtBG/cn1woFZfOv4/BKo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=vsVs3zzYCbMGwiCxEYBUMvYhHL6VpHRqVnJjJFbh7DBJ1zdizLYgioyP838YiQUgoC
         17ntxYj0g2f7dpbB9NUcS6H4W5rNbe4nR8qKzfLH4RuEvoqaJVVkMVKwFD3R1v5hXcHc
         4JRDOPTU81hTnVlHKiwg3+hs5+XVvhKi9tN0o=
Received: by 10.223.124.9 with SMTP id s9mr6838981far.91.1282712670625; Tue,
 24 Aug 2010 22:04:30 -0700 (PDT)
Received: by 10.223.50.154 with HTTP; Tue, 24 Aug 2010 22:04:30 -0700 (PDT)
In-Reply-To: <1282688422-7738-16-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154417>

Hi,

2010/8/24 Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>=
:
> By definition, narrow repository is incomplete. It does not even have
> enough tree for a single commit. So populating a full index is
> impossible.
>
> Because of this, unpack_trees() is modified to only unpack trees
> within $GIT_DIR/narrow, which narrow repo has all needed trees. This
> makes the resulting index unsuitable for creating commits later on.
> This is the reason index version is increased to 4, to avoid older
> git from using it.
>
> The resulting tree objects created from the index is only part of the
> full tree. Manipulation will be needed at commit time to create prope=
r
> tree for commits.

I spent a while thinking about this a couple weeks ago and never came
to a strong conclusion about which of two alternatives should be
preferred; I'm curious why you decided to go for this solution.  An
alternative I thought of was having the index have entries for missing
files (whose contents did not exist in the repository or the working
copy; rather all we know is the filename and its sha1sum) and also
gain the ability to have entries for missing trees (which behave
similarly; all we know is their name and their sha1sum, but the
contents of that sha1sum are not in the repository or the working
directory)  Is there a reason to prefer one alternative over the
other?  Does the alternative I thought of even make sense?
