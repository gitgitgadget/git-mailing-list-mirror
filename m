From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Makefile: Change library order for static linking
Date: Thu, 17 Sep 2015 15:08:25 -0700
Message-ID: <xmqq7fnoitra.fsf@gitster.mtv.corp.google.com>
References: <1442524332-10180-1-git-send-email-repk@triplefau.lt>
	<xmqqfv2cj03t.fsf@gitster.mtv.corp.google.com>
	<20150917212016.GF606@cruxbox>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Brandon Casey <drafnel@gmail.com>,
	Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>
To: Remi Pommarel <repk@triplefau.lt>
X-From: git-owner@vger.kernel.org Fri Sep 18 00:08:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZchM1-0000f1-2W
	for gcvg-git-2@plane.gmane.org; Fri, 18 Sep 2015 00:08:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751929AbbIQWI2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Sep 2015 18:08:28 -0400
Received: from mail-pa0-f50.google.com ([209.85.220.50]:33178 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751855AbbIQWI1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Sep 2015 18:08:27 -0400
Received: by pacex6 with SMTP id ex6so30666032pac.0
        for <git@vger.kernel.org>; Thu, 17 Sep 2015 15:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=BH7nj358QdsTzcz7VStSPoaBXoX33JQ1sNuDDmcVRBg=;
        b=JONBSo+V/Z5KYoVjBCo5o4mRwUTOaRqce2ymz795Bnnvfq8Q6bMHPuxCR1dCsF4L/J
         2tIw8o4uhRfvEdfiFTCPPktZJK30PrE1Ie6MtENHi3zB/Seg9eVm1Jlzaxe4IX42MF9L
         JbXVV06BCRfgnjJNCig6sxZI2mj38glU0gEa/G7pvqtiwXiZSKYHmY7gf13xzJBPbkbP
         AK/iLDOG7eE8i34Mzt18vFC9CXHNdjakWYQNYw9iZQW8pMY0Lboo7pdLt2OhykctvPql
         DPmHjvnSoPsd8INPi3kk6DR8VedofnkK4lH9i0lC9jIurwTIHe4fxvflFbRoNvKqwBks
         7lrw==
X-Received: by 10.68.94.3 with SMTP id cy3mr2801734pbb.113.1442527706811;
        Thu, 17 Sep 2015 15:08:26 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:25ac:307e:6383:2d03])
        by smtp.gmail.com with ESMTPSA id je5sm5170090pbd.79.2015.09.17.15.08.26
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 17 Sep 2015 15:08:26 -0700 (PDT)
In-Reply-To: <20150917212016.GF606@cruxbox> (Remi Pommarel's message of "Thu,
	17 Sep 2015 23:20:16 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278172>

Remi Pommarel <repk@triplefau.lt> writes:

> On Thu, Sep 17, 2015 at 12:51:18PM -0700, Junio C Hamano wrote:
>> IIRC historically the division between ssl and crypto was messy.
>> Especially, I am not sure if the change to NEEDS_SSL_WITH_CRYPTO
>> in this patch is correct for platforms that require that macro
>> defined.
>
> I think it is correct as anywhere else in Makefile the order is ssl
> first then crypto (from Makefile:1047):

IIRC, NEEDS_SSL_WITH_CRYPTO was invented for people whose platform
needed that to be different

597c9cc5 (Flatten tools/ directory to make build procedure simpler.,
2005-09-07) has this bit:

    +ifdef NEEDS_SSL_WITH_CRYPTO
    +       LIB_4_CRYPTO = -lcrypto -lssl
    +else
    +       LIB_4_CRYPTO = -lcrypto
    +endif

That is, for most people, linking with -lcrypto was sufficient, but
some people needed to grab things from -lssl when they need to do
so, because things in -lcrypto referred to what was only in -lssl.

Are you on such a platform?  If so can you test these both ways and
make sure you are not breaking things for those on such a platform?
