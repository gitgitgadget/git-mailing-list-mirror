From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH 08/14] fetch-pack: factor out
 get_selected_capabilities_list
Date: Mon, 02 May 2016 15:09:32 -0400
Organization: Twitter
Message-ID: <1462216172.4123.71.camel@twopensource.com>
References: <1461972887-22100-1-git-send-email-sbeller@google.com>
	 <1461972887-22100-9-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Mon May 02 21:09:43 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axJDy-0007Qp-A0
	for gcvg-git-2@plane.gmane.org; Mon, 02 May 2016 21:09:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932136AbcEBTJh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 May 2016 15:09:37 -0400
Received: from mail-qk0-f182.google.com ([209.85.220.182]:35758 "EHLO
	mail-qk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932132AbcEBTJg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 May 2016 15:09:36 -0400
Received: by mail-qk0-f182.google.com with SMTP id v128so10244193qkb.2
        for <git@vger.kernel.org>; Mon, 02 May 2016 12:09:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=VamU3dXAtvCoMOZlUe1mjN+zHPHkxzTWib8VXcCqOTc=;
        b=DOWL2xJLek2tgG04XfNemjwrwQyKEnhOlD/r6LfmQJyEJ2/FEzgeROKfnVUK/lZ9Vo
         F2v53FqikqQDgO43ulCbzNpzrxDigZf+N/Up1VCEQ2DaO1JePRRQXsZBe79GB487vgFN
         DVFMZtv0rpuI+wH9i7mZQlZsefkMU+jTZZ2UuHICk+pYgEgYTrkEHX9elKZ2XqZULuXA
         DxbqzmCtf8snOT9a1D7+D/uhBsKdMgQRCUg6kBoEatA9+5G72jDOEs+1dowbOMN/17Jx
         lZ8GR2HO908vhrdJWpiqhvoFhnyzJ9SB6OIumbLFpAFYuDUY0I3r4oiUPQpZnUP7XkrE
         h5KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=VamU3dXAtvCoMOZlUe1mjN+zHPHkxzTWib8VXcCqOTc=;
        b=PHB9M7KcDXBSNtJ36m7PER2rvUDJhlbUfmxLA71Zj8edOiKA3n1lzhMPW76zoVWlbf
         gFOlog4UgDFEkKBT+NWMtpWC9+NotsPUk4Nzn7af4Vr6CJ4JdnWSaoVw/juhshwFw2U3
         nm4Rl/jzLIEuZvh4eMfJS4T38ryACrJkI6i0V2bvXJYm8r1f6DunJS1ZGUm2LGEPZXI0
         jlD6pJKPfcxrfaJ1HuiUNZt1zXeV+7UQCmRlGTcWcOq60sSWieC69Q9tbvUmzi/JXp07
         OOPdELos0tGztHZfZhfdQK4bNqOyDe8RhkHPpUchKyU7Te0zRD8iVHLq+SYe9iEzbdkc
         Eo/w==
X-Gm-Message-State: AOPr4FWjr6U3kFNJ29DiTbKtQ9bUYoIbfu56vAiTuB64yJogJzCHKuuXDRqLM1QHnwBrMg==
X-Received: by 10.55.149.135 with SMTP id x129mr36294933qkd.140.1462216174900;
        Mon, 02 May 2016 12:09:34 -0700 (PDT)
Received: from ubuntu ([8.25.196.25])
        by smtp.gmail.com with ESMTPSA id b18sm9715605qkc.9.2016.05.02.12.09.33
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 02 May 2016 12:09:33 -0700 (PDT)
In-Reply-To: <1461972887-22100-9-git-send-email-sbeller@google.com>
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293270>

On Fri, 2016-04-29 at 16:34 -0700, Stefan Beller wrote:
> +			struct string_list_item *item;
> +			get_selected_capabilities_list(&list, args);
> +			for_each_string_list_item(item, &list) {
> +				strbuf_addstr(&c, " ");
> +				strbuf_addstr(&c, item->string);
> +			}
> +

I think the contents of list leak here -- you need a string_list_clear.
