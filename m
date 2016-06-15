From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 5/6] bisect--helper: `is_expected_rev` &
 `check_expected_revs` shell function in C
Date: Wed, 15 Jun 2016 17:14:48 -0400
Message-ID: <CAPig+cRNcg496Ty2SJ1ojm1n3OpHzX0obMAD2bY3AzoyrKdA9w@mail.gmail.com>
References: <20160607205454.22576-1-pranit.bauva@gmail.com>
 <20160615140026.10519-1-pranit.bauva@gmail.com> <20160615140026.10519-6-pranit.bauva@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Lars Schneider <larsxschneider@gmail.com>,
	=?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
To: Pranit Bauva <pranit.bauva@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 15 23:14:54 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bDI9F-0001v5-Nn
	for gcvg-git-2@plane.gmane.org; Wed, 15 Jun 2016 23:14:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753237AbcFOVOu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Jun 2016 17:14:50 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:35346 "EHLO
	mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753055AbcFOVOt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Jun 2016 17:14:49 -0400
Received: by mail-io0-f193.google.com with SMTP id n127so4426690iof.2
        for <git@vger.kernel.org>; Wed, 15 Jun 2016 14:14:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=NTlt5nQWWYXKFZb7a1IcnFzdvaMNphB9DQty2BloAgk=;
        b=P08LmZgZwAoPKMKyOBR9pSdT11WdJtgVVfdaJHAOsFHREaO2uOrsF7WG6ANl0y9d5N
         sxGFPNxcPfq4STglafxtJYDGg4b8QcfhUOG3mZXa36p/NJfxAxkAvNg+w9KcEp4MfDQg
         VQszWgO3StU+fh+7RywVPKBsqYn9ZV6Ytx6015tjSWuAFACxw39Z5QcBAQbMuYCtdykI
         LmJ6kE+B2f/u+UbNsFylHY0N6nnr0KPIyuXl+FseZuU7pz8I3cfe3hrvrD1lhmEAIkaE
         Dupghg3rqBlVcGZzIVIhRvx5t3qAezfLRWCyuFwXbtdEWbSMXxRX0DPQjo9RGRNKEp4y
         8Pkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=NTlt5nQWWYXKFZb7a1IcnFzdvaMNphB9DQty2BloAgk=;
        b=kV0on6PJsR3TwOjUmpsv87qoRQu75adl+sZOVBGvrnYrgWA3haI8kubH2U1Y6roNPp
         4khxQVaQXkUzw0Ca04J7oEZpc+vEDE4+Elda24rJRxDF11UsMnYtNOBuj0OvuAIiZHDr
         bYcFn9uwlj2pNn1fs2W0xQWYNcmpmf5RakM+7jPSE4oOQYCti1Sn+WNDHp/H6FS20cLK
         mlPg6GCxKNRU4SiwxYwyKfmcrtJtKzMDbDvDQaSRBsWWM9g6bjq9gZUYBLb0MopcurXV
         E6xoLczV0kiVes5dmEwInCStf0Zhe2PdWWFgDV9I/CiC50rLqVfF/behr5H/yahrbKq2
         RLYA==
X-Gm-Message-State: ALyK8tL8c0KJ+HCsatCaq0aRRBcYBYBGoeQdBJL7I4SAFAF2b5vHQjlHCbCcfxCEVg5AdnnZNp93tsE5YGq6qg==
X-Received: by 10.107.47.41 with SMTP id j41mr2437998ioo.168.1466025288647;
 Wed, 15 Jun 2016 14:14:48 -0700 (PDT)
Received: by 10.79.0.30 with HTTP; Wed, 15 Jun 2016 14:14:48 -0700 (PDT)
In-Reply-To: <20160615140026.10519-6-pranit.bauva@gmail.com>
X-Google-Sender-Auth: gT8GW2Exoekk-PuOL1bOIAbKzL0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297402>

On Wed, Jun 15, 2016 at 10:00 AM, Pranit Bauva <pranit.bauva@gmail.com> wrote:
> Reimplement `is_expected_rev` & `check_expected_revs` shell function in
> C and add a `--check-expected-revs` subcommand to `git bisect--helper` to
> call it from git-bisect.sh .
> [...]
> Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
> ---
> diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
> @@ -162,13 +162,44 @@ static int bisect_reset(const char *commit)
> +static int is_expected_rev(const char *expected_hex)
> +{
> +       struct strbuf actual_hex = STRBUF_INIT;
> +       int res;
> +
> +       if (strbuf_read_file(&actual_hex, git_path_bisect_expected_rev(), 0) < 0) {
> +               strbuf_release(&actual_hex);
> +               return 0;
> +       }
> +
> +       strbuf_trim(&actual_hex);
> +       res = !strcmp(actual_hex.buf, expected_hex);
> +       strbuf_release(&actual_hex);
> +       return res;
> +}

Not worth a re-roll, but this could be re-structured to avoid having
to remember to release the strbuf at all exits:

    struct strbuf actual_hex = ...;
    int res = 0;

    if (strbuf_read_file(...) >= 0) {
        strbuf_trim(...);
        res = !strcmp(...);
    }
    strbuf_release(...);
    return res;

Alternately:

    if (strbuf_read_file(...) < 0)
        goto done;

    strbuf_trim(...);
    res = !strcmp(...);

done:
    strbuf_release(...);
    return res;

which is a bit less compact.

> +static int check_expected_revs(const char **revs, int rev_nr)
> +{
> +       int i;
> +
> +       for (i = 0; i < rev_nr; i++) {
> +               if (!is_expected_rev(revs[i])) {
> +                       remove_path(git_path_bisect_ancestors_ok());
> +                       remove_path(git_path_bisect_expected_rev());
> +                       return 0;
> +               }
> +       }
> +       return 0;
> +}

Hmm, all execution paths return 0, so it feels a bit pointless to have
this function return a value at all.

You could also use a 'break' inside the loop rather than 'return'
since the return value is the same inside or outside the loop and
nothing else happens after the loop.
