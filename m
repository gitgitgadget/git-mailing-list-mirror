From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] Replace strcmp_icase with strequal_icase
Date: Sat, 9 Mar 2013 19:40:12 +0700
Message-ID: <CACsJy8DfsgzEiMELy4UHJ2fvExZjcmvRop4m7u1H3OibrJiSPg@mail.gmail.com>
References: <1362818574-16873-1-git-send-email-iveqy@iveqy.com>
 <CACsJy8CphBDKsAAKjCoze98jv=4U+3pN3cW1OYD5XNhYgfcVCA@mail.gmail.com>
 <CACsJy8BbXjJeTgo0DzKKMY7B3NZB=r3r+Z-WsWJR=t00DkTVzQ@mail.gmail.com>
 <20130309110815.GA8328@paksenarrion.iveqy.com> <CACsJy8D4Yqm3s+ALf=KnMQRQ6SrVcM5jjktpGXiGcOaqtEsyMg@mail.gmail.com>
 <20130309122200.GA7755@paksenarrion.iveqy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: gitster@pobox.com, git@vger.kernel.org
To: Fredrik Gustafsson <iveqy@iveqy.com>
X-From: git-owner@vger.kernel.org Sat Mar 09 13:41:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UEJ5U-0005zo-49
	for gcvg-git-2@plane.gmane.org; Sat, 09 Mar 2013 13:41:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756799Ab3CIMkp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Mar 2013 07:40:45 -0500
Received: from mail-oa0-f52.google.com ([209.85.219.52]:37070 "EHLO
	mail-oa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755770Ab3CIMko (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Mar 2013 07:40:44 -0500
Received: by mail-oa0-f52.google.com with SMTP id k14so3104525oag.11
        for <git@vger.kernel.org>; Sat, 09 Mar 2013 04:40:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=tB88lDKvXhxO96iXSDF+yV4W/Gqu88A6rtcAaAZF7NY=;
        b=fzQrVIfRJ22Uo1n+rQt6eSDooms3bZidUnW2Y3+FsfDctR7kQUJCQkQEXuNrkPuq1B
         Tl9mqWfdEyQp5VPTI11IImleYibPc/+dC9Nq1n5Konky9k9dsDJHv+7fVqmyJMQZqzP4
         xvQ/M/lfJw15zqayCnNWNftfUYwYcabn4Z2KUzOJ6thjZ5HfInDopN/2v7mfIa1rx7Fo
         5tUwKS+vnhqJ2D9/P33jarMn6CKfrG4NnNZ6yINIpJP9xIv63WgYOc+aUlQyqWyxbUBL
         kvsy7qoov+Dq7TZsysthqxDHZqrGKYqyki9ntjpTeTHuSNgFZHh1Toac+ITdGkZdlREC
         v80A==
X-Received: by 10.60.25.65 with SMTP id a1mr4494642oeg.40.1362832842298; Sat,
 09 Mar 2013 04:40:42 -0800 (PST)
Received: by 10.76.27.200 with HTTP; Sat, 9 Mar 2013 04:40:12 -0800 (PST)
In-Reply-To: <20130309122200.GA7755@paksenarrion.iveqy.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217725>

On Sat, Mar 9, 2013 at 7:22 PM, Fredrik Gustafsson <iveqy@iveqy.com> wrote:
> On Sat, Mar 09, 2013 at 07:05:37PM +0700, Duy Nguyen wrote:
>> On Sat, Mar 9, 2013 at 6:08 PM, Fredrik Gustafsson <iveqy@iveqy.com> wrote:
>> > Actually when implemented a str[n]equal_icase that actually should work.
>> > I break the test suite when trying to replace
>> > strncmp_icase(pathname, base, baselen)) on line 711 in dir.c and I don't
>> > get any significant improvements.
>>
>> Hmm.. mine passed the test suite.
>
> Using my patch or your own code? Maybe I just did something wrong. Could
> you see any improvements in speed?

It's the one I posted in [1] and yes it improves speed, numbers in [1].

[1] http://thread.gmane.org/gmane.comp.version-control.git/217712/focus=217724

>> > I like work in this area though, slow commit's are my worst git problem.
>> > I often have to wait 10s. for a commit to be calculated.
>>
>> Personally I don't accept any often used git commands taking more than
>> 1 second (in hot cache case). What commands do you use? What's the
>> size of the repository in terms of tracked/untracked files?
>
> It's a small repository, 100 MB. However I have a slow hdd which is
> almost full. I often add one file and make an one-line change to an
> other file and then do a git commit -a. That will make git to look
> through the whole repo, which isn't in the kernel RAM cache but needs to
> be reed from the hdd.

"commit -a" does not run exclude (what I'm improving here). It's
probably stat problem. If you already know what files you have
changed, "git add path..." then commit without -a might help. Or turn
on core.ignorestat (read doc about it first).
-- 
Duy
