From: yun sheng <uewing@gmail.com>
Subject: Re: Git doesn't notice file has changed (Re: Found a "bug" in git
 1.9.0 but can't reproduce it without copyrighted source code.)
Date: Fri, 28 Mar 2014 10:06:42 +0800
Message-ID: <CA+fYBFdK4EjUU2yVFJ27YhQMe2rcmZ=MXjxK9GsWWrvC=LvdEQ@mail.gmail.com>
References: <CA+fYBFdzC-_B2Qfk8Hg0pLUNy4oayySs+8B3vWq7uuBeAx9eJQ@mail.gmail.com>
	<20140328014022.GO15625@google.com>
	<CA+fYBFcqZtCxRjAiZk24VJutc_QT5asQU8EFRKpd0ZYqoN4=1g@mail.gmail.com>
	<20140328015921.GP15625@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org, msysgit@googlegroups.com
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 28 03:06:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WTMC9-0005B4-As
	for gcvg-git-2@plane.gmane.org; Fri, 28 Mar 2014 03:06:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757212AbaC1CGn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Mar 2014 22:06:43 -0400
Received: from mail-pa0-f45.google.com ([209.85.220.45]:48928 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757172AbaC1CGm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Mar 2014 22:06:42 -0400
Received: by mail-pa0-f45.google.com with SMTP id kl14so4320240pab.4
        for <git@vger.kernel.org>; Thu, 27 Mar 2014 19:06:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=y9LM9a+5E6T76zAVokJ7RxXTd+V9dsf5DGkmToDK+EI=;
        b=D6ECuqU3rdfJ1S1QyYmKeC2cBJzr7Eba5zwqRlHkaG2mChFYsAEmGZI7TyHCnXML1e
         +KL5EGlN5zDrcq4fKSn+rf/asEDaXuzjIzp3nPFt8gbiz2RtJKSgJAYJfBEh5F1GZAPp
         43uVc8brt59YXj8+RoF4HvIi6KMyTg/FIScPBustd/Sr+cD92hlprfKgQsqUTGIVP+3R
         yUry7g4kOuWk9UTORW+awgzGF7m5RgWuZlL9A8ui1LdrG/NQz70dvg6qLzhmOEaEPGvH
         1NaPWtJC98gvGqNd2z3KpMxe3e6YLi/SGr8BFUiCe2Tt0r8gvtSeAjJ3YrxMecah8eas
         Vdxw==
X-Received: by 10.66.142.233 with SMTP id rz9mr5411531pab.71.1395972402298;
 Thu, 27 Mar 2014 19:06:42 -0700 (PDT)
Received: by 10.70.128.208 with HTTP; Thu, 27 Mar 2014 19:06:42 -0700 (PDT)
In-Reply-To: <20140328015921.GP15625@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245351>

The problem is I can't reproduce this bug if create some other files
which have the same size and timestamp. It only happens on several
files in my project. And it's even more frustrating that I can't send
these files to the mailing list since it is a proprietary source file.

On Fri, Mar 28, 2014 at 9:59 AM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> (cc-ing msysgit list, where there are more Windows-knowledgeable people)
> yun sheng wrote:
>> On Fri, Mar 28, 2014 at 9:40 AM, Jonathan Nieder <jrnieder@gmail.com> wrote:
>>> yun sheng wrote:
>
>>>> these two files have the same timestamp, the same size, bug slightly
>>>> different contents.
>>>
>>> How did they get the same timestamp?
>>>
>>> [...]
>>>> Git I'm using is msysgit 1.9.0 on windows 7
>>>
>>> Unixy operating systems have other fields like inode number and ctime
>>> that make it possible to notice that a file might have been changed
>>> without actually rereading it.  Unfortunately Git for Windows is
>>> limited to what's in the WIN32_FILE_ATTRIBUTE_DATA which means the
>>> size, mtime, and mode are basically all it has to go by.
>>>
>>> Do you know of some other Windows API call that could help?
>>
>> The files get the same timestamp by using `git difftool -d` to view
>> diffs, the diff tool I use id beyond compare 3, this command would
>> generate temp files to feed the compare program, so these files get
>> the same time stamp, I copied them out from the temp folder.
>>
>> I have no idea of the second quesiton, I am really not familiar with
>> windows API. Do you mean this file may have been changed without
>> rereading and git can't detect it?
>
> Sorry for the lack of clarity.  I meant that normally git detects when
> a file might have been changed without actually reading the file.  To
> do this, it uses heuristics like "If all file attributes are
> unchanged, the file is unchanged" which tend to work well on Unix.  My
> question was whether there's some similar trick that could work better
> on Windows than the current code.
>
> For example, if some interested person ports something like Facebook's
> watchman[1] to Windows[2], then Git could take advantage of that work
> using something like Duy's file-watcher series[3], which would be one
> way to fix this problem.
>
> Thanks,
> Jonathan
>
> [1] https://github.com/facebook/watchman
> [2] using FindFirstChangeNotification and ReadDirectoryChangesW, perhaps
> [3] http://thread.gmane.org/gmane.comp.version-control.git/240339/focus=241395>
