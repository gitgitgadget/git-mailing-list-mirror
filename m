From: Kyle McKay <mackyle@gmail.com>
Subject: Re: [PATCH 2/2] git-svn: allow git-svn fetching to work using serf
Date: Sun, 7 Jul 2013 11:27:20 -0700
Message-ID: <053E9C47-31D9-4BD8-A417-4CEC371B1A07@gmail.com>
References: <ABDE5FFA-C19F-44BF-A360-3FD5D74F2B28@gmail.com> <20130707002430.GE30132@google.com> <8CACBE8F-8672-43AB-882E-4ADA05B4D822@gmail.com> <20130707022332.GD4193@google.com> <3871C226-16AE-4E25-8AD3-007EDAB0E25F@gmail.com> <20130707133957.GA3648@lp-shahaf.local>
Mime-Version: 1.0 (Apple Message framework v936)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	David Rothenberger <daveroth@acm.org>,
	Petr Baudis <pasky@ucw.cz>, Eric Wong <normalperson@yhbt.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 07 20:27:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UvtgH-0008Cq-OL
	for gcvg-git-2@plane.gmane.org; Sun, 07 Jul 2013 20:27:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753101Ab3GGS11 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Jul 2013 14:27:27 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:51616 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753053Ab3GGS1Y (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Jul 2013 14:27:24 -0400
Received: by mail-pa0-f46.google.com with SMTP id fa11so3630558pad.5
        for <git@vger.kernel.org>; Sun, 07 Jul 2013 11:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:in-reply-to:subject:references:message-id:content-type
         :content-transfer-encoding:mime-version:date:cc:x-mailer;
        bh=SCT1N+uBMcRxiVz4hrxbw5cZIOr5yU6ZytGcF4BKIKk=;
        b=I4IEcUrwRVKnnV/oVU6xiBeUPo5qYBVwP6fe3/66kA24BE24DvEWJsVbpmKk8NCCYC
         0qxvoVaEzyfCfYEE/kXy3E24IaApQ6UPWjSdrANFXNcbgWHeUyPYWymY2Dh3yNDXRfTE
         h6UQHMKjaJZb5CWhnS5woXQXNivtqg5+1M6DiBg5qWD3rgssy1zaxv+hgt1eW/H3YMaS
         W2Wh0xfP1zv/WAM3Yc/2yX9Db+sIJBPPYRGYKYpg/gULc1wSkV8GD3W4Bv97sPsiiHBP
         UUab9SPRbMQxWIBBQ1cDlJNXKTaXjBkZXH9jcY8KA+QHx/GJNbxf2w/Fr3VcqPWgMFHE
         SpPg==
X-Received: by 10.66.27.147 with SMTP id t19mr19556971pag.171.1373221643933;
        Sun, 07 Jul 2013 11:27:23 -0700 (PDT)
Received: from [172.16.16.105] (ip72-192-173-141.sd.sd.cox.net. [72.192.173.141])
        by mx.google.com with ESMTPSA id om2sm18163849pbb.34.2013.07.07.11.27.22
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sun, 07 Jul 2013 11:27:23 -0700 (PDT)
In-Reply-To: <20130707133957.GA3648@lp-shahaf.local>
X-Mailer: Apple Mail (2.936)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229795>

I forwarded the "SVNAllowBulkUpdates Off" question to the users@subversion.apache.org 
  list and here's the reply:

On Jul 7, 2013, at 11:11, Lieven Govaerts wrote:
> On Sun, Jul 7, 2013 at 4:48 PM, Kyle McKay <mackyle@gmail.com> wrote:
>> On Jul 7, 2013, at 06:39, Daniel Shahaf wrote:
>>>
>>> Kyle McKay wrote on Sat, Jul 06, 2013 at 19:46:40 -0700:
>>>>
>>>> On Jul 6, 2013, at 19:23, Jonathan Nieder wrote:
>>>>>
>>>>> Kyle McKay wrote:
>>>>>
>>>>>> Unless bulk updates are disabled when using the serf access  
>>>>>> method
>>>>>> (the only one available with svn 1.8) for https?: urls,
>>>>>> apply_textdelta does indeed get called multiple times in a row
>>>>>> without an intervening temp_release.
>>>>>
>>>>>
>>>>> You mean "Unless bulk updates are enabled" and "without an  
>>>>> intervening
>>>>> close_file", right?
>>>>
>>>>
>>>> The problem seems to be skelta mode although it may just be the  
>>>> fact
>>>> that ra_serf has multiple connections outstanding and since  
>>>> ra_neon only
>>>> ever has one it can't happen over ra_neon.
>>>>
>>>> If the server disables bulk updates (SVNAllowBulkUpdates Off) all
>>>> clients are forced to use skelta mode, even ra_neon clients.
>>>
>>>
>>> As Brane and I have pointed out, git-svn can instruct libsvn_* to  
>>> use
>>> bulk updates regardless of the server version, by setting
>>> SVN_CONFIG_OPTION_HTTP_BULK_UPDATES (new in 1.8).
>>>
>>> If you have questions about that, though, please address them to
>>> users@subversion.apache.org (the proper list for API usage  
>>> questions),
>>> not to me personally.
>>
>>
>> According to the table at
>> <http://subversion.apache.org/docs/release-notes/1.8.html#serf-skelta-default 
>> >,
>> if the server sets SVNAllowBulkUpdates Off, the client will be  
>> forced to use
>> skelta no matter what the client setting is.
>
> Indeed, the server admin has the final say in which mode is actually
> used. SVNAllowBulkUpdates Off is only advised if the server admin
> wants a log line per accessed resource. I doubt it's used a lot, but
> the option is there.
>
>>
>> Is that table incorrect?
>
> No, that table is correct.
>
> Lieven

So the final say so on whether or not bulk updates are allowed is on  
the server side which means git-svn really needs to handle skelta mode  
on the client side properly when using ra-serf to guarantee  
functionality with all subversion server configurations.

Kyle
