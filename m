From: Marek Zawirski <marek.zawirski@gmail.com>
Subject: Re: problem using jgit
Date: Tue, 22 Jul 2008 13:51:36 +0200
Message-ID: <4885C9C8.9090003@gmail.com>
References: <p06240809c4a9d887fda4@[192.168.1.106]> <488467E3.7000107@gmail.com> <488482A2.4000601@gmail.com> <p0624080dc4aa78c93ffe@[192.168.1.106]>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Robin Rosenberg <robin.rosenberg@dewire.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Stephen Bannasch <stephen.bannasch@deanbrook.org>
X-From: git-owner@vger.kernel.org Tue Jul 22 13:52:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLGQA-0008Fz-2E
	for gcvg-git-2@gmane.org; Tue, 22 Jul 2008 13:52:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751994AbYGVLvq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jul 2008 07:51:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751669AbYGVLvq
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Jul 2008 07:51:46 -0400
Received: from fg-out-1718.google.com ([72.14.220.154]:56311 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751212AbYGVLvp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jul 2008 07:51:45 -0400
Received: by fg-out-1718.google.com with SMTP id 19so846024fgg.17
        for <git@vger.kernel.org>; Tue, 22 Jul 2008 04:51:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=kLA5TsY7zyYUqz3Uf51TnBpAkxi6s1AWNXEnlESv2P0=;
        b=K6V86mzuiR7MgdH6WKe2kPQofIlkWXJYGQTCN1+oJmyCDAb9GeAL1dKbdX/54ulbHy
         tLlVnUSaZVuRYxbFyyx0KX/sUp7FhalshxfvoeA6qzz74CFLoJPbBrts61muQinPF/TQ
         hWzInuYtJfxRXb9FrkYSVLPaHn5sNCcdiOSwI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=BuUJTkHHK4OCsGar4YN4i3zfvUYVMdtRfv+xFSgNWC9ynNxjQJ8qCOPbuZVY0jT7Mw
         Qh8SGW8KU4G2hqCC7O5SY3GignpJ8XAJ6S1Pkpka40Hen8Z2EHkN977b26HBlnWPetcI
         7u4ug92OiYWML/evAaifoP/Deh4mCSnLg+kPg=
Received: by 10.86.49.13 with SMTP id w13mr349306fgw.30.1216727501625;
        Tue, 22 Jul 2008 04:51:41 -0700 (PDT)
Received: from ?192.168.1.167? ( [150.254.6.130])
        by mx.google.com with ESMTPS id e11sm10251452fga.4.2008.07.22.04.51.38
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 22 Jul 2008 04:51:39 -0700 (PDT)
User-Agent: Mozilla-Thunderbird 2.0.0.14 (X11/20080509)
In-Reply-To: <p0624080dc4aa78c93ffe@[192.168.1.106]>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89488>

Stephen Bannasch wrote:
> At 2:35 PM +0200 7/21/08, Marek Zawirski wrote:
>   
>> Marek Zawirski wrote:
>>     
>>> Stephen Bannasch wrote:
>>>       
>>>> I've setup a simple test class that integrates jgit to clone a git repository. However I'm getting a NullPointerError when RevWalk.parseAny ends up producing a null object id.
>>>>
>>>> The code and the stack trace for the error are here:
>>>>
>>>>  http://pastie.org/237711
>>>>
>>>> This problem occurs using the jgit from the master branch from this repo:
>>>>
>>>>  git://repo.or.cz/egit.git
>>>>         
>>> Hello Stephen,
>>>
>>> I think you've experienced error caused by the same bug as me, during my latest fetch/push GUI works few days ago.
>>> Your code looks fine, probably  it's actually bug in jgit. I think it's some regression. Thanks for reporting.
>>>       
>> It's caused by 14a630c3: Cached modification times for symbolic refs too
>> Changes introduced by this patch made Repository#getAllRefs() including Ref objects with null ObjectId in case of unresolvable (invalid?) HEAD symbolic ref, and null Ref for HEAD  when it doesn't exist. Previous behavior was just not including such refs in result.
>>
>> Fix for null Ref is just a matter of simple filtering out null Ref object for HEAD, if it doesn't exist (just is it considered to be legal state of repository when HEAD doesn't exist?).
>>
>> To fix null ObjectId issue, we have to either change all clients of this method or revert method to previous behavior. Now it's just unspecified in javadoc.
>> Robin, Shawn, what do you think? If we want to have unresolvable refs included, IMO it may be sensible to provide argument includeUnresolbable for Repository#getAllRefs() to let clients avoid burden of filtering them out when they don't need them (most cases, perhaps).
>> I can prepare fix for it (rather easy one) as you are unavailable now, let me now what's your opinion.
>>     
>
> Thanks for looking at this problem Marek. 
>
> If you get a change working for jgit that might not be available in a branch on git://repo.or.cz/egit.gi will you send a patch.
>
> I am looking forward to continuing my tests using jgit from Java and JRuby.
>   

You can find temporary workaround for that in "workaround" branch at 
git://repo.or.cz/egit/zawir.git
It's rather not a final solution (disables unresolvable HEADs), but I 
hope it let you continue using jgit for a while, as it does for me ;)
