From: Karsten Blees <karsten.blees@gmail.com>
Subject: Re: What's cooking in git.git (Dec 2013, #02; Fri, 6)
Date: Wed, 18 Dec 2013 15:12:54 +0100
Message-ID: <52B1AD66.4000507@gmail.com>
References: <xmqqk3fh1qrc.fsf@gitster.dls.corp.google.com>	<52A37D70.3090400@gmail.com> <87fvq41esw.fsf@thomasrast.ch>	<52A3A1F5.3080906@gmail.com> <87lhzvhceb.fsf@linux-1gf2.Speedport_W723_V_Typ_A_1_00_098> <52A5CDB0.2020206@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jonathan Nieder <jrnieder@gmail.com>
To: Thomas Rast <tr@thomasrast.ch>
X-From: git-owner@vger.kernel.org Wed Dec 18 15:13:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VtHry-0006iw-6s
	for gcvg-git-2@plane.gmane.org; Wed, 18 Dec 2013 15:13:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754041Ab3LROMz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Dec 2013 09:12:55 -0500
Received: from mail-ee0-f46.google.com ([74.125.83.46]:41246 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753243Ab3LROMy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Dec 2013 09:12:54 -0500
Received: by mail-ee0-f46.google.com with SMTP id d49so3561130eek.19
        for <git@vger.kernel.org>; Wed, 18 Dec 2013 06:12:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=gO5YX6KPU0GSAHrpItRT1BeI+VOgSXA69o3eb/xpbgY=;
        b=CySFNsDurptyFdflRwANZzV4s5YFkgs6u/l2+aYCX9AAN+eX74vMrs+uPB51tJZ16Q
         I7EKQhkLCrEHzOYWGHQQ/vx6GH0ORN/WpnLdYQI4KcTRKk49RUMPcjSUOj9AqwhZ9ItR
         WJMBEINPKk98DrY4Xbev5LI5UOwgNTwA109UhzBYJupXpBX1hPYNjic8g9onw5jF2dvt
         vBMy+s9WwuUw3W8UaFor+iASMzzntyY2qIs2MdSVASVRtDAjMuP+1MQVWPmkXDPnQahp
         tNlgvuFN6LdQY9Zs18lGy39cmvAR6YkwHoDKahJbXzrrVdxI1SXil0godaSD7Zz/Bl59
         chCA==
X-Received: by 10.14.99.129 with SMTP id x1mr24558415eef.89.1387375973691;
        Wed, 18 Dec 2013 06:12:53 -0800 (PST)
Received: from [10.1.100.52] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id l4sm386613een.13.2013.12.18.06.12.52
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 18 Dec 2013 06:12:52 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.2.0
In-Reply-To: <52A5CDB0.2020206@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239435>

Am 09.12.2013 15:03, schrieb Karsten Blees:
> 3.) Inject individual fields via macro
> 
> Instead of injecting a struct hashmap_entry, which implies alignment to sizeof(struct hashmap_entry), we could inject the individual fields, e.g.
> 
>  #define HASHMAP_ENTRY_HEADER struct hashmap_entry __next; unsinged int __hash;
> 
>  struct name_entry {
>    HASHMAP_ENTRY_HEADER
>    int namelen;
>    char *name;
>  };
> 

I've tried this as well. However, the change is much more intrusive, and produces lots of strict-aliasing warnings in GCC 4.4, probably due to this bug [1]. So I don't think its a good solution. For anyone interested, the patch can be found at [2].

[1] http://gcc.gnu.org/bugzilla/show_bug.cgi?id=42032
[2] https://github.com/kblees/git/commits/kb/hashmap-v5-fixes-macro
