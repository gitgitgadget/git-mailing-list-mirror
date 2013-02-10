From: Junio C Hamano <gitster@pobox.com>
Subject: Re: inotify to minimize stat() calls
Date: Sun, 10 Feb 2013 12:16:51 -0800
Message-ID: <7vhaljudos.fsf@alter.siamese.dyndns.org>
References: <7vehgqzc2p.fsf@alter.siamese.dyndns.org>
 <7va9rezaoy.fsf@alter.siamese.dyndns.org>
 <7vsj56w5y9.fsf@alter.siamese.dyndns.org>
 <9AF8A28B-71FE-4BBC-AD55-1DD3FDE8FFC3@gmail.com>
 <CALkWK0mttn6E+D-22UBbvDCuNEy_jNOtBaKPS-a8mTbO2uAF3g@mail.gmail.com>
 <CALkWK0nQVjKpyef8MDYMs0D9HJGCL8egypT3YWSdU8EYTO7Y+w@mail.gmail.com>
 <CACsJy8CEHzqH1X=v4yau0SyZwrZp1r6hNp=yXD+eZh1q_BS-0g@mail.gmail.com>
 <CALkWK0=6_n4rf6AWci6J+uhGHpjTUmK7YFdVHuSJedN2zLWtMA@mail.gmail.com>
 <CACsJy8DeM5--WVXg3b65RxLBS7Jho-7KmcGwWk7B5uAx77yOEw@mail.gmail.com>
 <20130210111732.GA24377@lanh> <20130210112205.GA28434@lanh>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Robert Zeh <robert.allan.zeh@gmail.com>,
	Git List <git@vger.kernel.org>, finnag@pvv.org
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 10 21:17:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U4dKy-00039f-8N
	for gcvg-git-2@plane.gmane.org; Sun, 10 Feb 2013 21:17:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761162Ab3BJUQ5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Feb 2013 15:16:57 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54110 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761108Ab3BJUQ4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Feb 2013 15:16:56 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4E415C15D;
	Sun, 10 Feb 2013 15:16:55 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ia+DMDiuQWdTd8qKEYYuBHsnGs0=; b=iZMMeO
	T0XYAUeLBjI7Cp7y+BOtB8UKIr8wvQ+e2S0X1Ga7U3wrjpamey/TZm8K3x7/auJl
	9U7cSuNYBR4B4pbWQ4Ppc/MjGbWsO8XvXU3eG7j3vtzEVr0Q4egisWKqG5req68y
	q00eVcaWDmDjnzSv3pXowL48U11HXWpknr8Mw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=N57fa73/CS3Ap6OoO/FSvn0ne4ukLFOX
	SlBdTrbNlE8tKV41G6jp63t4qlb8q1TgR6Wvit2NIRgB7GljSoZbUWAZ0W2743r5
	pB/rLKLOwmih6Iduow29SNjhKa7hk1zXWUX+8uldo4oWRbVNWdn3qgCDme++vliP
	edTkU5NXlGg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 27FF3C157;
	Sun, 10 Feb 2013 15:16:55 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B648EC136; Sun, 10 Feb 2013
 15:16:53 -0500 (EST)
In-Reply-To: <20130210112205.GA28434@lanh> (Duy Nguyen's message of "Sun, 10
 Feb 2013 18:22:05 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: CFD51DA4-73BE-11E2-970E-BCD12E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215930>

Duy Nguyen <pclouds@gmail.com> writes:

> On Sun, Feb 10, 2013 at 06:17:32PM +0700, Duy Nguyen wrote:
>> The following patch eliminates untracked search code. As we can see,
>> open+getdents also disappears with this patch:
>> 
>> 0.462909 40950 lstat   0.462909 40950 lstat
>> 0.003417 129 brk       0.003417 129 brk
>> 0.000762 53 read       0.000762 53 read
>> 0.000720 36 open       0.000720 36 open
>> 0.000544 12 munmap     0.000454 33 close
>
> .. and the patch is missing:
>
> -- 8< --
> diff --git a/dir.c b/dir.c
> index 57394e4..1963c6f 100644
> --- a/dir.c
> +++ b/dir.c
> @@ -1439,8 +1439,10 @@ int read_directory(struct dir_struct *dir, const char *path, int len, const char
>  		return dir->nr;
>  
>  	simplify = create_simplify(pathspec);
> +#if 0
>  	if (!len || treat_leading_path(dir, path, len, simplify))
>  		read_directory_recursive(dir, path, len, 0, simplify);
> +#endif

The other "lstat()" experiment was a very interesting one, but this
is not yet an interesting experiment to see where in the "ignore"
codepath we are spending times.

We know that we can tell wt_status_collect_untracked() not to bother
with the untracked or ignored files with !s->show_untracked_files
already, but I think the more interesting question is if we can show
the untracked files with less overhead.

If we want to show untrackedd files, it is a given that we need to
read directories to see what paths there are on the filesystem. Is
the opendir/readdir cost dominating in the process? Are we spending
a lot of time sifting the result of opendir/readdir via the ignore
mechanism? Is reading the "ignore" files costing us much to prime
the ignore mechanism?

If readdir cost is dominant, then that makes "cache gitignore" a
nonsense proposition, I think.  If you really want to "cache"
something, you need to have somebody (i.e. a daemon) who constantly
keeps an eye on the filesystem changes and can respond with the up
to date result directly to fill_directory().  I somehow doubt that
it is a direction we would want to go in, though.
