From: Dilyan Palauzov <dilyan.palauzov@aegee.org>
Subject: Re: git 2.2.2 annotate crash (strbuf.c:32)
Date: Mon, 09 Feb 2015 20:22:46 +0100
Message-ID: <54D90906.7000507@aegee.org>
References: <54D7D634.2050807@aegee.org> <20150209012858.GB21072@peff.net> <CAPig+cQ7iYq_c_MstfsMzArCZFM_0ORRa8Gi-YckaeZiWKN=4w@mail.gmail.com> <54D88D03.1090501@aegee.org> <20150209184612.GA4327@flurp.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Mon Feb 09 20:23:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YKtvb-0006rc-0O
	for gcvg-git-2@plane.gmane.org; Mon, 09 Feb 2015 20:23:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933717AbbBITXW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Feb 2015 14:23:22 -0500
Received: from mailout-aegee.scc.kit.edu ([129.13.185.235]:59060 "EHLO
	mailout-aegee.scc.kit.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933468AbbBITXV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Feb 2015 14:23:21 -0500
Received: from smtp.aegee.org (aegeepc1.aegee.uni-karlsruhe.de [129.13.131.81])
	by scc-mailout-02.scc.kit.edu with esmtp (Exim 4.72 #1)
	id 1YKtvT-0000HZ-CH; Mon, 09 Feb 2015 20:23:19 +0100
Authentication-Results: aegeeserv.aegee.org; auth=pass (PLAIN) smtp.auth=didopalauzov
DKIM-Filter: OpenDKIM Filter v2.10.0 smtp.aegee.org t19JNJd8003443
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aegee.org; s=k4096;
	t=1423509799; i=dkim+MSA-tls@aegee.org;
	bh=CvUMwpJefTBBHszwOOq8zJi6vyCSI1rRXLSc2j8WSkQ=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=oRNliGdPKs5zoPKtua4/loi879PlAvrsQVK+WF6uIMZS7rUEU2eWx8vehKsskq1TW
	 xff7saIFNvbANfQncMN3HNWuxvOPKhLYDBv4fjzEGBRI3du1vBGKuO0GFjXbtHgtCw
	 9gK6l/Xz+AlQTae8dJ+41u8LfJLSEj9rSQD94HjVtVEaHVlvbBGHoEFMlm+q4AKy1K
	 2Aeru5nmt4eKh13Uq/DYrVYMPnd7bPMFoyWKkxRM8xLf7yIYDXoo1ZhpiuVarnCuGI
	 FGUjNvtw6jr8KK0bldyIl7/Tjs4q90QPvyVjFwEQecdf0O/46X8YV9YkugwmnWoRq/
	 JQI9UVtuIFPVNLKkGdgMXdT2sS8eW3u9mIsxRoe1+6Vi1LLtP5BCQypoA4/B1U3ye5
	 +xGxleYKPERO6rXCrJbBozY8u7CGlceiog5uSl3x/psbvskhla8DT9U7m7MK+m16sP
	 uP6Fidryy+vfVNt7zJpylgL/bFsY0DyK/CD1VU+udNBnW+jNV1oKyuEI8dz41EepkW
	 5Hn6MR+PMUP7JkhZZmyYDhTIw8wKNCTVcTnhXx2DvivT6vUUVh2e2M0IwMmr9tqbBb
	 adYMmlR1eA1F/FxpgpFh38BCvi0+3to/go73RT8rNTyS+pQUMnb1M4f/L4s 
Received: from [192.168.0.2] (zuhause [212.202.110.243])
	(authenticated bits=0)
	by smtp.aegee.org (8.15.1/8.14.5) with ESMTPSA id t19JNJd8003443
	(version=TLSv1.2 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Mon, 9 Feb 2015 19:23:19 GMT
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.4.0
In-Reply-To: <20150209184612.GA4327@flurp.local>
X-Virus-Scanned: clamav-milter 0.98.6 at aegeeserv
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263587>

Hello,

this patch fixes the problem for me.

Thanks
   Dilyan

On 09.02.2015 19:46, Eric Sunshine wrote:
> On Mon, Feb 09, 2015 at 11:33:39AM +0100, Dilyan Palauzov wrote:
>> the point is that with exactly the same configuration on one
>> computer there is crash and on another one things work just fine.
>>
>> I found out that line builtin/blame.c:1675 makes the problems:
>>
>> if (len) {
>>    printf("blame.c:1676, subject: %s, len: %i\n", subject, len);
>> -->  strbuf_add(&ret->summary, subject, len);  <--
>> } else
>>     strbuf_addf(&ret->summary, "(%s)", sha1_to_hex(commit->object.sha1));
>>
>> commenting it out and compiling does not lead to crashing git
>> anymore. You can find below the output of printf.
>>
>> git clone git://git.cyrusimap.org/cyrus-imapd
>> git annotate timsieved/parser.c
>>
>> *** Error in `git': double free or corruption (!prev):
>> 0x00000000022e4b40 ***
>
> There is a bit of suspicious code in builtin/blame.c where it is
> destroying the commit_info without ever initializing it, and this
> happens many times when blaming 'timsieved/parser.c'. Does the
> following patch fix the problem for you?
>
> --- 8< ---
> diff --git a/builtin/blame.c b/builtin/blame.c
> index 303e217..a3cc972 100644
> --- a/builtin/blame.c
> +++ b/builtin/blame.c
> @@ -2085,7 +2085,6 @@ static void find_alignment(struct scoreboard *sb, int *option)
>
>   	for (e = sb->ent; e; e = e->next) {
>   		struct origin *suspect = e->suspect;
> -		struct commit_info ci;
>   		int num;
>
>   		if (compute_auto_abbrev)
> @@ -2096,6 +2095,7 @@ static void find_alignment(struct scoreboard *sb, int *option)
>   		if (longest_file < num)
>   			longest_file = num;
>   		if (!(suspect->commit->object.flags & METAINFO_SHOWN)) {
> +			struct commit_info ci;
>   			suspect->commit->object.flags |= METAINFO_SHOWN;
>   			get_commit_info(suspect->commit, &ci, 1);
>   			if (*option & OUTPUT_SHOW_EMAIL)
> @@ -2104,6 +2104,7 @@ static void find_alignment(struct scoreboard *sb, int *option)
>   				num = utf8_strwidth(ci.author.buf);
>   			if (longest_author < num)
>   				longest_author = num;
> +			commit_info_destroy(&ci);
>   		}
>   		num = e->s_lno + e->num_lines;
>   		if (longest_src_lines < num)
> @@ -2113,8 +2114,6 @@ static void find_alignment(struct scoreboard *sb, int *option)
>   			longest_dst_lines = num;
>   		if (largest_score < ent_score(sb, e))
>   			largest_score = ent_score(sb, e);
> -
> -		commit_info_destroy(&ci);
>   	}
>   	max_orig_digits = decimal_width(longest_src_lines);
>   	max_digits = decimal_width(longest_dst_lines);
>
