From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-svn SVN 1.7 fix, take 2
Date: Tue, 24 Jul 2012 16:45:05 -0700
Message-ID: <7va9yoenb2.fsf@alter.siamese.dyndns.org>
References: <500F17A3.60307@pobox.com> <20120724220207.GA15969@burratino>
 <500F26BF.7090501@pobox.com> <20120724233128.GD16333@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael G Schwern <schwern@pobox.com>, git@vger.kernel.org,
	"Robin H. Johnson" <robbat2@gentoo.org>,
	Eric Wong <normalperson@yhbt.net>,
	Ben Walton <bwalton@artsci.utoronto.ca>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 25 01:45:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1StonJ-0000bL-C4
	for gcvg-git-2@plane.gmane.org; Wed, 25 Jul 2012 01:45:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755987Ab2GXXpQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jul 2012 19:45:16 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50457 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932618Ab2GXXpN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jul 2012 19:45:13 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B4B948E38;
	Tue, 24 Jul 2012 19:45:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=E+RcmPsGSdvXU1QR6VTeZd8YQqg=; b=rO8T8p
	O0xw/rYXyrEGJvfhAE5+yjOzadJoZ4yhYesxMv+wHnfVhCfgbuZaYL6Ok6s7sq8J
	cIG8Sy3kD1icbziuvWq2aCcgVNxASQCT6Lhtc75CDiqIxrl+X2Lc4sM3DaNDzzRn
	pUgbVVBdItOHwlOTIGu4KlOGHLmIWgqzZjqO4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jcfS8ao6oTFJRlEeABkamWAjU3jzMhls
	x6Ee+/WXGG3OsX5MrQVu4eJhJFwu2/hm9V+2gYx33UgpJ1PgIVQQruM3s3Q24hu0
	jn0ZG7PbR08R79HbdPZ7yYqnniGN4YSLMMj8b+X/DkYufasYDQc4huRx4pH/KTjb
	Q0lMuC8n4ZY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9F9868E37;
	Tue, 24 Jul 2012 19:45:12 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0FDAF8E34; Tue, 24 Jul 2012
 19:45:11 -0400 (EDT)
In-Reply-To: <20120724233128.GD16333@burratino> (Jonathan Nieder's message of
 "Tue, 24 Jul 2012 18:31:28 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9C182420-D5E9-11E1-B682-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202088>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Michael G Schwern wrote:
>
>>   git log -p schwern/git-svn/extract-classes..schwern/git-svn/fix-canonical
>>
>> That should give you the information you need...
>
> I guess so.  May we have your sign-off on these changes?  (A simple
> reply of "yes" is enough, no need to resend patches to do this.)
>
> Here it is in patch form for reviewers.  If I understand correctly,
> the idea is to replace accesses to $gs->{path} with calls to a
> $gs->path function that canonicalizes (and likewise for s/path/url/).
>
> There are probably other subtleties, but that seems to be the gist.

The impression I am getting is that the updated code wants to handle
URL and paths without any funny encoding, but it is unclear from my
cursory read (e.g. what goes on with escape_url?).

>  	if ($old_url =~ m#^svn(\+ssh)?://# ||
>  	    ($full_url =~ m#^https?://# &&
> -	     escape_url($full_url) ne $full_url)) {
> +	     $full_url ne $full_url)) {

How can the latter part of this conditional be true?
