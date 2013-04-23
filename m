From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH v2 0/2] avoid bogus "recursion detected in die handler" message
Date: Tue, 23 Apr 2013 23:27:31 +0200
Message-ID: <CABPQNSbdYSbb5KrMDp8gKPTJcbjq2j91G3kJwrTMz=rJUydGuA@mail.gmail.com>
References: <20130415230651.GA16670@sigill.intra.peff.net> <20130415230802.GA11267@sigill.intra.peff.net>
 <CA+sFfMes99EepY4FCW32s1L3ywv_gyFb76=Y=35rvPbc2K1BWA@mail.gmail.com>
 <20130416004228.GA14995@sigill.intra.peff.net> <CA+sFfMdzTNjH10FKxhvJy+7hZg+0=1Wrqy9k8KaPoJg1DuDpmg@mail.gmail.com>
 <20130416025024.GA20932@sigill.intra.peff.net> <516CFB56.1090805@viscovery.net>
 <20130416130154.GA17976@sigill.intra.peff.net> <516D5CA4.7000500@viscovery.net>
 <20130416194418.GA7187@sigill.intra.peff.net>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Brandon Casey <drafnel@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Apr 23 23:28:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UUkl7-0002Iw-8M
	for gcvg-git-2@plane.gmane.org; Tue, 23 Apr 2013 23:28:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752933Ab3DWV2N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Apr 2013 17:28:13 -0400
Received: from mail-ie0-f181.google.com ([209.85.223.181]:36866 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752410Ab3DWV2M (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Apr 2013 17:28:12 -0400
Received: by mail-ie0-f181.google.com with SMTP id tp5so1253568ieb.40
        for <git@vger.kernel.org>; Tue, 23 Apr 2013 14:28:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:reply-to:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=bSiCC147oC9ldLpjAPO7B2ysQ2wYzERswzm+sQPVU5Y=;
        b=QgHDe/kLfn994z/hiE8Qo3o1Mkjua/J2yZdvgpJnVzQ36a2Y5un5fTEE1HXPsbkqui
         UBcH+7KrlYa2J2+mbeSkZXp/STTY20wqBKjjCvn1upyMc5QKQrFvvKOlxNINtjgySCSQ
         XTfEir191MF4Ag+KlybZwY7iWHic5ntqjz37UwLoWZ8bWHygnUs+NCMw5Asuuq0HY8nE
         ZZ684v1b0wkRlmO4yL8IffXH/LKBmr0FXt57RqYFJmE4oBmRc0zVMwVtQAVqjiNByvlr
         Pz5+c9Mm2xV/u24sWRsp/+gwTHpk0U2Mghh9HJbvjTu5uUW/V6u31Fq1SQNHIjD2kYyf
         ecuQ==
X-Received: by 10.50.131.225 with SMTP id op1mr3995181igb.85.1366752491776;
 Tue, 23 Apr 2013 14:28:11 -0700 (PDT)
Received: by 10.64.44.47 with HTTP; Tue, 23 Apr 2013 14:27:31 -0700 (PDT)
In-Reply-To: <20130416194418.GA7187@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222213>

On Tue, Apr 16, 2013 at 9:44 PM, Jeff King <peff@peff.net> wrote:
> On Tue, Apr 16, 2013 at 04:13:56PM +0200, Johannes Sixt wrote:
>
>> > I'm not clear on what you are suggesting. That we protect only the main
>> > thread from recursion, or that we drop the check entirely? Or that we
>> > implement thread-local storage for this case without using pthread_once?
>>
>> Anything(*) that does not require pthread_once. A pthread_once
>> implementation on Windows would be tricky and voluminous and and on top of
>> it very likely to be done differently for gcc and MSVC. I don't like to go
>> there if we can avoid it.

This seems to have been settled as a "we don't need to go there"
already, but just in case; here's an implementation of
PTHREAD_MUTEX_INITIALIZER using double-checked locks, and it would
probably be repurposable to do pthread_once if needed:

https://github.com/kusma/git/commit/c2d7190ed64652c3ac8ea1f2800ff8e7d0b6c01e

Yes, it's not pretty, it's error-prone; the best thing would be not to do it.
