From: Stephen Boyd <bebarino@gmail.com>
Subject: Re: [PATCH 2/2] format-patch: Add --cover-letter-wrap
Date: Wed, 01 Jul 2009 23:45:08 -0700
Message-ID: <4A4C5774.9050905@gmail.com>
References: <cover.1246404999.git.joe@perches.com> <5035332845f173ac9c236a90621ca04ea6633b10.1246404999.git.joe@perches.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Joe Perches <joe@perches.com>
X-From: git-owner@vger.kernel.org Thu Jul 02 08:45:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MMG2u-0007ut-C1
	for gcvg-git-2@gmane.org; Thu, 02 Jul 2009 08:45:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752326AbZGBGpN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Jul 2009 02:45:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751428AbZGBGpL
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Jul 2009 02:45:11 -0400
Received: from mail-pz0-f188.google.com ([209.85.222.188]:63807 "EHLO
	mail-pz0-f188.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751420AbZGBGpK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Jul 2009 02:45:10 -0400
Received: by pzk26 with SMTP id 26so1367682pzk.33
        for <git@vger.kernel.org>; Wed, 01 Jul 2009 23:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :x-enigmail-version:content-type:content-transfer-encoding;
        bh=nswwWjJKCh27L9WSPG1ssnfqA0qVWpmk625ZkMEEJ4I=;
        b=qyE6b1VwEt1KqgniIA+99WRWuhyu0rZxaWb9EycxntFVD/zVjAOwtuXuMO6rP7U3GF
         cfLq5Zr3UpmFXii+49WjvLb1SM3Nm4NTpa8AkG5Rri6f96bzzEInQc6Lak3xV1LveCC9
         l7oG5bId3EwctCF/Akv9S+NVL7I92nTt4SZYE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-enigmail-version:content-type
         :content-transfer-encoding;
        b=M6o+rFov1pT+SkyWETC/MlcsEVXe2bH1DhigoI9KQIl1yYFy0dgGKPGz1Ph03of2Ki
         u9DZ9AfnCDkfGfod7i3QFh8JV+U4JAWqQSB7ztL1JA1d7Ez9M8EmfhMlE5qY2qfwgJay
         LM/FOrh5TWXSA+FyQWdjAIYlDKtIFqtPxYuvY=
Received: by 10.114.133.1 with SMTP id g1mr16538359wad.162.1246517113719;
        Wed, 01 Jul 2009 23:45:13 -0700 (PDT)
Received: from ?10.10.0.2? (cpe-66-75-25-79.san.res.rr.com [66.75.25.79])
        by mx.google.com with ESMTPS id f20sm3581982waf.17.2009.07.01.23.45.12
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 01 Jul 2009 23:45:12 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.22 (X11/20090629)
In-Reply-To: <5035332845f173ac9c236a90621ca04ea6633b10.1246404999.git.joe@perches.com>
X-Enigmail-Version: 0.95.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122625>

Joe Perches wrote:
> @@ -792,6 +806,27 @@ static int output_directory_callback(const struct option *opt, const char *arg,
>  	return 0;
>  }
>  
> +static int cls_callback(const struct option *opt, const char *arg, int unset)
> +{
> +	if (unset)
> +		cls.cover_letter_wrap = 0;
> +	else {
> +		int i1, i2, i3;
> +		if (!arg)
> +			return 1;
> +		int arg_count = sscanf(arg, "%d,%d,%d", &i1, &i2, &i3);
> +		if (arg_count <= 0)
> +			return 1;
> +		if (arg_count >= 1)
> +			cls.cover_letter_wrappos = i1;
> +		if (arg_count >= 2)
> +			cls.cover_letter_indent1 = i2;
> +		if (arg_count >= 3)
> +			cls.cover_letter_indent2 = i3;
> +		}

This bracket is one indent off.

I'm not sure, but can this be simplified to just setting the struct
members directly through sscanf? You won't need to have these if's in
that case. I think something like --cover-letter-wrap="" would be
equivalent to just using the defaults and not an error. Does that sound
right?

> +	return 0;
> +}
> +
>  static int thread_callback(const struct option *opt, const char *arg, int unset)
>  {
>  	int *thread = (int *)opt->value;
> @@ -875,6 +910,9 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
>  			    "print patches to standard out"),
>  		OPT_BOOLEAN(0, "cover-letter", &cover_letter,
>  			    "generate a cover letter"),
> +		{ OPTION_CALLBACK, 0, "cover-letter-wrap", &cls, NULL,
> +			    "control the cover letter format",
> +			    PARSE_OPT_OPTARG, cls_callback },

Why is this PARSE_OPT_OPTARG? I only see the choice of having arguments
or prefixed with a --no. Also, please use PARSE_OPT_LITERAL_ARGHELP and
give it the help string you use in the docs
(<width>[,<indent1>[,<indent2>]]).
