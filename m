From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v8 5/6] verify-tag: move tag verification code to tag.c
Date: Fri, 22 Apr 2016 13:19:21 -0400
Message-ID: <CAPig+cSXoVeiHsq1m7Ng_+fP0bY3eR20jJqCmTwUF5a1C-F=LA@mail.gmail.com>
References: <1461336725-29915-1-git-send-email-santiago@nyu.edu>
	<1461336725-29915-6-git-send-email-santiago@nyu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>
To: Santiago Torres <santiago@nyu.edu>
X-From: git-owner@vger.kernel.org Fri Apr 22 19:19:32 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1atejr-0000j3-1l
	for gcvg-git-2@plane.gmane.org; Fri, 22 Apr 2016 19:19:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932489AbcDVRTZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Apr 2016 13:19:25 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:32886 "EHLO
	mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932298AbcDVRTW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Apr 2016 13:19:22 -0400
Received: by mail-io0-f196.google.com with SMTP id x35so4104137ioi.0
        for <git@vger.kernel.org>; Fri, 22 Apr 2016 10:19:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=enU7aYObQ0zEO5eipGH4SvJqbWhR2YpOPpOBbuPLkPA=;
        b=t5/2V4hHfDHcLooaBGwDf1ANJyTjwHshBblXYA/+705IZ9nogAK1sKY6iVcJtdO+N3
         dBA2u4rrFQkKuNB1qRFquRcCvMav/CLK/uKQuMcjAQTxLzlSr5hIliRYNs34Oe4dfei1
         N3k12vImWfiI5n6CE5BdXBm74Lp/V8JdQQM8VvBK8I2NSzwRYIPxs6pMSM3A4yOxcNp7
         3YsKsHba02lyAgBorbTBJbOvUPq3ZHr1Bp+d80HY3AMiRPyPynpjOTAGdqGATO7BUmj7
         6MWAPOtKmGnEm25bLGeMNh+L+7ea49i5LaXgutIxUhQ9yHacockqmL31pKo4aX/o+klR
         PFvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=enU7aYObQ0zEO5eipGH4SvJqbWhR2YpOPpOBbuPLkPA=;
        b=AFwRCwRaZCXeRvQPPvaHsx71iYwiogs/ErUyscTvR7bzad3MNBzyCP7jowiZvUr5bl
         x0jZ2GWUJxVXHW23ZNVspsNh1Ct5OddlIIzClhY65kf/Qum09emBy0mM/1xlcXqCULuN
         kEuPX0XXTq2bznXNLLav4IZ4WWZ7ZPgMjqSNbJ0uAfptOx1n8YC2tyqwF1H2Rtx6HU4p
         BkovBRIac1QMfLg8bCdb70z1fXDRJiOIYEWaEcarsbCo2RWLv2rsEJX9YhO9hy494VqF
         dUTTeU3NT1vuDdgQwQBZajKlJAnx7657hkzw58A4i+L3i3GgfLkfQRVjYs6LooebL1ya
         oSHQ==
X-Gm-Message-State: AOPr4FV81eQ3WQHmmm9ZGopEwdIAGKTKWSQG3aH3talfyQ6hU12nE0ELNAFObZVJ6qMmUynNRUtrvJYOJ793Hw==
X-Received: by 10.107.9.102 with SMTP id j99mr20896480ioi.104.1461345561910;
 Fri, 22 Apr 2016 10:19:21 -0700 (PDT)
Received: by 10.79.139.4 with HTTP; Fri, 22 Apr 2016 10:19:21 -0700 (PDT)
In-Reply-To: <1461336725-29915-6-git-send-email-santiago@nyu.edu>
X-Google-Sender-Auth: 1p-la66xQYRQgxSaEAY2yUZ8qmE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292228>

On Fri, Apr 22, 2016 at 10:52 AM,  <santiago@nyu.edu> wrote:
> The PGP verification routine for tags could be accessed by other modules
> that require to do so.
>
> Publish the verify_tag function in tag.c and rename it to gpg_verify_tag
> so it does not conflict with builtin/mktag's static function.
>
> Helped-by: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: Santiago Torres <santiago@nyu.edu>
> ---
> diff --git a/tag.c b/tag.c
> @@ -6,6 +6,59 @@
> +int gpg_verify_tag(const unsigned char *sha1, const char *name_to_report,

Nit: This line has trailing whitespace. Probably not worth a re-roll.

> +               unsigned flags)
> +{
> +       enum object_type type;
> +       char *buf;
> +       unsigned long size;
> +       int ret;
> +
> +       type = sha1_object_info(sha1, NULL);
> +       if (type != OBJ_TAG)
> +               return error("%s: cannot verify a non-tag object of type %s.",
> +                               name_to_report ?
> +                               name_to_report :
> +                               find_unique_abbrev(sha1, DEFAULT_ABBREV),
> +                               typename(type));
> +
> +       buf = read_sha1_file(sha1, &type, &size);
> +       if (!buf)
> +               return error("%s: unable to read file.",
> +                               name_to_report ?
> +                               name_to_report :
> +                               find_unique_abbrev(sha1, DEFAULT_ABBREV));
> +
> +       ret = run_gpg_verify(buf, size, flags);
> +
> +       free(buf);
> +       return ret;
> +}
