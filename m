From: Marius Storm-Olsen <mstormo@gmail.com>
Subject: Re: [msysGit] [PATCH 07/17] Fix __stdcall/WINAPI placement and function
 prototype
Date: Tue, 15 Sep 2009 07:59:26 +0200
Message-ID: <4AAF2D3E.3030706@gmail.com>
References: <cover.1252925290.git.mstormo@gmail.com> <160ceafba5f58cfcadb13380e3d8ef724009b700.1252925290.git.mstormo@gmail.com> <1d699897d4163224ce22db9400569fab20547e9d.1252925290.git.mstormo@gmail.com> <200909142200.52174.j6t@kdbg.org> <alpine.DEB.1.00.0909150224010.8306@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Johannes Sixt <j6t@kdbg.org>, msysgit@googlegroups.com,
	git@vger.kernel.org, lznuaa@gmail.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Sep 15 08:00:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MnR55-0001jO-I5
	for gcvg-git-2@lo.gmane.org; Tue, 15 Sep 2009 07:59:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751051AbZIOF7v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Sep 2009 01:59:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751021AbZIOF7u
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Sep 2009 01:59:50 -0400
Received: from mail-ew0-f206.google.com ([209.85.219.206]:62809 "EHLO
	mail-ew0-f206.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750850AbZIOF7u (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Sep 2009 01:59:50 -0400
Received: by ewy2 with SMTP id 2so152401ewy.17
        for <git@vger.kernel.org>; Mon, 14 Sep 2009 22:59:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=PHfi8ljHOGfjprO2wH3YVcsC/E252xVOLRUEttQP/KM=;
        b=HdCduYJdgszJ2IESUlnMYg+flHUHOlZA5jbmPoASkrMCwUIM9xE9jg7m+/s7L+wXwj
         jcNbeCwseGEucwg2Q9rHHyYH67WwAjfQtZHXcSZfPeOkeuYflcE4m9OaC2DC36KW7frV
         4iljXGEPL2IuBXeSBj4kvGlaKENgljrfkLip4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=kqMl3Lbl1LRQFy37J/TToC5sFgMmBVS/qXhcnx7eTohk0vp9ISVEU08yW5hmxntssL
         cJ2SEHk4QVbDdry7ggxbuWcwZ5cMnN3J+CeYi+xoz/WxhMD1Sq3YgueATqEJEdsWGmNf
         VWtriBmgIXt84Za7hrEg88lfb9I/tJXJSb5g0=
Received: by 10.211.154.16 with SMTP id g16mr7902976ebo.19.1252994392864;
        Mon, 14 Sep 2009 22:59:52 -0700 (PDT)
Received: from ?172.24.90.95? ([62.70.27.104])
        by mx.google.com with ESMTPS id 7sm3357686eyb.37.2009.09.14.22.59.51
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 14 Sep 2009 22:59:51 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.23) Gecko/20090812 Lightning/0.9 Thunderbird/2.0.0.23 ThunderGit/0.1a Mnenhy/0.7.6.666
In-Reply-To: <alpine.DEB.1.00.0909150224010.8306@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128512>

Johannes Schindelin said the following on 15.09.2009 02:24:
> Hi,
> 
> On Mon, 14 Sep 2009, Johannes Sixt wrote:
> 
>> On Montag, 14. September 2009, Marius Storm-Olsen wrote:
>>> WINAPI is a macro which translates into the proper calling convention, so
>>> replace __stdcall with that.
>> I've already pointed out elsewhere that the documentation of 
>> _beginthreadex explicitly says that the calling convention of the 
>> function pointer must be __stdcall. It does not mention WINAPI. 
>> Therefore, I think that these two changes are not correct:
>>
>>> -static __stdcall unsigned ticktack(void *dummy)
>>> +static unsigned WINAPI ticktack(void *dummy)
>>> -static __stdcall unsigned run_thread(void *data)
>>> +static unsigned WINAPI run_thread(void *data)
>> You should s/WINAPI/__stdcall/.
> 
> I don't think that comments by our most proficient MSys guy should be 
> disregarded as thee comments were.

I also pointed out that WINAPI is just a define for __stdcall (since 
_MSC_VER >= 800; VC 6.0 being _MSC_VER == 1200 and VC 2008 being 
_MSC_VER == 1500), and that's probably never going to change now. So, 
the change is not as bad as Hannes portrays it to be, and makes things 
less convoluted by using the same convention all over.

However, I'll cave for the pressure, and reroll the commit :)

--
.marius
