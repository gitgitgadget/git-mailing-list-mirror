From: Luke Diamand <luke@diamand.org>
Subject: Re: [PATCHv3 1/3] git-p4: add failing test for P4EDITOR handling
Date: Wed, 20 May 2015 22:43:43 +0100
Message-ID: <555D000F.105@diamand.org>
References: <xmqqa8x0a7wq.fsf@gitster.dls.corp.google.com>	<1432074198-13806-1-git-send-email-luke@diamand.org>	<1432074198-13806-2-git-send-email-luke@diamand.org>	<xmqq617nnhxk.fsf@gitster.dls.corp.google.com> <xmqqd21vm0hw.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 20 23:44:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YvBmp-00041C-HP
	for gcvg-git-2@plane.gmane.org; Wed, 20 May 2015 23:44:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753465AbbETVoT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 May 2015 17:44:19 -0400
Received: from mail-wi0-f182.google.com ([209.85.212.182]:33586 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752624AbbETVoS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 May 2015 17:44:18 -0400
Received: by wicmx19 with SMTP id mx19so812079wic.0
        for <git@vger.kernel.org>; Wed, 20 May 2015 14:44:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=g3fAQ0xwwVlsscN3sl0l2hgrEL42m6eUSQqRejcDb3c=;
        b=jGD1iY/SKI4hUndUBcKnB5j7u3kFAIBmDzC020nqPPq39jheneXON2G9Hdk6T2Ep9O
         dU5Qh4ApumsIzL2mOO9mWL0m5GmPYW7PzfXyqr5Z5vFd0RaQNRO5bxFiBpvk/YrIJ4aO
         M29OqNK3isWTze6DYNAFLWGKzVNp1T3nAQ1Ok=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=g3fAQ0xwwVlsscN3sl0l2hgrEL42m6eUSQqRejcDb3c=;
        b=dKMAnO97fw29Gus/yvuXB63k9QQLuT4xTJy+1CLJtC6K7CWuwPwgRix5PHScwKSToN
         LPniXTwXMtZfoDYFtSvrB2gtoFDcgmbuQrO74b8uqR0ytAvDfRXCh4wetrEe/efOnItv
         +LS2deJVJbVNOHAVMBUQ/tnb9//+KCFXQTPqeQs5XNRXhzgd7zupxALnTIdW91rURts6
         WRqrmP03nHnEsHQUNqEGiEJB8/MlncZEqhtTlsp41JuD5BJkt37P3/3g6W0jmzKVW5J9
         pc2OGtgT4fDqAha0QupxMw9T33mo8cIYy7g5hf7S0Z+aGn7XVjBiWY6ECb7avK/ZHc2a
         2QAw==
X-Gm-Message-State: ALoCoQm4c+JZahpkO3r+zQbSzdDS3W6Pf2uBXcPhttps9Vi5GDhE3Zoa93h1UhdHiMhq4WABx7qH
X-Received: by 10.194.161.138 with SMTP id xs10mr70113455wjb.37.1432158257158;
        Wed, 20 May 2015 14:44:17 -0700 (PDT)
Received: from [192.168.245.128] (cpc7-cmbg17-2-0-cust139.5-4.cable.virginm.net. [86.1.43.140])
        by mx.google.com with ESMTPSA id v3sm5470998wix.8.2015.05.20.14.44.16
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 May 2015 14:44:16 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.6.0
In-Reply-To: <xmqqd21vm0hw.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269531>

On 20/05/15 21:56, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> Luke Diamand <luke@diamand.org> writes:
>>
>>> +
>>> +test_expect_failure 'EDITOR has options' '
>>> +# Check that the P4EDITOR argument can be given command-line
>>> +# options, which git-p4 will then pass through to the shell.
>>> +test_expect_success 'EDITOR has options' '
>>> +	git p4 clone --dest="$git" //depot &&
>>
>> Oops?  I assume that the one before the comment should go and this
>> one is
>>
>> 	test_expect_failure 'Editor with an option' '
>>
>> or something.
>
> I'll queue the three patches, each of them followed with its own
> SQUASH commit.  Could you sanity check them?  If everything looks OK
> then I'll just squash them and that way we can save back-and-forth.

That would be great, thanks!
