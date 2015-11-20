From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH 0/5] Use watchman to reduce index refresh time
Date: Fri, 20 Nov 2015 10:45:21 +0100
Message-ID: <CAP8UFD00SViJ3fdj2s+z1-GWtrcgrF_pXuUUsEGjzmnxe5_gmQ@mail.gmail.com>
References: <1446386146-10438-1-git-send-email-pclouds@gmail.com>
	<CAHVLzcn3j8eLi9VrNoZjyOZ2UzE7=NYF1bqB9UyKmghUoUw1Zg@mail.gmail.com>
	<CACsJy8DzSEVJYc85-3vSAZ8wB1pR9TLz0RrKyKFfHth9Tq+xyg@mail.gmail.com>
	<CACsJy8Dz17gRSHch9e=iB2Kq2t4FbssatW84DF8pHTuFMgEgjQ@mail.gmail.com>
	<CAP8UFD0rAL62eFdtLo__ta=_Yhq4cdRcqmfYTqw3imNa5Lde-A@mail.gmail.com>
	<1447189468.20147.32.camel@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Duy Nguyen <pclouds@gmail.com>,
	Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>,
	Git <git@vger.kernel.org>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Fri Nov 20 10:47:06 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZziGA-0007TV-Aw
	for gcvg-git-2@plane.gmane.org; Fri, 20 Nov 2015 10:45:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934919AbbKTJpZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Nov 2015 04:45:25 -0500
Received: from mail-ig0-f172.google.com ([209.85.213.172]:33190 "EHLO
	mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934085AbbKTJpW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Nov 2015 04:45:22 -0500
Received: by igvi2 with SMTP id i2so29616511igv.0
        for <git@vger.kernel.org>; Fri, 20 Nov 2015 01:45:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=won700Rh9Ou0ht1nwo+lAgOijrC0ksngwWCRNWOXGjI=;
        b=zQXFFEefnoYJ/6cDQNEVM7/oWi1PS9JFJ1fUL1VExcg16jSJT/lYeBP2V9vv8HC3Wd
         zt3N3lksL0mP6RYB0xI2r3PtX3fgwQIDG2oHfayDgaJZBsAA8fnH83hTOP2Zx0AndTcT
         5z0RiArqaR/SC38PovIvlijjn6nAXDa3J5uMC4qnm/QYrSgpUXCXa/FDTmI6t8Yoxyxj
         n7gTgQn4ZAxouFV8iWMCH1//OMzBStCbioyln2n3W1v0OCJpaJSxqksFABMWZvQ5dCiR
         6h7PgXSFJWNgSIT35T3/+y+wD38QMz0LaUuf1TjVX49V68QMY7er68zbFF3LUUWh0f4R
         ZaOQ==
X-Received: by 10.50.59.179 with SMTP id a19mr851992igr.59.1448012721862; Fri,
 20 Nov 2015 01:45:21 -0800 (PST)
Received: by 10.36.146.68 with HTTP; Fri, 20 Nov 2015 01:45:21 -0800 (PST)
In-Reply-To: <1447189468.20147.32.camel@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281502>

On Tue, Nov 10, 2015 at 10:04 PM, David Turner <dturner@twopensource.com> wrote:
> On Mon, 2015-11-09 at 21:06 +0100, Christian Couder wrote:
>> Using David's series I get worse results than all of the above but I
>> guess it's because his series is based on an ancient git version
>> (v2.0.0-rc0).
>
> My more-recent series is on top of 2.4, but (for webkit):
> mine: 0m0.206s
> duy's: 0m0.107s

I tried using your more recent series and I get basically no change
compared to the current git (without using untracked cache) on Webkit
with around 5600 untracked files. Maybe I am doing something wrong.

I compiled watchman and installed it. It is in /usr/local/bin/watchman
but I am not sure it is actually being used though I have configured
"core.usewatchman" to "true".

> However, I'm getting occasional index-helper segfaults due to
> istate->last_update being NULL.  (I'm using Duy's  index-helper branch
> from his github + this patchset + a function signature fix due to a
> newer version of libwatchman).  I haven't looked into why this is --
> maybe accidentally mixing git versions while testing?
>
> Also, after messing around for a while (on Duy's branch), I ended up in
> a state where git status would take ~2.5s every time.  The index helper
> was alive but evidently not working right.  Killing and restarting it
> worked.  Actually, I think I can repro this more easily: "git rm
> Changelog" seems to put the index-helper into this state.

Thanks for this. I have also seen strange things happening with the
index-helper.
When it is working I found that it provides around 10% improvement on
git rebase time.
