From: Brent Goodrick <bgoodr@gmail.com>
Subject: Re: "warning: no common commits" triggered due to change of remote's 
	IP address?
Date: Sun, 1 Mar 2009 15:01:20 -0800
Message-ID: <e38bce640903011501t2c7a134dp887f5a96db3db0f4@mail.gmail.com>
References: <e38bce640903011001p2d705707o9f7145ab5ab68929@mail.gmail.com>
	 <200903012221.03662.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Mon Mar 02 00:02:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LdugO-0006M7-4r
	for gcvg-git-2@gmane.org; Mon, 02 Mar 2009 00:02:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756385AbZCAXBY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Mar 2009 18:01:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755255AbZCAXBY
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Mar 2009 18:01:24 -0500
Received: from yx-out-2324.google.com ([74.125.44.30]:44108 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754755AbZCAXBX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Mar 2009 18:01:23 -0500
Received: by yx-out-2324.google.com with SMTP id 8so1369262yxm.1
        for <git@vger.kernel.org>; Sun, 01 Mar 2009 15:01:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=gj7banhxGikaS8/g4FJJ+8870vCPIyMiRrXm7gKctFc=;
        b=lzV2fQwOsDGz1WSXyrkTsf2iEKxGLH6RqE0kuiAnh1IZPfizjpSM5cacWKs3FJBN8x
         QFvz2CwqP73y56M7uk3fD/rP2G/gy++9kFTQrlrqqK9YTW1ZNVLkAgVBbxgqsE5i3IbJ
         OOEuS9e1lLgbEazA3OYMk2XKSBs4DVSo30qZQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=NqDlZ2elEWBiI77fdwF3z0H1rI5iquJdpLLT9QoB4/4/PrgGlmm9ZNCkBzq2nkCzTE
         ZvQT1yOve8Qq9kQmtlqGD20yAO2Ccc0WQFYuCNx5s5o+Wdix1XsiU9R7b8d1k4pCVUd4
         tSAWWiRWk2H/vkoQZNrkLG5gNMBe571UxVmBM=
Received: by 10.90.71.16 with SMTP id t16mr2360611aga.120.1235948480796; Sun, 
	01 Mar 2009 15:01:20 -0800 (PST)
In-Reply-To: <200903012221.03662.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111895>

On Sun, Mar 1, 2009 at 1:20 PM, Thomas Rast <trast@student.ethz.ch> wrote:
> However, your use of + refspecs in
>
>>   gitw fetch 88.99.100.101:git.repos/environ.git
>> +refs/heads/home:refs/remotes/origin/home
>
> makes me wonder: have you rewritten the repo hosting 'home' between
> two fetches?  Using (especially, but not only) git-filter-branch can
> easily render your history disjoint from the pre-filtering state.
>
>>   warning: no common commits
>
> Either your history is very short and really has no common commits
> whatsoever, or it gave up because of the 256 revision limit during
> find_common().

Hmmm, maybe, without knowing it. Originally, that section of the
.git/config file had "*"'s where "home" was. To clarify, the original
was:

[remote "origin"]
	url = <some_ip_address>:git.repos/environ.git
	fetch = +refs/heads/*:refs/remotes/origin/*

and the current one is now:

[remote "origin"]
	url = <some_ip_address>:git.repos/environ.git
	fetch = +refs/heads/home:refs/remotes/origin/home

Maybe I had made that change and this is the first time I am doing a
fetch to using that change. I thinking that was the cause of this,
because I retried doing a fetch into a separate throw-away repo with
just the change of IP address, and it did not need to fetch anything
more. I had not executed git-filter-branch at all.

>>  1. Will terminating the git fetch like I did leave the satellite repo
>>     in an inconsistent state? If so, is my only choice to start
>>     a new repo from scratch on the satellite machine, or is there some
>>     repair mechanism?
>
> It will just leave a temporary pack file that git-gc will eventually
> remove.  You can just try another fetch later.

Good, that is what I would have expected.

Brent
