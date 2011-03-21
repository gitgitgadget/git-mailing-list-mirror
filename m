From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] Fix sparse warnings
Date: Mon, 21 Mar 2011 09:12:36 -0700
Message-ID: <7vsjugsb9n.fsf@alter.siamese.dyndns.org>
References: <1300700704-22674-1-git-send-email-bebarino@gmail.com>
 <1300700704-22674-2-git-send-email-bebarino@gmail.com>
 <4D872420.8080501@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stephen Boyd <bebarino@gmail.com>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Mon Mar 21 17:12:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q1hit-0007qS-Ix
	for gcvg-git-2@lo.gmane.org; Mon, 21 Mar 2011 17:12:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752220Ab1CUQMr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Mar 2011 12:12:47 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:33221 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751287Ab1CUQMq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Mar 2011 12:12:46 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id C6923449C;
	Mon, 21 Mar 2011 12:14:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=U/YvM0HE4Vw1OuWaKV8G6Dp8ipM=; b=b9DlDk
	3EYdOjK1M+/vj+vs35GyEz/y5bNkX5PgdamuDqYJNObB6oF0cDZAd4ynaZkUBfka
	VkwZdHvPNW+A4d4pfqifwDM6syNNx7yhswHpzjLfyVHdaJb9To90QHb07JQcW3ke
	hVH1hOxj20K9UAXkD9AXqBdhWtZiw0KD6goYQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=nE+Jpo1EcPHxnEhDFjzuADf6rY4Nh9nP
	FmsD+W8AT8kDVRc3zvqt/Uawm8GGiCuFjmZRcGK6CEuGDEGmrNNwMzhMupIo24O0
	78N63VAC7u+Eb5USZ+TDMU6TfYHHrWI949eFFDdBRSxcpwmu2iAcx38RPAfJNGT9
	i33rxcOvhQY=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 95E38448D;
	Mon, 21 Mar 2011 12:14:19 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 7580E4489; Mon, 21 Mar 2011
 12:14:15 -0400 (EDT)
In-Reply-To: <4D872420.8080501@viscovery.net> (Johannes Sixt's message of
 "Mon, 21 Mar 2011 11:10:40 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 46B2BD1A-53D6-11E0-94EA-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169607>

Johannes Sixt <j.sixt@viscovery.net> writes:

> Am 3/21/2011 10:45, schrieb Stephen Boyd:
>> diff --git a/daemon.c b/daemon.c
>> index 347fd0c..4c8346d 100644
>> --- a/daemon.c
>> +++ b/daemon.c
>> @@ -660,7 +660,7 @@ static void check_dead_children(void)
>>  static char **cld_argv;
>>  static void handle(int incoming, struct sockaddr *addr, socklen_t addrlen)
>>  {
>> -	struct child_process cld = { 0 };
>> +	struct child_process cld = { NULL };
>
> IMO this change is not good.
>
> The purpose of { 0} is not to initialize (only) the first member, but
> rather to serve as a visual marker that says "We want the complete struct
> zero-initialized".

Huh?  News to me.

The first element of type const char ** is initialized to a NULL pointer
and the rest if filled with NUL bytes either way.
