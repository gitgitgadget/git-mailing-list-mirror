From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/WIP PATCH 05/11] transport: add infrastructure to support a protocol version number
Date: Wed, 27 May 2015 12:10:37 -0700
Message-ID: <xmqq617dn8eq.fsf@gitster.dls.corp.google.com>
References: <1432677675-5118-1-git-send-email-sbeller@google.com>
	<1432677675-5118-6-git-send-email-sbeller@google.com>
	<20150527063925.GC885@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org, pclouds@gmail.com
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed May 27 21:10:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yxgj2-0005Uu-Ku
	for gcvg-git-2@plane.gmane.org; Wed, 27 May 2015 21:10:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754460AbbE0TKn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 May 2015 15:10:43 -0400
Received: from mail-ig0-f171.google.com ([209.85.213.171]:36165 "EHLO
	mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754457AbbE0TKj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 May 2015 15:10:39 -0400
Received: by igbpi8 with SMTP id pi8so93288586igb.1
        for <git@vger.kernel.org>; Wed, 27 May 2015 12:10:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=HKzT91yjq/tNrko7vn7/aSez7x5fz9Ahs/CKXKE9Onw=;
        b=XMRrVNKsItKv3p3hy8e8Elv82mN+MP2F17vJBx7r7wB0ZtArGfu+bAoWLuZ6FRtRxb
         nlAM6KM/36g/uHVHd4U6QhDMYmoxBFDza3UlQ8mjXv3SJomO9fePOmQ+syS5kG3KbF7H
         gLRTJAL4VYSDbAyi9AyydrV8n7I35zcihUgpGhcldY3n2UdKiZE/8r6TOBULtf2nqM4k
         kbbH8aExI1Xj6iI4/BoLZAgPXClBs/Ho3Q4rZoadqVDae3/jmEHkJWxw9YAyXU8IH2Tl
         Rfy3r6pU1weyaohcee78/Mj8qp0wPVgDAkZVlwdL0aSqmj1ocp051UmfEBdYQqe0owZE
         mIlQ==
X-Received: by 10.42.50.81 with SMTP id z17mr5244753icf.57.1432753839236;
        Wed, 27 May 2015 12:10:39 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:91c7:752b:4513:7344])
        by mx.google.com with ESMTPSA id 7sm6739619iok.43.2015.05.27.12.10.38
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 27 May 2015 12:10:38 -0700 (PDT)
In-Reply-To: <20150527063925.GC885@peff.net> (Jeff King's message of "Wed, 27
	May 2015 02:39:25 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270066>

Jeff King <peff@peff.net> writes:

> On Tue, May 26, 2015 at 03:01:09PM -0700, Stefan Beller wrote:
>
>> +	OPT_STRING('y', "transport-version", &transport_version,
>> +		   N_("transport-version"),
>> +		   N_("specify transport version to be used")),
>
> Interesting choice for the short option ("-v" would be nice, but
> obviously it is taken). Do we want to delay on claiming the
> short-and-sweet 'y' until we are sure this is something people will use
> a lot? In an ideal world, it is not (i.e., auto-upgrade and other tricks
> become good enough that nobody bothers to specify it manually).

Yes, just stuff 0 (not NULL but NUL) there; unless we have a very
good reason to believe that the option will be used every day to
toggle per invocation settings, we shouldn't squat on a short and
sweet single letter.
