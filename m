From: david@lang.hm
Subject: Re: is gitosis secure?
Date: Sun, 14 Dec 2008 03:25:17 -0800 (PST)
Message-ID: <alpine.DEB.1.10.0812140304320.17688@asgard.lang.hm>
References: <200812090956.48613.thomas@koch.ro> <bd6139dc0812090138l5dbaf20bsd1cde00f52bb94e5@mail.gmail.com> <87hc58hwmi.fsf@hades.wkstn.nix> <gi1qsl$22p$1@ger.gmane.org> <alpine.DEB.1.10.0812132126470.17688@asgard.lang.hm> <4944D4F7.7050501@siamect.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: git@vger.kernel.org
To: martin <martin@siamect.com>
X-From: git-owner@vger.kernel.org Sun Dec 14 11:29:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LBoE8-00015N-HL
	for gcvg-git-2@gmane.org; Sun, 14 Dec 2008 11:29:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752536AbYLNKYQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Dec 2008 05:24:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752464AbYLNKYQ
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Dec 2008 05:24:16 -0500
Received: from mail.lang.hm ([64.81.33.126]:37354 "EHLO bifrost.lang.hm"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752438AbYLNKYP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Dec 2008 05:24:15 -0500
Received: from asgard.lang.hm (asgard.lang.hm [10.0.0.100])
	by bifrost.lang.hm (8.13.4/8.13.4/Debian-3) with ESMTP id mBEAO6n2029651;
	Sun, 14 Dec 2008 02:24:06 -0800
X-X-Sender: dlang@asgard.lang.hm
In-Reply-To: <4944D4F7.7050501@siamect.com>
User-Agent: Alpine 1.10 (DEB 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103056>

On Sun, 14 Dec 2008, martin wrote:

> Dear David.
> Why do you trust VPN more than the SSH?
> I ask because I have just removed the "first VPN then SSH" solution in favor 
> for a SSH only solution using Gitosis just to get rid of the VPN which I 
> believe is less secure than SSH (well until I read you comments below).
> I thought I was doing something right for once but maybe I'm not?
> Thanks and best regards
> Martin

in part it's that a VPN is a single point of control for all remote 
access.

If you use ssh you end up exposing all the individual machines

1. data leakage of just what machines exist to possibly hostile users.

2. the many machines are configured seperatly, frequently by different 
people. this makes it far more likely that sometime some machine will get 
misconfigured.

3. people who are focused on providing features have a strong temptation 
to cut corners and just test that the feature works and not test that 
everything that isn't supposed to work actually doesn't work. as a 
result, in many companies there is a deliberate seperation (and tension) 
between a group focused on controlling and auditing access and one that is 
focused on creating fucntionality and features.

also from a polical/social point of view everyone recognises that if you 
grant someone VPN access you are trusting them, but people don't seem to 
think the same way with ssh.

David Lang

> david@lang.hm wrote:
>> this is really a reply to an earlier message that I deleted.
>> 
>> the question was asked 'what would the security people like instead of SSH'
>> 
>> as a security person who doesn't like how ssh is used for everything, let 
>> me list a couple of concerns.
>> 
>> ssh is default allow (it lets you run any commands), you can lock it down 
>> with effort.
>> 
>> ssh defaults to establishing a tunnel between machines that other network 
>> traffic can use to bypass your system. yes I know that with enough effort 
>> and control of both systems you can tunnel over anything, the point is that 
>> ssh is eager to do this for you (overly eager IMHO)
>> 
>> ssh depends primarily on certificates that reside on untrusted machines. it 
>> can be made to work with tokens or such, but it takes a fair bit of effort.
>> 
>> sshd runs as root on just about every system
>> 
>> people trust ssh too much. they tend to think that anything is acceptable 
>> if it's done over ssh (this isn't a technical issue, but it is a social 
>> issue)
>> 
>> 
>> what would I like to see in an ideal world?
>> 
>> something that runs as the git user, does not enable tunneling, and only 
>> does the data transfer functions needed for a push. it should use 
>> off-the-shelf libraries for certificate authentication and tie into PAM for 
>> additional authentication.
>> 
>> the authentication would not be any better than with SSH, but the rest 
>> would be better. I was very pleased to watch the git-daemon development, 
>> and the emphisis on it running with minimum privilages and provide just the 
>> functionality that was needed, and appropriately assuming that any 
>> connection from the outside is hostile until proven otherwise.
>> 
>> 
>> what would I do with current tools?
>> 
>> I would say that developers working from outside should VPN into the 
>> company network before doing the push with SSH rather than exposing the SSH 
>> daemon to the entire Internet.
>> 
>> in the medium term, if the git-over-http gets finished, I would like to see 
>> a seperate cgi created to allow push as well. http is overused as a 
>> tunneling protocol, but it's easy to setup a server that can't do anything 
>> except what you want, so this tunneling is generally not a threat to 
>> servers (it's a horrible threat to client systems)
>> 
>> David Lang
>> -- 
>> To unsubscribe from this list: send the line "unsubscribe git" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> 
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
