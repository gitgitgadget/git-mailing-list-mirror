From: "=?ISO-8859-1?Q?=D8yvind_Harboe?=" <oyvind.harboe@zylin.com>
Subject: Re: Problems getting rid of large files using git-filter-branch
Date: Wed, 7 Jan 2009 11:15:53 +0100
Message-ID: <c09652430901070215p436db79boae4c56bfa1afbc1a@mail.gmail.com>
References: <c09652430901061359q7a02291fk656ab23e54b19f5e@mail.gmail.com>
	 <alpine.DEB.1.00.0901062319070.30769@pacific.mpi-cbg.de>
	 <c09652430901061436w36c013ep938e9cfba43140c9@mail.gmail.com>
	 <alpine.DEB.1.00.0901071101480.7496@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jan 07 11:17:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LKVTb-00036x-FP
	for gcvg-git-2@gmane.org; Wed, 07 Jan 2009 11:17:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753075AbZAGKP6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 7 Jan 2009 05:15:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752809AbZAGKP6
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Jan 2009 05:15:58 -0500
Received: from mail-bw0-f21.google.com ([209.85.218.21]:48416 "EHLO
	mail-bw0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757512AbZAGKP4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 7 Jan 2009 05:15:56 -0500
Received: by bwz14 with SMTP id 14so25250631bwz.13
        for <git@vger.kernel.org>; Wed, 07 Jan 2009 02:15:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references
         :x-google-sender-auth;
        bh=4rCzmVngO8EUBtwVqp0d8dbnOXFUfeTtMXPEfGpllKE=;
        b=drQfnsvNZgbv5kb9/V+ZaP1gEy+RB9/dWdQajnih/Se9TAHPUNk5SkEkCB9NImFlGh
         RxDMqGB3AFGea+ZqXhw3YLGg0yxo0XVEYV0KPxy/5Jyrf1T6N0oglK6YrhrGwoxao+Aw
         rjXSsitDNEmZ95BGJKQLJVgrK8kI2EseIUJMU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references:x-google-sender-auth;
        b=wDdumq0iRQzGvinWfV3PHqc6F6Je0BziZQkViUZ+7A2RWn11aD+PwyX3UQqddrf3Xj
         pCB0uR19IFOEaQYnYn9CXvyK8tRh8LRPPdyEOSaBcBrSXh+p5Dgt/zq8+x4tz01BUjp/
         6O8YGhI1s8XGQ3Ptt+863xy6FTORQGT6snSkY=
Received: by 10.223.120.197 with SMTP id e5mr16259492far.25.1231323353550;
        Wed, 07 Jan 2009 02:15:53 -0800 (PST)
Received: by 10.223.121.142 with HTTP; Wed, 7 Jan 2009 02:15:53 -0800 (PST)
In-Reply-To: <alpine.DEB.1.00.0901071101480.7496@intel-tinevez-2-302>
Content-Disposition: inline
X-Google-Sender-Auth: d0197d1ecf007698
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104781>

On Wed, Jan 7, 2009 at 11:07 AM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Tue, 6 Jan 2009, =D8yvind Harboe wrote:
>
>> On Tue, Jan 6, 2009 at 11:20 PM, Johannes Schindelin
>> <Johannes.Schindelin@gmx.de> wrote:
>>
>> > $ git verify-pack -v $PACK | grep -v "^chain " | sort -n -k 4
>>
>> I have never used the git verify-pack command, but I'm pretty sure t=
he
>> "Terminated" string isn't the normal output :-)
>>
>> $ git verify-pack -v
>> .git/objects/pack/pack-1e039b82d8ae53ef5ec3614a3021466663cc70a4
>> Terminated
>
> I did
>
>        $ git grep Terminated
>
> and came up empty :-)
>
> Seriously, I guess this could be some OOM thing.  We _should_ handle =
this
> more gracefully, but it is possible that some uncatchable condition h=
its
> you, such as out-of-stack-space.
>
> I'd try running the command either with strace or with gdb, and I'd l=
ook
> at $? after the command returns, to find out what is actually happeni=
ng.

After some investigation it turns out that my server has 228mByte of RA=
M
available. It is a virtual server running CentOS, hence the strange num=
ber
and ridiciulously tiny amount of memory(these days).

Now the strange thing is that I'm not getting this error message this m=
orning...

How would git behave if it ran out of memory?


--=20
=D8yvind Harboe
http://www.zylin.com/zy1000.html
ARM7 ARM9 XScale Cortex
JTAG debugger and flash programmer
