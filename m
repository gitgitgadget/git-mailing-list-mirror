From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] Add support for merging from upstream by default.
Date: Tue, 08 Feb 2011 16:04:36 -0800
Message-ID: <7vpqr2oyy3.fsf@alter.siamese.dyndns.org>
References: <1297198129-3403-1-git-send-email-jaredhance@gmail.com>
 <20110208223359.GB17981@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jared Hance <jaredhance@gmail.com>, git@vger.kernel.org,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	Andreas Schwab <schwab@linux-m68k.org>,
	Bert Wesarg <bert.wesarg@gmail.com>, Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 09 01:05:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PmxYT-0006yo-5n
	for gcvg-git-2@lo.gmane.org; Wed, 09 Feb 2011 01:05:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755934Ab1BIAFB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Feb 2011 19:05:01 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:42543 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755828Ab1BIAFA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Feb 2011 19:05:00 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 724664040;
	Tue,  8 Feb 2011 19:05:56 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=rHG6CE1ya/QW0knCiGyldiPkbV0=; b=m9nWcj
	rhkR8toBpITnY2BDWdqBc4eJQXnNe032Fyku9j6dTOT81kcKHC5tdq4uOvHF4w0e
	S2gPNqYMt6lKd/2SiUcjLWrhXW3w5BJSqBKxsS3VIzQqTZVLmt0QyYjBKunzsZC3
	00WpMjWWAzWPOhSI4CKQzct23BP6qBZhCwwXo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=V1JpvPRG3ugv/13YxJ3hz5n/D2OkmI5m
	G21UrwGP5Yyv6ojIUsVxXKPYfGo+oFj1O/WNl+gOIjqE+jCc9OTvJHXREeo5IXL7
	1fdWRCz5sxRtqZ3DLR3XqfJathAKTbExLZjJlDCkFJKwqutKN79kPvzqDC1or1/O
	amSN464QFyo=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id E8AE7403B;
	Tue,  8 Feb 2011 19:05:47 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 1D7264034; Tue,  8 Feb 2011
 19:05:36 -0500 (EST)
In-Reply-To: <20110208223359.GB17981@elie> (Jonathan Nieder's message of
 "Tue\, 8 Feb 2011 16\:33\:59 -0600")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 58F32F8E-33E0-11E0-A596-F13235C70CBC-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166375>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Jared Hance wrote:

>>> Subject: Re: [PATCH v2] Add support for merging from upstream by default.

Drop full-stop '.' at the end.

>> Adds the option merge.defaultupstream to add support for merging from the
>> upstream branch by default.
>
> Could you give an example of breakage this configurability is designed
> to prevent?

I think there is no "prevent" or "breakage"; the patch is to give people a
way to turn the feature on; without the configuration, "git merge" will
keep the traditional behaviour, no?

>> +++ b/builtin/merge.c
>> @@ -37,7 +37,7 @@ struct strategy {
>>  };
>>  
>>  static const char * const builtin_merge_usage[] = {
>> -	"git merge [options] <remote>...",
>> +	"git merge [options] [<remote>...]",
>>  	"git merge [options] <msg> HEAD <remote>",
>>  	NULL
>
> Side note: these should probably say "<commit>" or "<branch>" rather
> than "<remote>".  I'm guessing the usage string comes from the days
> before the separate-remotes ref layout...

Yes, your guess is correct.

>> @@ -911,6 +934,24 @@ static int evaluate_result(void)
>>  	return cnt;
>>  }
>>  
>> +static void setup_merge_commit(struct strbuf *buf,
>> +	struct commit_list ***remotes, const char *s)
>> +{
>> +	struct object *o;
>> +	struct commit *commit;
>> +
>> +	o = peel_to_type(s, 0, NULL, OBJ_COMMIT);
>> +	if (!o)
>> +		die("%s - not something we can merge", s);
>> +	commit = lookup_commit(o->sha1);
>> +	commit->util = (void *)s;
>> +	*remotes = &commit_list_insert(commit, *remotes)->next;
>> +
>> +	strbuf_addf(buf, "GITHEAD_%s", sha1_to_hex(o->sha1));
>> +	setenv(buf->buf, s, 1);
>> +	strbuf_reset(buf);
>> +}
>
> Would be easier to review if this code movement were in a separate
> patch (separating cleanup from semantic changes).

Probably.  It is a very good idea to move this code out to its own helper
function, nevertheless; I like this part of the patch.

> Even better would be to use descriptive messages, like so:
>
>  if (head_invalid)
> 	usage_msg_opt("cannot use old-style invocation from an unborn branch",
> 		...);
>  if (!argc && ...)
> 	usage_msg_opt("no commit to merge specified", ...);

Much better.
