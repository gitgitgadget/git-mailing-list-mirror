From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 3/3] fast-import: rename object_count to pack_object_count
Date: Sun, 18 Sep 2011 16:40:10 -0500
Message-ID: <20110918214010.GK2308@elie>
References: <1316372508-7173-1-git-send-email-divanorama@gmail.com>
 <1316372508-7173-4-git-send-email-divanorama@gmail.com>
 <20110918193205.GF2308@elie>
 <CA+gfSn8aOWPm=xmTE9WzuXsQY0EfYypFxRAyVb-x3_kmhNUb-Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>,
	David Barr <davidbarr@google.com>
To: Dmitry Ivankov <divanorama@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 18 23:40:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R5P64-0007xs-Bz
	for gcvg-git-2@lo.gmane.org; Sun, 18 Sep 2011 23:40:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932584Ab1IRVkP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Sep 2011 17:40:15 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:52492 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932255Ab1IRVkO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Sep 2011 17:40:14 -0400
Received: by iaqq3 with SMTP id q3so4582293iaq.19
        for <git@vger.kernel.org>; Sun, 18 Sep 2011 14:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=ITYhximMjsKhsBY0nLYVVBIt8Y4YiYuR6I+Wnz3n1r8=;
        b=sNmQHc+Bpf1fRlKlBPuU00KyPhuKO32j0cSO1s2vCjClDNQvtBko6V/FuMn3wKa092
         zjTD71lre/t627/mRaHcN6UBCm/4hO32lNrpawD+sjqB/jMSpXq+cYTWm73cBweVU3Fk
         bPN5zrFbLxvgRlNMR+gFB1kVmSZGVOn3lcwp8=
Received: by 10.42.155.137 with SMTP id u9mr3210587icw.31.1316382013631;
        Sun, 18 Sep 2011 14:40:13 -0700 (PDT)
Received: from elie (99-120-124-35.lightspeed.cicril.sbcglobal.net. [99.120.124.35])
        by mx.google.com with ESMTPS id j2sm22378087ibx.11.2011.09.18.14.40.12
        (version=SSLv3 cipher=OTHER);
        Sun, 18 Sep 2011 14:40:13 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CA+gfSn8aOWPm=xmTE9WzuXsQY0EfYypFxRAyVb-x3_kmhNUb-Q@mail.gmail.com>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181646>

Dmitry Ivankov wrote:

> --- a/fast-import.c
> +++ b/fast-import.c
[...]
> @@ -310,8 +309,16 @@ static unsigned int atom_cnt;
>  static struct atom_str **atom_table;
> 
>  /* The .pack file being generated */
> +/*
> + * objects that are being written to the current pack
> + * all *must* have current pack_id in struct object_entry.
> + * And object_count *must* be a count of object_entry's
> + * having current pack_id. This data is used to create
> + * index file once current pack_file is finished.
> + */
>  static struct pack_idx_option pack_idx_opts;
>  static unsigned int pack_id;
> +static unsigned long object_count;
>  static struct sha1file *pack_file;

Closer.  Now I am tempted to nitpick and say that this should be
a single comment, formatted in complete sentences, and written to
be descriptive rather than normative when possible (since norms
will inevitably change over time, and future readers should not
have an excuse to be afraid to adjust the comment to match code
changes).

	/*
	 * The .pack file being generated
	 *
	 * Objects that are being written to the current pack store the
	 * current value of "pack_id" in struct object_entry.
	 * "object_count" counts the object_entrys with the current
	 * pack_id.  These values are used to create the pack index
	 * file when the current pack is finished.
	 */
	static struct pack_idx_option pack_idx_opts;
	static unsigned int pack_id;
	...
