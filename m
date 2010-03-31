From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] gitweb: git_get_project_config requires only $git_dir,
 not also $project
Date: Wed, 31 Mar 2010 10:56:17 -0700
Message-ID: <7vpr2ktlxa.fsf@alter.siamese.dyndns.org>
References: <4BAE4F07.3040806@gentoo.org>
 <201003272027.59216.jnareb@gmail.com> <201003311947.33587.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Tobias Heinlein <keytoaster@gentoo.org>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 31 19:56:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nx29b-0007iV-Pp
	for gcvg-git-2@lo.gmane.org; Wed, 31 Mar 2010 19:56:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757934Ab0CaR4a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Mar 2010 13:56:30 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:65362 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757924Ab0CaR43 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Mar 2010 13:56:29 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 07E9DA6DA0;
	Wed, 31 Mar 2010 13:56:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=EKm3ixN+hmnhFbo905+208QnqzU=; b=Q2WO+o
	TYuwcr4i01Vgbvi2GROOVtrbe7vp52MRtb+FFQkvsevKkSSAs4ajMdEYkmsev9js
	qhrVmFaxdV2Bn8NFrs2CXE1/L7OTQud8B/Kw0FHZTGhThkrVz2Jskjjm5cqkzl6L
	/tthN0coXoNXFI7OdU38i3jjDya3Zt8B2dyx4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=tVDGmVrQYufFqx2JzY2WHm5lPfaoR/FY
	O1GfJDarXm26AIKpctsuoq9Gr42WMnWCt8XTd6mfK5cR5fXTbCiRu5EpELCbwkuB
	il+eiinIgcVrJ/Qz/6p67XpDHdoudnFv9Nd02v1d/wze6HelA+9MRnpcYjEiOCOT
	A6a0fSHARr8=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id C3B12A6D9F;
	Wed, 31 Mar 2010 13:56:24 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4B542A6D9E; Wed, 31 Mar
 2010 13:56:19 -0400 (EDT)
In-Reply-To: <201003311947.33587.jnareb@gmail.com> (Jakub Narebski's message
 of "Wed\, 31 Mar 2010 19\:47\:31 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: B8F6F7F6-3CEE-11DF-9469-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143690>

Jakub Narebski <jnareb@gmail.com> writes:

> Ping!  This patch is straight fix for a recently introduced bug
> (in a bugfix)... and it removes more than it adds.

I took your "Does this fix?" as a request for Tested-By: and has been
waiting for the exchange between you two to move forward.

I'll queue it; thanks for the reminder.

>
> On Sat, 27 Mar 2010, Jakub Narebski wrote:
>> On Sat, 27 Mar 2010, Tobias Heinlein wrote:
>> 
>> > I stumbled upon a small bug in gitweb that was introduced by commit
>> > 9be3614eff36271d5f1cd460a568a219902cb044.
>> > 
>> > The projects list page is no longer able to display the projects'
>> > descriptions and owners properly when they are set in the git config
>> > file, e.g. like this:
>> > 
>> >   [gitweb]
>> >           owner = Tobias Heinlein
>> >           description = test
> [...]
>
>> Does the following patch fixes this issue?
>> 
>> -- >8 --
>> From: Jakub Narebski <jnareb@gmail.com>
>> Date: Sat, 27 Mar 2010 20:26:59 +0100
>> Subject: [PATCH] gitweb: git_get_project_config requires only $git_dir, not also $project
>> 
>> Fix overeager early return in git_get_project_config, introduced in 9be3614
>> (gitweb: Fix project-specific feature override behavior, 2010-03-01).  When
>> git_get_project_config is called from projects list page via
>> git_get_project_owner($path) etc., it is called with $git_dir defined (in
>> git_get_project_owner($path) etc.), but $project variable is not defined.
>> git_get_project_config doesn't use $project variable anyway.
>> 
>> Reported-by: Tobias Heinlein <keytoaster@gentoo.org>
>> Signed-off-by: Jakub Narebski <jnareb@gmail.com>
>> ---
>>  gitweb/gitweb.perl |    3 +--
>>  1 files changed, 1 insertions(+), 2 deletions(-)
>> 
>> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
>> index a2d2283..c356e95 100755
>> --- a/gitweb/gitweb.perl
>> +++ b/gitweb/gitweb.perl
>> @@ -2216,8 +2216,7 @@ sub config_to_multi {
>>  sub git_get_project_config {
>>  	my ($key, $type) = @_;
>>  
>> -	# do we have project
>> -	return unless (defined $project && defined $git_dir);
>> +	return unless defined $git_dir;
>>  
>>  	# key sanity check
>>  	return unless ($key);
>> -- 
>> 1.7.0.1
>> 
>> 
>
> -- 
> Jakub Narebski
> Poland
