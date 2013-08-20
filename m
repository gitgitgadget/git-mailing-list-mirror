From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [RFC PATCHv4] repack: rewrite the shell script in C.
Date: Tue, 20 Aug 2013 14:34:52 -0700
Message-ID: <20130820213452.GI4110@google.com>
References: <1376864786-21367-1-git-send-email-stefanbeller@googlemail.com>
 <1376954619-24314-1-git-send-email-stefanbeller@googlemail.com>
 <52136F9C.6030308@kdbg.org>
 <5213DE72.3000308@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Stefan Beller <stefanbeller@googlemail.com>
X-From: git-owner@vger.kernel.org Tue Aug 20 23:35:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VBtZv-0001Kk-Ar
	for gcvg-git-2@plane.gmane.org; Tue, 20 Aug 2013 23:35:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751947Ab3HTVe5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Aug 2013 17:34:57 -0400
Received: from mail-pa0-f52.google.com ([209.85.220.52]:43568 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751484Ab3HTVe4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Aug 2013 17:34:56 -0400
Received: by mail-pa0-f52.google.com with SMTP id kq13so1206167pab.39
        for <git@vger.kernel.org>; Tue, 20 Aug 2013 14:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=TwNbw3fSIie0Bw5IndS8TEVKt6AHhaDOhrI8YNFNZlI=;
        b=IEpWBNcf2Y2HR0smNz07NT/hvICKFN+I9oN9oFIOT4Y+FpQYH4H1XsMSS1Nih3T0Hx
         oXzefmuNg9BFUQJ9BsH1/fW3zoLunq6JBVw0mkdLOF4ZmosEYdtb6DDIOkK4dZO7aitd
         EylVBV6weJPZcD7M6tvQEXbFTq5tVwPfiIDTkhabNZ7wuTt8fZ5mgwDZtlIQC2l6d+5L
         KoclmcX6v88zIL50+YUit7+R5q07yTeeoN8udn9j0P1amkwwwAUQ/QkcZy+5W7QhBhjk
         nnRnwPodtZhw9AR4wyJ9lawJlYoE8hZEV2C1LUNhWEYcqoI2RrgriVv0WjQyZLrFQx/j
         V6Dw==
X-Received: by 10.68.232.166 with SMTP id tp6mr4129434pbc.153.1377034495574;
        Tue, 20 Aug 2013 14:34:55 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id t9sm4062783pba.46.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 20 Aug 2013 14:34:54 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <5213DE72.3000308@googlemail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232649>

Stefan Beller wrote:
> On 08/20/2013 03:31 PM, Johannes Sixt wrote:

>>> +    packdir = mkpathdup("%s/pack", get_object_directory());
>>> +    packtmp = mkpathdup("%s/.tmp-%d-pack", packdir, getpid());
>> 
>> Should this not be
>> 
>>     packdir = xstrdup(git_path("pack"));
>>     packtmp = xstrdup(git_path("pack/.tmp-%d-pack", getpid()));
>
> Just a question for documentational purpose. ;)
> Am I right suggesting the following:
>
> `mkpathdup`::
> 	Use parameters to build the path on the filesystem,
> 	i.e. create required folders and then return a duplicate
> 	of that path. The caller is responsible to free the memory

Right.  mkpathdup is basically just mkpath composed with xstrdup,
except that it avoids stomping on mkpath's buffers.

The corresponding almost-shortcut for xstrdup(git_path(s)) is
git_pathdup(s).  But that's a minor detail.

Maybe a new Documentation/technical/api-paths.txt is in order.

Thanks,
Jonathan
