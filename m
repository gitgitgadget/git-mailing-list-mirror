From: David Lang <david@lang.hm>
Subject: Re: Git: How to keep multiple bare repos in sync?
Date: Tue, 2 Jun 2015 21:10:58 -0700 (PDT)
Message-ID: <alpine.DEB.2.02.1506022104320.3147@nftneq.ynat.uz>
References: <2015051312090840845945@126.com>,  <xmqq4mnhccti.fsf@gitster.dls.corp.google.com>,  <2015051315014048836362@126.com> <201506030955200885513@126.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="680960-1119848637-1433304658=:3147"
Cc: Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
To: chenxitwo <chenxitwo@126.com>
X-From: git-owner@vger.kernel.org Wed Jun 03 06:11:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z001S-0003d8-D3
	for gcvg-git-2@plane.gmane.org; Wed, 03 Jun 2015 06:11:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751028AbbFCELQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Jun 2015 00:11:16 -0400
Received: from mail.lang.hm ([64.81.33.126]:46090 "EHLO bifrost.lang.hm"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750743AbbFCELO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jun 2015 00:11:14 -0400
Received: from asgard.lang.hm (asgard.lang.hm [10.0.0.100])
	by bifrost.lang.hm (8.13.4/8.13.4/Debian-3) with ESMTP id t534AwDd023694;
	Tue, 2 Jun 2015 21:10:58 -0700
X-X-Sender: dlang@asgard.lang.hm
In-Reply-To: <201506030955200885513@126.com>
User-Agent: Alpine 2.02 (DEB 1266 2009-07-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270624>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--680960-1119848637-1433304658=:3147
Content-Type: TEXT/PLAIN; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Wed, 3 Jun 2015, chenxitwo wrote:

> Hi Konrad Scherer,
> 	Thanks for your reply.
>
> 	But git mirror is helpless for me.
> 	I have an idea about two repos' sync. However there is a problem with this is how to prevent other usrs' push operation.
>
> 	Details as follows:
> 	Team A, B have their own git server repos, respectively repos_A, repos_B.
> 	step1: The repos_A locking repos_B When repos_A received Team_A requests to push, and repos_B can't accept other users' push request. (use pre-receive hook)
> 	step2: After the repos_A is updated, the repos_A will send push request to the repos_B.
> 	step3: After the repos_B is updated, the repos_A will unlock the repos_B.
>
> 	Problem: How to lock git remote repos to prevent other usrs' push operation.

you can't lock the remote repos to prevent pushes to them.

This is the problem that Junio was referring to when he said that if people are 
pushing to all repos there is no general solution.

What you will need to do is to have someone reconcile the differences between 
the different repos periodically.

However, stepping back a bit. Why is it that you say that you don't have enough 
bandwidth between the sites? If you have the developers working with a local 
clone on their workstation, the bandwidth needed after the initial clone should 
be pretty low.

In any case, the issue is how much the work of the different developers overlap 
with each other. If they are all changing the same part of the code, you will 
have a problem. But if they are working on different areas, then you can use the 
branch and pull model where the developers do their development locally and then 
push what they have ready to integrate into a local (at least same building) 
repo and send a pull request to whoever is coordinating the changes, and they 
then pull all the different changes and deal with reconciling conflicts between 
them.

David Lang

>
>
> --------------
> chenxitwo
>> not remote sync.
>>
>> We have three teams to participate in the same project, and is located in different places. Bandwidth that between the two of our teams is not enough. Three teams have their own git server. Like this kind of situation, how should handle?
>>
>>
>>
>> chenxitwo
>>
>> From: Junio C Hamano
>> Date: 2015-05-13 12:37
>> To: chenxitwo
>> CC: git
>> Subject: Re: Git: How to keep multiple bare repos in sync?
>> chenxitwo <chenxitwo@126.com> writes:
>>
>>> There are three git server(bare repos), but i don't know to solve the
>>> problem that how to keep these git servers in sync.
>>
>> rsync?
>>
>> The problem is under-specified.  Is there one of them that is
>> authoritative and that the other ones should match its progress?
>> If so, perhaps push from the authoritative one to the other two
>> with "push --mirror" (or have the other ones "fetch --mirror")?
>>
>> If you are allowing people to push into any of them randomly,
>> then there is no general solution.  If I push an update to 'master'
>> of instance A while you update the same 'master' branch of instance
>> B, somebody has to reconcile the divergence between the two by
>> creating a merge, and that can possibly conflict, needing human
>> intervention to resolve.N嫥叉靣笡y???氊b瞂???千v豝???藓{.n???壏爦丕???洝塄}???财爖???j:+v墾???珣赙zZ+€???zf＂穐殘???啳嗃i???鄗???畐ア???櫒璀??????撷f
--680960-1119848637-1433304658=:3147--
