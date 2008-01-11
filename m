From: Kristian =?ISO-8859-1?Q?H=F8gsberg?= <krh@redhat.com>
Subject: Re: [PATCH 2/5] Use new compress helpers in git files
Date: Fri, 11 Jan 2008 10:29:17 -0500
Message-ID: <1200065357.18570.2.camel@gaara.boston.redhat.com>
References: <e5bfff550801102337w1afc6c88n2c60f26fa80d8da4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Marco Costalba <mcostalba@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 11 16:30:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JDLph-0004Tq-9x
	for gcvg-git-2@gmane.org; Fri, 11 Jan 2008 16:30:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759281AbYAKP3l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jan 2008 10:29:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759059AbYAKP3l
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Jan 2008 10:29:41 -0500
Received: from mx1.redhat.com ([66.187.233.31]:59004 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758787AbYAKP3k (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jan 2008 10:29:40 -0500
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id m0BFTNj9010704;
	Fri, 11 Jan 2008 10:29:23 -0500
Received: from pobox.corp.redhat.com (pobox.corp.redhat.com [10.11.255.20])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id m0BFTNir006714;
	Fri, 11 Jan 2008 10:29:23 -0500
Received: from [192.168.1.105] (dhcp83-9.boston.redhat.com [172.16.83.9])
	by pobox.corp.redhat.com (8.13.1/8.13.1) with ESMTP id m0BFTNQA013740;
	Fri, 11 Jan 2008 10:29:23 -0500
In-Reply-To: <e5bfff550801102337w1afc6c88n2c60f26fa80d8da4@mail.gmail.com>
X-Mailer: Evolution 2.21.4 (2.21.4-1.fc9) 
X-Scanned-By: MIMEDefang 2.58 on 172.16.52.254
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70167>

On Fri, 2008-01-11 at 08:37 +0100, Marco Costalba wrote:
> These are the 'easy' ones, where a signgle step
> compression is requested so that we can use only
> one call to compress_all()
> 
> Signed-off-by: Marco Costalba <mcostalba@gmail.com>
> ---
>  archive-zip.c          |   28 +++-------------------------
>  builtin-pack-objects.c |   21 ++++-----------------
>  diff.c                 |   22 +++++-----------------
>  index-pack.c           |   20 +++-----------------
>  4 files changed, 15 insertions(+), 76 deletions(-)
> 
> diff --git a/archive-zip.c b/archive-zip.c
> index 74e30f6..9071b86 100644
> --- a/archive-zip.c
> +++ b/archive-zip.c
> @@ -3,6 +3,7 @@
>   */
>  #include "cache.h"
>  #include "commit.h"
> +#include "compress.h"
>  #include "blob.h"
>  #include "tree.h"
>  #include "quote.h"
> @@ -97,33 +98,10 @@ static void copy_le32(unsigned char *dest,
>  static void *zlib_deflate(void *data, unsigned long size,
>                            unsigned long *compressed_size)
>  {

How about just getting rid of this function alltogether, since it seems
to do more or less the same as your new compress_all() function?  Just
change the call-sites of zlib_deflate() to call compress_all() instead.

> @@ -1037,23 +1038,10 @@ static unsigned char *deflate_it(char *data,
>  				 unsigned long size,
>  				 unsigned long *result_size)
>  {

Same here.

cheers,
Kristian
