From: "Jon Lim" <snowblink@gmail.com>
Subject: Re: [PATCH] git svn clone -s was not prefixing 'branches/'
Date: Sat, 17 Jan 2009 11:39:28 +0000
Message-ID: <751e526a0901170339m6471ac84tdb032a090d19d7c6@mail.gmail.com>
References: <1232050647-2870-1-git-send-email-snowblink@gmail.com>
	 <20090117105427.GA15801@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Eric Wong" <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Sat Jan 17 12:44:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LO9bc-0003Q1-7H
	for gcvg-git-2@gmane.org; Sat, 17 Jan 2009 12:44:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755406AbZAQLjb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Jan 2009 06:39:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755327AbZAQLja
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Jan 2009 06:39:30 -0500
Received: from rv-out-0506.google.com ([209.85.198.235]:11448 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750867AbZAQLj3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Jan 2009 06:39:29 -0500
Received: by rv-out-0506.google.com with SMTP id k40so1947423rvb.1
        for <git@vger.kernel.org>; Sat, 17 Jan 2009 03:39:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=1LPbFGmBevwNQKjSmgHHdZ/xShf6HBmIy+j8fqXQWnw=;
        b=sTFksKyDndgbJwySRTRfOpo6AJU+6m/z9eZsVVANV4MzcKVZhjtB1Gu8NlEpISS1vM
         TiEYEUTCo2dHIu3npLSVhEQDRxaJP7iK5tIxM92dTDZYTxt7AlDo/+I/A3S88E1Sy7QA
         3n5ZoWirzNGjD1HzS2RQevjjw49R9IS5pnyuw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=n0gVqdXoVu+AaMXE/IelJKCvA/+qYpfmPRxFCc33XiA1+cwgu3I/LkWBvcTj0GuYtX
         hxJavT5ZjWIeXyW59gPWYo8kKo73nV6c4j7d3bwUSSSk6/+WCknr8atI3crKH5DB5dnS
         qtVFi7yLr6XU5zOCggmunEYiVNMUa47tDCMMQ=
Received: by 10.140.163.12 with SMTP id l12mr1755865rve.41.1232192368873;
        Sat, 17 Jan 2009 03:39:28 -0800 (PST)
Received: by 10.140.208.2 with HTTP; Sat, 17 Jan 2009 03:39:28 -0800 (PST)
In-Reply-To: <20090117105427.GA15801@dcvr.yhbt.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106042>

Hi,

Maybe this patch doesn't fix the problem I was having. I will attempt
to describe it better here.

I understand that a standard subversion setup is as follows:
trunk
branches
tags

With the -s option, svn clone should expect this.

Using the example subversion repository:
trunk
branches/RB_1.0
branches/RB_2.0
tags/REL_1.0
tags/REL_2.0

Currently, using the -s option you get:
trunk
RB_1.0
RB_2.0
tags/REL_1.0
tags/REL_2.0

I think it makes sense to have:
trunk
branches/RB_1.0
branches/RB_2.0
tags/REL_1.0
tags/REL_2.0

Regards,
Jon

On Sat, Jan 17, 2009 at 10:54, Eric Wong <normalperson@yhbt.net> wrote:
> Jonathan Lim <snowblink@gmail.com> wrote:
>> All branches in the subversion repository would appear at the same
>> level as trunk.  The should now appear with a 'branches/' prefix.
>>
>> Signed-off-by: Jonathan Lim <snowblink@gmail.com>
>
> This is too ugly for the common existing cases.  For the rare case where
> this could lead to a namespace conflict[1], it's possible to work around
> it by editing .git/config.
>
> I would accept a --tags-prefix= and --branches-prefix= patch to make
> this possible w/o having to edit .git/config, but I don't want the
> default prefixes changed.
>
> Thanks,
>
> [1] - "/branches/trunk" vs "/trunk", which I've yet to see evidence of...
>
>> ---
>>  git-svn.perl |    2 +-
>>  1 files changed, 1 insertions(+), 1 deletions(-)
>>
>> diff --git a/git-svn.perl b/git-svn.perl
>> index ad01e18..17d65cb 100755
>> --- a/git-svn.perl
>> +++ b/git-svn.perl
>> @@ -789,7 +789,7 @@ sub cmd_multi_init {
>>       }
>>       return unless defined $_branches || defined $_tags;
>>       my $ra = $url ? Git::SVN::Ra->new($url) : undef;
>> -     complete_url_ls_init($ra, $_branches, '--branches/-b', $_prefix);
>> +     complete_url_ls_init($ra, $_branches, '--branches/-b', $_prefix . 'branches/');
>>       complete_url_ls_init($ra, $_tags, '--tags/-t', $_prefix . 'tags/');
>>  }
>



-- 
http://snowblink.co.uk/
