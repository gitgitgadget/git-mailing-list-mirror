From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH v2] fast-import: tag may point to any object type
Date: Wed, 13 Jan 2010 09:24:56 -0800
Message-ID: <20100113172456.GB18625@spearce.org>
References: <1263186165-23920-1-git-send-email-dpotapov@gmail.com> <20100111171454.GO32155@spearce.org> <20100113123532.GC10586@dpotapov.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Dmitry Potapov <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 13 18:25:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NV6xy-0006hG-Gp
	for gcvg-git-2@lo.gmane.org; Wed, 13 Jan 2010 18:25:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756160Ab0AMRZF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jan 2010 12:25:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756122Ab0AMRZE
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jan 2010 12:25:04 -0500
Received: from mail-yw0-f176.google.com ([209.85.211.176]:34608 "EHLO
	mail-yw0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754347Ab0AMRZC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jan 2010 12:25:02 -0500
Received: by ywh6 with SMTP id 6so23625045ywh.4
        for <git@vger.kernel.org>; Wed, 13 Jan 2010 09:25:02 -0800 (PST)
Received: by 10.150.127.4 with SMTP id z4mr9757138ybc.37.1263403502125;
        Wed, 13 Jan 2010 09:25:02 -0800 (PST)
Received: from localhost (george.spearce.org [209.20.77.23])
        by mx.google.com with ESMTPS id 6sm310219ywc.38.2010.01.13.09.24.57
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 13 Jan 2010 09:24:58 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20100113123532.GC10586@dpotapov.dyndns.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136843>

Dmitry Potapov <dpotapov@gmail.com> wrote:
> If you tried to export the official git repository, and then to import it
> back then git-fast-import would die complaining that "Mark :1 not a commit".
...
> diff --git a/fast-import.c b/fast-import.c
> index cd87049..4fdf809 100644
> --- a/fast-import.c
> +++ b/fast-import.c
> @@ -2325,19 +2326,20 @@ static void parse_new_tag(void)
>  	} else if (!get_sha1(from, sha1)) {
>  		unsigned long size;
>  		char *buf;
>  
> +		type = sha1_object_info(sha1, NULL);
>  		buf = read_object_with_reference(sha1,
> -			commit_type, &size, sha1);
> +			typename(type), &size, sha1);

This is better spelled as:

  buf = read_sha1_file(sha1, &type, &size);

But otherwise the patch looks correct now, thanks.

If you could make this one change, add my

  Acked-by: Shawn O. Pearce <spearce@spearce.org>

and resend so Junio can apply, thanks.

-- 
Shawn.
