From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v3 4/4] contrib: add convert-grafts-to-replace-refs.sh
Date: Fri, 6 Jun 2014 17:47:39 +0200
Message-ID: <CAP8UFD2kSP-ONaANhXhmr5-USC4af9RHEkeTOAhH6Jm-1TNdiA@mail.gmail.com>
References: <20140604194118.23903.3019.chriscool@tuxfamily.org>
	<20140604194353.23903.58934.chriscool@tuxfamily.org>
	<xmqqa99rrpgx.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Christian Couder <chriscool@tuxfamily.org>,
	git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Jakub Narebski <jnareb@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 06 17:47:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WswMq-0004jG-9x
	for gcvg-git-2@plane.gmane.org; Fri, 06 Jun 2014 17:47:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751883AbaFFPrk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jun 2014 11:47:40 -0400
Received: from mail-vc0-f169.google.com ([209.85.220.169]:48151 "EHLO
	mail-vc0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751460AbaFFPrj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jun 2014 11:47:39 -0400
Received: by mail-vc0-f169.google.com with SMTP id la4so3291615vcb.0
        for <git@vger.kernel.org>; Fri, 06 Jun 2014 08:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=8ZOZDz+251txAQUGUG26Tm3OwDKNB7xJPDcQVLQ/CNM=;
        b=akNEBGvzd97tU4XeDZbpgNnShuXrR2DHWDEY2pmBMDzN4IkJOiNGReS5k2Ovj9PmLN
         KIDKQ7epvFZweCCuLRVraagsnwLFq0eCT0Q6aTZpC1MfJdG2T+5wxU3XPtpKIPAbPz7C
         F50lOGIYcRxvP2hAN1XmE47Tg7OGw1ElD6R0DpEOBZGeLOC2r9wQj1mM9fpkUsgGm86t
         bw+v76TmhwTjWDkU58L/gOVfMMCT9CxSjo9yk7g3QXiYPnu+cfmGOpphud/pKMi39/Fo
         GfmKymY3A8N/ZPQhV+em943YCV24a6SlHUfvZjrzCel8MrhgUEAbXwG9JNCVCEljt7eR
         41FQ==
X-Received: by 10.220.92.135 with SMTP id r7mr6383572vcm.11.1402069659205;
 Fri, 06 Jun 2014 08:47:39 -0700 (PDT)
Received: by 10.58.134.107 with HTTP; Fri, 6 Jun 2014 08:47:39 -0700 (PDT)
In-Reply-To: <xmqqa99rrpgx.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250944>

On Thu, Jun 5, 2014 at 11:55 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Christian Couder <chriscool@tuxfamily.org> writes:
>
>> diff --git a/contrib/convert-grafts-to-replace-refs.sh b/contrib/convert-grafts-to-replace-refs.sh
>> new file mode 100755
>> index 0000000..8472879
>> --- /dev/null
>> +++ b/contrib/convert-grafts-to-replace-refs.sh
>> @@ -0,0 +1,29 @@
>> +#!/bin/sh
>> +
>> +# You should execute this script in the repository where you
>> +# want to convert grafts to replace refs.
>> +
>> +die () {
>> +     echo >&2 "$@"
>> +     exit 1
>> +}
>
> Don't we install git-sh-setup in GIT_EXEC_PATH, in order to allow
> these third-party scripts to begin with:
>
>         . $(git --exec-path)/git-sh-setup
>
> just like our own scripted Porcelains?

Ok, I will use that.

>> +GRAFTS_FILE="${GIT_DIR:-.git}/info/grafts"
>> +
>> +test -f "$GRAFTS_FILE" || die "Could not find graft file: '$GRAFTS_FILE'"
>> +
>> +grep '^[^# ]' "$GRAFTS_FILE" | while read definition
>> +do
>
> Format the above like so:
>
>     grep '^[^# ]' "$GRAFTS_FILE" |
>     while read definition
>     do
>
> which is easier to see what that "do" is doing.

Ok.

>> +     test -n "$definition" && {
>> +             echo "Converting: $definition"
>> +             git replace --graft $definition ||
>> +                     die "Conversion failed for: $definition"
>> +     }
>
> Hmph, why not if/then/fi?

Ok, I will use if/then/fi.

Thanks,
Christian.
