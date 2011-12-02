From: Neal Kreitzinger <nkreitzinger@gmail.com>
Subject: Re: Anyone have a commit hook for forbidding old branches from being
 merged in?
Date: Thu, 01 Dec 2011 19:37:14 -0600
Message-ID: <4ED82BCA.5080909@gmail.com>
References: <CACBZZX4LyTaz=fU1vvgpeL904QFjJULCMVSP0uutcuxZT+-vWQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 02 02:37:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RWI45-0008FS-3V
	for gcvg-git-2@lo.gmane.org; Fri, 02 Dec 2011 02:37:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756244Ab1LBBhU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 1 Dec 2011 20:37:20 -0500
Received: from mail-gy0-f174.google.com ([209.85.160.174]:50082 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756158Ab1LBBhT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Dec 2011 20:37:19 -0500
Received: by ghrr1 with SMTP id r1so2429733ghr.19
        for <git@vger.kernel.org>; Thu, 01 Dec 2011 17:37:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:newsgroups:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=I3qyUigSm35yFwrDyPkGcPDDk1QZdGSu5L3fbFt6SmA=;
        b=t7bBZmwmaJ3Ge6pEPmfKeZHd9RzGZ/yqbgDownelFlsLhT8gSN59ak+Wj3tW6wAeoZ
         IKfvbTENBA6avltdGGcFFXJHOonVbGqbfRuidbAD7ZMQiwyXgJGV1H/yiuTa5daWhzlB
         hoRVHlf2UUYKNfZzm9blm0OVv8JSl6yk219eU=
Received: by 10.236.131.82 with SMTP id l58mr15450630yhi.36.1322789838412;
        Thu, 01 Dec 2011 17:37:18 -0800 (PST)
Received: from [172.25.2.210] ([67.63.162.200])
        by mx.google.com with ESMTPS id h28sm20279415ani.17.2011.12.01.17.37.17
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 01 Dec 2011 17:37:17 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.2.24) Gecko/20111103 Thunderbird/3.1.16
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <CACBZZX4LyTaz=fU1vvgpeL904QFjJULCMVSP0uutcuxZT+-vWQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186208>

On 12/1/2011 9:34 AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> I work on a web application that due to underlying database schema
> changes etc only even compiles and runs for a given 2 week moving
> window.
>
> Thus if someone started a branch say 1 month ago, works on it one and
> off, and then merges it back into the mainline it becomes impossible
> to bisect that code if it has a problem. You either have to:
>
> * Revert the whole merge * Manually eyeball the code to see where
> the error might be * Brute-force manually bisect it by checking out
> only the files altered in those commits instead of the commit at a
> given data. Usually individual files are still compatible with the
> new code.
>
> But the whole reason this is a problem is because people don't rebase
> their branches before merging them in, unintentionally causing
> problems.
>
> So before I write a hook to do this, is there anything that
> implements a hook that:
>
> * Checks if you're pushing a merge commit * If so, is that merge
> based off and old version of $MAINBRANCH * Is the base of that
> branch more than N days old? * If so reject the push

It sounds like you're saying that people should rebase before merging t=
o=20
main.  That means their merge would be a fast-forward.  You could just=20
reject anyone who has not done a current rebase.  Then you could use=20
this technique from the pre-rebase.sample hook to enforce up-to-date=20
rebases:

only_in_main=3D'git rev-list "^$topic" main'
if test -z "$only-in-main"
then
     exit 0
else
     echo >&2 "error: please rebase on main before merging to main."
     exit 1
fi

v/r,
neal
