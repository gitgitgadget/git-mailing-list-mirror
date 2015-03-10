From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 2/3] bundle.c: fix memory leak
Date: Tue, 10 Mar 2015 16:08:32 -0700
Message-ID: <CAGZ79kZ5=Q3WE6Ztr7PJ2Kv2xdKdCB2cD+_MH1GcqEDiZpU11w@mail.gmail.com>
References: <1425920304-22360-1-git-send-email-sbeller@google.com>
	<1425920304-22360-2-git-send-email-sbeller@google.com>
	<xmqq1tkwzdbj.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 11 00:08:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YVTGR-0005DE-NL
	for gcvg-git-2@plane.gmane.org; Wed, 11 Mar 2015 00:08:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750772AbbCJXId (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Mar 2015 19:08:33 -0400
Received: from mail-ie0-f173.google.com ([209.85.223.173]:33302 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750707AbbCJXId (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Mar 2015 19:08:33 -0400
Received: by iecvj10 with SMTP id vj10so35004927iec.0
        for <git@vger.kernel.org>; Tue, 10 Mar 2015 16:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=7LC552jVRnyE0FF9XHL9bGFj6faN8rA6PzfWdB7EISY=;
        b=gjucpWIQHf0JSHqJ4iFBpe0OcY3Na9kFePmhvhSsGMWIawE5Rh3vHjigLgQtL8QWTo
         RuuPmKT+5BDkyNEoyrUZS3Mdc8dzzkoGkk6Zc05c46wp2MT43BfeZkuQ736teUbDg8Sl
         yle1mojKMTzTODNo2iD5rZPUMZP9JupdU1PHcpsQ8D1Unqvx2V/YB505w/AQK8SFMtZc
         jEGaCuA57qw/Et5dy9GEyKcT3+Vs+vVOHtH8rRWKrHvBGUP6C1BUw8Hz2b8tEi/LiBrW
         hKBqmqxrc9JNsZhWBEWMpa1zyYn7rY8QZ1UTKfVjAIt0db5BI/wmnJewfXKvsOlGOfoz
         zxKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=7LC552jVRnyE0FF9XHL9bGFj6faN8rA6PzfWdB7EISY=;
        b=FYiJpdNo1PBqDpO/BysR2rbkqoW6HWsWkvU1HOtsC+tWRXWF/w6LtpKvc+hMHDfnZV
         Psk5iLYFIvJjzClWQNEaEW8y14LXJBS13MzOQR/nnCNvxUZRFn/auKYH0/waM3lzepp1
         4H82J1AF2AMct7cRY2Hutw3oe2vPS0a5hFvMahFH1+NXOuI+S9nN7ddnvpzXrMRivccx
         SKF9izmSmMomiB/ClQYy1Tw7txU9fjVCPu993e8cNhVcGlAvTLOWTXpH+9jhB3yr5UdW
         /YET/vq/37jWrXwvtTTv+4/x1SzreU5PR+pOskRXmYEHbKtpcaZ3XNrWbD888ydm1AR3
         ouCA==
X-Gm-Message-State: ALoCoQm0MZPeNikfqtTqNjd4Q/cUyPG5FeiGY9Xq6Bm0YcAjW11s5Zv7ymjhmsrycc/7/y69+9NT
X-Received: by 10.50.107.36 with SMTP id gz4mr60976810igb.25.1426028912307;
 Tue, 10 Mar 2015 16:08:32 -0700 (PDT)
Received: by 10.107.46.31 with HTTP; Tue, 10 Mar 2015 16:08:32 -0700 (PDT)
In-Reply-To: <xmqq1tkwzdbj.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265279>

On Tue, Mar 10, 2015 at 3:40 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> The continue statements nearby also have an accompanying free(ref);
>>
>> Signed-off-by: Stefan Beller <sbeller@google.com>
>> ---
>
> I wonder what happens when dwim_ref() returned 2 or more, though.

That should also be fixed I guess. I'll look into it.

These one liner fixes are mostly done as a side project
having fun, just doing what the code analysis tools says,
sorry for not catching that one.

Maybe instead of the reoccuring pattern

    free(ref);
    continue;

we could just have a

    goto cleanup

which goes to the end of the loop where we have
the free anyway.
