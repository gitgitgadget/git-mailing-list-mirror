From: Phil Hord <hordp@cisco.com>
Subject: Re: [PATCHv3 2/5] Learn to handle gitfiles in enter_repo
Date: Thu, 06 Oct 2011 15:16:31 -0400
Message-ID: <4E8DFE8F.3060408@cisco.com>
References: <4E8C5C2E.50309@cisco.com> <CACsJy8BiZ7Ey95BOf4p-zwysyYwEY6WectRaj-GqnFvgDNTtZw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Phil Hord <phil.hord@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Erik Faye-Lund <kusmabite@gmail.com>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 06 21:16:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RBtQn-0005yo-QV
	for gcvg-git-2@lo.gmane.org; Thu, 06 Oct 2011 21:16:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758638Ab1JFTQ2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Oct 2011 15:16:28 -0400
Received: from rcdn-iport-5.cisco.com ([173.37.86.76]:35121 "EHLO
	rcdn-iport-5.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756307Ab1JFTQ2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Oct 2011 15:16:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=hordp@cisco.com; l=1395; q=dns/txt;
  s=iport; t=1317928588; x=1319138188;
  h=message-id:date:from:mime-version:to:cc:subject:
   references:in-reply-to:content-transfer-encoding;
  bh=qU3VDiq5B4fhcEg+CmnCToeF1IQHiyUsC3ryHYu9esI=;
  b=XnlZMR8h7H7n3IXlD9DR66AZaY4ytWKp0TvYWw0JxPA/sTy0wBE014cl
   I75N/hLrdB/4ndGF348D+u2tNQZ4uH7mgyE1WkGyDy8OvqMrdgaMDgw+G
   3KSUXhOyeI/uc5UCs7g89c9rS09N9+m9YNxdPxTl7ncmtcn8iGAD/oV67
   M=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AgAFADX9jU6tJV2a/2dsb2JhbABChHSjP4EFgVMBAQEEEgEQVQEQCxgCAgUWCwICCQMCAQIBDzYGDQEFAgEBHqJBAYxGkVCBLYRrgRQEk26FKIM3gUOHQA
X-IronPort-AV: E=Sophos;i="4.68,498,1312156800"; 
   d="scan'208";a="26598314"
Received: from rcdn-core-3.cisco.com ([173.37.93.154])
  by rcdn-iport-5.cisco.com with ESMTP; 06 Oct 2011 19:16:27 +0000
Received: from [64.100.104.107] (dhcp-64-100-104-107.cisco.com [64.100.104.107])
	by rcdn-core-3.cisco.com (8.14.3/8.14.3) with ESMTP id p96JGQ3t031750;
	Thu, 6 Oct 2011 19:16:26 GMT
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:6.0) Gecko/20110812 Thunderbird/6.0
In-Reply-To: <CACsJy8BiZ7Ey95BOf4p-zwysyYwEY6WectRaj-GqnFvgDNTtZw@mail.gmail.com>
X-Enigmail-Version: 1.2.1
X-TagToolbar-Keys: D20111006151631109
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183020>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> says,
> On Thu, Oct 6, 2011 at 12:31 AM, Phil Hord <hordp@cisco.com> wrote:
>> -               if (!suffix[i] || chdir(used_path))
>> +               if (!suffix[i])
>> +                       return NULL;
>> +               gitfile = read_gitfile(used_path) ;
>> +               if (gitfile)
>> +                       strcpy(used_path, gitfile);
>> +               if (chdir(used_path))
>>                        return NULL;
>>                path = validated_path;
>>        }
> 
> This is room for improvement, the patch is fine as it is now. We could
> improve error reporting here. If .git file points to nowhere, we get
> "not a repository-kind of message. Except daemon.c, enter_repo()
> callers always die() if enter_repo() returns NULL. We could move the
> die() part (with improved error message) into enter_repo().
> 
> We could update enter_repo(const char *, int) to enter_repo(const char
> *, int, int gently). If gently is 1, we never die() nor report
> anything (ie. what we're doing now). daemon.c will need this, the rest
> of callers will be happy with gently = 0.

I like that.  It wasn't clear to me what the 'gently' moniker meant
before, but now I understand it.  It could easily apply to this function
and the new is_gitfile() to help reduce code duplication.

In a different patch, though.

Phil
