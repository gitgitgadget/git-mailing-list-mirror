From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] config: add options to list only variable names
Date: Wed, 27 May 2015 15:20:41 -0700
Message-ID: <xmqqd21lk6h2.fsf@gitster.dls.corp.google.com>
References: <1432757240-4445-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Thu May 28 00:21:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yxjh8-0006Lt-0q
	for gcvg-git-2@plane.gmane.org; Thu, 28 May 2015 00:21:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752035AbbE0WUp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 27 May 2015 18:20:45 -0400
Received: from mail-ig0-f182.google.com ([209.85.213.182]:36480 "EHLO
	mail-ig0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751633AbbE0WUn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 May 2015 18:20:43 -0400
Received: by igbpi8 with SMTP id pi8so97242362igb.1
        for <git@vger.kernel.org>; Wed, 27 May 2015 15:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:content-transfer-encoding;
        bh=g1GAnQV7VX4ompazSFFUngdFqDQ6FoR3SRJiE2KpFJo=;
        b=NnHwhpZaHCVe0T/kv/srsXyAxY5zbwpM3qsOxgX185J5nWdLlthigry+7CsHketFr4
         1V/7T3TdnEKz2uGCVrTwqvu2XwLFymQY7SYrKS6XQdUMJzxVOJ8Tel+6d0WSUX3gUYLA
         wA68aarB+7j/ZVY89OLfWpy9DsEwVP4FFOtF1pPddlm9cGZkF+IZYapmDv2k+vwFmBdN
         dMjq2WZR3buz9uKCqdHKiRMlVGCnl2Lb4qvxd7WjOMeXr/nFGvcTp/symtWoRvd7rAYX
         3+aMwUcAwLcE5bGTHuZrA3sgz/KXlDj2mfuAZOy//kTrKl3qAj2NRo9VZ4VQGyrfrqCP
         hSRQ==
X-Received: by 10.42.64.76 with SMTP id f12mr6091337ici.93.1432765242912;
        Wed, 27 May 2015 15:20:42 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:91c7:752b:4513:7344])
        by mx.google.com with ESMTPSA id o15sm599491igw.11.2015.05.27.15.20.42
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 27 May 2015 15:20:42 -0700 (PDT)
In-Reply-To: <1432757240-4445-1-git-send-email-szeder@ira.uka.de> ("SZEDER
	=?utf-8?Q?G=C3=A1bor=22's?= message of "Wed, 27 May 2015 22:07:19 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270112>

SZEDER G=C3=A1bor <szeder@ira.uka.de> writes:

> diff --git a/builtin/config.c b/builtin/config.c
> index 7188405..38bcf83 100644
> --- a/builtin/config.c
> +++ b/builtin/config.c
> @@ -13,6 +13,7 @@ static char *key;
>  static regex_t *key_regexp;
>  static regex_t *regexp;
>  static int show_keys;
> +static int show_only_keys;

Is it just me who thinks this is a strange phrase?  Somehow these
words do not roll well on my tongue.

Perhaps "static int omit_values"?  Which would match what this part
does pretty well:

>  static int show_all_config(const char *key_, const char *value_, voi=
d *cb)
>  {
> -	if (value_)
> +	if (!show_only_keys && value_)

That is, "if not omitting values and there is a value, then do this".

> -	return format_config(&values->items[values->nr++], key_, value_);
> +	if (show_only_keys) {
> +		struct strbuf *buf =3D &values->items[values->nr++];
> +		strbuf_init(buf, 0);
> +		strbuf_addstr(buf, key_);
> +		strbuf_addch(buf, term);
> +		return 0;

xstrfmt()?
