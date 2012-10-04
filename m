From: Andrew Wong <andrew.kw.w.lists@gmail.com>
Subject: Re: Rebase doesn't restore branch pointer back on out of memory
Date: Thu, 04 Oct 2012 11:13:50 -0400
Message-ID: <506DA7AE.50005@gmail.com>
References: <CAGAhT3kofdaQEye9QHnvFhAAzoQqZtR7d5UzbxU+zEdkAHVfuQ@mail.gmail.com> <506CB3B5.808@gmail.com> <CAGAhT3mVn-W5P-n_YeafZ_7bntkJGArJ3o6+dA5GO_H44=KHFg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git list <git@vger.kernel.org>
To: Alexander Kostikov <alex.kostikov@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 05 00:11:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TJtaA-0001w8-JQ
	for gcvg-git-2@plane.gmane.org; Fri, 05 Oct 2012 00:07:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422642Ab2JDPN4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Oct 2012 11:13:56 -0400
Received: from mail-ie0-f174.google.com ([209.85.223.174]:53925 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965616Ab2JDPNx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Oct 2012 11:13:53 -0400
Received: by mail-ie0-f174.google.com with SMTP id k13so1176470iea.19
        for <git@vger.kernel.org>; Thu, 04 Oct 2012 08:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=FNpV/SEkYp5zC2Qy+JUAl8HnHjfLNXHdHaOlTuNrt74=;
        b=A1TUYLINpbXZE+FvOJTz4wRLg/aKNrAWlwmkFURpii/zn3aUybxXYiDwE/1rdNjKaw
         pCkE6qGkR5xfhqgZ8bYYliTrw5kWmQD6feDAiaLHrvj+AKX1SefWsKaGT6efTVt88YqY
         BRqDDkmkItEJCN0wIYtWQf9cz7IWbQHvXH67v2Viw3cw/q0Xnqd+35d3pLHYx80IZzxO
         DaOVP4ErUA3DUWnSSbVwEFkY5s+xAf7NgKEfOcsuhp8nuTEoYxfObjda+t6se1HSpY1U
         UhPMi8yw862DBrSbCowZ8SJWVbKRFy3hSKe8AyCb7a7wJ4N9uMcLyFe7NF8GYT+aQRej
         /aQg==
Received: by 10.42.43.1 with SMTP id v1mr4627902ice.23.1349363632525;
        Thu, 04 Oct 2012 08:13:52 -0700 (PDT)
Received: from [192.168.1.112] ([66.207.196.114])
        by mx.google.com with ESMTPS id us4sm13630582igc.9.2012.10.04.08.13.51
        (version=SSLv3 cipher=OTHER);
        Thu, 04 Oct 2012 08:13:52 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:12.0) Gecko/20120421 Thunderbird/12.0
In-Reply-To: <CAGAhT3mVn-W5P-n_YeafZ_7bntkJGArJ3o6+dA5GO_H44=KHFg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206975>

On 10/03/2012 06:35 PM, Alexander Kostikov wrote:
>> That allows you can go back to the pre-rebase state by
>> "rebase --abort".
> rebase --abort command were not available. I guess rebase file was not created.
I meant "rebase --abort" would be available *if* the error was caught by 
"rebase". But in your case, "rebase" is probably dying somewhere and the 
error was not caught, causing "rebase" to think that everything 
completed successfully, and go ahead to update the branch.

> Is there a way to include some log verbose mode to detect where
> exactly error happens?
There isn't any built-in to git itself. But one way to get more info is 
running the rebase command this way:
     env SHELLOPTS="verbose" git rebase <your arguments>

That should print out every shell command that rebase executes. Having 
the last page of that output should give us enough context as to where 
it's failing.

Just a wild guess: rebase is probably failing at the "format-patch" command.
It'd also be interesting to see if "rebase -i" will also workaround the 
issue. But like you said, there's no way set "-i" or "-m" as the default.
