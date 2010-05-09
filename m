From: Bo Yang <struggleyb.nku@gmail.com>
Subject: Multiple line ranges and files in line level history browser
Date: Sun, 9 May 2010 07:00:32 -0700
Message-ID: <p2q41f08ee11005090700xdb6070dajab0e2d77b1d0f9fc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Thomas Rast <trast@student.ethz.ch>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Jakub Narebski <jnareb@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 09 16:00:41 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OB73f-0007KG-9k
	for gcvg-git-2@lo.gmane.org; Sun, 09 May 2010 16:00:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753470Ab0EIOAe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 May 2010 10:00:34 -0400
Received: from mail-qy0-f183.google.com ([209.85.221.183]:34549 "EHLO
	mail-qy0-f183.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753092Ab0EIOAd (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 May 2010 10:00:33 -0400
Received: by qyk13 with SMTP id 13so4510757qyk.1
        for <git@vger.kernel.org>; Sun, 09 May 2010 07:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:cc:content-type;
        bh=dss4mOprKQlaEQuUR2UmCmRdAwsLHDiTgQsO/CYZuYc=;
        b=WyRMLLImObDVlMy4cAU1ddq+oHgsw1yxGafCCopi6gSuqQsC4Rg+xMcPO9q+7qZP3X
         TASYq1BWnWKJaKBCqv7Z26qa8Qbr9lMNrnBMMRJhqYdOMGc0O0e6bFE01BFANRUtMa+n
         /tuQe/sRM5nXOL4PI/ZV5ET0dIbMju+ejHsDI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        b=vOpxs4TM+Qw+rJTUqZCG5yofVoivXG+dAkmklYStv/HYkoi/pz7pzeQ//QY1LHXgnZ
         7thjL6V5q3/IWvYQw3zNHESMjDsVBg5n68/yKsgZgIWLxbbZlTaKhICfVt2v2XaDcGww
         nWMVVGzTUB9xc36+QYAEfV3HTKh7iwmelTDSI=
Received: by 10.224.72.34 with SMTP id k34mr1642737qaj.283.1273413632067; Sun, 
	09 May 2010 07:00:32 -0700 (PDT)
Received: by 10.229.97.80 with HTTP; Sun, 9 May 2010 07:00:32 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146725>

Hi,

    Since we want to support to browse the history of multiple line
ranges in multiple files, so we should design a workable way to let
users specify these kind of thing. Generally, git revision walking
mechanism support syntax like:

git log <revision> -- <file1> <file2>

That's that we can specify one revision and multiple files one time.
And the dashdash is optional. And I want to introduce a new way for
line ranges argument based on this, that is something like:

git log <revision> -L1,8 -L45,+6 <file1> -L/some/,/end/ -L9,29 <file2> <file3>

That's that putting the line ranges arguments just before the filename
argument.  And here, no dashdash should be provided by users, if there
is, all the following arguments are still take considered as normal
filenames. And this helps if there are some files in your working
directory called '-L1,8'... Yes, you can always try to browse the line
level history of such a strange file by 'git log -L1,8 <revision> --
-L1,8' .

And the principle for this:
1. After '--', all following arguments are treated as filenames, just
as what we do now;
2. After any <filename>, all following arguments are treated as
whether ranges or filenames, using -L to separate;
3. '-L' can be specified at any place, and all ranges will be assigned
to the first filename following the '-L';
4. If some file has no '-L', we will display the normal log for that
file just like git log -p <file>.

Since '-L' option is also used by many other command, I don't know the
exact impact of this, anyway we can use another name anytime...

If there is no opposition for this kind of option syntax, I will try
to implement it in revision.c. ;-)

Regards!
Bo
-- 
My blog: http://blog.morebits.org
