From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 6/8] run-command: add an asynchronous parallel child processor
Date: Mon, 14 Dec 2015 13:40:28 -0800
Message-ID: <CAGZ79kbseHv+gbjxFHH8nO_QV-8SS+7u=LYVQ0_K5u39rD0uGQ@mail.gmail.com>
References: <1450121838-7069-1-git-send-email-sbeller@google.com>
	<1450121838-7069-7-git-send-email-sbeller@google.com>
	<566F28EA.3080802@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Eric Sunshine <ericsunshine@gmail.com>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Mon Dec 14 22:40:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a8arE-0006nN-69
	for gcvg-git-2@plane.gmane.org; Mon, 14 Dec 2015 22:40:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932733AbbLNVkc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Dec 2015 16:40:32 -0500
Received: from mail-io0-f174.google.com ([209.85.223.174]:33425 "EHLO
	mail-io0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932382AbbLNVk3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Dec 2015 16:40:29 -0500
Received: by iow186 with SMTP id 186so41625204iow.0
        for <git@vger.kernel.org>; Mon, 14 Dec 2015 13:40:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=oLIQrZaBOlvWyfYqY9GmqMcVQWSMrZ9ZONiogUdcmjA=;
        b=oxKw/W/hR0wya5UlNTbrdZYpqKuZDEU1KYM2I49HFprzlIiUnAS9Xk47bvEf2gyi3q
         HzgwqtTu0j4iiCL4eaOuMKtGxF3ae69/556wS6kTipKjWozWgHjwk/XJT2LzG9DUnkt5
         wghXWWOKP/gKOlUy6ou9MHrKqYCow18ANAtvh6dxAo40xUXIP7djeB0aVHTbcHULfDPt
         jAmOZS0MwDxNUXbwW8BVOJ8d0EFYa35SG+ZnAScB8AOU5+YUt2BlwZ4IBr79qXrHICs3
         ca0mmWwaKzJpXZed/bqLPxmLJYNQfpbTkgKJCgQr9TrH8xLujFJBMxmGbMA+/U2HDz75
         QtwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=oLIQrZaBOlvWyfYqY9GmqMcVQWSMrZ9ZONiogUdcmjA=;
        b=D7CMAXCsVeJsOYyPUhYH6c6xxNSPzpYT33O8gin0XvnX+rqv60IVs3TyTFbOs8clY4
         Kq3xHBn0dMI7JTRCk03IYIZYf8mP3DO0GqeU0RCNu4qpqVxDpKtC6XCAklG+Jmx5Kx7T
         E6OUI6yvfmE4x2RPVstK3WfpYUZyyBxRpsiWe+j1ULNxNTJEnyKNLT6bAqHHtg5YMFt5
         7Myy/K8UGuyqhM5hvscYWcI4Z2kMRBnZI6mlYWz5YgdKT7qInRbNXftimGxyi1+NWmVg
         N+7NtvvLi6GJhAUcwMPYWqXhe2TRHF2vHWGowZT2laLq70DeWE+LnfZUXRECAmL5GFFF
         +/Kw==
X-Gm-Message-State: ALoCoQnltRtMEp+F7y4QsnrVubJ2dDR43F9zti896LzWPudD/Tm62o72fXshlq2hfPcRO8h31LUYNqqwQmT/EavTRUG2wDxwwP3fPCu9F5a0fvhaQNwhjUQ=
X-Received: by 10.107.152.142 with SMTP id a136mr37185872ioe.110.1450129228472;
 Mon, 14 Dec 2015 13:40:28 -0800 (PST)
Received: by 10.107.8.84 with HTTP; Mon, 14 Dec 2015 13:40:28 -0800 (PST)
In-Reply-To: <566F28EA.3080802@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282424>

On Mon, Dec 14, 2015 at 12:39 PM, Johannes Sixt <j6t@kdbg.org> wrote:
>
> I can't quite parse the first sentence in this paragraph. Perhaps something
> like this:
>
> To detect when a child has finished executing, we check interleaved
> with other actions (such as checking the liveliness of children or
> starting new processes) whether the stderr pipe still exists. Once a
> child closed its stderr stream, we assume it is terminating very soon,
> and use finish_command() from the single external process execution
> interface to collect the exit status.

Sounds much better than my words. If a resend is necessary, I'll have your
reworded version of the paragraph instead.

>
>
>>
>> By maintaining the strong assumption of stderr being open until the
>> very end of a child process, we can avoid other hassle such as an
>> implementation using `waitpid(-1)`, which is not implemented in Windows.
>>
>> Signed-off-by: Stefan Beller <sbeller@google.com>
>
>
