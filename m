From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCHv2] gitweb: Better regexp for SHA-1 committag match
Date: Fri, 6 Feb 2009 23:00:13 +0100
Message-ID: <200902062300.16798.jnareb@gmail.com>
References: <200902022204.46651.toralf.foerster@gmx.de> <alpine.DEB.1.00.0902061403130.7377@intel-tinevez-2-302> <76718490902061347h5bc35e7et9e1b66bf9dd2c93a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Rafael Garcia-Suarez <rgarciasuarez@gmail.com>,
	git@vger.kernel.org,
	Toralf =?utf-8?q?F=C3=B6rster?= <toralf.foerster@gmx.de>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 06 23:01:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LVYlk-0003FD-Az
	for gcvg-git-2@gmane.org; Fri, 06 Feb 2009 23:01:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753902AbZBFWAX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Feb 2009 17:00:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753819AbZBFWAW
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Feb 2009 17:00:22 -0500
Received: from fg-out-1718.google.com ([72.14.220.152]:3753 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753767AbZBFWAW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Feb 2009 17:00:22 -0500
Received: by fg-out-1718.google.com with SMTP id 16so630897fgg.17
        for <git@vger.kernel.org>; Fri, 06 Feb 2009 14:00:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=9EnWG7vghBEEl9Opysn6QCdu7Xrb8c29wuiadu+TWeQ=;
        b=KLR5ccMhbm+Z7GFEVR7ZuPCECJXh2TRr58VkKhfRx3vtMHKLj+V7amGejrdC04DO9q
         SHXw9PEJJRpfyhNOXOy10UlRstg9J8YJlEsOuJK62USsuZaoET0QS0oc6RyJaavYereY
         viWVw1E0ILcn1BEpASjnIrgzLGwuLEwVmzPPU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=Duk+KTNamVIucSkHUh8+KzXufQnoBwo1a1UiJxwjgGAGSQSTpDaMy808CCcDSgqQXp
         PqUYXLV8DRoldvDFLfJOjMYYJ+kwJzrRqMSMYo6wpGode1Vo47yEGN3Z35p7hYudOhFb
         DqEndKBpqZQ8EAKHKvkDFY41NPnchLmR5HMkU=
Received: by 10.86.33.10 with SMTP id g10mr1238930fgg.44.1233957620468;
        Fri, 06 Feb 2009 14:00:20 -0800 (PST)
Received: from ?192.168.1.13? (abwn77.neoplus.adsl.tpnet.pl [83.8.237.77])
        by mx.google.com with ESMTPS id d6sm5373460fga.59.2009.02.06.14.00.19
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 06 Feb 2009 14:00:19 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <76718490902061347h5bc35e7et9e1b66bf9dd2c93a@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108792>

Jay Soffian wrote:
> On Fri, Feb 6, 2009 at 8:03 AM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
>> On Fri, 6 Feb 2009, Jakub Narebski wrote:
>>
>>> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
>>> index f27dbb6..5dcc108 100755
>>> --- a/gitweb/gitweb.perl
>>> +++ b/gitweb/gitweb.perl
>>> @@ -1364,7 +1364,7 @@ sub format_log_line_html {
>>>       my $line = shift;
>>>
>>>       $line = esc_html($line, -nbsp=>1);
>>> -     if ($line =~ m/([0-9a-fA-F]{8,40})/) {
>>> +     if ($line =~ m/\b([0-9a-fA-F]{8,40})\b(!?\@)/) {
>>
>> Looks good to me!
> 
> I wonder if just matching lower-case a-f would be sufficient as well?

Well... 

On one hand side git generates always lower-case a-f for SHA-1.
On the other hand git _accepts_ upper-case A-F for SHA-1 of object.

-- 
Jakub Narebski
Poland
