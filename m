From: A Large Angry SCM <gitzilla@gmail.com>
Subject: Re: [PATCH] t9118 (git-svn): prevent early failure from taking down
 later tests
Date: Thu, 08 Jul 2010 10:35:28 -0400
Message-ID: <4C35E230.8020202@gmail.com>
References: <4C352EB5.5020005@gmail.com> <20100708133602.GA1882@burratino>
Reply-To: gitzilla@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Torsten Schmutzler <git-ts@theblacksun.eu>,
	Eric Wong <normalperson@yhbt.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 08 16:35:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OWsCQ-0008W5-9W
	for gcvg-git-2@lo.gmane.org; Thu, 08 Jul 2010 16:35:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753555Ab0GHOfc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Jul 2010 10:35:32 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:47075 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752094Ab0GHOfb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Jul 2010 10:35:31 -0400
Received: by gye5 with SMTP id 5so401643gye.19
        for <git@vger.kernel.org>; Thu, 08 Jul 2010 07:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id
         :disposition-notification-to:date:from:reply-to:user-agent
         :mime-version:to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=0Z7HTXguokpfr9k0QyfODzrtCg1s7UUpb9u7tYnWTp0=;
        b=bofEgZ0nS4jw4aCts4//JinyklIwXQWhdxTAfvfBR94jQKY/gdG0TLZYAbmRQ9Zo6t
         EY3Ri9xFM/GCsN0xZZQ6gA3wNU2P9L3xf77Fy7+HO/u1SW0/rLUY97F2b107tDThrNdI
         DJunAKi3ipbbUawr+ofitO99oZTvX8V84farc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:disposition-notification-to:date:from:reply-to
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        b=uaz0E6p6Ju3tkZ1y8tTjus/+CIn/7fKAbnnoUKPJv89acES6ma+8IvNZ0j3T1Lvsom
         iGsygulTDJdJVJrNFClV2TVmOhKdjQTY01v4klxq74DQSw6vDJNwCS7yHNU5HvlZ+SL5
         5Fq6xE3l8mKyQDCb584CTw1yylNaOTIABTZDI=
Received: by 10.100.92.18 with SMTP id p18mr9637487anb.181.1278599730913;
        Thu, 08 Jul 2010 07:35:30 -0700 (PDT)
Received: from [10.0.1.133] (c-24-129-111-166.hsd1.fl.comcast.net [24.129.111.166])
        by mx.google.com with ESMTPS id 14sm79382402ant.21.2010.07.08.07.35.29
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 08 Jul 2010 07:35:29 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.10) Gecko/20100620 Icedove/3.0.5
In-Reply-To: <20100708133602.GA1882@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150578>

On 07/08/2010 09:36 AM, Jonathan Nieder wrote:
> When test #2 fails, the cwd is project/, causing all the
> remaining tests in the same script to get confused and fail.
>
> So in the spirit of v1.7.1.1~53^2~10 (t5550-http-fetch: Use subshell
> for repository operations, 2010-04-17), use a subshell for svn
> working copy operations.  This way, the cwd will reliably return
> to the top of the trash directory and later tests can still be run
> when a command has failed.
>
> Reported-by: A Large Angry SCM<gitzilla@gmail.com>
> Signed-off-by: Jonathan Nieder<jrnieder@gmail.com>
> ---
> A Large Angry SCM wrote:
>
>> *** t9118-git-svn-funky-branch-names.sh ***
>> ok 1 - setup svnrepo
>> not ok - 2 test clone with funky branch names
>
> Relates to an svn change from some point between 1.5.1 and 1.6.12.
> Not solved yet.  See
> <http://thread.gmane.org/gmane.comp.version-control.git/146498/focus=150549>.
>
>> not ok - 3 test dcommit to funky branch
>> not ok - 4 test dcommit to scary branch
>> not ok - 5 test dcommit to trailing_dotlock branch
>
> Collateral damage.  How about this patch?
>
>   t/t9118-git-svn-funky-branch-names.sh |   46 ++++++++++++++++++---------------
>   1 files changed, 25 insertions(+), 21 deletions(-)
>
> diff --git a/t/t9118-git-svn-funky-branch-names.sh b/t/t9118-git-svn-funky-branch-names.sh
> index 7d7acc3..5dbea59 100755
[...]


With this patch, test 2 still fails but the others now pass.


*** t9118-git-svn-funky-branch-names.sh ***
ok 1 - setup svnrepo
not ok - 2 test clone with funky branch names
#
#               git svn clone -s "$svnrepo/pr ject" project &&
#               (
#                       cd project &&
#                       git rev-parse "refs/remotes/fun%20plugin" &&
#                       git rev-parse "refs/remotes/more%20fun%20plugin!" &&
#                       git rev-parse "refs/remotes/$scary_ref" &&
#                       git rev-parse "refs/remotes/%2Eleading_dot" &&
#                       git rev-parse "refs/remotes/trailing_dot%2E" &&
#                       git rev-parse 
"refs/remotes/trailing_dotlock%2Elock" &&
#                       git rev-parse "refs/remotes/not-a%40{0}reflog"
#               )
#
ok 3 - test dcommit to funky branch
ok 4 - test dcommit to scary branch
ok 5 - test dcommit to trailing_dotlock branch
# failed 1 among 5 test(s)
1..5
