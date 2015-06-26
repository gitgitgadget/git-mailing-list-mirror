From: Stefan Beller <sbeller@google.com>
Subject: Re: Bug in 'git am' when applying a broken patch
Date: Fri, 26 Jun 2015 12:49:46 -0700
Message-ID: <CAGZ79kYbyTOeEvJBPqWOX8fxbB637N5aV3Q=yENQXu4v9FzBPQ@mail.gmail.com>
References: <20150601001759.GA3934@kroah.com>
	<xmqqwpzn5lht.fsf@gitster.dls.corp.google.com>
	<xmqqd21f5k7w.fsf@gitster.dls.corp.google.com>
	<CAPig+cTc72npgXUA9EirGonrjwhXCROxn4cc=6=uPywers_h9w@mail.gmail.com>
	<xmqq8uc35gap.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Greg KH <gregkh@linuxfoundation.org>,
	Git List <git@vger.kernel.org>,
	Gaston Gonzalez <gascoar@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 26 21:49:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z8ZdI-0000VK-Kw
	for gcvg-git-2@plane.gmane.org; Fri, 26 Jun 2015 21:49:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752194AbbFZTtt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Jun 2015 15:49:49 -0400
Received: from mail-yk0-f182.google.com ([209.85.160.182]:32956 "EHLO
	mail-yk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752068AbbFZTtr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Jun 2015 15:49:47 -0400
Received: by ykdt186 with SMTP id t186so67858032ykd.0
        for <git@vger.kernel.org>; Fri, 26 Jun 2015 12:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=bAhnPgpJmaOpAVCWcgYuIctooTHbR2EgCmu0LyubIMA=;
        b=l07ZyJw142Y2pAPFpWkSgJpk9d2vg/0jKgIOGXairswhRY9HOKEWLSobTiZ9ZXNL8q
         ggnvMNiyn70GM/uzvuWCb4EILbpYlxPIUItykdl1TLOEaSTp8OJWD8Y2EmVTsR3QOrEv
         fy+q68un2PZ33GCCOpdO1snCxlmV4NdnWZNm8x2FWV4keiRXczN0f1iUM1i6JkKApFrr
         QVFw06ukZGH5jMCQQ4kVKReV5zd48XtoS7hDo4/sazAqx14fx1npVPbg4zWNF8Sd18/x
         7rG1YNd1OCHyQsJzSIHh53sOIHhLbmP80RnUPWC236gh+PohCz8PqLSpd0ozw+xNcEco
         IphQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=bAhnPgpJmaOpAVCWcgYuIctooTHbR2EgCmu0LyubIMA=;
        b=MgdLe7WHedNWa1/UKoLjd9WtDj/ACTWHkjVEPDADCTBzrP0zoIi2s63RR/ELwVMqtl
         aGhB19vXXfFNXkhdzuFfLuUHRiY7GIjwATmL1wme3OqFTGUFpU4gHo6EaBNZJJo7W9Kp
         v2hembiNHGfRlKCzL4eQgf+nLHmUf8OO3OdvPGT57BrxhCuEiQNlYk1TxEVBfZMYwK3A
         GCkzYVEsUzXnvhztje4sEyXmQdRjOiDosGxw3y1K1d3sLcBkAqxI5WhH4Vl6kYKea9hJ
         tnF3kvaaj1dNqy5a/0IrZp2LqJ9VxeSwK2vWtseOpF6NFMTS396dp9FjaOpGGaQMNsCk
         L60g==
X-Gm-Message-State: ALoCoQnKOoZauo1Xcnas5yOeqdfzLDIYZu0Bbg8LVxtAhMhJgYx7j1HXo9pqI4U5SZ0u/EK7+2uZ
X-Received: by 10.13.238.71 with SMTP id x68mr4164390ywe.129.1435348186492;
 Fri, 26 Jun 2015 12:49:46 -0700 (PDT)
Received: by 10.37.4.80 with HTTP; Fri, 26 Jun 2015 12:49:46 -0700 (PDT)
In-Reply-To: <xmqq8uc35gap.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272817>

On Mon, Jun 1, 2015 at 1:23 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
>
>> s/enw/new/
>
> Heh, thanks; I wasn't planning to commit this one yet, but why not.
> Here is with an updated log message and a test.
>
> -- >8 --
> Subject: [PATCH] apply: reject a hunk that does not do anything
>
> A hunk like this in a hand-edited patch without correctly adjusting
> the line counts:
>
>      @@ -660,2 +660,2 @@ inline struct sk_buff *ieee80211_authentic...
>              auth = (struct ieee80211_authentication *)
>                      skb_put(skb, sizeof(struct ieee80211_authentication));
>      -       some old text
>      +       some new text
>      --
>      2.1.0
>
>      dev mailing list
>
> at the end of the input does not have a good way for us to diagnose
> it as a corrupt patch.  We just read two context lines and discard
> the remainder as cruft, which we must do in order to ignore the
> e-mail footer.  Notice that the patch does not change anything and
> signal an error.
>
> Note that this fix will not help if the hand-edited hunk header were
> "@@ -660,3, +660,2" to include the removal.  We would just remove
> the old text without adding the new one, and treat "+ some new text"
> and everything after that line as trailing cruft.  So it is dubious
> that this patch alone would help very much in practice, but it may
> be better than nothing.

I agree on this patch being better than nothing, but IMHO we can
make the check better. In the hunk header we can learn about the
expected lines to read for this hunk and after the hunk we only have
3 possible lines:

  * it's the next hunk, then the line starts with @@
  * it's a new file, so the line starts with "diff --git"
  * it's the end of the patch, so the line is "--\n" and the line there after
    is version number as git describe puts (not sure we want to test on that)

I think this would be a add more safety against missformed patches.


>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  builtin/apply.c        |  3 +++
>  t/t4136-apply-check.sh | 13 +++++++++++++
>  2 files changed, 16 insertions(+)
>
> diff --git a/builtin/apply.c b/builtin/apply.c
> index 6696ea4..606eddd 100644
> --- a/builtin/apply.c
> +++ b/builtin/apply.c
> @@ -1639,6 +1639,9 @@ static int parse_fragment(const char *line, unsigned long size,
>         }
>         if (oldlines || newlines)
>                 return -1;
> +       if (!deleted && !added)
> +               return -1;
> +
>         fragment->leading = leading;
>         fragment->trailing = trailing;
>
> diff --git a/t/t4136-apply-check.sh b/t/t4136-apply-check.sh
> index a321f7c..4b0a374 100755
> --- a/t/t4136-apply-check.sh
> +++ b/t/t4136-apply-check.sh
> @@ -16,4 +16,17 @@ test_expect_success 'apply --check exits non-zero with unrecognized input' '
>         EOF
>  '
>
> +test_expect_success 'apply exits non-zero with no-op patch' '
> +       cat >input <<-\EOF &&
> +       diff --get a/1 b/1
> +       index 6696ea4..606eddd 100644
> +       --- a/1
> +       +++ b/1
> +       @@ -1,1 +1,1 @@
> +        1
> +       EOF
> +       test_must_fail git apply --stat input &&
> +       test_must_fail git apply --check input
> +'
> +
>  test_done
> --
> 2.4.2-556-g58822d7
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
