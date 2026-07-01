Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58D543EFFA1
	for <git@vger.kernel.org>; Wed,  1 Jul 2026 08:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782895543; cv=none; b=Lu7O/OTI3r8zskYZXW3QYHCAeXqJv1itLNq23lw+D8afVO91EP7jOVPlA6lo802rdBzTH26NjsgIGezNtpvEeOg3/hCsdogjlGWzWoaMau8GEx+GJCtaUNvUkTonGkd//ey7+hqTUbPok8ffA89xWcZdzkVF6b3EzQVlGy3zvpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782895543; c=relaxed/simple;
	bh=rUZEJsIFJHC44ZJuDbqDDI9tc6gHTLwC1OyOsYHqKj8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qsAhGCwBJIFuIocUVZNziFkrvg8/jXkLpbDNTkLdNyIQHzgo9yg9bgc2PTVL/BggKhq4w6BoJ4ciY3QthM/KRnxnLeeGQ2WXdMv4UaAPnMyF1oaCZ78P6nkN0ulYMPRUpldLIe69wZatY8pknCYo0NUj1ccLJiAKWVv084mgHe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net; spf=pass smtp.mailfrom=posteo.net; dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b=AaG689lY; arc=none smtp.client-ip=185.67.36.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b="AaG689lY"
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id 4AE78240028
	for <git@vger.kernel.org>; Wed,  1 Jul 2026 10:45:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.net; s=2017;
	t=1782895533; bh=LvudmcgAq5llwaqWx+T2TrqCH6fh43RQ221iMu9kThM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:Content-Type:
	 Content-Transfer-Encoding:From;
	b=AaG689lYe8iyaHMobBxTFWBtQoNE/KI0AnhxelhgwODbbvlURSVFnpoewi6BdNiii
	 Q72519PTGgyRROI4jzPw2pClCu0XrmyOPjVYXhSvElBUkmu+bNtqcv2NfE6gFSAmh3
	 rViACsZ606avrVedfhTTuLDLKNrSBbtGwtBOeAGFBwwC/BSPabexXlwEkdTJfjtnMv
	 uQYzop9779RSOnvM+BZh69sWNcQeDCus8bJ1ZhGdD19YphCFW10SwZh/oO0wlV4OBA
	 MTePt7E55PXcAtjk+oMHeNfKPtf6Ihr5WfRZLw+9c8udXr+Wb0/Zl8ljNfCjlMxlv2
	 M540bQCYQcG/A==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4gqtrX4t1mz6tvm;
	Wed,  1 Jul 2026 10:45:32 +0200 (CEST)
Message-ID: <7146f6a0-89aa-41bb-b187-4fc456b0c7da@posteo.net>
Date: Wed, 01 Jul 2026 08:45:33 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: git-blame vs. abbrev
Content-Language: en-US
To: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
 Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
References: <b500479b-14c1-4fbb-a672-1d2cd4852601@posteo.net>
 <xmqqy0fvreps.fsf@gitster.g> <f9761389-8c31-4928-babf-8218e9393376@web.de>
From: Laszlo Ersek <laszlo.ersek@posteo.net>
In-Reply-To: <f9761389-8c31-4928-babf-8218e9393376@web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 6/30/26 23:38, René Scharfe wrote:
> On 6/30/26 9:49 PM, Junio C Hamano wrote:
>> Laszlo Ersek <laszlo.ersek@posteo.net> writes:
>>
>>> Hi,
>>>
>>> when git-blame is passed the "-b" option ("Show blank SHA-1 for boundary
>>> commits"), shouldn't git-blame *stop* reserving a commit hash nibble for
>>> the caret that otherwise marks boundary commits?
>>>
>>> More directly, I find it inconvenient that git-blame shows commit hashes
>>> that are one nibble longer (13) than my "core.abbrev" (12) setting;
>>
>> Just for the sake of aesthetics, I agree that when we are not
>> showing the boundary mark, it would make sense not to reserve one
>> column that we know we will never use.
> Here's a patch to reserve a column only if marks are actually shown.
> 
> I strongly suspect that any line can only have a single mark, but I
> didn't bother checking and proving whether that's actually true; the
> new code should be able to handle multiple marks just fine.
> 
> Misses tests.
> 
> René
> 
> 
> ---
>   builtin/blame.c | 61 ++++++++++++++++++++++++++++++++++---------------
>   1 file changed, 42 insertions(+), 19 deletions(-)
> 
> diff --git a/builtin/blame.c b/builtin/blame.c
> index ffbd3ce5c5..0e747a43f2 100644
> --- a/builtin/blame.c
> +++ b/builtin/blame.c
> @@ -453,6 +453,39 @@ static void determine_line_heat(struct commit_info *ci, const char **dest_color)
>   	*dest_color = colorfield[i].col;
>   }
>   
> +static size_t handle_marks(const struct blame_entry *ent, int opt, bool print)
> +{
> +	size_t len = 0;
> +
> +	if ((ent->suspect->commit->object.flags & UNINTERESTING) &&
> +	    !blank_boundary && !(opt & OUTPUT_ANNOTATE_COMPAT)) {
> +		if (print)
> +			putchar('^');
> +		len++;
> +	}
> +	if (mark_unblamable_lines && ent->unblamable) {
> +		if (print)
> +			putchar('*');
> +		len++;
> +	}
> +	if (mark_ignored_lines && ent->ignored) {
> +		if (print)
> +			putchar('?');
> +		len++;
> +	}
> +	return len;
> +}
> +
> +static size_t print_marks(const struct blame_entry *ent, int opt)
> +{
> +	return handle_marks(ent, opt, true);
> +}
> +
> +static size_t count_marks(const struct blame_entry *ent, int opt)
> +{
> +	return handle_marks(ent, opt, false);
> +}
> +
>   static void emit_other(struct blame_scoreboard *sb, struct blame_entry *ent,
>   		       int opt, struct blame_entry *prev_ent)
>   {
> @@ -499,23 +532,10 @@ static void emit_other(struct blame_scoreboard *sb, struct blame_entry *ent,
>   		if (color)
>   			fputs(color, stdout);
>   
> -		if (suspect->commit->object.flags & UNINTERESTING) {
> -			if (blank_boundary) {
> -				memset(hex, ' ', strlen(hex));
> -			} else if (!(opt & OUTPUT_ANNOTATE_COMPAT)) {
> -				length--;
> -				putchar('^');
> -			}
> -		}
> -
> -		if (mark_unblamable_lines && ent->unblamable) {
> -			length--;
> -			putchar('*');
> -		}
> -		if (mark_ignored_lines && ent->ignored) {
> -			length--;
> -			putchar('?');
> -		}
> +		if ((suspect->commit->object.flags & UNINTERESTING) &&
> +		    blank_boundary)
> +			memset(hex, ' ', strlen(hex));
> +		length -= print_marks(ent, opt);
>   
>   		printf("%.*s", (int)(length < GIT_MAX_HEXSZ ? length : GIT_MAX_HEXSZ), hex);
>   		if (opt & OUTPUT_ANNOTATE_COMPAT) {
> @@ -647,11 +667,15 @@ static void find_alignment(struct blame_scoreboard *sb, int *option)
>   	struct blame_entry *e;
>   	int compute_auto_abbrev = (abbrev < 0);
>   	int auto_abbrev = DEFAULT_ABBREV;
> +	size_t max_marks_count = 0;
>   
>   	for (e = sb->ent; e; e = e->next) {
>   		struct blame_origin *suspect = e->suspect;
>   		int num;
> +		size_t marks_count = count_marks(e, *option);
>   
> +		if (max_marks_count < marks_count)
> +			max_marks_count = marks_count;
>   		if (compute_auto_abbrev)
>   			auto_abbrev = update_auto_abbrev(auto_abbrev, suspect);
>   		if (strcmp(suspect->path, sb->path))
> @@ -685,8 +709,7 @@ static void find_alignment(struct blame_scoreboard *sb, int *option)
>   	max_score_digits = decimal_width(largest_score);
>   
>   	if (compute_auto_abbrev)
> -		/* one more abbrev length is needed for the boundary commit */
> -		abbrev = auto_abbrev + 1;
> +		abbrev = auto_abbrev + max_marks_count;
>   }
>   
>   static void sanity_check_on_fail(struct blame_scoreboard *sb, int baa)

This way, I didn't even need to pass "-b". :)

I didn't try to test the patch exhaustively, but it definitely does what 
I'm after.

Tested-by: Laszlo Ersek <laszlo.ersek@posteo.net>

Thank you!
Laszlo
