From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 5/7] receive-pack: move execute_commands_non_atomic before execute_commands
Date: Tue, 23 Dec 2014 16:30:44 -0800
Message-ID: <CAGZ79ka0hAko54g4rG27Ef=YFAXd-x50bPr0NSHRwPtDEobzHQ@mail.gmail.com>
References: <1419017941-7090-1-git-send-email-sbeller@google.com>
	<1419017941-7090-6-git-send-email-sbeller@google.com>
	<xmqqfvc7a6o3.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: ronnie sahlberg <ronniesahlberg@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 24 01:30:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y3Zqk-0002vH-Mo
	for gcvg-git-2@plane.gmane.org; Wed, 24 Dec 2014 01:30:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756630AbaLXAaq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Dec 2014 19:30:46 -0500
Received: from mail-ig0-f177.google.com ([209.85.213.177]:41690 "EHLO
	mail-ig0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751297AbaLXAap (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Dec 2014 19:30:45 -0500
Received: by mail-ig0-f177.google.com with SMTP id z20so6296283igj.10
        for <git@vger.kernel.org>; Tue, 23 Dec 2014 16:30:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=pz4XkVSvug8vfGwjJl1zefKR0AJ5vTvj13XTA00GkIM=;
        b=f6b2w5d680ys5rVmmI9l5SUVkBoWmDPN7N/MzdIekaZYAtfM90inN8+1hjUoEr5icR
         SntQLudlbCRb5jq0zqVpbH3KP61izFMtAVZoz9WTtIbYmRqJl/n6rtFci2rRtmmOVFK0
         HIYjOFoOWwhnf+ZOqzkqmZ67ZwJ/ZBXpCforH/hmF71N0hT9Zr0iqgC/sAdo6gRZvzeh
         RwsvL0rUCqnjyCuYMlK5HC5rUvV2Bb3j2ifiBcCrVkUi2LjMHnSihua2LNjUC45mOpeG
         JoEYYTarA1yiCP6mWj1W6vJMwiKrTk8s0zeZd6wiIjaF4+i7LtxpQSuj1qk7JhTzfTGw
         ocyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=pz4XkVSvug8vfGwjJl1zefKR0AJ5vTvj13XTA00GkIM=;
        b=OqRn25Z+U9+K5qeM5jNIJW4PM1nurLL1RUZKp3hiqT7qJZ1sfpiHWUSETQKuhyjebL
         4iLr/7Ktg6Q1qAdNhVwn8amZx/JfHCBLfsJ+7C3wKQdHwj+vbeDFHBO2ShvPyBAo+8Ur
         6FDNzrmuXWM/LNZ+NywHHngIkSLTjJcS9NXUddHTQj7rMJ7IG76DDw1JBtwMu6aRGgNT
         9d1Laou/dC9wwWXo3PQdP6AqQaFSj9FjYTcFnGP0GEontvwxjulu7NJ/mhviSET8B72f
         Sj0/sXxjMGOrw/cDNa2JU85k2Gd7TGo8xi5iMDnpTw1/8Df4TWiBe51jv/6EzVNUGL0c
         z7Sg==
X-Gm-Message-State: ALoCoQkyOBlw5zzNxK2a37vr4YSyq84z19cwZdgIXEkXb92/GiZNQYLXJrKgA1ylM8SOvdMUyRgH
X-Received: by 10.43.82.72 with SMTP id ab8mr24916879icc.76.1419381044911;
 Tue, 23 Dec 2014 16:30:44 -0800 (PST)
Received: by 10.107.31.8 with HTTP; Tue, 23 Dec 2014 16:30:44 -0800 (PST)
In-Reply-To: <xmqqfvc7a6o3.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261785>

I tried all four diff options as listed in the man page of
format-diff. I forget which one I used, but there was no large
difference w.r.t. reviewability if I remember correctly.


On Mon, Dec 22, 2014 at 10:19 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> Notes:
>>     This patch is new with v6 of the series
>>
>>     As execute_commands_non_atomic is larger than execute_commands, the diff
>>     is not moving around execute_commands_non_atomic, but execute_commands.
>
> ;-)
>
> Next time perhaps try "--patience" to decide between with and
> without which one reads better?
