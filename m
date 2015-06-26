From: Jonathan Kamens <jkamens@quantopian.com>
Subject: Re: [PATCH] Revert "stash: require a clean index to apply"
Date: Thu, 25 Jun 2015 21:12:55 -0400
Message-ID: <558CA717.2040400@quantopian.com>
References: <5570F094.10007@quantopian.com> <20150607124001.GA11042@peff.net> <CADQvvWWpjZoXt7=8yAEt110pBTNtBfg7XfPOTbJRfPUH=J3OKw@mail.gmail.com> <20150610185635.GA22800@peff.net> <xmqq616vl6gm.fsf@gitster.dls.corp.google.com> <20150610192734.GA23715@peff.net> <xmqqsi9samx1.fsf@gitster.dls.corp.google.com> <20150615182721.GA4041@peff.net> <xmqqy4jk7muq.fsf@gitster.dls.corp.google.com> <f06e573d-02e3-47e9-85d8-3bb6551d72f5.maildroid@localhost> <20150626002706.GA6367@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?YsOkcg==?= <crashcookie@gmail.com>,
	Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jun 26 03:13:03 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z8ICU-0000sN-OA
	for gcvg-git-2@plane.gmane.org; Fri, 26 Jun 2015 03:13:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751617AbbFZBM7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Jun 2015 21:12:59 -0400
Received: from mail-qg0-f48.google.com ([209.85.192.48]:36045 "EHLO
	mail-qg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751576AbbFZBM5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Jun 2015 21:12:57 -0400
Received: by qgal13 with SMTP id l13so30854727qga.3
        for <git@vger.kernel.org>; Thu, 25 Jun 2015 18:12:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=5zNyrBvKxU4gMWUn+a5lK2Zr+0Wqwl946FgfyBXI8cc=;
        b=Eflstmz1H9KsUvv76TJiTBMgnqOMdhYYXQkdLOSynq8PpAhNRkqm0NDj6Rzw6zf6Se
         lYDu93G89Hu5PnR7gpzdQRw4oG8KhWg40p6TYohUvc0dqGE/urYolqcLP67fIyHS+KgN
         scXDDRX3n+ZlP2Qd9TyCb/KViKEz7JjxIEMPQEGsThwv6CpD1DowHU0o8u5fEYtE+n/2
         h12M1K/77vxH+5KPmJNko7R7k5YlVFvMn+RYR2AXfPiN03kEe6h6Cz/1iath+ndI78g7
         fttuhvXURoE8dWNvLZiDXUh0iq16xLFrYPfbyyh7E0SejsJzTe0noJuL25ZNihQgwcOf
         GCZg==
X-Gm-Message-State: ALoCoQlTgc5zLkEgK4uZiMwQjfXi4ANZs/q4bPCZq1xkVC32M/kHI2fIOjtihQ/iAoX/h9oa+GHa
X-Received: by 10.140.42.247 with SMTP id c110mr62503194qga.100.1435281176540;
        Thu, 25 Jun 2015 18:12:56 -0700 (PDT)
Received: from [192.168.4.233] (146-115-42-232.c3-0.abr-ubr1.sbo-abr.ma.cable.rcn.com. [146.115.42.232])
        by mx.google.com with ESMTPSA id h81sm6004866qkh.34.2015.06.25.18.12.55
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Jun 2015 18:12:56 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
In-Reply-To: <20150626002706.GA6367@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272757>

Um.

I encountered this issue in git 2.4.3 on Fedora 22.

These lines appear in /usr/libexec/git-core/git-stash on my Fedora 22 
system:

         git diff-index --cached --quiet --ignore-submodules HEAD -- ||
                 die "$(gettext "Cannot apply stash: Your index contains 
uncommitted changes.")"

They also appear in 
https://github.com/git/git/blob/69f9a6e54a46c4a75dff680047a465d04cca20ca/git-stash.sh#L445 
, which is the commit tagged v2.4.3.

In fact, it appears they were released in v2.4.2, at least according to 
https://github.com/git/git/compare/v2.4.1...v2.4.2 .

So it appears to me that this patch was, in fact, released in v2.4.x and 
therefore needs to be reverted in v2.4.x.

   jik

On 06/25/2015 08:27 PM, Jeff King wrote:
> On Thu, Jun 25, 2015 at 05:49:11PM -0400, Jonathan Kamens wrote:
>
>> Is this revert going to be applied and released?
> It is on "master", and part of v2.5.0-rc0 (it is not part of v2.4.x, because
> the original problem was not there, either).
>
> -Peff
