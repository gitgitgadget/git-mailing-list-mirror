From: Pranit Bauva <pranit.bauva@gmail.com>
Subject: Re: [PATCH 2/2] bisect--helper: `check_expected_revs` shell function
 in C
Date: Fri, 10 Jun 2016 13:22:35 +0530
Message-ID: <CAFZEwPNYxWpFcspHL8Oo3NydUPuKQeZWCFphM_an+_iKk9wBVw@mail.gmail.com>
References: <20160608152415.7770-1-pranit.bauva@gmail.com> <20160608152415.7770-2-pranit.bauva@gmail.com>
 <CAPig+cQVWng0idk0ETRQA44OsS5+GewVX=pt4uOg-=SFbL+deQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Lars Schneider <larsxschneider@gmail.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Fri Jun 10 09:52:41 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bBHFB-0003mJ-1N
	for gcvg-git-2@plane.gmane.org; Fri, 10 Jun 2016 09:52:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751573AbcFJHwh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Jun 2016 03:52:37 -0400
Received: from mail-yw0-f194.google.com ([209.85.161.194]:34565 "EHLO
	mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751225AbcFJHwh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Jun 2016 03:52:37 -0400
Received: by mail-yw0-f194.google.com with SMTP id j74so7629658ywg.1
        for <git@vger.kernel.org>; Fri, 10 Jun 2016 00:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=XJcTUXoVccZQfypheNpy+XFFirDiCeha5qzvc3EgEZY=;
        b=Of04xkoh8S8ghQ519CD5Y264pcHuM7gnN5K56gcoBC0Drav5wuoAFsjQfCdK4rcmfb
         s6PiCe9nHJglp5kSMEq18AHKrKh4YmDmyroDyBGEnA4YduKPvhmytAmjmsvztZruvfpx
         9HFMcAImUgpnyhh2spw3QHSEzFy30MvVUYZtVzb7yYuPGhyqKBRFGBC54Ll8sOyXBx3G
         vV8B6Di5eR4lwHBw5qR+1OAfyCpHe3nX7FyZkMU5ERPiaq+oi+BZJzSo/lgTO/4behVt
         vF2jv0LuKzbURsQdoLqZl+sDTFmQSJB2wKulBIj30cJoww8XOspli/svVubehIN27w2a
         RowQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=XJcTUXoVccZQfypheNpy+XFFirDiCeha5qzvc3EgEZY=;
        b=Lm+YR8mCUxTo8nS4tjMosNr2wb13I59keklMMAFkOPv3ioDMagesDxURaHmVdHefG8
         EkNxVND+3jUcJktn+tQJGXRMtF7Dk9nusFRT2lKN0wH2d3XUp6JFqK+2lrHiFsr6tpam
         O75HB087Kk9K1blujJTJW9IlPU6W0u0HZy6atJYBgIkCaB9xUrZK+vdZf+yrQSNuYbpF
         TGaoxX6AradzFJiFhMWTPotK3fRRJ+CCmXpVKgbzIsgwM3U6xEsdCHr3gv782CRV2b41
         jXWexd5SaGotyu8Y9veUsTGYdIQmdNV5Tgzexo6ReacjqZ4TvLH0Z3M/u1Whtl1uHk9Q
         MTrA==
X-Gm-Message-State: ALyK8tIT1+tgMCzdPBv89Crv5trlqImUMTFAPgpKG7fvuUdPC0xJeI08R+Ao3SfdrgUV9OcwYB4IwnRdlqTSmQ==
X-Received: by 10.129.116.4 with SMTP id p4mr299043ywc.68.1465545156102; Fri,
 10 Jun 2016 00:52:36 -0700 (PDT)
Received: by 10.129.124.132 with HTTP; Fri, 10 Jun 2016 00:52:35 -0700 (PDT)
In-Reply-To: <CAPig+cQVWng0idk0ETRQA44OsS5+GewVX=pt4uOg-=SFbL+deQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296948>

Hey Eric,

On Fri, Jun 10, 2016 at 3:24 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Wed, Jun 8, 2016 at 11:24 AM, Pranit Bauva <pranit.bauva@gmail.com> wrote:
>> Reimplement the `check_expected_revs` shell function in C and add a
>> `--check-expected-revs` subcommand to `git bisect--helper` to call it
>> from git-bisect.sh .
>> [...]
>> Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
>> ---
>> diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
>> index 06bc9b8..500efd5 100644
>> @@ -174,13 +174,28 @@ static int is_expected_rev(const char *expected_hex)
>> +static int check_expected_revs(const char **revs, int no)
>
> In this codebase, it's more common to name this 'nr' rather than 'no'.
> 'revs_nr' would also be a good name.

Thanks. I will use `revs_nr`.

Regards,
Pranit Bauva
