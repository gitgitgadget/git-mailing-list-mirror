From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH V2 1/2] t9801: check git-p4's branch detection and client view together
Date: Mon, 20 Apr 2015 15:45:15 -0700
Message-ID: <xmqq4moaju6c.fsf@gitster.dls.corp.google.com>
References: <1429441009-17775-1-git-send-email-vitor.hda@gmail.com>
	<1429441009-17775-2-git-send-email-vitor.hda@gmail.com>
	<xmqqtwwbmk16.fsf@gitster.dls.corp.google.com>
	<48EB5BF2-166D-45F5-9573-0C9E16CAC2B9@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Luke Diamand <luke@diamand.org>
To: Vitor Antunes <vitor.hda@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 21 00:46:07 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YkKRT-00015s-Lf
	for gcvg-git-2@plane.gmane.org; Tue, 21 Apr 2015 00:45:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751386AbbDTWpT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Apr 2015 18:45:19 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:52830 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750872AbbDTWpS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Apr 2015 18:45:18 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 634A849305;
	Mon, 20 Apr 2015 18:45:17 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=qYJUU62H3MrfabXqRmrFASMmU4E=; b=EhdQJ4
	HjMSbAoFfGqmW9X0CEwTfmj9HZaSJ4FU3+b62bq+9NbPTj5zFKx0S7JRTeomsvBs
	RGSt4Q2QpoUi0UnnltfWlJomduUdAHZQOwiyrrOkbyMpsZ7YAMTW7DWynK0AQ43B
	FJ0EVjUX/b5K7UVxrSkSWQ5bKSCWJfUKs/Dd4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=dB66SpuaeIUMQsMon/m5zCyplfGtgmZ2
	ESxAgCEEhjB43rrtJBpsqSVfEMiWl3GnZMSZoKeVlwmt4Wf/WHVVK3v7iRK4nSTT
	wsicrLxIzweumG0SHok7ZSFZ165KtfdSXaLqxqJ+NPXC7K9qxabb7nCoTr0CO80L
	SpBOqgM0j9E=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 5C74D49304;
	Mon, 20 Apr 2015 18:45:17 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D7D3849303;
	Mon, 20 Apr 2015 18:45:16 -0400 (EDT)
In-Reply-To: <48EB5BF2-166D-45F5-9573-0C9E16CAC2B9@gmail.com> (Vitor Antunes's
	message of "Mon, 20 Apr 2015 23:25:17 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: EA4970A2-E7AE-11E4-876D-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267508>

Vitor Antunes <vitor.hda@gmail.com> writes:

> On April 20, 2015 6:43:49 AM GMT+01:00, Junio C Hamano <gitster@pobox.com> wrote:
>>Vitor Antunes <vitor.hda@gmail.com> writes:
>>
>>> Add failing scenario where branch detection is enabled together with
>>> use client view. In this specific scenario git-p4 will break when the
>>> perforce client view removes part of the depot path.
>>
>>I somehow cannot parse "together with use client view", especially
>>the word "use".  Is it "user client view" or something (I am not
>>familiar with p4 lingo), or perhaps "use of client view"?
>
> I meant "spec" instead of "view". As in - -use-client-spec.
>
> In perforce you need to configure your workspace using a client specification.
> One of the configured values is the client view, which maps files/folders in the
> server to locations in your local workspace. What I'm trying to fix with these
> patches is the ability of git-p4 to process the client view definition through
> the use of "p4 where" to determine the correct location of the local files, such
> that it is able to apply the necessary patches for submission to the perforce
> server.
>
> While thinking about client views I completely forgot that the git-p4 argument
> that enables thos feature uses "spec" and not "view".

So,... what's the conclusion?  Should the log message be written
like this perhaps?

    t9801: check git-p4's branch detection and client spec together
    
    Add failing scenario where branch detection is enabled together
    with use of client spec.  In this specific scenario git-p4 will
    break when the perforce client spec removes part of the depot
    path.
    
    The test case also includes an extra sub-file mapping to enforce
    robustness check on git-p4 implementation.
    
    Signed-off-by: Vitor Antunes <vitor.hda@gmail.com>
    Signed-off-by: Junio C Hamano <gitster@pobox.com>
