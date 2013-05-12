From: Andrew Wong <andrew.kw.w@gmail.com>
Subject: Re: [PATCH] git-gui: fix file name handling with non-empty prefix
Date: Sat, 11 May 2013 22:03:25 -0400
Message-ID: <518EF86D.3060207@gmail.com>
References: <264998b2b2201b7d6ab9bfa8b5518f712b3a6a08.1367069056.git.john@keeping.me.uk> <20130427141839.GF472@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Pat Thoyts <patthoyts@users.sourceforge.net>, git@vger.kernel.org
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Sun May 12 04:07:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UbLhW-0007Dk-4w
	for gcvg-git-2@plane.gmane.org; Sun, 12 May 2013 04:07:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754008Ab3ELCHe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 May 2013 22:07:34 -0400
Received: from mail-pb0-f50.google.com ([209.85.160.50]:39855 "EHLO
	mail-pb0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752619Ab3ELCHd (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 May 2013 22:07:33 -0400
Received: by mail-pb0-f50.google.com with SMTP id um15so3603567pbc.9
        for <git@vger.kernel.org>; Sat, 11 May 2013 19:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:message-id:date:from:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=ZrVYgPOgNd6KYhv9vlGpEoPjvPt4BUoTDorTl3bvf/Y=;
        b=XpTjAgV0HLM8TZFpi4/LjOKgCvYHjOrP942o9s9tNcEB4N9KP9jYnaQ3k+93FbA+qf
         h7wRX2ssLxNir+yXHdayuOcoP4/4WaZ5zQkCPQZTKulOzJeJrcsEA3Em1308lzlD/Myw
         dIIlSE2HMIveVQHG9Rrj/mG3B01t/CBUZwLFlYuzAgpIWUO3gcHRwqEhihBhzm7kWrbI
         ALDw7LM72jXid4K4ImaTBqfvOJILbwabM8fOVzqPfnvZWva0UZ86CGOmnMk/zxrXaeIi
         vPAic2Z+ew2WgiL6hAfxOoj7OCJZvTO5RZqVKuga7lueHwLgJ9ZE4nq60xwT4JI1tGKf
         R43w==
X-Received: by 10.66.177.46 with SMTP id cn14mr24548168pac.4.1368324452685;
        Sat, 11 May 2013 19:07:32 -0700 (PDT)
Received: from [192.168.0.21] (S0106185933487631.vc.shawcable.net. [24.85.157.19])
        by mx.google.com with ESMTPSA id zo4sm8357417pbc.21.2013.05.11.19.07.30
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 11 May 2013 19:07:31 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130501 Thunderbird/17.0.5
In-Reply-To: <20130427141839.GF472@serenity.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224022>

Sorry for the late reply. I was able to reproduce the problem that you
were describing a while ago. And your patch indeed fixes it. It's a much
more elegant way of dealing with the "absolute vs relative" path problem
that I was trying to fix.

Thanks!

As for Pat, I'm not sure wha'ts going on with his email address. It was
working back in October, and his username still seems to be active over
at SourceForge... let's see if this email reaches him.

Here's a link for his reference just in case he missed your original email:
http://thread.gmane.org/gmane.comp.version-control.git/222646


On 04/27/13 10:18, John Keeping wrote:
> I got a bounce with "550 no such user" for Pat's email address when
> sending this.  Does anyone have more up-to-date contact details?  Or is
> it just SourceForge being broken?
>
> On Sat, Apr 27, 2013 at 02:24:16PM +0100, John Keeping wrote:
>> Commit e3d06ca (git-gui: Detect full path when parsing arguments -
>> 2012-10-02) fixed the handling of absolute paths passed to the browser
>> and blame subcommands by checking whether the file exists without the
>> prefix before prepending the prefix and checking again.  Since we have
>> chdir'd to the top level of the working tree before doing this, this
>> does not work if a file with the same name exists in a subdirectory and
>> at the top level (for example Makefile in git.git's t/ directory).
>>
>> Instead of doing this, revert that patch and fix absolute path issue by
>> using "file join" to prepend the prefix to the supplied path.  This will
>> correctly handle absolute paths by skipping the prefix in that case.
>>
>> Signed-off-by: John Keeping <john@keeping.me.uk>
>> ---
>>  git-gui.sh | 14 +++-----------
>>  1 file changed, 3 insertions(+), 11 deletions(-)
>>
>> diff --git a/git-gui.sh b/git-gui.sh
>> index e133331..a94ad7f 100755
>> --- a/git-gui.sh
>> +++ b/git-gui.sh
>> @@ -3003,19 +3003,11 @@ blame {
>>  	set jump_spec {}
>>  	set is_path 0
>>  	foreach a $argv {
>> -		if {[file exists $a]} {
>> -			if {$path ne {}} usage
>> -			set path [normalize_relpath $a]
>> -			break
>> -		} elseif {[file exists $_prefix$a]} {
>> -			if {$path ne {}} usage
>> -			set path [normalize_relpath $_prefix$a]
>> -			break
>> -		}
>> +		set p [file join $_prefix $a]
>>  
>> -		if {$is_path} {
>> +		if {$is_path || [file exists $p]} {
>>  			if {$path ne {}} usage
>> -			set path [normalize_relpath $_prefix$a]
>> +			set path [normalize_relpath $p]
>>  			break
>>  		} elseif {$a eq {--}} {
>>  			if {$path ne {}} {
>> -- 
>> 1.8.3.rc0.149.g98a72f2.dirty
