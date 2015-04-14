From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/7] path.c: implement xdg_config_home()
Date: Tue, 14 Apr 2015 13:39:03 -0700
Message-ID: <xmqqzj6a1m3c.fsf@gitster.dls.corp.google.com>
References: <1428824772-8736-1-git-send-email-pyokagan@gmail.com>
	<e1bc6f19af608db796a2212dbf00ba45@www.dscho.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Paul Tan <pyokagan@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Apr 14 22:39:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yi7c1-0003Q6-NC
	for gcvg-git-2@plane.gmane.org; Tue, 14 Apr 2015 22:39:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754000AbbDNUjJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Apr 2015 16:39:09 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:63724 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753983AbbDNUjG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Apr 2015 16:39:06 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A63C54AFAD;
	Tue, 14 Apr 2015 16:39:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=sHtQ+Z/WeKHgcMLmjKo3Nsn8vaw=; b=EbsnLRyfvh3COjmCRg66
	o6dZ8izut+M/lWGCsclfsisUIlRLJRx8RH44KTDBl4w0EqsqS+JIoQyLd7Zec82V
	Wv1jx3H4fB4bgKfiLb1jGdwFZSeAT973ltLm2xKNIbqtxveG53uT9YvBqf/auYWw
	tLcRCFQNiKCmTuBAGhRqw80=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=FBC1oIxChurdwjzn/831alBrCkxjIU5fA5lJDMF2rDRlwU
	4wSoqIBewqqC/O5ejCVHKTtuHrvwhZXwwZquVPkreLTDjClBPyRSwKcC7hMMJSp/
	6BIVRHACkz8yGw90g19k6qKUyeB1CtCgMokWwAnslHcq9YW76c1UQb286y9Hk=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 9D30C4AFAC;
	Tue, 14 Apr 2015 16:39:05 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 899C24AFA9;
	Tue, 14 Apr 2015 16:39:04 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 4A5A7784-E2E6-11E4-8732-11859F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267160>

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

>> diff --git a/cache.h b/cache.h
>> index 3d3244b..7f9bab0 100644
>> --- a/cache.h
>> +++ b/cache.h
>> @@ -836,6 +836,13 @@ char *strip_path_suffix(const char *path, const
>> char *suffix);
>>  int daemon_avoid_alias(const char *path);
>>  extern int is_ntfs_dotgit(const char *name);
>>  
>> +/**
>> + * Returns the newly allocated string "$XDG_CONFIG_HOME/git/%s".  If
>> + * $XDG_CONFIG_HOME is unset or empty, returns the newly allocated string
>> + * "$HOME/.config/git/%s". Returns NULL if an error occurred.
>> + */
>> +extern char *xdg_config_home(const char *fn);
>
> Should this not be inserted close to home_config_paths()? Also, the
> name "fn" sounds more like "function" than like "filename" to me,
> especially keeping the name `config_fn_t` in mind. Maybe call the
> parameter "filename" to avoid confusion?

It is OK to omit the name in the extern declaration here.  We have
to have a sensible variable name in the definition in path.c, of
course ;-), and "filename" sounds like a very sensible suggestion.
