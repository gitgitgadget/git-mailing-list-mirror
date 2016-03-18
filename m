From: Pranit Bauva <pranit.bauva@gmail.com>
Subject: Re: [PATCH/RFC] parse-options.c: make OPTION__COUNTUP consider
 negative values
Date: Fri, 18 Mar 2016 16:53:34 +0530
Message-ID: <CAFZEwPOib-3JJQ+ufAbmNf1HYb5003LJw_paF2s9L8OK59N0PQ@mail.gmail.com>
References: <0102015381b7c7b5-5b57a780-369b-478b-94d2-7094f0befdad-000000@eu-west-1.amazonses.com>
	<20160317015044.GB12830@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Mar 18 12:23:59 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1agsVR-00050J-QE
	for gcvg-git-2@plane.gmane.org; Fri, 18 Mar 2016 12:23:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754930AbcCRLXi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Mar 2016 07:23:38 -0400
Received: from mail-yw0-f173.google.com ([209.85.161.173]:33709 "EHLO
	mail-yw0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750786AbcCRLXf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Mar 2016 07:23:35 -0400
Received: by mail-yw0-f173.google.com with SMTP id m126so110683147ywd.0
        for <git@vger.kernel.org>; Fri, 18 Mar 2016 04:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=Gmbk+tapjQCt8aBMRmeqJJjK86PgujqKhkTS4oqO6aw=;
        b=YKoMjc+8u3/QOyWjIl5s/Z/9N0x4+8W0ovRMbjoxUqv+x0nMxwoxb9dHkTmYvDUAT3
         U8ebfteQ3cBJBJZZA2/0Pq3hlu4qIWVLIL4oZG5h0VIiO2kL9hBgZANXMgl6dBuppUfk
         Mmv4GF2JPWGxcyJJzMZzOmjOAlX/j2V54iAcqtMczdXowtDlNe50VUG/08pY2OSoxYzW
         MzO8PWTuwLZOFX30OiyYly+sv4akzAXE5+ZjAji1IV+dXjfeCg2PWI3kcj0bHG9sYYuv
         OekFbWk+Ne8Lt2AMqxvbOqco6HAKM1RYoZ9kQJsK0vjiMB9vfTB5PshQMyj9CYdDarv/
         5c2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=Gmbk+tapjQCt8aBMRmeqJJjK86PgujqKhkTS4oqO6aw=;
        b=IqfyU7wy6GY/zKA0Cy0VsggvOXfJzii1dvYEd106srG319+JSFNwCp3LpA2YPbL7ol
         oVfwPrRENnsxe7DhjAmgPGbPEjsmLve1gBKyVV5p41k6g/BSZPQ7rPtAPYaO5WHisJ/b
         MS3h+nprQ5WzA0XLNFfprFwzMjvunnO16+nqpV/sZmMupA0QqlcHAn4AS5tRyq4gto9O
         Besyc/qsUtXhoeYgN3GzpKASkYSX7DSsCeGcKNdw5KVh4BZSNAkSq7NPeHSnz1BewAoD
         dx+sCmAVRXncCsVXnRvisQwoRyqvC/pQ5zznWhV3U4+mLxDdoCoisWk/jR3Pnzz8O+jF
         gobQ==
X-Gm-Message-State: AD7BkJI37pVv+59lfjGswELlqbKiCTxJZ/LlCEO8ejNu3cfpv2ADhMoiXSm9Ewbze0fLuCoIHPGOJTrxNK4IKw==
X-Received: by 10.129.94.7 with SMTP id s7mr7029838ywb.93.1458300214352; Fri,
 18 Mar 2016 04:23:34 -0700 (PDT)
Received: by 10.13.203.137 with HTTP; Fri, 18 Mar 2016 04:23:34 -0700 (PDT)
In-Reply-To: <20160317015044.GB12830@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289216>

Sorry for a little late reply. I was under the impression that I had
replied before.

On Thu, Mar 17, 2016 at 7:20 AM, Jeff King <peff@peff.net> wrote:

> That aside, this patch does mean that one can no longer use
> OPT_COUNTUP() for negative values (i.e., the caller must start it at
> either 0 or 1, and it must always go up from there).
>
>
> And we would need to verify that all of the existing callers are OK with
> this. Did you check that that (not rhetorical; I suspect they are all
> OK, but somebody needs to check)?

I did a grep on parse-options.h and saw that only "verbose", "quiet"
and "force" use OPT_COUNTUP().
I then did a git grep for "verbose = -1", "quiet = -1"
But with "force = -1" showed that "builtin/clean.c" uses it. On a bit
careful examination, this patch would not make difference to it.

> We are also changing semantics without changing the interface, which
> means any topics in flight (that you _cannot_ review, because you have
> not seen them yet) may be subtly broken. To me that is not an absolute
> deal-breaker, but something to weigh against the utility of the change.

As I am new here, I don't really know how to go about with this. Could
you describe in a little detail so that I can work on it?
> When looking more carefully at builtin/commit.c for the other thread, it
> occurred to me that OPT_BOOL might be a better fit for commit's "-v". It
> really is a boolean "show the diff or not" and thus unlike the other
> "make me more verbose". And OPT_BOOL already has the behavior you want,
> I think.
>
> -Peff
