From: A Large Angry SCM <gitzilla@gmail.com>
Subject: t9118 broken in current master, 9918285, git/git/v1.7.2-rc2
Date: Wed, 07 Jul 2010 21:49:41 -0400
Message-ID: <4C352EB5.5020005@gmail.com>
Reply-To: gitzilla@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 08 03:49:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OWgFO-0000mg-Ks
	for gcvg-git-2@lo.gmane.org; Thu, 08 Jul 2010 03:49:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758115Ab0GHBtt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Jul 2010 21:49:49 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:33252 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757264Ab0GHBts (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Jul 2010 21:49:48 -0400
Received: by gxk23 with SMTP id 23so155525gxk.19
        for <git@vger.kernel.org>; Wed, 07 Jul 2010 18:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id
         :disposition-notification-to:date:from:reply-to:user-agent
         :mime-version:to:subject:content-type:content-transfer-encoding;
        bh=bNKMWHL/KcxTaDES+i42mPgJB3xAOFqOZJsao6zQ3UE=;
        b=V/Cx0BTYHb1z6ip4EH1E1hZzNvRGkkcM8HLrJTkjPBAjHoLiso60O86OI5exb4Rylj
         zGPBxrDQ8cwPaRlktlvUkAnXstiUc1/B5KDS5r3433iacS680G4q1uvTvnKF7pey6orA
         /b7Z5Gl78cNK0kktBAqCQt6vqhFa/ckr9sT7Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:disposition-notification-to:date:from:reply-to
         :user-agent:mime-version:to:subject:content-type
         :content-transfer-encoding;
        b=W+gIumTniC1SsIe/vG3RlR6h2JQYeSFnat+4uUUnD260WHU3Kh36notXNT6arJGGJS
         vY2a84g5xzX9N5fjEG4r5V7qOyHVT2F8kHOUH7Jsy32YYGn8rUb/oxY78HMt+p0CnTKP
         UhKrdYOFlcnFUBc6oM4qMFIGAUz0QC0ShXYOo=
Received: by 10.101.106.36 with SMTP id i36mr8811806anm.134.1278553788017;
        Wed, 07 Jul 2010 18:49:48 -0700 (PDT)
Received: from [10.0.1.133] (c-24-129-111-166.hsd1.fl.comcast.net [24.129.111.166])
        by mx.google.com with ESMTPS id h5sm72062484anb.8.2010.07.07.18.49.46
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 07 Jul 2010 18:49:47 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.10) Gecko/20100620 Icedove/3.0.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150524>

I've been busy with other projects and haven't attempted a full make & 
make test since f526d12, which did pass all the tests. Since the test 
name implies svn/git-svn breakage, I hoping the git-svn experts can find 
the problem.

This was on an amd64 Debian Squeeze system, up to date as of about 13:00 
EDT today.


*** t9118-git-svn-funky-branch-names.sh ***
ok 1 - setup svnrepo
not ok - 2 test clone with funky branch names
#
#               git svn clone -s "$svnrepo/pr ject" project &&
#               cd project &&
#                       git rev-parse "refs/remotes/fun%20plugin" &&
#                       git rev-parse "refs/remotes/more%20fun%20plugin!" &&
#                       git rev-parse "refs/remotes/$scary_ref" &&
#                       git rev-parse "refs/remotes/%2Eleading_dot" &&
#                       git rev-parse "refs/remotes/trailing_dot%2E" &&
#                       git rev-parse 
"refs/remotes/trailing_dotlock%2Elock" &&
#                       git rev-parse "refs/remotes/not-a%40{0}reflog" &&
#               cd ..
#
not ok - 3 test dcommit to funky branch
#
#               cd project &&
#               git reset --hard 'refs/remotes/more%20fun%20plugin!' &&
#               echo hello >> foo &&
#               git commit -m 'hello' -- foo &&
#               git svn dcommit &&
#               cd ..
#
not ok - 4 test dcommit to scary branch
#
#               cd project &&
#               git reset --hard "refs/remotes/$scary_ref" &&
#               echo urls are scary >> foo &&
#               git commit -m "eep" -- foo &&
#               git svn dcommit &&
#               cd ..
#
not ok - 5 test dcommit to trailing_dotlock branch
#
#               cd project &&
#               git reset --hard "refs/remotes/trailing_dotlock%2Elock" &&
#               echo who names branches like this anyway? >> foo &&
#               git commit -m "bar" -- foo &&
#               git svn dcommit &&
#               cd ..
#
# failed 4 among 5 test(s)
