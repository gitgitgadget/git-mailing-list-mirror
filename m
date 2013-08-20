From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 02/24] read-cache: use fixed width integer types
Date: Tue, 20 Aug 2013 12:30:59 -0700
Message-ID: <xmqqr4do5fd8.fsf@gitster.dls.corp.google.com>
References: <1376854933-31241-1-git-send-email-t.gummerer@gmail.com>
	<1376854933-31241-3-git-send-email-t.gummerer@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, trast@inf.ethz.ch, mhagger@alum.mit.edu,
	pclouds@gmail.com, robin.rosenberg@dewire.com,
	sunshine@sunshineco.com, ramsay@ramsay1.demon.co.uk
To: Thomas Gummerer <t.gummerer@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 20 21:31:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VBreG-00076C-Rv
	for gcvg-git-2@plane.gmane.org; Tue, 20 Aug 2013 21:31:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751275Ab3HTTbF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Aug 2013 15:31:05 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56148 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751142Ab3HTTbD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Aug 2013 15:31:03 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D8FE03A6F8;
	Tue, 20 Aug 2013 19:31:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=M4EA0J3H3K17nl0VoIvwaT26dVQ=; b=Lk++1J
	nRYnir8jMI6lByM1zWMCGq2dKva2fQZFq3GcE/UyDjQ9sugo7ae3Gc7S0qMjnrq9
	iIBHbnv8EPIs5LkmPEqiKM/2pc+Id6R+mN+ZPuF7BKhRzFWP9lGySyKVE8ArY43m
	LU1SqQJNi3BD+1Q3UJkipbUDTPFwe8M5r5tvY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=kD10Pthft/CpE8E4dJzgQ03JraCkT9We
	PAILjE35apQq8c8lQeCTXURG7z9Oa7vg6oTs/LBXlOPKjTIE6kTpO0/IOdhHcLLX
	9PzN4KH9i/hSpC5RNK2XX+N1zj29hspLCnMaqw5eiQ448D410B5g2HaTwEzWbldU
	Ggti3YUoH9M=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CF0943A6F6;
	Tue, 20 Aug 2013 19:31:02 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0B04D3A6F1;
	Tue, 20 Aug 2013 19:31:01 +0000 (UTC)
In-Reply-To: <1376854933-31241-3-git-send-email-t.gummerer@gmail.com> (Thomas
	Gummerer's message of "Sun, 18 Aug 2013 21:41:51 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 0BC23C10-09CF-11E3-87E9-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232636>

Thomas Gummerer <t.gummerer@gmail.com> writes:

> Use the fixed width integer types uint16_t and uint32_t for ondisk
> structures, because unsigned short and unsigned int do not hae a
> guaranteed size.

This sounds like an independent fix to me.  I'd queue this early
independent from the rest of the series.

Thanks.

>
> Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
> ---
>  cache.h      | 10 +++++-----
>  read-cache.c | 30 +++++++++++++++---------------
>  2 files changed, 20 insertions(+), 20 deletions(-)
>
> diff --git a/cache.h b/cache.h
> index bd6fb9f..9ef778a 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -101,9 +101,9 @@ unsigned long git_deflate_bound(git_zstream *, unsigned long);
>  
>  #define CACHE_SIGNATURE 0x44495243	/* "DIRC" */
>  struct cache_header {
> -	unsigned int hdr_signature;
> -	unsigned int hdr_version;
> -	unsigned int hdr_entries;
> +	uint32_t hdr_signature;
> +	uint32_t hdr_version;
> +	uint32_t hdr_entries;
>  };
>  
>  #define INDEX_FORMAT_LB 2
> @@ -115,8 +115,8 @@ struct cache_header {
>   * check it for equality in the 32 bits we save.
>   */
>  struct cache_time {
> -	unsigned int sec;
> -	unsigned int nsec;
> +	uint32_t sec;
> +	uint32_t nsec;
>  };
>  
>  struct stat_data {
> diff --git a/read-cache.c b/read-cache.c
> index ceaf207..0df5b31 100644
> --- a/read-cache.c
> +++ b/read-cache.c
> @@ -1230,14 +1230,14 @@ static struct cache_entry *refresh_cache_entry(struct cache_entry *ce, int reall
>  struct ondisk_cache_entry {
>  	struct cache_time ctime;
>  	struct cache_time mtime;
> -	unsigned int dev;
> -	unsigned int ino;
> -	unsigned int mode;
> -	unsigned int uid;
> -	unsigned int gid;
> -	unsigned int size;
> +	uint32_t dev;
> +	uint32_t ino;
> +	uint32_t mode;
> +	uint32_t uid;
> +	uint32_t gid;
> +	uint32_t size;
>  	unsigned char sha1[20];
> -	unsigned short flags;
> +	uint16_t flags;
>  	char name[FLEX_ARRAY]; /* more */
>  };
>  
> @@ -1249,15 +1249,15 @@ struct ondisk_cache_entry {
>  struct ondisk_cache_entry_extended {
>  	struct cache_time ctime;
>  	struct cache_time mtime;
> -	unsigned int dev;
> -	unsigned int ino;
> -	unsigned int mode;
> -	unsigned int uid;
> -	unsigned int gid;
> -	unsigned int size;
> +	uint32_t dev;
> +	uint32_t ino;
> +	uint32_t mode;
> +	uint32_t uid;
> +	uint32_t gid;
> +	uint32_t size;
>  	unsigned char sha1[20];
> -	unsigned short flags;
> -	unsigned short flags2;
> +	uint16_t flags;
> +	uint16_t flags2;
>  	char name[FLEX_ARRAY]; /* more */
>  };
