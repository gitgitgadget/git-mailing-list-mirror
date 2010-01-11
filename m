From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] fast-import: tag may point to any object type
Date: Mon, 11 Jan 2010 09:14:54 -0800
Message-ID: <20100111171454.GO32155@spearce.org>
References: <1263186165-23920-1-git-send-email-dpotapov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Dmitry Potapov <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 11 18:15:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NUNrB-0005r4-Eo
	for gcvg-git-2@lo.gmane.org; Mon, 11 Jan 2010 18:15:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753384Ab0AKRPB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jan 2010 12:15:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753334Ab0AKRPA
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Jan 2010 12:15:00 -0500
Received: from mail-yw0-f176.google.com ([209.85.211.176]:46493 "EHLO
	mail-yw0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753320Ab0AKRPA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jan 2010 12:15:00 -0500
Received: by ywh6 with SMTP id 6so21610101ywh.4
        for <git@vger.kernel.org>; Mon, 11 Jan 2010 09:14:59 -0800 (PST)
Received: by 10.91.162.31 with SMTP id p31mr3898029ago.121.1263230099235;
        Mon, 11 Jan 2010 09:14:59 -0800 (PST)
Received: from localhost (george.spearce.org [209.20.77.23])
        by mx.google.com with ESMTPS id 7sm10515596yxg.32.2010.01.11.09.14.55
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 11 Jan 2010 09:14:56 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1263186165-23920-1-git-send-email-dpotapov@gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136645>

Dmitry Potapov <dpotapov@gmail.com> wrote:
> If you tried to export the official git repository, and then to import it
> back then git-fast-import would die complaining that "Mark :1 not a commit".
> 
> Accordingly to a generated crash file, Mark 1 is not a commit but a blob,
> which is pointed by junio-gpg-pub tag. Because git-tag allows to create such
> tags, git-fast-import should import them.
> 
> Signed-off-by: Dmitry Potapov <dpotapov@gmail.com>
> ---
>  fast-import.c |    6 +++---
>  1 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/fast-import.c b/fast-import.c
> index cd87049..e99990d 100644
> --- a/fast-import.c
> +++ b/fast-import.c
> @@ -2305,6 +2305,7 @@ static void parse_new_tag(void)
>  	struct tag *t;
>  	uintmax_t from_mark = 0;
>  	unsigned char sha1[20];
> +	enum object_type type = OBJ_COMMIT;

NAK.

Your patch is the right idea.  But you need to make sure all of
the branch arms are handled correctly.

That is, if we do this, the get_sha1() on line 2459 should also
permit non-commit objects, and the lookup_branch() earlier up on
line 2451 should do "type = OBJ_COMMIT".
  
-- 
Shawn.
