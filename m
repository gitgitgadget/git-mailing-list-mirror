From: Tor Arvid Lund <torarvid@gmail.com>
Subject: Re: git-p4 and git clone
Date: Tue, 23 Mar 2010 18:38:19 +0100
Message-ID: <1a6be5fa1003231038h695ebbf2k8a765b4a9b6e274d@mail.gmail.com>
References: <B978892CA0FBD142827E74F92AC4BBD429B2444D4D@HQMAIL03.nvidia.com>
	 <4880E32B-7880-40BF-8AFD-AC00DA457CEE@meyerhome.net>
	 <B978892CA0FBD142827E74F92AC4BBD429B2444D5C@HQMAIL03.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Benjamin Meyer <ben@meyerhome.net>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Thomas Kistler <tkistler@nvidia.com>
X-From: git-owner@vger.kernel.org Tue Mar 23 18:38:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nu83f-0000AQ-Cl
	for gcvg-git-2@lo.gmane.org; Tue, 23 Mar 2010 18:38:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753081Ab0CWRiW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 23 Mar 2010 13:38:22 -0400
Received: from fg-out-1718.google.com ([72.14.220.159]:27060 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751343Ab0CWRiV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 23 Mar 2010 13:38:21 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1116125fgg.1
        for <git@vger.kernel.org>; Tue, 23 Mar 2010 10:38:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=3eF6UhjxXEcGi19TVBKNUG/G+dnuOIp60+HzxxENSgU=;
        b=a/iBLTRAmUMdOcpV8hapd7/HpzpTjPB1fDPKRvfKusgVPSllTjGw0ZoMfztNeL1++s
         aj6cOJMOc/uqq2JjMmyhXQnijBsXUVaPMfc/3OOZozcTm2e+Qros2aoM0mlKVzWPzlPg
         +R/mCMLAzPrXL1um2eBb0OU4qq6DxtWgteWX8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=xCrm9pWso/zttbfkI/0Mj/bWxyDwzfzdui/6apU6m2Fpm/0U/k9mIa69w6KoRSf1jr
         tOxThPQ6zthKRdDB6gaX6Y0sgvsH0ZbsQzEC9IuoNyzUtzzvLBcWLCe/FSpf+PspgNtz
         MptkmihZuj08XrvhUFyqV64yM13JV1gaQOf78=
Received: by 10.204.36.82 with SMTP id s18mr4247959bkd.94.1269365899344; Tue, 
	23 Mar 2010 10:38:19 -0700 (PDT)
In-Reply-To: <B978892CA0FBD142827E74F92AC4BBD429B2444D5C@HQMAIL03.nvidia.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143035>

On Tue, Mar 23, 2010 at 4:37 PM, Thomas Kistler <tkistler@nvidia.com> w=
rote:
> That doesn't seem to work. With --import-local, I can't even submit b=
ack from the original repository.

Hi.

=46or me it works in this scenario:
If your perforce depot is A, you "git-p4 clone --import-local" that
into B, then git clone B into C. From C you should be able to do
git-p4 submit.

So, my normal recipe (if anyones interested) is to not use B for
anything other than importing from p4 and functioning as a clone
source. Like so:

$ git-p4 clone --import-local //depot/A@all B
$ mv B/.git B.git
$ rm -rf B
$ cd B.git
$ git config core.bare true
$ rm refs/heads/master
$ echo ref: refs/heads/p4/master > HEAD

(Then I have a script that does "git-p4 sync --import-local" every so
often in this repo)

=2E.. And then on my working computer, I do:

$ git clone user@remote:B.git C
$ cd C
$ [work, work, work, git commit]
$ git-p4 submit

=2E..And every so often:
$ git-p4 sync

(Disclaimer: recipe from memory... might not be 100% correct :-/)

-Tor Arvid-

> =C2=A0 =C2=A0$ cd tmp1
> =C2=A0 =C2=A0$ git-p4 clone --import-local //foo/bar
> =C2=A0 =C2=A0$ cd bar
> =C2=A0 =C2=A0$ git checkout p4/master
> =C2=A0 =C2=A0$ git-p4 submit --verbose
>
> Reading pipe: git name-rev HEAD
> Reading pipe: git config git-p4.allowSubmit
> Reading pipe: git rev-parse --symbolic =C2=A0--remotes
> Reading pipe: git cat-file commit HEAD~0
> Reading pipe: git cat-file commit HEAD~1
> fatal: Not a valid object name HEAD~1
>
>
> -----Original Message-----
> From: Benjamin Meyer [mailto:ben@meyerhome.net]
> Sent: Monday, March 22, 2010 5:15 PM
> To: Thomas Kistler
> Cc: 'git@vger.kernel.org'
> Subject: Re: git-p4 and git clone
>
>
> On Mar 22, 2010, at 7:16 PM, Thomas Kistler wrote:
>
>> I'm probably missing something fairly fundamental but I'm running in=
to problems with cloning a git-p4 repository:
>>
>> First, I'm setting up a git-p4 master repository:
>>
>> =C2=A0 =C2=A0$ cd tmp1
>> =C2=A0 =C2=A0$ git-p4 clone //foo/bar
>>
>> Then I'm cloning it through git:
>>
>> =C2=A0 =C2=A0$ cd tmp2
>> =C2=A0 =C2=A0$ git clone tmp1/bar
>>
>> Finally, I'm trying to submit back to p4:
>>
>> =C2=A0 =C2=A0$ git-p4 submit
>>
>> This now fails because the remotes/p4/master seems to get lost when =
doing the "git clone". Is this supposed to work?
>>
>> -Thomas
>
> There is a -import-local option you can use. =C2=A0Then the p4/master=
 branch is local and when you do the second clone you will get the p4/m=
aster branch.
>
> -Benjamin Meyer
> ---------------------------------------------------------------------=
--------------
> This email message is for the sole use of the intended recipient(s) a=
nd may contain
> confidential information. =C2=A0Any unauthorized review, use, disclos=
ure or distribution
> is prohibited. =C2=A0If you are not the intended recipient, please co=
ntact the sender by
> reply email and destroy all copies of the original message.
> ---------------------------------------------------------------------=
--------------
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
>
