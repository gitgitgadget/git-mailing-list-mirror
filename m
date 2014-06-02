From: Ronnie Sahlberg <sahlberg@google.com>
Subject: Re: [PATCH] refs.c: change read_ref_at to use the reflog iterators
Date: Mon, 2 Jun 2014 10:59:05 -0700
Message-ID: <CAL=YDWmc40RdtMfOra0y4fnAfFAnQMsxmpF7oMBNNvjF5t54ig@mail.gmail.com>
References: <1401479462-2329-1-git-send-email-sahlberg@google.com>
	<CAPig+cTi5qzS0xOvZcu05SK9vihufPDOxYYEEyo9AqG6wsKxoQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Mon Jun 02 19:59:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WrWVv-0004R6-Lr
	for gcvg-git-2@plane.gmane.org; Mon, 02 Jun 2014 19:59:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752168AbaFBR7I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Jun 2014 13:59:08 -0400
Received: from mail-ve0-f172.google.com ([209.85.128.172]:50917 "EHLO
	mail-ve0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750927AbaFBR7G (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jun 2014 13:59:06 -0400
Received: by mail-ve0-f172.google.com with SMTP id oz11so5693684veb.3
        for <git@vger.kernel.org>; Mon, 02 Jun 2014 10:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=q5Ygl3QxIP3Cgrrm4/TtXhKFJnQPLuoBaJVYEOi+uQE=;
        b=K2q2q1HzAs5cx2/NTuBrYYv7Zbyist5A0AjQDau+EfH+ZZS4MzZnyiMPUDSs+bLGCR
         t46KdUZHO/AyHNVRVRt9lHZTEWxvVtNFd/Vkc0csFy7PSywAI+R9wflVttvCMWioLhEP
         tDSfNjo+RBKtmpdaVdOh7rddCI4ys8+o8QyAG++SZzvqx1DFm3ZcQ5r3pMtCCusaxoaY
         KAt5U0OMv2TtSzbnc+PZW5xCM14NYvFeu2o6/9sIlKWRBc9oCWbC2Kgr4TH4g3+W4t16
         rblm2DcokFP6njeyJhIexiRwti9p5KxyxTAYfjCjndCYFAUBMXO6X0On0RWr/hR9/n1b
         gdeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=q5Ygl3QxIP3Cgrrm4/TtXhKFJnQPLuoBaJVYEOi+uQE=;
        b=IiJv9cYcjR46PRDL4m3cAPaZ49Ptip6ii/bqolsdkctyWHwIx1sYr573l897k7wRAj
         Ra2K+5+xxPA4y+GUk5uBeAl3l+jeBPnfhVYkLSxkDfdMYrUE+OB/9d7qZuSHGc2AlbK5
         i/yHIBkNwiXrEApy/wpzPbhgj1ZGgl3aVyT9dEQ/aVItVI0jOPU6WQSmXaBU4+YODChA
         SRGAj+eiTAYAia4vetZE4hWJZtgcQpSTC2+vXzUlMLTTS0h1d83Ntz2laYj6AeY5yz7W
         fCQQTYlyObghRBOV9F0oNtaMzu9yUdrckmfJ9H2/3gvXOTMzXB+SOpP2dN5Si2gsntaO
         SwCA==
X-Gm-Message-State: ALoCoQnC90d8cAOiYi8XR8UOlJXJAaw0VODqD9wXEW9e5neihZD4GZVMQQ98JorYv5b2loe6yXfv
X-Received: by 10.220.250.203 with SMTP id mp11mr31882255vcb.2.1401731945347;
 Mon, 02 Jun 2014 10:59:05 -0700 (PDT)
Received: by 10.52.255.65 with HTTP; Mon, 2 Jun 2014 10:59:05 -0700 (PDT)
In-Reply-To: <CAPig+cTi5qzS0xOvZcu05SK9vihufPDOxYYEEyo9AqG6wsKxoQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250574>

Fixed. Thanks.

On Fri, May 30, 2014 at 3:51 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Fri, May 30, 2014 at 3:51 PM, Ronnie Sahlberg <sahlberg@google.com> wrote:
>> read_ref_at has its own parsing of the reflog file for no really good reason
>> so lets change this to use the existing reflog iterators. This removes one
>> instance where we manually unmarshall the reflog file format.
>>
>> Log messages for errors are changed slightly. We no longer print the file
>> name for the reflog, instead we refer to it as 'Log for ref <refname>'.
>> This might be a minor useability regression, but I don't really think so, since
>> experienced users would know where the log is anyway and inexperienced users
>> would not know what to do about/how to repair 'Log ... has gap ...' anyway.
>>
>> Adapt the t1400 test to handle the cahnge in log messages.
>
> s/cahnge/change/
>
> More below.
>
>> Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
>> ---
>> diff --git a/refs.c b/refs.c
>> index 6898263..99d4832 100644
>> --- a/refs.c
>> +++ b/refs.c
>> @@ -2936,109 +2936,132 @@ static char *ref_msg(const char *line, const char *endp)
>>         return xmemdupz(line, ep - line);
>>  }
>>
>> +static int read_ref_at_ent(unsigned char *osha1, unsigned char *nsha1,
>> +               const char *email, unsigned long timestamp, int tz,
>> +               const char *message, void *cb_data)
>> +{
>> +       struct read_ref_at_cb *cb = cb_data;
>> +
>> +       cb->reccnt++;
>> +       cb->tz = tz;
>> +       cb->date = timestamp;
>> +
>> +       if (timestamp <= cb->at_time || cb->cnt == 0) {
>> +               if (cb->msg)
>> +                       *cb->msg = xstrdup(message);
>> +               if (cb->cutoff_time)
>> +                       *cb->cutoff_time = timestamp;
>> +               if (cb->cutoff_tz)
>> +                       *cb->cutoff_tz = tz;
>> +               if (cb->cutoff_cnt)
>> +                       *cb->cutoff_cnt = cb->reccnt - 1;
>> +
>> +               /*
>> +                * we have not yet updated cb->[n|o]sha1 so they still
>> +                * hold the values for the previous record.
>> +                */
>> +               if (!is_null_sha1(cb->osha1)) {
>> +                       hashcpy(cb->sha1, nsha1);
>> +                       if (hashcmp(cb->osha1, nsha1))
>> +                               warning("Log for ref %s has gap after %s.",
>> +                                       cb->refname, show_date(cb->date, cb->tz, DATE_RFC2822));
>> +               }
>> +               else if (cb->date == cb->at_time)
>> +                       hashcpy(cb->sha1, nsha1);
>> +               else
>> +                       if (hashcmp(nsha1, cb->sha1))
>
> This could be an 'else if', allowing you to drop one level of indentation.
>
>> +                               warning("Log for ref %s unexpectedly ended on %s.",
>> +                                       cb->refname, show_date(cb->date, cb->tz,
>> +                                                          DATE_RFC2822));
>> +
>> +               /*
>> +                * return 1. Not to signal an error but to break the loop
>> +                * since we have found the entry we want.
>> +                */
>> +               hashcpy(cb->osha1, osha1);
>> +               hashcpy(cb->nsha1, nsha1);
>> +               cb->found_it = 1;
>> +               return 1;
>> +       }
>> +
>> +       hashcpy(cb->osha1, osha1);
>> +       hashcpy(cb->nsha1, nsha1);
>> +       if (cb->cnt > 0)
>> +               cb->cnt--;
>> +
>> +       return 0;
>> +}
