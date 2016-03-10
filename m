From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 01/19] trace.c: add GIT_TRACE_PACK_STATS for pack usage statistics
Date: Thu, 10 Mar 2016 17:59:43 +0700
Message-ID: <CACsJy8BdbhPXAoP9ZSxtK3+gnmDmfJ_wB1w2od2QPL5HACRfWA@mail.gmail.com>
References: <1457548582-28302-1-git-send-email-dturner@twopensource.com>
 <1457548582-28302-2-git-send-email-dturner@twopensource.com>
 <xmqq4mcfgsxn.fsf@gitster.mtv.corp.google.com> <1457568342.13557.11.camel@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Thu Mar 10 12:00:24 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1adyKK-0008Lx-CO
	for gcvg-git-2@plane.gmane.org; Thu, 10 Mar 2016 12:00:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965528AbcCJLAR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Mar 2016 06:00:17 -0500
Received: from mail-lb0-f179.google.com ([209.85.217.179]:36677 "EHLO
	mail-lb0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932519AbcCJLAO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Mar 2016 06:00:14 -0500
Received: by mail-lb0-f179.google.com with SMTP id x1so106398345lbj.3
        for <git@vger.kernel.org>; Thu, 10 Mar 2016 03:00:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=E0LEgc5dv4aqkpmkVCKwsO0p496V9se3bRwjOMnHAS8=;
        b=oo7Dj/53WkdEIHHs2oZrj+f42Fy9RtTFTGX8rlext5SxsHrbSVW61zKwc/4x5+oPcR
         eNs6c7NccTt9yVsZw5S9Xi0nQjyDhBnqk3+rHJKKI01eUqJ023+8r09DIdK3ebttuIfc
         eRELmQAfVzeRj5gjvtNq/vCyDbbW3dabVQGrjbVayB8OFo3N7rk7O07ungu+P4aqYlR6
         iS8kgupToUHq+bBm3m8BhJRuBYQGnZfWQenOP5TDwPMUkT+l4itnmg4H9GiAGc+zFFzD
         9AVkvqS+kobyfeaGNq28wTP4O9ui6Y3UV9DQ60xfl5t56HtUcXi6qUNkS6rEOeVDqQsC
         mv5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=E0LEgc5dv4aqkpmkVCKwsO0p496V9se3bRwjOMnHAS8=;
        b=d9RQuCFOh8HEC/0TpyNYi/cv+j2msmdCPxZD/Adx19PugAxREuXb47g6HETJF2uQTv
         UTpkQUetXHyfDpKzhR9365i/VIneiP2DR43vzBH/ty2BKrUDZ/tLOkMMv41qk58x/0u/
         wO+gJTvilOWdwI40+d7bE1RUXI3vHegM21vHCxl32VfvLef16i1buEY/ehqVrEvXeu8H
         pbOQ7mTk/h+bw+SWSOz1kkXvHPrs345ZlPiCtOawz8mG7KR/9feZ1yosLofgLtvPI78b
         mANRxy8LBA1QEUq5LP8ozDBiqPbCBwXDhkFJgwNwFfjHgHnTsVXhK7awyjSWrxmJRAoe
         nxPw==
X-Gm-Message-State: AD7BkJKANuDrfmmmEoHhMHJOgsXkD3czuAGbM72nfi7ZO3CsidQjQwFdi4vk7YSljM63zy3Crg4zXOeynLbX0g==
X-Received: by 10.112.171.163 with SMTP id av3mr947558lbc.145.1457607613131;
 Thu, 10 Mar 2016 03:00:13 -0800 (PST)
Received: by 10.112.167.10 with HTTP; Thu, 10 Mar 2016 02:59:43 -0800 (PST)
In-Reply-To: <1457568342.13557.11.camel@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288612>

On Thu, Mar 10, 2016 at 7:05 AM, David Turner <dturner@twopensource.com> wrote:
> On Wed, 2016-03-09 at 14:58 -0800, Junio C Hamano wrote:
>> David Turner <dturner@twopensource.com> writes:
> ...
>> > trace_stats() is intended for GIT_TRACE_*_STATS variable group and
>> > GIT_TRACE_PACK_STATS is more like an example how new vars can be
>> > added.
> ...
>
>> > +   pack_access_nr++;
>> >  }
>>
>> This looks rather half-hearted, in that those who are interested in
>> this new number can run "wc -l" on the pack-access trace log without
>> adding a new "stats" anyway.  It may make the "stats" far more
>> useful to keep track of the summary information of what would be
>> written to the pack access log and add to the report_pack_stats()
>> output things like the average and median distance of seeks
>> (i.e. differences in the "obj_offset" into the same pack by two
>> adjacent pack accesse) and the variance, for example?
>
> On reflection, I do not think I need this patch; it was in Duy's series
> and the index stats patch would need to be rewritten slightly to get
> rid of it, but I'm OK with that.  I wanted to make minimal changes to
> Duy's patches, but I'd rather make larger changes than do work on
> patches I don't need.
>
> So unless Duy objects, I'm going to drop this from the series.

I wanted something to verify from the tests and this was the best I
could come up. But since I added trace_printf_key(&trace_exclude,... I
think that could serve better to show what's going on, and we can
easily summarize from the trace if we want to. That's one option. If
you can adjust the tests another way, I'm fine too.
-- 
Duy
