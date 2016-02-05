From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v4 10/12] ref-filter: introduce remote_ref_atom_parser()
Date: Thu, 4 Feb 2016 19:05:06 -0500
Message-ID: <20160205000506.GA6417@flurp.local>
References: <1454262176-6594-1-git-send-email-Karthik.188@gmail.com>
 <1454262176-6594-11-git-send-email-Karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 05 01:05:24 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aRTtq-0003y2-Im
	for gcvg-git-2@plane.gmane.org; Fri, 05 Feb 2016 01:05:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933788AbcBEAFQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Feb 2016 19:05:16 -0500
Received: from mail-io0-f196.google.com ([209.85.223.196]:33995 "EHLO
	mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933739AbcBEAFM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Feb 2016 19:05:12 -0500
Received: by mail-io0-f196.google.com with SMTP id k127so5136463iok.1
        for <git@vger.kernel.org>; Thu, 04 Feb 2016 16:05:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=D1iFVY9aZqKkOXxmDRjdOpOIehUPWtxJN76wPhIDiTs=;
        b=bJfs7u9CfWu/WA/hkqQQuuC4QwMzHeYd/9LbGI3HoIUOFfwf3wjyzLH9HK6xgvPhZ5
         Ptxnhxfzb7FnZ/1crcigxqsqW7xAv0akd6ODInY0+JvkU/aPQmHD1UcBqFOLakUHTriY
         1TGo06r6lfD42e96PcyYZUaZw9xVImdt7OMt9ouTkRT4aJAX4n1cqwCmFaGLJNp8v/KY
         dvDWDsa714MkxxbZ6ExWj/4d6pVcfG4QrXZ23Mp+mIQKvx/WXWQTT68wRxVHmlOJMd+G
         z3HASkPLtvhN1M3E7mtdTtn3V0kW2HGxI7MSq2keS+V/YTld5Mx4gnc6Nj4AK/s+acU4
         ivYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=D1iFVY9aZqKkOXxmDRjdOpOIehUPWtxJN76wPhIDiTs=;
        b=RuERjYXnKMzfc6IM30wZvP+il/a5RYqtG7nzfJFiD6ghqzQDgRMXvSvp5GrLudfD/i
         3CnNTc/p+/POy8c8GurQF6K2LtGaPXji+pgiLKj7vlzNi4PlrdoKNVLyN87MZZlDGXM8
         yGe3BaZJs00ZYdhnx9+J8p3vK2px/TvxMC8ZOiceGnxFxbMTee+H6tebZSnt/2v5jiMj
         ruqHCtfTryCgxVtTjvoETGHeV7ue5BXVHPH+xlJsJZrZPwDKoK5RlcxdjlMSYOW8X8r0
         FtEGpKErL9DGlTA6KnfSwnUYMasSdYnxWIXx8TE9cfoZq1qWV4jnEPqQkzJEa27L/x6A
         jhHg==
X-Gm-Message-State: AG10YOR9jtZQPHkoR/6LCVeWmeyjEDO7PmxlDCHRJooyIhfqjrySH2YHGPS1zdfuGost+Q==
X-Received: by 10.107.133.151 with SMTP id p23mr11864988ioi.16.1454630711649;
        Thu, 04 Feb 2016 16:05:11 -0800 (PST)
Received: from flurp.local (user-12l3c5v.cable.mindspring.com. [69.81.176.191])
        by smtp.gmail.com with ESMTPSA id o14sm10868292igi.21.2016.02.04.16.05.10
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 04 Feb 2016 16:05:11 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1454262176-6594-11-git-send-email-Karthik.188@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285529>

On Sun, Jan 31, 2016 at 11:12:54PM +0530, Karthik Nayak wrote:
> Introduce remote_ref_atom_parser() which will parse the '%(upstream)'
> and '%(push)' atoms and store information into the 'used_atom'
> structure based on the modifiers used along with the corresponding
> atom.
> 
> Signed-off-by: Karthik Nayak <Karthik.188@gmail.com>
> ---
> diff --git a/ref-filter.c b/ref-filter.c
> @@ -50,6 +52,20 @@ static void color_atom_parser(struct used_atom *atom, const char *color_value)
> +static void remote_ref_atom_parser(struct used_atom *atom, const char *arg)
> +{
> +	if (!arg) {
> +		atom->u.remote_ref = RR_NORMAL;
> +	} else if (!strcmp(arg, "short"))

Style: drop unnecessary braces

> +		atom->u.remote_ref = RR_SHORTEN;
> +	else if (!strcmp(arg, "track"))
> +		atom->u.remote_ref = RR_TRACK;
> +	else if (!strcmp(arg, "trackshort"))
> +		atom->u.remote_ref = RR_TRACKSHORT;
> +	else
> +		die(_("unrecognized format: %%(%s)"), atom->name);
> +}
