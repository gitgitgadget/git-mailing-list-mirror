From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/3] t7800: fix tests when difftool uses --no-symlinks
Date: Mon, 25 Mar 2013 09:15:59 -0700
Message-ID: <7vvc8fzc8w.fsf@alter.siamese.dyndns.org>
References: <cover.1363980749.git.john@keeping.me.uk>
 <cover.1364045138.git.john@keeping.me.uk>
 <e44349728c07d8ae22d4b73527b1d124b49cc4a9.1364045138.git.john@keeping.me.uk>
 <7vd2up4bo7.fsf@alter.siamese.dyndns.org>
 <20130324123620.GA2286@serenity.lan>
 <CAJELnLEhcY4Oc-EB=Mi7PKBQQF+EiVpW_dNH6G-abjZj0MAdNw@mail.gmail.com>
 <20130324151557.GB2286@serenity.lan> <514FFFC7.3090004@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: John Keeping <john@keeping.me.uk>,
	Matt McClure <matthewlmcclure@gmail.com>, git@vger.kernel.org,
	David Aguilar <davvid@gmail.com>,
	Sitaram Chamarty <sitaramc@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Mon Mar 25 17:16:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UKA4W-00015L-32
	for gcvg-git-2@plane.gmane.org; Mon, 25 Mar 2013 17:16:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932116Ab3CYQQE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Mar 2013 12:16:04 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62792 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758606Ab3CYQQC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Mar 2013 12:16:02 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9A579B9D5;
	Mon, 25 Mar 2013 12:16:01 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=uwSimJNk9Lq1pnB5fm0O9moMi+c=; b=T87SQ2
	puE/2b5mcRmGHb+EQaZVUV8o6DzUsK0f4AJu6ninthLhk/fUVcHEOHubLmQA6lua
	df3qYkRXWRlKLpeXYQwuk3K0Ag83wTAYidPuUIb7uR2CusXCCdWBEaOfgDRu6hbk
	MUa1o2G9Bi5t+ZzOEBJ7Ci48QPUJaBPMPLH8Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BmAWbe6+IC1OvRe830xTLJL58mo6htj8
	ERTipmBmF5QBqwy3M6Jbsh1f2s4PMSjw2kOABm99NuMFMFx4Z5poo5phdEHZcto9
	kQTLDzIyy18kofYnCIfwzViamVipUuCVrmcNUjXyrozQh2SewCH+vJNj1mvdof20
	UUbIf8iNyEg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8CAB5B9D4;
	Mon, 25 Mar 2013 12:16:01 -0400 (EDT)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D66F1B9D2; Mon, 25 Mar 2013
 12:16:00 -0400 (EDT)
In-Reply-To: <514FFFC7.3090004@viscovery.net> (Johannes Sixt's message of
 "Mon, 25 Mar 2013 08:41:59 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 48C1AA4C-9567-11E2-AFD2-EA7A2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219043>

Johannes Sixt <j.sixt@viscovery.net> writes:

> Am 3/24/2013 16:15, schrieb John Keeping:
> ...
>> +	for my $file (keys %worktree) {
>>  		next if $symlinks && -l "$b/$file";
>>  		next if ! -f "$b/$file";
>>  
>> -		my $diff = compare("$b/$file", "$workdir/$file");
>> -		if ($diff == 0) {
>> -			next;
>> -		} elsif ($diff == -1) {
>> -			my $errmsg = "warning: Could not compare ";
>> -			$errmsg += "'$b/$file' with '$workdir/$file'\n";
>> +		my $wt_hash = $repo->command_oneline('hash-object',
>> +			"$workdir/$file");
>> +		my $tmp_hash = $repo->command_oneline('hash-object',
>> +			"$b/$file");
>
> This is gross. Can't we do much better here? Difftool already keeps a
> GIT_INDEX of the files in the temporary tree ($tmpdir/rindex). Running
> git-diff-files should be sufficient to tell which ones where edited via
> the users's diff-tool. Then you can restrict calling hash-object to only
> those worktree files where an "edit collision" needs to be checked for.

;-).
