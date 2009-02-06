From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: Re: [PATCHv2 6/6] gitweb: check if-modified-since for feeds
Date: Fri, 6 Feb 2009 12:19:29 +0100
Message-ID: <cb7bb73a0902060319q474f3daeu5f67ea859cfa97b1@mail.gmail.com>
References: <1232970616-21167-1-git-send-email-giuseppe.bilotta@gmail.com>
	 <1232970616-21167-6-git-send-email-giuseppe.bilotta@gmail.com>
	 <1232970616-21167-7-git-send-email-giuseppe.bilotta@gmail.com>
	 <200902050303.43356.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 06 12:21:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LVOle-0006Nh-8q
	for gcvg-git-2@gmane.org; Fri, 06 Feb 2009 12:21:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754230AbZBFLTc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Feb 2009 06:19:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751622AbZBFLTb
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Feb 2009 06:19:31 -0500
Received: from mail-ew0-f21.google.com ([209.85.219.21]:44156 "EHLO
	mail-ew0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751491AbZBFLTb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Feb 2009 06:19:31 -0500
Received: by ewy14 with SMTP id 14so1231067ewy.13
        for <git@vger.kernel.org>; Fri, 06 Feb 2009 03:19:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=M2cLLzZQZN0PPabFpjQpcw96+Il0OuDd2HIEeSWw9BY=;
        b=BHvmkAXyk00t3FNvW/7j6zshqmAwGQI1df2tXMZXdDuJOgQPacX96r4ZFUZKCOhuAU
         h+wJ4NzBkfPxBA2W5W3Bksbj4bf2vTJWTFXATahJ0kHC2rfxCEr7wgl21bp7JciqHi3n
         PTGvyKhtrWWA/Dgqebut0yT924RRZz1sSNGec=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=v+f7yiJYOXT2cOa+5fYba/doklolg026vSGIIEITfkV4QpWy5YJLgaCcc/akCNBUTV
         FsvtLd6x5WtYChrTlZCtLyVvX0XWHw+EuIWb5aFHTS/HRxdnuh25VScRQ4fowQL4qtB0
         xefQ8MqC1sRCuJ5b6T+SnxfLWpEj+hF2LTeB8=
Received: by 10.210.104.20 with SMTP id b20mr1254578ebc.8.1233919169068; Fri, 
	06 Feb 2009 03:19:29 -0800 (PST)
In-Reply-To: <200902050303.43356.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108685>

On Thu, Feb 5, 2009 at 3:03 AM, Jakub Narebski <jnareb@gmail.com> wrote:
> On Mon, 26 Jan 2009, Giuseppe Bilotta wrote:
>
>> Offering Last-modified header for feeds is only half the work, even if
>> we bail out early on HEAD requests. We should also check that same date
>> against If-modified-since, and bail out early with 304 Not Modified if
>> that's the case.
>
> It looks now quite nice, but I'd like to see information about
> dependencies for this feature in the commit message, something like:
>
>   This feature (terminating early with '304 Not Modified' in response
>   to 'If-Modified-Since' conditional request) requires having either
>   HTTP::Date module (from libwww-perl) or Time::ParseDate module.
>   If neither is present gitweb falls back to earlier behaviour of not
>   reacting to 'If-Modified-Since'.

Good idea.

> Note also (although I'm not sure if it is worth mentioning in commit
> message) that it doesn't save gitweb as much work as one could think,
> because at this place the whole list of commits is already generated
> and parsed.  What we save is cost of running git-diff-tree for each
> commit (we could do better here, I think), and of course bandwidth.

If it's possible to get the first commit without generating and
parsing the entire commit list, this can probably be optimized
further.

> I wonder if it would be possible to separate this code into subroutine,
> to make it possible to have support for "cache control" conditional
> requests also in other cases where it might help (for the future of
> course, not in this commit).

Yes, I thought about it too.

>
> Perhaps if we run gitweb from Apache mod_perl in compatibility mode
> (ModPerl::Registry) to use Apache Perl API to respond to
> 'If-Modified-Since' ($r->is_fresh or something). But that is also
> just idea for the future improvement.

Also, it's way beyond my current knowledge of Apache, CGI and Perl 8-D

-- 
Giuseppe "Oblomov" Bilotta
