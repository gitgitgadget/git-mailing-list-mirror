From: Nick Muerdter <stuff@nickm.org>
Subject: Re: Permission denied on home dir results in fatal error as of 1.8.1.1
Date: Fri, 8 Feb 2013 19:33:27 -0700
Message-ID: <CAECnihwGK8+cHJYQCVMtTwRnrh5V3T-v2-8dM2rd=ziRUA2x5A@mail.gmail.com>
References: <CAECnihxpvtE1XejzHDCRBF=GkyBHmb53WDLa16Suiq=4SeYzvA@mail.gmail.com>
	<7v6222xqc4.fsf@alter.siamese.dyndns.org>
	<20130209010534.GC8461@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 09 03:33:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U40GF-0000mu-TI
	for gcvg-git-2@plane.gmane.org; Sat, 09 Feb 2013 03:33:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760537Ab3BICd2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Feb 2013 21:33:28 -0500
Received: from mail-qc0-f172.google.com ([209.85.216.172]:45719 "EHLO
	mail-qc0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753787Ab3BICd2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Feb 2013 21:33:28 -0500
Received: by mail-qc0-f172.google.com with SMTP id b25so1672383qca.3
        for <git@vger.kernel.org>; Fri, 08 Feb 2013 18:33:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:x-received:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :x-gm-message-state;
        bh=Twmf/l7Te62b23om5Prelx3MJquNTeoIYXSVLU55r7Q=;
        b=AW8HKmu9lGDCY796BlXWMp29RHN7nXoNTdTcHGqglps87VCYORyPznk7K86PFoV0o2
         bwnDQiBoGcLey2Wv2TzQs29yg6IDCYBVUBNCeQRCRerl6/w9qW06/Vpv9WTZo85KHhwF
         NWoesafSSaJ2Km/kdq/yx2ZsJF0FCEJ4iGX1tytxk/Oju0uBvnpjW697eIHS0zg7pwPL
         16sxVHAmo4+0CypUI5qxUUksHbZeM9yC3m8WmvuwuGTi4jpq+dTeeQsUHSspkpf9uz8Q
         O6q/SgFA63lrUQhnCPrdtDMlW/5BHMRsXlkkhxprj2/yLdNrTJ6flNn6mV2Me5CsJeJC
         9GiA==
X-Received: by 10.49.34.146 with SMTP id z18mr3201659qei.29.1360377207303;
 Fri, 08 Feb 2013 18:33:27 -0800 (PST)
Received: by 10.49.39.37 with HTTP; Fri, 8 Feb 2013 18:33:27 -0800 (PST)
In-Reply-To: <20130209010534.GC8461@google.com>
X-Google-Sender-Auth: kg1CN7IUsZiUBhmxkurFJPlE7Ts
X-Gm-Message-State: ALoCoQmcCADRr158TiZnOJC2Wo7tVrgjFXZSiDlt5swv/a9FYb7XD98FjVfYu2T3Gf1Utrt0gyBo
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215846>

On Fri, Feb 8, 2013 at 6:05 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Junio C Hamano wrote:
>> Nick Muerdter <stuff@nickm.org> writes:
>
>>> As of git 1.8.1.1 and above (tested up to 1.8.1.3), if the home
>>> directory can't be accessed, it results in a fatal error. In git 1.8.1
>>> and below this same setup just resulted in warnings. Was this an
>>> intentional change?
>>
>> I think this was done to not just help diagnosing misconfiguration,
>> but to prevent an unintended misconfiguration from causing problems
>> (e.g. the user thinks user.name is set up correctly, but forbids Git
>> from reading it from the configuration files, and ends up creating
>> commits under wrong names).
>
> Yes, that's right.  Sometimes ignoring settings has bad consequences,
> so git errors out to let the user intervene and decide whether the
> inaccessible settings are important.

Thanks for the quick response.

Just for reference, the specific issue I ran into stems from using
Chef to provision servers. Chef gets run as root but can perform the
git commands as a different user on the system. The way this appears
to be implemented is to fork, set the uid, and then execute git. But
since the HOME environment variable is still set to /root, this leads
to this fatal error. This can obviously be fixed on the script's end
by properly determining and setting the HOME before executing git, but
more care has to be taken, and I'm not sure how common this fork + set
uid + exec approach in other programs might be. But I'll file a bug
with Chef to get it fixed there.

Thanks again,
Nick
