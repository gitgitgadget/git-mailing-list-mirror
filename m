From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] merge-recursive: separate message for common ancestors
Date: Sun, 05 Aug 2012 11:44:49 -0700
Message-ID: <7vehnl41r2.fsf@alter.siamese.dyndns.org>
References: <1344189398-27127-1-git-send-email-ralf.thielow@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, worldhello.net@gmail.com
To: Ralf Thielow <ralf.thielow@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 05 20:45:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sy5ov-0002eE-T4
	for gcvg-git-2@plane.gmane.org; Sun, 05 Aug 2012 20:44:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754825Ab2HESox (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Aug 2012 14:44:53 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34088 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754760Ab2HESow (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Aug 2012 14:44:52 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7934586B6;
	Sun,  5 Aug 2012 14:44:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=QOTtWn3qnqxCTPH5AsMB2YMSmqY=; b=HAnY1I
	OrqDR8DUgFA99yXuI5RbdIT6ej0TydN8r09RoYzqdVQ1hAu8GUpf+ZLuFm/ESrCa
	Gx+9abPm7hsyiDUYB0gLgyLgAwN3hkpEyARTu3aPz8u/vTVjBXpx7TovkqKVY8/m
	CAtJB7LkkvI5jhddT9uXWEUdoekJz84vefZDA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=E0DtyKA/ldRo1m56sO6yXkROd16Omef3
	7TkGdzzjaV5fd2+DUMlVzlOEAJ8tAerww7CAhptFt/T+qQ7qumk3LKqxik3XiSXg
	rXEI5H7Hv36Rj1/rmnDurU1n2Sh9GbCuzbSk+rYSKpsXChfHYI7nkDkM2RUzxJ3V
	my0kexLhjd8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6673786B5;
	Sun,  5 Aug 2012 14:44:51 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BF57886B4; Sun,  5 Aug 2012
 14:44:50 -0400 (EDT)
In-Reply-To: <1344189398-27127-1-git-send-email-ralf.thielow@gmail.com> (Ralf
 Thielow's message of "Sun, 5 Aug 2012 19:56:38 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A3878082-DF2D-11E1-9C1F-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202912>

Ralf Thielow <ralf.thielow@gmail.com> writes:

> The function "merge_recursive" prints the count of common
> ancestors as "found %u common ancestor(s):". At least for
> better translation, we should use a singular and a plural
> form of this message.
>
> Signed-off-by: Ralf Thielow <ralf.thielow@gmail.com>
> ---

Thanks.

In your "At least" above, I am getting an impression that either (1)
you think the updated two-message solution is still not ideal for
some reason, or (2) you think the change not only helps translation,
it also helps something else.  But I cannot quite guess which.  If
it is (1) I am not sure what you are not exactly happy about, if it
is (2) I am not sure what other problem the change helps.

I am a bit puzzled by the log message, but the change makes sense to
me otherwise.

>  merge-recursive.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/merge-recursive.c b/merge-recursive.c
> index 8903a73..39b2e16 100644
> --- a/merge-recursive.c
> +++ b/merge-recursive.c
> @@ -1915,7 +1915,10 @@ int merge_recursive(struct merge_options *o,
>  	}
>  
>  	if (show(o, 5)) {
> -		output(o, 5, _("found %u common ancestor(s):"), commit_list_count(ca));
> +		unsigned cnt = commit_list_count(ca);
> +
> +		output(o, 5, Q_("found %u common ancestor:",
> +				"found %u common ancestors:", cnt), cnt);
>  		for (iter = ca; iter; iter = iter->next)
>  			output_commit_title(o, iter->item);
>  	}
