From: Luke Diamand <luke@diamand.org>
Subject: Re: [PATCH 2/2] git-p4: fix handling of multi-word P4EDITOR
Date: Thu, 07 May 2015 21:42:13 +0100
Message-ID: <554BCE25.5070308@diamand.org>
References: <1431019501-30807-1-git-send-email-luke@diamand.org>	<1431019501-30807-3-git-send-email-luke@diamand.org>	<xmqqr3qsp8a0.fsf@gitster.dls.corp.google.com>	<554BBCBE.1020408@diamand.org> <xmqqlhh0nny1.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	Chris Lasell <chrisl@pixar.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 07 22:42:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YqSdB-000520-CW
	for gcvg-git-2@plane.gmane.org; Thu, 07 May 2015 22:42:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751859AbbEGUmr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 May 2015 16:42:47 -0400
Received: from mail-wg0-f48.google.com ([74.125.82.48]:35612 "EHLO
	mail-wg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751846AbbEGUmr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 May 2015 16:42:47 -0400
Received: by wgyo15 with SMTP id o15so55032349wgy.2
        for <git@vger.kernel.org>; Thu, 07 May 2015 13:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=uIu11VuWjKmdmpShmnj75Vn3wv9x/ucF+/bCGaEEF7w=;
        b=iwErtyI5TPYGuUoNGMS5eS1VXsNra+294Ih3DaD7rKyo438mDEfiY8EP2qnEdjY8BO
         Gx3IbIFJ9hXwJOZMohqL45ipNbZbjnXIYVgfBb9ys+jeCk8KBoQDhs74o6r0GmxGJtng
         qW8a3ZSgsecaY6iMN9KLXrKR/IA7GxAqKtAwc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=uIu11VuWjKmdmpShmnj75Vn3wv9x/ucF+/bCGaEEF7w=;
        b=kAjgtEMQffbnQEL1kNwvTOahYgm2wquNtm+nUE5i9Ru0z3dRJ+h7WQJpL1B8E0tMAS
         UVDNzHtL6zQ39dew8slo6yrEhzVhL+X1KqdAz91CBpfm0kCg+rrlEA1iyWHx05OjrD5T
         9RMttoSVG1KYJmRqYSIqYKxJ2Yrmmgyo2LfnrQHgzgqwwjJJnEHhV81XpNdXggArU8s3
         XGqA7IAWjPhcDHaVIZnUYEjGVbTc/fWykuPEjT0Pa9DaX5MSXOlKXombdYTGeh94RNH8
         K2X3OQuzOiXmE4nZowBxWs+QDtdbmwa8d2NI5dYlvDaJY5xDO8nBCGC6056uydnZV4S+
         Zgmw==
X-Gm-Message-State: ALoCoQnUjwMLXKoNoh6GkLLDf4xAy+t67i6GMX4NfUAwVzCs3vEJVkGWzJ6faxFjt1tEDhnAlOUD
X-Received: by 10.180.79.66 with SMTP id h2mr126831wix.46.1431031365926;
        Thu, 07 May 2015 13:42:45 -0700 (PDT)
Received: from [192.168.245.128] (cpc7-cmbg17-2-0-cust139.5-4.cable.virginm.net. [86.1.43.140])
        by mx.google.com with ESMTPSA id r9sm5155945wjo.26.2015.05.07.13.42.44
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 May 2015 13:42:45 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.6.0
In-Reply-To: <xmqqlhh0nny1.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268586>

On 07/05/15 21:16, Junio C Hamano wrote:
> Luke Diamand <luke@diamand.org> writes:
>
>> On Linux:
>>
>> $ export P4EDITOR="gvim -f"
>> $ p4 submit
>> -- works as you would hope --
>>
>> $ export P4EDITOR="/home/lgd/My Programs/editor.sh"
>> $ p4 submit
>> sh: 1: /home/lgd/My: not found
>>
>> $ export P4EDITOR="/home/lgd/My\ Programs/editor.sh"
>> -- works fine --
>
> Good.  That is exactly I wanted to see.

Test case t9805-git-p4-skip-submit-edit.sh fails with that change. It 
sets P4EDITOR to "$TRASH_DIRECTORY/ed.sh".
