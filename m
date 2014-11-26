From: Paolo Bonzini <bonzini@gnu.org>
Subject: Re: [PATCH 0/2] git-am: add --message-id/--no-message-id options
Date: Wed, 26 Nov 2014 10:07:18 +0100
Message-ID: <54759846.6040804@gnu.org>
References: <1416924056-29993-1-git-send-email-bonzini@gnu.org>	<CAP8UFD0+Ef9JbbkZ+LBHcD6DVZiMGxFdrMnjLEViHHMERY5wuw@mail.gmail.com>	<5474B5EE.1030406@redhat.com> <CAP8UFD0WcSM4NP8XHQe5pg0bwC5-C19OdcNoPWFFz7Ngrfbg8g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Cc: git <git@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>
To: Christian Couder <christian.couder@gmail.com>,
	Paolo Bonzini <pbonzini@redhat.com>
X-From: git-owner@vger.kernel.org Wed Nov 26 10:07:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XtYZV-0004dM-9q
	for gcvg-git-2@plane.gmane.org; Wed, 26 Nov 2014 10:07:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751389AbaKZJH3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Nov 2014 04:07:29 -0500
Received: from mail-wi0-f178.google.com ([209.85.212.178]:60478 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751016AbaKZJHX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Nov 2014 04:07:23 -0500
Received: by mail-wi0-f178.google.com with SMTP id hi2so4174509wib.11
        for <git@vger.kernel.org>; Wed, 26 Nov 2014 01:07:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=EoEsJohrd2aBWk1XJ4gHTukSXhEFwZu3yGvx+GvhQzc=;
        b=TSjdAV3d1wuD5SHVQFFaCIEi0/11wkMgrCoqL5iOqOn4oUXdXtRo6mGKXEkxc9D8Pv
         9MLeLvr279xXmgGaD6SNzQ/bDxsRA/oLa16KI7/iDsgnKGL06BOU5McXK6UI24rdaABD
         7ECG/qUEsWh3jTZhCZhv6b2dQGoJFv1IaaO4eUGSIKrKO9OXMejATi2d36oFRm5MKsvZ
         imC/a8+je/RzYnkcFecLguWh1ajc8oBL3ZFLfi1pGlNxhSpCaN1jw+yl5qJK3OlIU2JP
         18A6DOgNymE6rEouPtK8mTQdgnkuJ/KWCBGpcvljQfqmPK7MI+IhtP/hw7E1HlL1NhcD
         Of8A==
X-Received: by 10.194.92.176 with SMTP id cn16mr45681435wjb.62.1416992842064;
        Wed, 26 Nov 2014 01:07:22 -0800 (PST)
Received: from [192.168.10.150] (net-93-146-133-240.cust.vodafonedsl.it. [93.146.133.240])
        by mx.google.com with ESMTPSA id h2sm6398626wix.5.2014.11.26.01.07.19
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Nov 2014 01:07:20 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
In-Reply-To: <CAP8UFD0WcSM4NP8XHQe5pg0bwC5-C19OdcNoPWFFz7Ngrfbg8g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260276>



On 25/11/2014 22:21, Christian Couder wrote:
> On Tue, Nov 25, 2014 at 6:01 PM, Paolo Bonzini <pbonzini@redhat.com> wrote:
>>
>>
>> On 25/11/2014 17:27, Christian Couder wrote:
>>>>> From: Paolo Bonzini <pbonzini@redhat.com>
>>>>>
>>>>> This series adds a --message-id option to git-mailinfo and git-am.
>>>>> git-am also gets an am.messageid configuration key to set the default,
>>>>> and a --no-message-id option to override the configuration key.
>>>>> (I'm not sure of the usefulness of a mailinfo.messageid option, so
>>>>> I left it out; this follows the example of -k instead of --scissors).
>>>>>
>>>>> This option can be useful in order to associate commit messages with
>>>>> mailing list discussions.
>>>>>
>>>>> If both --message-id and -s are specified, the Signed-off-by goes
>>>>> last.  This is coming out more or less naturally out of the git-am
>>>>> implementation, but is also tested in t4150-am.sh.
>>> Did you have a look at git interpret-trailers currently in master?
>>
>> Hmm, now I have.
>>
>> As far as I understand, all the git-am hooks are called on the commit
>> rather than the incoming email: all headers are lost by the time
>> git-mailinfo exits, including the Message-Id.  And you cannot call any
>> hook before git-mailinfo because git-mailinfo is where the
>> Content-Transfer-Encoding is processed.
>>
>> How would you integrate git-interpret-trailers in git-mailinfo?
> 
> I don't know exactly, but people may want to add trailers when they
> run git-am, see:
> 
> http://thread.gmane.org/gmane.comp.version-control.git/251412/
> 
> and we decided that it was better to let something like git
> interpret-trailers decide how they should be handled.
> 
> Maybe if git-interpret-trailers could be called from git-mailinfo with
> some arguments coming from git-am, it could be configured with
> something like:
> 
> git config trailer.Message-Id.command 'perl -ne '\''print $1 if
> m/^Message-Id: (.*)$/'\'' $ARG'
> 
> So "git am --trailer 'Message-Id: msg-file' msg-file" would call "git
> mailinfo ..." that would call "git interpret-trailers --trailer
> 'Message-Id: msg-file'" that would call "perl -ne 'print $1 if
> m/^Message-Id: (.*)$/' msg-file" and the output of this command, let's
> call it $id, would be put into a "Message-Id: $id" trailer in the
> commit message.

I think overloading trailer.Message-Id.command is not a good idea,
because it would prevent using "git interpret-trailers" to add a message
id manually ("git interpret-trailers --trailer message-id='<foo@bar>'").

Another possibility could be to add a third output file to git-mailinfo,
including all the headers.  Then a hook could be called with the headers
and commit message.

The question is: what would it be used for?  There aren't that many mail
headers, and most of them (From, Subject, Date) are recorded in the
commit anyway.  One idea could be to record who was a recipient of the
original message, even if no Cc line was added explicitly.  In most
projects, Cc is often added randomly, but I guess that's a valid
usecase.  I can certainly code the above hook instead of this approach
if Junio thinks it's better.

In the meanwhile, I have thought of a couple additions to "git
interpret-trailers" and I can submit patches for them.

Paolo

> This way there is nothing specific to Message-Id in the code and
> people can decide using other trailer.Message-Id.* config variables
> exactly where the Message-Id trailer would be in the commit message.
> 
> Best,
> Christian.
> 
