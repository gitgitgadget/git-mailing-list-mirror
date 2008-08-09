From: "Bert Wesarg" <bert.wesarg@googlemail.com>
Subject: Re: [TopGit PATCH 2/2] tg-import.sh: A dump quilt queue importer
Date: Sat, 9 Aug 2008 09:56:58 +0200
Message-ID: <36ca99e90808090056n63ce97bduc64a24a524eae2b9@mail.gmail.com>
References: <1218219588-6849-1-git-send-email-bert.wesarg@googlemail.com>
	 <1218219588-6849-2-git-send-email-bert.wesarg@googlemail.com>
	 <20080809005736.GR10151@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Petr Baudis" <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Sat Aug 09 10:00:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KRjMm-0002IC-EK
	for gcvg-git-2@gmane.org; Sat, 09 Aug 2008 10:00:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753647AbYHIH5A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Aug 2008 03:57:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753175AbYHIH5A
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Aug 2008 03:57:00 -0400
Received: from wx-out-0506.google.com ([66.249.82.234]:41535 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752654AbYHIH47 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Aug 2008 03:56:59 -0400
Received: by wx-out-0506.google.com with SMTP id h29so646381wxd.4
        for <git@vger.kernel.org>; Sat, 09 Aug 2008 00:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=NHHjF7iOd/l1I5h+6Rj0uOZa3OFtMRZ0surW+ld7AmI=;
        b=UqPOuhKSmbpUmIWQIBUJxrs5dhllIr0J9fWmxXVWVdrV8lIFs7XV0w5mlJabUd8fgr
         4fzyabtfLQcxtbW4AvFrBg2B3kCqaEdQKkli9haJH9VFjx9X3HKUNEDwWTzCwLchSMez
         mUZkWkKbsTAkxaw2cgG9dCx+MJJCVd0IVe1gA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=d8uAuYaOaNwnmctpPZz6w0TMq8UEifpSJfGtG4VeIilOhNvM+CGw5zSFvqm6MrEnnN
         GMpvsQcKoqUT2A+5yoNaJZ/T6CAMRbc8w+hQ81754PNtM7AvBT0So4mSyUn3JXcduw+R
         mgQBMEpA1PCxJJXDvkWz2ZmJd8+Bww2pgXw54=
Received: by 10.70.36.20 with SMTP id j20mr7329366wxj.15.1218268618173;
        Sat, 09 Aug 2008 00:56:58 -0700 (PDT)
Received: by 10.70.28.18 with HTTP; Sat, 9 Aug 2008 00:56:58 -0700 (PDT)
In-Reply-To: <20080809005736.GR10151@machine.or.cz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91750>

On Sat, Aug 9, 2008 at 02:57, Petr Baudis <pasky@suse.cz> wrote:
> On Fri, Aug 08, 2008 at 08:19:48PM +0200, Bert Wesarg wrote:
>> +tg import
>> +~~~~~~~~~
>> +     Import a quilt queue into TopGit. First argument is the series
>> +     file from quilt. Second is the prefix for the topic names
>> +     (i.e. "t/"). All remaining arguments are the dependencies for
>> +     the first patch in the series.
>
> Sensible usage, but I'm not happy with making tg import quilt-only;
> what if we will say want to import to topgit from existing branches,
> or from StGIT or something else? The command name is good, but maybe
> I'd add a required --quilt switch. After all, this is not a command you
> run three times a day by hand.
Your absolutly right, that import should not be quilt specific. It was
just what I currently need, so I made it.

>
>> + Use '-s' if you want to strip
>> +     common patch suffixes from the patch file name (like .diff and
>> +     .patch).
>
> When *wouldn't* we want to do this? Doesn't it make sense to make this
> the default?
I suggest never ;-)

>> +             # add all modified files from patch to index
>> +             # (and prepending it with $root_dir)
>> +             # be stupid, hard coded -p1 --strip=1
>> +             lsdiff --strip=1 "$patchfile" |
>> +                     sed -e "s/^/$root_dir_esc\//" |
>> +                     xargs git add
>
> lsdiff? I don't have this tool. And this won't work with file removals
> properly anyway.
lsdiff comes with the patchutils package.

>
> I guess git add -u is too new for us, so you might opt for this snippet
> I've used in git-filter-branch:
>
>        (
>                git diff-index -r --name-only HEAD
>                git ls-files --others
>        ) |
>        git update-index --add --replace --remove --stdin
>
> Or even better, use git apply?
Ohh yeah, that sounds reasonable. Sometimes it an be so easy.

Thanks for the comments and input.

Bert
>
> --
>                                Petr "Pasky" Baudis
