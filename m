From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Copying Git repository from Linux to Windows.
Date: Wed, 15 Jun 2011 13:29:52 +0200
Message-ID: <201106151329.53839.jnareb@gmail.com>
References: <4DF87B42.1020004@st.com> <m3ei2vv0nw.fsf@localhost.localdomain> <4DF891CC.1040700@st.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Shiraz HASHIM <shiraz.hashim@st.com>,
	Vipin KUMAR <vipin.kumar@st.com>
To: viresh kumar <viresh.kumar@st.com>
X-From: git-owner@vger.kernel.org Wed Jun 15 13:30:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QWoIT-00086H-Px
	for gcvg-git-2@lo.gmane.org; Wed, 15 Jun 2011 13:30:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755017Ab1FOLaF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Jun 2011 07:30:05 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:50703 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754941Ab1FOLaE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Jun 2011 07:30:04 -0400
Received: by bwz15 with SMTP id 15so365091bwz.19
        for <git@vger.kernel.org>; Wed, 15 Jun 2011 04:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=G0EMbfa55moDcsl9ADELF9+RSr+8NbYSMigv5GlwCsw=;
        b=gIZmNzHkrgnbe8U8jQVEhaqyBXf8k1qvRSYNDtfyO/qbqvihdlGH+AxTYgurvGVWNi
         lrJv3Wx9i/aLn+CiX4hV3efsyXrZnPdbe1OZ+0kKohtWvh8V0pcDjwiP2Hf5TdD7i43n
         Fdk/EG8bcmV9fdv/X5RpGiOiY80droUvO4kXI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=hVaY42Txguqlk0Alpwp0qhfyxbmjRc0z+aYUIZKw6ikKxYtwn8x8XxTDhKblvxk5Ot
         T8zdKMqClOxohnVS9GHsXphnHfcoatFIvXqPCNqeYYH7oLZOxOz4Yyzuf+bJyK7seLCb
         y3Xy0GT/I79Sc2JDe4IvUQNXceYxrhJrAS/ik=
Received: by 10.205.35.1 with SMTP id su1mr399123bkb.129.1308137402601;
        Wed, 15 Jun 2011 04:30:02 -0700 (PDT)
Received: from [192.168.1.15] (abwp5.neoplus.adsl.tpnet.pl [83.8.239.5])
        by mx.google.com with ESMTPS id k16sm364901bks.1.2011.06.15.04.30.00
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 15 Jun 2011 04:30:01 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <4DF891CC.1040700@st.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175825>

On Wed, 15 June 2011, viresh kumar wrote:
> On 06/15/2011 04:10 PM, Jakub Narebski wrote:
>> viresh kumar <viresh.kumar@st.com> writes:

>>> After completing copy operation on mem stick, i found something strange.
>>> - git branch shows correct results and is exactly same of state at Linux machine.
>>> - git log is also fine.
>>> - git status, shows me a lot of files are modified, which is not present in Linux.
>> 
>> That is probably because stat information is stale... or stat
>> information doesn't work.  Does second "git status" still show files
>> as modified?
> 
> Yes. The files status is same.
> 
>>> - git reset --hard also doesn't work and fails with following error.
>>>
>>> $ git reset --hard HEAD
>>> error: unable to create symlink arch/microblaze/boot/dts/system.dts (Operation not permitted)
>>> Checking out files: 100% (36696/36696), done.
>>> fatal: Could not reset index file to revision 'HEAD'.
>> 
>> Try setting `core.symlinks` to false, or just try
>> 
>>  $ git -c core.symlinks=false reset --hard HEAD
[...]
>> BTW. what filesystem do you use?
>> 
> 
> It was FAT on memory stick as FAT is also there in Windows PC.
> More observation: All files marked modified had only changes in file permissions.
> i.e. 755 instead of 644. chmod doesn't work with FAT so can't change there permissions
> now.

Ah. This is caused by the fact that FAT doesn't store executable
permission.

> Problem is not only for symlinks but standard c files too.

So beside setting `core.symlinks` to false, you would have also set
`core.filemode` to false (and perhaps also `core.ignorecase` to true).

You might also want to set `core.ignoreStat` to true to try to increase
performace.

P.S. git-bundle ddidn't work?

-- 
Jakub Narebski
Poland
