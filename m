From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC/PATCH] gitweb: Paginate project list
Date: Wed, 14 May 2008 01:28:39 +0200
Message-ID: <200805140128.40853.jnareb@gmail.com>
References: <200805011220.58871.jnareb@gmail.com> <200805131904.38317.jnareb@gmail.com> <8c5c35580805131230p37953e33he97803c0609012fa@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Petr Baudis" <pasky@suse.cz>,
	"John Hawley" <warthog19@eaglescrag.net>
To: "Lars Hjemli" <hjemli@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 14 01:29:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jw3wE-0002Mg-2c
	for gcvg-git-2@gmane.org; Wed, 14 May 2008 01:29:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756963AbYEMX2w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 May 2008 19:28:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756822AbYEMX2w
	(ORCPT <rfc822;git-outgoing>); Tue, 13 May 2008 19:28:52 -0400
Received: from ug-out-1314.google.com ([66.249.92.168]:58767 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756512AbYEMX2v (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 May 2008 19:28:51 -0400
Received: by ug-out-1314.google.com with SMTP id h2so1003937ugf.16
        for <git@vger.kernel.org>; Tue, 13 May 2008 16:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=gNQQ3bESoLwF56aWi0cOYlHKGhNjb2O+e4mvfB9Gb/U=;
        b=Q+7pDgh0xAkBwmadnZ4zv2jKkDB1MJe+OTxqk0tfvqsWfbNJdfOsAREV2ZM4Mya5lOPgubgY5kMf5fwahdJ66+hw/DBySU24y7+8u+9jTGijwBBIfOR3u2RTreB2bHzJs/34AB2YuRdVT9nQX0JZ7exx67CTxjeD8Y1q7hLcQ0k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=cflZPr60kI2x7Wz3KWcFtUfZJY3aJ35mZR3ZeLTmOq2SyRdk6gpCRsePdAY1KU5BUHzMQOMlcBrODCAgqqQ0QxM1lNex/Nh2T/TTJOS5fvLTLDkXCc4DClXttfcTSZZRlI4NgTHFeoalFj6KR9ZxKvHT6VfrrVjAjJF4sL/QIuk=
Received: by 10.67.97.1 with SMTP id z1mr7830078ugl.11.1210721328377;
        Tue, 13 May 2008 16:28:48 -0700 (PDT)
Received: from ?192.168.1.15? ( [83.8.213.214])
        by mx.google.com with ESMTPS id y37sm696924iky.8.2008.05.13.16.28.44
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 13 May 2008 16:28:46 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <8c5c35580805131230p37953e33he97803c0609012fa@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82053>

On Tue, 13 May 2008, Lars Hjemli wrote:
> On Tue, May 13, 2008 at 7:04 PM, Jakub Narebski <jnareb@gmail.com>
> wrote: 
>> On Tue, 13 May 2008, Lars Hjemli wrote:
>>>
>>> [...] (cgit never touches the repos to generate
>>> the project list/search).
[...]
>>  Second, gitweb's projects list page contains "Last Changed" column,
>>  and you _*have*_ to hit repositories for this data
> 
> No you don't. One alternative is to use the post-update hook in each
> repo to update a separate file with info about last-changed-time.

Well, adding setting / caching last-changed data using post-update hook
was one of my early patches to gitweb, but it got shot down. Mainly 
because the fact that it doesn't work with gitweb as "usergit" service,
as you won't be able to install hooks into other users repositories, 
like in the kernel.org case (it should/would work for repo.or.cz etc.).
Another issue is if you publish via web interface non-bare repo; then
update is not the only way data arrives at repository (yes, I know that
post-commit would solve this).

> Another (less accurate) alternative is to stat one or more of
> packed-refs and refs/heads/*; 

And now, in the times of detached HEAD, also HEAD.

BTW. how this work with hierarchical branch names?

>                               cgit uses both of these alternatives to 
> avoid hitting the repo (i.e. object-db) when the project list/search
> page is generated.

First is implicit caching of data, made easier because in this case you
can invalidate cache when it becomes invalid.  Second doesn't hit the 
object-db, but it hits I/O (perhaps very slightly); and the second 
solution is what we can pursue for gitweb in addition to caching data.

Additional complication is that currently there is no place for 
timestamp in project_index format (backward compatibility, unnamed 
tuple not good design to storing structured/tabular data).

-- 
Jakub Narebski
Poland
