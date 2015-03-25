From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [msysGit] Re: Sparse checkout not working as expected (colons in
 filenames on Windows)
Date: Wed, 25 Mar 2015 13:44:30 +0700
Message-ID: <CACsJy8CZPufnyjdx0Z+SuUNhQ58gvKQprY98V7EJnodHgeyK5A@mail.gmail.com>
References: <BE2660C974C9415E997F20A49ABC766E@PhilipOakley>
 <CACsJy8BOuhohQzaGzD+4cthqOaL4sz1ADRD-ekhFhKt4wMcg7A@mail.gmail.com>
 <90D5D4B5F2ED41A6AB07E291004AA615@PhilipOakley> <CACsJy8AACwDPSEWdGiLLK3PTY=hLm0XOvN4_y4PbCFYrMzrnHg@mail.gmail.com>
 <61604ca6e1c2c114f5b536be420ba73a@www.dscho.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Philip Oakley <philipoakley@iee.org>,
	Git List <git@vger.kernel.org>,
	Yue Lin Ho <yuelinho777@gmail.com>,
	msysGit <msysgit@googlegroups.com>
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Mar 25 07:45:07 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yaf3q-0003B9-F0
	for gcvg-git-2@plane.gmane.org; Wed, 25 Mar 2015 07:45:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751167AbbCYGpC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Mar 2015 02:45:02 -0400
Received: from mail-ig0-f177.google.com ([209.85.213.177]:34093 "EHLO
	mail-ig0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750710AbbCYGpA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Mar 2015 02:45:00 -0400
Received: by igcau2 with SMTP id au2so65582420igc.1
        for <git@vger.kernel.org>; Tue, 24 Mar 2015 23:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=YY4hD9aDw7ipe+XCrvjTD9RHED2v7a4PAN/rW2+4LhM=;
        b=Rcfi1V/DuxoXybPnI+dH3iMWXpBBqOKgRhYqwuwoi79xv4mX+WTTtAntZaKjiXsdAM
         MReKwkhwVRc2YXNHa7T5e41qFa1rwlm3+ABbPOrxKAB0RQVj9z1wjakI6aGTuW7sWsCY
         PUjqdxYYWuJBxTC+8USspZuDkKWLGNVflGMVNuJEyrJ7WmPpKzXBtUcXsw+sg04LNOjz
         2Pbw4tIN4enNrGPlHtqQ7lj1c1vDRw7S8rT1R3b5B/hdVQvLvoHvV1Y9y7RW1SiBKykb
         J1I8Xsf00oZRYoqutNA59S71bFOH4tsTgwkMrtwpKm6WMPuw62KxixRFo75UCsqWiQkE
         zMbQ==
X-Received: by 10.107.155.131 with SMTP id d125mr12002349ioe.17.1427265900162;
 Tue, 24 Mar 2015 23:45:00 -0700 (PDT)
Received: by 10.107.131.33 with HTTP; Tue, 24 Mar 2015 23:44:30 -0700 (PDT)
In-Reply-To: <61604ca6e1c2c114f5b536be420ba73a@www.dscho.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266266>

On Wed, Mar 25, 2015 at 1:39 PM, Johannes Schindelin
<johannes.schindelin@gmx.de> wrote:
> Hi Duy,
>
> On 2015-03-25 01:46, Duy Nguyen wrote:
>> On Wed, Mar 25, 2015 at 6:50 AM, Philip Oakley <philipoakley@iee.org> wrote:
>>
>>> That said, the final error (which I'd missed in the earlier post) is:
>>> fatal: make_cache_entry failed for path 'ifcfg-eth0:0'
>>>
>>> This is on the Windows (pre-compiled msysgit at v1.9.5) Git bash, so could
>>> be a catch path in that code for make_cache_entry (I've not checked the code
>>> yet). So at the moment it doesn't look like sparse checkout can be used to
>>> avoid colons in windows on-disk files based on the current code.
>>
>> Both of your commands below fail by the same function, verify_path()
>> because of this msysgit commit 2e2a2d1 (NTFS: Prevent problematic
>> paths from being checked out - 2014-12-10). I guess that check is a
>> bit too strong, it should apply when new index entries are created
>> from worktree (not from a tree)..
>
> Oh, right, that check needs some relaxing. But certainly in a different way: you *definitely* want to prevent attacks from the outside, and those originate from the *tree*.
>
> What we need to do instead is to relax the check to apply only if we are really going to write out that file, not when it is skipped.

Yeah. In fact if you do this, not checking out  files that can't be or
not safe to be checked out, then the ifcfg-eth0:0 problem that Phillip
wanted to avoid using sparse checkout is also gone.
-- 
Duy
